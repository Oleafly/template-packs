unsafe extern "C" fn scan_begin(
    relation: *mut RelationData,
    snapshot: *mut SnapshotData,
    nkeys: i32,
    key: *mut ScanKeyData,
    parallel_scan: *mut ParallelTableScanDescData,
    flags: u32,
) -> *mut TableScanDescData {
    if relation.is_null() {
        return ptr::null_mut();
    }

    RelationIncrementReferenceCount(relation);

    let scan: *mut HeapScanDescData = palloc(std::mem::size_of::<HeapScanDescData>()) as *mut HeapScanDescData;

    (*scan).rs_base.rs_rd = relation;
    (*scan).rs_base.rs_snapshot = snapshot;
    (*scan).rs_base.rs_nkeys = nkeys;
    (*scan).rs_base.rs_flags = flags;
    (*scan).rs_base.rs_parallel = parallel_scan;
    (*scan).rs_strategy = ptr::null_mut();

    if flags & (SO_TYPE_SEQSCAN | SO_TYPE_SAMPLESCAN) != 0 {
        assert!(!snapshot.is_null());
        PredicateLockRelation(relation, snapshot);
    }

    (*scan).rs_ctup.t_tableOid = RelationGetRelid(relation);

    if !parallel_scan.is_null() {
        (*scan).rs_parallelworkerdata = palloc(std::mem::size_of::<ParallelBlockTableScanWorkerData>()) as *mut _;
    } else {
        (*scan).rs_parallelworkerdata = ptr::null_mut();
    }

    (*scan).rs_base.rs_key = if nkeys > 0 {
        palloc((std::mem::size_of::<ScanKeyData>() * nkeys as usize) as usize) as *mut ScanKeyData
    } else {
        ptr::null_mut()
    };

    initscan(scan, key, false);

    (*scan).rs_read_stream = ptr::null_mut();

    if flags & SO_TYPE_SEQSCAN != 0 || flags & SO_TYPE_TIDRANGESCAN != 0 {
        let cb = if !parallel_scan.is_null() {
            heap_scan_stream_read_next_parallel
        } else {
            heap_scan_stream_read_next_serial
        };

        (*scan).rs_read_stream = read_stream_begin_relation(
            READ_STREAM_SEQUENTIAL,
            (*scan).rs_strategy,
            (*scan).rs_base.rs_rd,
            MAIN_FORKNUM,
            cb,
            scan as *mut _,
            0,
        );
    }

    scan as *mut TableScanDescData
}

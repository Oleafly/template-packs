unsafe extern "C" fn scan_end(sscan: *mut TableScanDesc) {

    let scan = sscan as *mut HeapScanDesc;
    if BufferIsValid((*scan).rs_cbuf) {
        ReleaseBuffer((*scan).rs_cbuf);
    }

    if !(*scan).rs_read_stream.is_null() {
        read_stream_end((*scan).rs_read_stream);
    }

    RelationDecrementReferenceCount((*scan).rs_base.rs_rd);
    if !(*scan).rs_base.rs_key.is_null() {
        pfree((*scan).rs_base.rs_key.cast());
    }
    if !(*scan).rs_strategy.is_null() {
        FreeAccessStrategy((*scan).rs_strategy);
    }
    if !(*scan).rs_parallelworkerdata.is_null() {
        pfree((*scan).rs_parallelworkerdata.cast());
    }
    if ((*scan).rs_base.rs_flags & SO_TEMP_SNAPSHOT) != 0 {
        UnregisterSnapshot((*scan).rs_base.rs_snapshot);
    }

    pfree(scan.cast());
}
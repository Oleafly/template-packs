#[pg_guard]
unsafe extern "C-unwind" fn tuple_insert(
    rel: Relation,
    slot: *mut TupleTableSlot,
    cid: CommandId,
    options: ::core::ffi::c_int,
    _bistate: *mut BulkInsertStateData,
) {
    let mut shouldFree = true;
    let tuple = ExecFetchSlotHeapTuple(slot, true, &raw mut shouldFree);
    (*slot).tts_tableOid = (*rel).rd_id;
    (*tuple).t_tableOid = (*rel).rd_id;

    heap_insert(rel, tuple, cid, options, std::ptr::null_mut());
    ItemPointerCopy(&raw const (*tuple).t_self, &raw mut (*slot).tts_tid);

    if shouldFree {
        pfree(tuple.cast());
    }
}


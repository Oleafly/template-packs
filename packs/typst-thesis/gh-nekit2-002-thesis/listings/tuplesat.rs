unsafe extern "C-unwind" fn tuple_satisfies_snapshot(
    rel: *mut RelationData,
    slot: *mut TupleTableSlot,
    snapshot: *mut SnapshotData,
) -> bool {
    if rel.is_null() || slot.is_null() || snapshot.is_null() {
        return false;
    }

    let bslot = slot as *mut BufferHeapTupleTableSlot;
    LockBuffer((*bslot).buffer, BUFFER_LOCK_SHARE);
    let res = HeapTupleSatisfiesVisibility((*bslot).base.tuple, snapshot, (*bslot).buffer);

    LockBuffer((*bslot).buffer, BUFFER_LOCK_UNLOCK);
    res
}

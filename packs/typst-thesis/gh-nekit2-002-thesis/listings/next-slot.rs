pub unsafe fn scan_getnextslot(
	sscan: *mut TableScanDescData,
	direction: ScanDirection,
	slot: *mut TupleTableSlot,
) -> bool { 
	if sscan.is_null() || slot.is_null() {
    	return false;
	}

	let scan = sscan as *mut HeapScanDescData;

    heapgettup( scan, direction, (*sscan).rs_nkeys, (*sscan).rs_key, );

	if (*scan).rs_ctup.t_data.is_null() {
    	ExecClearTuple(slot);
    	return false;
	}

	pgstat_count_heap_getnext((*scan).rs_base.rs_rd);
	ExecStoreBufferHeapTuple(&(*scan).rs_ctup, slot, (*scan).rs_cbuf);
	true
}


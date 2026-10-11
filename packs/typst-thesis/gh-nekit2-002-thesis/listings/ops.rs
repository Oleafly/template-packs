pub struct TupleTableSlotOps {
    pub base_slot_size: usize,
    pub init: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot)>,
    pub release: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot)>,
    pub clear: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot)>,
    pub getsomeattrs: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot, natts: c_int)>,
    pub getsysattr: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot, attnum: c_int, isnull: *mut bool) -> Datum>,
    pub materialize: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot)>,
    pub copyslot: Option<unsafe extern "C" fn(dstslot: *mut TupleTableSlot, srcslot: *mut TupleTableSlot)>,
    pub get_heap_tuple: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot) -> HeapTuple>,
    pub get_minimal_tuple: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot) -> MinimalTuple>,
    pub copy_heap_tuple: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot) -> HeapTuple>,
    pub copy_minimal_tuple: Option<unsafe extern "C" fn(slot: *mut TupleTableSlot) -> MinimalTuple>,
}



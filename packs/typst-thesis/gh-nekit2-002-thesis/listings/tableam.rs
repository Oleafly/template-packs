#[pg_extern(strict)]
fn rsam_am_handler(_internal: TableAmArgs) -> TableAmHandler {
    static VTABLE: TableAmRoutine = const {
        let mut vtable = new_table_am_routine();

        vtable.slot_callbacks = Some(slot_callbacks);
        vtable.scan_begin = Some(scan_begin);
        vtable.scan_end = Some(scan_end);
        vtable.scan_getnextslot = Some(scan_getnextslot);

        . . .

        vtable.tuple_satisfies_snapshot = Some(tuple_satisfies_snapshot);
        vtable.tuple_insert = Some(tuple_insert);

        . . .

        vtable
    };

    TableAmHandler(&VTABLE)
}

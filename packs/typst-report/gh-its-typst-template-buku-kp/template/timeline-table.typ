// ============================================================
// AUTO — Tabel timeline jadwal kegiatan TA
// ============================================================
// kegiatan: array of (judul-kegiatan, (bulan-mulai, bulan-selesai))
// n-bulan: total bulan (default 6)
// label-kolom: array label kolom bulan

#let timeline-table(kegiatan, n-bulan: 6, label-kolom: none) = {
  let labels = if label-kolom != none {
    label-kolom
  } else {
    range(n-bulan).map(i => [#{i + 1}])
  }
  figure(
    kind: table,
    supplement: [Tabel],
    caption: [Lini Masa Pengerjaan Tugas Akhir],
    table(
      columns: (auto, 2fr) + n-bulan * (1fr,),
      fill: (x, y) => {
        if y == 0 { luma(220) }
        else if x > 1 and kegiatan.len() > y - 1 {
          let (_, range_) = kegiatan.at(y - 1)
          let (a, b) = range_
          if a <= (x - 2) and (x - 2) <= b { rgb(47, 84, 150).lighten(50%) }
          else { none }
        } else { none }
      },
      table.header(
        [*No*], [*Kegiatan*],
        ..labels.map(l => align(center)[*#l*]),
      ),
      ..kegiatan.enumerate().map(((i, (judul, _))) => (
        [#{i + 1}],
        [#judul],
        ..n-bulan * ([],),
      )).flatten(),
    ),
  )
}

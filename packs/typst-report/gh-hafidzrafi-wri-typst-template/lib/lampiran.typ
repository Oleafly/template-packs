// lib/lampiran.typ
// Generator tabel Daftar Panitia Offline dengan prefix Koordinator & Anggota

#let render-daftar-panitia-offline(kegiatan-judul, kepanitiaan) = {
  // Hitung dan kumpulkan semua baris panitia
  let baris = ()
  
  // BPH
  if kepanitiaan.at("ketua-pelaksana", default: none) != none {
    baris.push((
      nama: kepanitiaan.ketua-pelaksana.nama,
      jabatan: "Ketua Pelaksana"
    ))
  }
  if kepanitiaan.at("sekretaris", default: none) != none {
    let title = kepanitiaan.at("sekretaris-title", default: "Sekretaris Pelaksana")
    baris.push((
      nama: kepanitiaan.sekretaris.nama,
      jabatan: title
    ))
  }
  if kepanitiaan.at("bendahara", default: none) != none {
    let title = kepanitiaan.at("bendahara-title", default: "Bendahara Pelaksana")
    baris.push((
      nama: kepanitiaan.bendahara.nama,
      jabatan: title
    ))
  }
  
  // Sie-sie
  for sie in kepanitiaan.at("sie-list", default: ()) {
    // Koordinator
    if sie.at("koordinator", default: none) != none {
      baris.push((
        nama: sie.koordinator.nama,
        jabatan: "Koordinator " + sie.nama
      ))
    }
    // Anggota
    for agg in sie.at("anggota", default: ()) {
      baris.push((
        nama: agg.nama,
        jabatan: "Anggota " + sie.nama
      ))
    }
  }

  // Judul Lampiran
  let display-judul = if type(kegiatan-judul) == str { upper(kegiatan-judul) } else { kegiatan-judul }
  align(center)[
    #text(weight: "bold")[DAFTAR PANITIA #emph[OFFLINE]\ #display-judul]
  ]
  v(8pt)

  // Tabel Panitia
  table(
    columns: (1.20cm, 7.30cm, 6.00cm),
    align: (center + horizon, left + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y: 8pt),
    table.header(
      align(center + horizon)[*NO*],
      align(center + horizon)[*NAMA*],
      align(center + horizon)[*JABATAN*]
    ),
    ..for (idx, p) in baris.enumerate() {
      (
        str(idx + 1) + ".",
        p.nama,
        p.jabatan
      )
    }
  )
}

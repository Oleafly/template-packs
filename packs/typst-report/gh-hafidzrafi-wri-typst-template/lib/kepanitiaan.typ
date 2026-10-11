// lib/kepanitiaan.typ
// Layout Bagian VII: Susunan Kepanitiaan Proposal WRI

#let render-susunan-kepanitiaan(
  kepanitiaan: (),
  pelindung: "Direktur Politeknik Negeri Malang",
  penasehat: (
    "Wakil Direktur III",
    "Dosen Pembina Kemahasiswaan",
    "Presiden BEM"
  ),
  penanggung-jawab: (
    jabatan: "Ketua Umum WRI",
    nama: "Savero Athallah Hardiana Putra",
    nim: "244107020116"
  ),
  tampilkan-petinggi: true,
  sie-start: 1,
  sie-end: 99
) = {
  if tampilkan-petinggi {
    grid(
      columns: (115pt, 12pt, 1fr, auto),
      row-gutter: 12.0pt,
      [Pelindung], [:], [#pelindung], [],
      [Penasehat], [:], [
        #for (i, p) in penasehat.enumerate() {
          if i > 0 { [\ ] }
          p
        }
      ], [],
      [Penanggung jawab], [:], [#penanggung-jawab.jabatan], [],
      [], [], [#penanggung-jawab.nama], [NIM. #penanggung-jawab.nim],
      [Ketua Pelaksana], [:], [#kepanitiaan.ketua-pelaksana.nama], [NIM. #kepanitiaan.ketua-pelaksana.nim],
      [Sekretaris], [:], [#kepanitiaan.sekretaris.nama], [NIM. #kepanitiaan.sekretaris.nim],
      [Bendahara], [:], [#kepanitiaan.bendahara.nama], [NIM. #kepanitiaan.bendahara.nim]
    )
    v(10pt)
  }

  // Sie-sie
  let sie-idx = 1
  for sie in kepanitiaan.at("sie-list", default: ()) {
    if sie-idx >= sie-start and sie-idx <= sie-end {
      let rows = ()
      if sie.at("koordinator", default: none) != none {
        rows.push([Koordinator])
        rows.push([:])
        rows.push([#sie.koordinator.nama])
        rows.push([NIM. #sie.koordinator.nim])
      }
      for (a-idx, agg) in sie.at("anggota", default: ()).enumerate() {
        if a-idx == 0 {
          rows.push([Anggota])
          rows.push([:])
        } else {
          rows.push([])
          rows.push([])
        }
        rows.push([#agg.nama])
        rows.push([NIM. #agg.nim])
      }
      
      block(spacing: 12.0pt)[
        #grid(
          columns: (25pt, 1fr),
          [#str(sie-idx).], [#sie.nama]
        )
        #v(3pt)
        #pad(left: 25pt)[
          #grid(
            columns: (78pt, 12pt, 1fr, auto),
            row-gutter: 12.0pt,
            ..rows
          )
        ]
      ]
    }
    sie-idx += 1
  }
}

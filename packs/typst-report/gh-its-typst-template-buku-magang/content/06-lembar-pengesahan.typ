// ============================================================
// AUTO — Lembar pengesahan. Nama & NIP diambil dari data.yaml.
// ============================================================

#import "../template/lib.typ": *

#let lembar-pengesahan(data) = {
  headz[LEMBAR PENGESAHAN]
  v(0.8cm)
  set par(first-line-indent: 0pt, justify: false)

  align(center)[
    #text(size: 12pt, weight: "bold")[#data.tipe]
    #v(0.5cm)
    #text(size: 12pt, weight: "bold")[#data.judul]
    #v(0.9cm)
    Oleh:
    #v(0.3cm)
    #grid(
      columns: (1fr, 1fr),
      align: (center, center),
      [#data.mahasiswa.nama], [#data.mahasiswa.nrp],
    )
  ]

  v(0.9cm)
  [Disetujui oleh Pembimbing Magang:]
  v(0.8cm)

  let tanda-tangan = (
    (data.pembimbing-departemen, "Pembimbing Departemen"),
    (data.pembimbing-lapangan, "Pembimbing Lapangan"),
  )

  for (i, (orang, jabatan)) in tanda-tangan.enumerate() {
    set text(size: 11pt)
    grid(
      columns: (0.7cm, 1fr, 3.3cm),
      align: (left, left, left),
      [#(i + 1).],
      [#orang.nama \ NIP. #orang.nip],
      [(#jabatan)],
    )
    v(1.4cm)
  }
}

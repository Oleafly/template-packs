// ============================================================
// AUTO — Lembar pengesahan ID & EN, data dari data.yaml
// ============================================================

#import "../template/lib.typ": *

#let _pengesahan(data, lang: "id") = {
  let judul    = if lang == "id" { data.judul.id } else { data.judul.en }
  let tipe     = if lang == "id" { "TUGAS AKHIR" } else { "FINAL PROJECT" }
  let prodi    = if lang == "id" { data.institusi.prodi.id } else { data.institusi.prodi.en }
  let dept     = if lang == "id" { data.institusi.departemen.id } else { data.institusi.departemen.en }
  let fak      = if lang == "id" { data.institusi.fakultas.id } else { data.institusi.fakultas.en }
  let oleh     = if lang == "id" { "Oleh:" } else { "By:" }
  let kal1     = if lang == "id" { "Diajukan untuk memenuhi salah satu syarat" } else { "Submitted to fulfill one of the requirements" }
  let kal2     = if lang == "id" { "memperoleh gelar Sarjana Komputer pada" } else { "for obtaining a Bachelor of Computer Science degree at" }
  let disetujui = if lang == "id" { "Disetujui oleh Tim Penguji Tugas Akhir:" } else { "Approved by Final Project Examiner Team:" }
  let bulan    = if lang == "id" { data.bulan.id } else { data.bulan.en }
  let judul-hal = if lang == "id" { "LEMBAR PENGESAHAN" } else { "APPROVAL SHEET" }
  let lbl-pemb  = if lang == "id" { "Pembimbing" } else { "Advisor" }
  let lbl-kopemb = if lang == "id" { "Ko-pembimbing" } else { "Co-advisor" }

  headz[#judul-hal]
  v(0.8cm)

  set par(first-line-indent: 0pt)

  align(center)[
    #set par(justify: false)
    #text(size: 12pt, weight: "bold")[#judul] \
    #v(0.6cm)
    #{
      set par(leading: 1em)
      [
        #text(size: 12pt, weight: "bold")[#tipe] \
        #kal1 \
        #kal2 \
        #prodi \
        #dept \
        #fak \
        #data.institusi.nama \
        #v(0.7cm)
        #oleh #text(weight: "bold")[#upper(data.mahasiswa.nama)] \
        NRP. #data.mahasiswa.nrp
      ]
    }
  ]

  v(0.9cm)
  align(center, text(size: 12pt)[#disetujui])
  v(0.7cm)

  let all-sv = (
    (data.pembimbing.nama, lbl-pemb),
    ..data.ko-pembimbing.map(k => (k.nama, lbl-kopemb)),
    ..data.penguji.map(p => (p.nama, if lang == "id" { p.label.id } else { p.label.en })),
  )

  for (i, (nama, jabatan)) in all-sv.enumerate() {
    grid(
      columns: (auto, 1fr, 3.4cm),
      align: (left, left, left),
      gutter: 0.85em,
      text(size: 13pt)[#(i+1).],
      text(size: 13pt)[#nama],
      text(size: 13pt)[#jabatan],
    )
    v(0.7cm)
  }

  v(0.8cm)
  align(center)[
    #set par(justify: false, leading: 1em)
    #text(weight: "bold")[
      #upper(data.institusi.kota) \
      #bulan, #data.tahun
    ]
  ]
}

// Dipanggil per bahasa dari main.typ; halaman-kosong() dipasang eksplisit di main.typ
#let lembar-pengesahan(data, lang: "id") = _pengesahan(data, lang: lang)

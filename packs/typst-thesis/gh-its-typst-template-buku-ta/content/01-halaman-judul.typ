// ============================================================
// AUTO — Halaman judul dalam (putih), data dari data.yaml
// Pakai Lambang ITS (berwarna) + stripe biru di bawah logo
// ============================================================

#import "../template/lib.typ": *

#let its-blue = rgb(0, 103, 171)

#let _logo-lambang() = image("../assets/brand/Lambang-ITS-2.png", height: 2.65cm)

#let _halaman-judul-single(data, lang: "id") = {
  let judul      = if lang == "id" { data.judul.id } else { data.judul.en }
  let tipe       = if lang == "id" { "TUGAS AKHIR" } else { "FINAL PROJECT" }
  let lbl-pemb   = if lang == "id" { "Dosen Pembimbing" } else { "Advisor" }
  let lbl-kopemb = if lang == "id" { "Dosen Ko-pembimbing" } else { "Co-advisor" }
  let prodi      = if lang == "id" { data.institusi.prodi.id } else { data.institusi.prodi.en }
  let dept       = if lang == "id" { data.institusi.departemen.id } else { data.institusi.departemen.en }
  let fak        = if lang == "id" { data.institusi.fakultas.id } else { data.institusi.fakultas.en }

  set page(
    paper: "a4",
    margin: 0cm,
    fill: white,
    header: none,
    footer: none,
    numbering: none,
  )
  set text(font: "Trebuchet MS")
  set par(first-line-indent: 0pt, justify: false, leading: 0.85em)

  // Blok atas: lambang ITS di kiri
  block(
    width: 100%,
    height: 4cm,
    inset: (left: 2cm, right: 3cm, top: 1cm, bottom: 2cm),
    _logo-lambang(),
  )

  // Stripe biru horizontal
  block(fill: its-blue, width: 100%, height: 0.85cm)

  // Konten di bawah stripe
  pad(left: 3cm, right: 3cm, top: 0.4cm, bottom: 0cm)[

    // Kode MK
    #text(size: 14pt, weight: "bold")[#tipe – #data.kode-mk]
    #v(1cm)

    // Judul — bold italic
    #par(justify: true)[#text(size: 18pt, weight: "bold")[#judul]]
    #v(2cm)

    // Mahasiswa
    #text(size: 14pt, weight: "bold")[#upper(data.mahasiswa.nama)] \
    #text(size: 14pt)[NRP #data.mahasiswa.nrp]
    #v(1cm)

    // Pembimbing
    #text(size: 14pt)[#lbl-pemb] \
    #text(size: 14pt, weight: "bold")[#data.pembimbing.nama] \
    #text(size: 14pt)[NIP #data.pembimbing.nip]

    #for kp in data.ko-pembimbing [
      #v(1cm)
      #text(size: 14pt)[#lbl-kopemb] \
      #text(size: 14pt, weight: "bold")[#kp.nama] \
      #text(size: 14pt)[NIP #kp.nip]
    ]

    #v(1.8cm)

    // Institusi
    #text(size: 14pt, weight: "bold")[#prodi] \
    #text(size: 12pt)[#dept] \
    #text(size: 12pt)[#fak] \
    #text(size: 12pt)[#data.institusi.nama] \
    #text(size: 12pt)[#data.institusi.kota] \
    #text(size: 12pt)[#data.tahun]
  ]
}

// Dipanggil per bahasa dari main.typ; halaman-kosong() dipasang eksplisit di main.typ
#let halaman-judul(data, lang: "id") = _halaman-judul-single(data, lang: lang)

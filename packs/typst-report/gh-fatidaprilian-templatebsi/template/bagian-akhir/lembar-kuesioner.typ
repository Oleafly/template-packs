// =============================================================================
// LEMBAR KUESIONER PKL (Sesuai Lampiran 32 Pedoman PKL UBSI)
// Berisi bukti tangkapan layar pengisian kuesioner testimoni pengguna lulusan
// =============================================================================
#import "../../lib.typ": *
#import "../metadata.typ": *

#pagebreak()

// Jika mahasiswa memiliki file tangkapan layar/scan bukti pengisian kuesioner (PNG/JPG)
// Konfigurasi file-bukti-kuesioner ada di metadata.typ

#if file-bukti-kuesioner != none [
  #align(center)[
    #text(size: 14pt, weight: "bold")[LEMBAR KUESIONER]
  ]
  #v(0.5cm)
  #image(file-bukti-kuesioner, width: 100%)
] else [
  #align(center)[
    #text(size: 14pt, weight: "bold")[LEMBAR KUESIONER]
  ]
  #v(0.8cm)

  #block(
    width: 100%,
    stroke: 1pt + luma(180),
    radius: 4pt,
    inset: 1cm,
  )[
    #set align(center)
    #text(size: 11pt, weight: "bold")[Form Kuesioner Testimoni Pengguna Mahasiswa/Lulusan\ Universitas Bina Sarana Informatika]\
    #v(0.2cm)
    #text(size: 9pt, fill: luma(100))[Google Formulir \<forms-receipts-noreply\@google.com\>]\
    #v(0.5cm)

    #rect(width: 90%, height: 12cm, stroke: (paint: luma(140), dash: "dashed"))[
      #set align(center + horizon)
      #text(size: 11pt, weight: "bold", fill: luma(80))[
        TEMPELKAN SCREENSHOT / PRINT BUKTI EMAIL\
        PENGISIAN FORM KUESIONER DARI GOOGLE FORMS DI SINI
      ]\
      #v(0.5cm)
      #text(size: 9pt, fill: luma(100))[
        Link survey untuk pihak perusahaan:\
        #link("http://tiny.cc/testi-pengguna-lulusan")[http://tiny.cc/testi-pengguna-lulusan]
      ]
    ]
  ]

  #v(1fr)
  #block(
    stroke: none,
    inset: 0pt,
  )[
    #set text(size: 8.5pt, style: "italic")
    #set par(leading: 4.5pt)
    *Catatan:*\
    - Setelah mendapatkan nilai dan sertifikat dari perusahaan, mahasiswa memberikan link kepada perusahaan terkait pengisian survey kepuasan pengguna pada link #link("http://tiny.cc/testi-pengguna-lulusan")[http://tiny.cc/testi-pengguna-lulusan]\
    - Link Kuesioner ini diisi oleh pihak Perusahaan dan dilampirkan bukti pengisiannya (seperti contoh diatas) bersama dengan Surat Keterangan PKL dari Perusahaan/Instansi dan Lembar Penilaian PKL.
  ]
]

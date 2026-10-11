// =============================================================================
// SURAT KETERANGAN PKL (Sesuai Lampiran 26 Pedoman PKL UBSI)
// Mendukung penyisipan berkas scan asli dari perusahaan atau template resmi
// =============================================================================
#import "../../lib.typ": *
#import "../metadata.typ": *

#pagebreak()

// Jika mahasiswa memiliki scan surat keterangan asli (JPG/PNG), tampilkan penuh
// Konfigurasi file-surat-keterangan ada di metadata.typ

#if file-surat-keterangan != none [
  #align(center)[
    #text(size: 14pt, weight: "bold")[SURAT KETERANGAN PKL]
  ]
  #v(0.5cm)
  #image(file-surat-keterangan, width: 100%)
] else [
  // Format Template Resmi UBSI Sesuai Lampiran 26
  align(center)[
    #text(size: 14pt, weight: "bold")[SURAT KETERANGAN PKL]
  ]
  #v(1cm)

  #block(
    width: 100%,
    stroke: 1pt + luma(150),
    inset: 1.5cm,
  )[
    #align(center)[
      #text(size: 14pt, weight: "bold")[#upper(nama-instansi)]\
      #text(size: 10pt)[#alamat-instansi | Telp. #kontak-instansi]\
      #line(length: 100%, stroke: 1.5pt + black)
      #v(-6pt)
      #line(length: 100%, stroke: 0.5pt + black)
      #v(0.5cm)
      #text(size: 13pt, weight: "bold")[#underline("SURAT KETERANGAN")]\
      #text(size: 10pt)[Nomor: 007/PKL/#tahun]
    ]

    #v(0.8cm)
    Yang bertanda tangan di bawah ini:\
    #table(
      columns: (3cm, 0.3cm, 1fr),
      stroke: none,
      inset: (y: 3pt),
      [Nama], [:], [Nama Pembimbing Perusahaan, S.Kom],
      [Jabatan], [:], [Kepala Divisi Teknologi Informasi],
    )

    #v(0.3cm)
    Dengan ini menerangkan bahwa, yang tersebut di bawah ini:\
    #table(
      columns: (3cm, 0.3cm, 1fr),
      stroke: none,
      inset: (y: 3pt),
      [Nama], [:], [#penulis],
      [N I M], [:], [#nim],
      [Program Studi], [:], [#program-studi],
    )

    #v(0.3cm)
    Adalah benar telah melakukan Praktik Kerja Lapangan pada #nama-instansi terhitung sejak #tanggal-mulai-pkl sampai dengan #tanggal-selesai-pkl, dan yang bersangkutan telah melaksanakan tugasnya dengan baik dan penuh tanggung jawab.

    Demikian surat keterangan ini dibuat dengan benar, untuk dapat dipergunakan sebagaimana mestinya.

    #v(1.2cm)
    #align(right)[
      #block(width: 7cm)[
        #set align(left)
        #kota, #tanggal-selesai-pkl\
        \
        #v(1.5cm)
        *Nama Pembimbing Perusahaan, S.Kom*\
        Kepala Divisi Teknologi Informasi
      ]
    ]
  ]

  #v(1fr)
  #text(size: 8.5pt, style: "italic")[
    *Catatan:*\
    - Surat Keterangan PKL Wajib terdapat KOP dan Nomor Surat\
    - Surat Keterangan PKL disahkan menggunakan tanda tangan (bukan scan) pimpinan tempat PKL dan stempel asli atau QR Code resmi\
    - Surat Keterangan PKL dapat berupa Sertifikat Pelaksanaan Kegiatan\
    - Wajib mencantumkan keterangan telah melaksanakan PKL minimal 3 bulan
  ]
]

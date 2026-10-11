#import "../../config.typ": *

= #abstract_ringkasan
#par(first-line-indent: 0pt)[
  #lorem(200)
]

#par(first-line-indent: 0pt)[
  #strong[Kata kunci:] _Typst_, Dokumen, Format Dokumen
]


#if report_type == "Laporan Proyek Akhir" [
  = Abstract
  #par(first-line-indent: 0pt)[
    #lorem(200)
  ]

  #par(first-line-indent: 0pt)[
    #strong[Keywords:] #emph[API, Business Intelligence, Real-time data stream];, #emph[Websocket]
  ]
]


#if report_type == "Laporan Proyek Akhir" [
  = Kata Pengantar

  Puji syukur kehadirat Tuhan Yang Maha Esa atas segala
  rahmat dan karunia-Nya penulis dapat menyelesaikan Proyek Akhir
  yang berjudul “#title_txt” beserta laporan Proyek Akhir
  ini tepat pada waktunya. Proyek akhir ini disusun sebagai salah satu
  syarat untuk menyelesaikan jenjang pendidikan Diploma IV pada
  #program_of_study #campus_name. 

  Alhamdulillah, segala puji bagi Allah subhanahu wata’ala karena
  atas rahmat dan karunia-Nya

  + Allah SWT atas rahmat dan kebaikan-Nya yang telah membukakan pintu pengetahuan sehingga penulis dapat menyelesaikan tugas akhir ini tepat waktu tanpa hambatan yang berarti.
  + Keluarga penulis yang telah memberikan bantuan, baik secara materi maupun non-materi, selama penyusunan tugas akhir ini, sehingga penulis dapat menyelesaikannya tanpa masalah.
  + #advisor_honorific #advisor_name, selaku selaku pembimbing, yang dengan penuh kesabaran telah memberikan ilmu dan bimbingan kepada penulis dalam menyelesaikan proyek akhir ini.
  #let reviewer_mentions = for (i, name) in reviewer_names.enumerate() {
    if reviewer_names.len() == 1 {
      [#reviewer_honorifics.at(i) #name]
    } else if i != reviewer_names.len() - 1 {
      [#reviewer_honorifics.at(i) #name, ]
    } else {
      [dan #reviewer_honorifics.at(i) #name]
    }
  }
  + #reviewer_mentions selaku dosen penguji, yang telah memberikan masukan dan saran dalam menyelesaikan proyek akhir.
  + #coord_honorific #coord_name, selaku koordinator PA dan dosen wali, yang telah membimbing penulis dalam memenuhi berbagai persyaratan yang diperlukan selama pengerjaan proposal, laporan akhir, serta dalam merencanakan pengajuan sidang.
  + Seluruh dosen #program_of_study yang telah memberikan ilmu dan pengetahuan kepada penulis, sehingga dapat menyelesaikan proyek akhir ini.
  + Seluruh teman dari generasi #author_gen #program_of_study yang memberikan dukungan kepada penulis selama pengerjaan proyek akhir ini.

  Penulis menyadari bahwa Laporan Proyek Akhir ini masih memiliki kekurangan, oleh karena itu, penulis sangat mengharapkan kritik, saran, dan masukan yang membangun agar dapat memberikan wawasan bagi pembaca, dan terutama bagi penulis sendiri.

  #align(end)[
    #pad(bottom: 4em, top: 2em)[#date_of_release]
    #author_name
  ]
]


= Daftar Isi
#outline(title: none)

= Daftar Gambar
#outline(title: none, target: figure.where(kind: "gambar"))

= Daftar Tabel
#outline(title: none, target: figure.where(kind: "tabel"))

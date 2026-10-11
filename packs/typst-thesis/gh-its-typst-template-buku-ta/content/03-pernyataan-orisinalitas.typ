// ============================================================
// AUTO — Pernyataan orisinalitas ID & EN, data dari data.yaml
// ============================================================

#import "../template/lib.typ": *

#let _orisinalitas(data, lang: "id") = {
  let judul-hal  = if lang == "id" { "PERNYATAAN ORISINALITAS" } else { "STATEMENT OF ORIGINALITY" }
  let pembuka    = if lang == "id" { "Yang bertanda tangan di bawah ini:" } else { "The undersigned:" }
  let isi        = if lang == "id" {
    [dengan ini menyatakan bahwa Tugas Akhir dengan judul "#data.judul.id" adalah hasil karya sendiri, bersifat orisinal, dan ditulis dengan mengikuti kaidah penulisan ilmiah.]
  } else {
    [hereby declares that the Final Project entitled "#data.judul.en" is my own work, is original, and was written in accordance with the rules of scientific writing.]
  }
  let sanksi     = if lang == "id" {
    [Bilamana di kemudian hari ditemukan ketidaksesuaian dengan pernyataan ini, maka saya bersedia menerima sanksi sesuai dengan ketentuan yang berlaku di Institut Teknologi Sepuluh Nopember.]
  } else {
    [If any discrepancies with this statement are found in the future, I am willing to accept sanctions in accordance with the provisions of Institut Teknologi Sepuluh Nopember.]
  }
  let lbl-mengetahui = if lang == "id" { "Mengetahui" } else { "Acknowledged" }
  let lbl-pemb   = if lang == "id" { "Dosen Pembimbing" } else { "Advisor" }
  let lbl-kopemb = if lang == "id" { "Dosen Ko-pembimbing" } else { "Co-advisor" }
  let lbl-mhs    = if lang == "id" { "Mahasiswa" } else { "Student" }
  let bulan      = if lang == "id" { data.bulan.id } else { data.bulan.en }

  headz[#judul-hal]
  v(1cm)

  set par(first-line-indent: 0pt)

  [#pembuka]
  v(0.5cm)

  if lang == "id" {
    entry-fields((
      ([Nama mahasiswa / NRP], [#data.mahasiswa.nama / #data.mahasiswa.nrp]),
      ([Program Studi], [S-1 Teknik Informatika]),
      ([Dosen Pembimbing / NIP], [#data.pembimbing.nama / #data.pembimbing.nip]),
      ..data.ko-pembimbing.map(k => ([Dosen Ko-pembimbing / NIP], [#k.nama / #k.nip])),
    ), col-widths: (5.55cm, 0.5cm, 1fr), row-gutter: 0.4cm)
  } else {
    entry-fields((
      ([Student Name / Student ID], [#data.mahasiswa.nama / #data.mahasiswa.nrp]),
      ([Study Program], [Bachelor of Informatics]),
      ([Advisor / Employee ID], [#data.pembimbing.nama / #data.pembimbing.nip]),
      ..data.ko-pembimbing.map(k => ([Co-advisor / Employee ID], [#k.nama / #k.nip])),
    ), col-widths: (5.55cm, 0.5cm, 1fr), row-gutter: 0.4cm)
  }

  v(0.5cm)

  isi
  v(0cm)

  sanksi
  v(2cm)
  
  grid(
    columns: (1fr, 1fr),
    gutter: 1cm,
    align(center)[
      #lbl-mengetahui \
      #lbl-pemb
      #v(1.5cm)
      #data.pembimbing.nama \
      NIP. #data.pembimbing.nip
      #if data.ko-pembimbing.len() > 0 [
        #v(0.6cm)
        #lbl-kopemb
        #v(1.5cm)
        #data.ko-pembimbing.at(0).nama \
        NIP. #data.ko-pembimbing.at(0).nip
      ]
    ],
    align(center)[
      #data.institusi.kota, #data.tanggal #bulan #data.tahun \
      #lbl-mhs
      #v(1.5cm)
      #data.mahasiswa.nama \
      NRP. #data.mahasiswa.nrp
    ],
  )
}

// Dipanggil per bahasa dari main.typ; halaman-kosong() dipasang eksplisit di main.typ
#let pernyataan-orisinalitas(data, lang: "id") = _orisinalitas(data, lang: lang)

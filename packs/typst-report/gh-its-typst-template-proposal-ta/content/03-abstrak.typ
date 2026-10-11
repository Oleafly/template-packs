// ============================================================
// WAJIB EDIT — Abstrak bahasa Indonesia dan Inggris (200–400 kata + kata kunci)
// ============================================================

#import "../template/lib.typ": *

// ABSTRAK BAHASA INDONESIA — EDIT DI SINI
// 200–400 kata, tanpa sitasi, tanpa singkatan yg belum didefin.
#let id = [
  Ketidaksiapan karir talenta digital, khususnya mahasiswa tingkat akhir dan _fresh graduate_, masih menjadi salah satu tantangan yang berkontribusi terhadap tingginya angka pengangguran terdidik di Indonesia. Permasalahan ini juga relevan dengan upaya pencapaian _Sustainable Development Goals_ (SDGs) ke-8 serta visi Asta Cita poin 3 dan 4 yang menekankan peningkatan kualitas sumber daya manusia. Permasalahan ini muncul akibat tersebarnya sumber informasi persiapan karir, mulai dari eksplorasi jalur karir, penyusunan dokumen lamaran, hingga persiapan wawancara, yang belum terintegrasi dalam satu platform yang solutif.

  // Lanjutkan abstrak Bahasa Indonesia di sini...
]

// KATA KUNCI BAHASA INDONESIA — EDIT DI SINI
// Tiap elemen bisa pakai markup, misal: [_Design Thinking_], [Kata Biasa]
#let kata-kunci-id = ([Antarmuka Pengguna], [_Design Thinking_], [Pengalaman Pengguna], [Persiapan Karir Digital], [_Usability Testing_])

// ABSTRACT IN ENGLISH — EDIT HERE
// 200–400 words.
#let en = [
  The lack of career readiness among digital talents, particularly final-year university students and fresh graduates, remains one of the challenges contributing to the high rate of educated unemployment in Indonesia. This issue is also aligned with the achievement of Sustainable Development Goal (SDG) 8 and Indonesia's Asta Cita agenda, specifically points 3 and 4, which emphasize the development of high-quality human resources. The problem arises from the fragmentation of career preparation resources, ranging from career exploration and application document preparation to interview readiness, which are not yet integrated into a single comprehensive platform.

  // Continue abstract in English here...
]

// KEYWORDS IN ENGLISH — EDIT HERE
// Separate with commas.
#let kata-kunci-en = ([Design Thinking], [User Interface], [User Experience], [Digital Career Preparation], [Career Readiness])

// ============================================================
// Layout — tidak perlu diedit
// ============================================================

#let _render(data, lang, body, kw) = {
  let judul-hal = if lang == "id" { "ABSTRAK" } else { "ABSTRACT" }
  let judul-ta = if lang == "id" { data.judul.id } else { data.judul.en }
  let kw-label = if lang == "id" { "Kata kunci" } else { "Keywords" }
  let abs-label = if lang == "id" { "Abstrak" } else { "Abstract" }
  let dept-val = if lang == "id" { "Teknik Informatika FTEIC – ITS" } else { "Informatics ELECTICS – ITS" }

  headz[#judul-hal]
  v(1cm)

  set par(first-line-indent: 0pt)
  align(center)[#set par(justify: false); #text(weight: "bold")[#judul-ta]]
  v(0.5cm)

  {
    set text(weight: "bold")
    if lang == "id" {
      entry-fields((
        ([Nama Mahasiswa / NRP], [#data.mahasiswa.nama / #data.mahasiswa.nrp]),
        ([Departemen], [#dept-val]),
        ([Dosen Pembimbing], [#data.pembimbing.nama]),
        ..data.ko-pembimbing.map(k => ([Dosen Ko-pembimbing], [#k.nama])),
      ), row-gutter: 8pt)
    } else {
      entry-fields((
        ([Full Name / Student ID], [#data.mahasiswa.nama / #data.mahasiswa.nrp]),
        ([Department], [#dept-val]),
        ([Advisor], [#data.pembimbing.nama]),
        ..data.ko-pembimbing.map(k => ([Co-advisor], [#k.nama])),
      ), row-gutter: 8pt)
    }
  }

  v(0.5cm)
  text(weight: "bold")[#abs-label]
  set par(first-line-indent: 1cm, leading: 1em)
  body
  v(0.5cm)
  set par(first-line-indent: 0pt)
  [*#kw-label: #kw.join([, ]).*]
}

// Dipanggil per bahasa dari main.typ; halaman-kosong() dipasang eksplisit di main.typ
#let halaman-abstrak(data, lang: "id") = {
  if lang == "id" { _render(data, "id", id, kata-kunci-id) }
  else { _render(data, "en", en, kata-kunci-en) }
}

/*
  File: daftarIsi.typ
  Description: Generates the Table of Contents dynamically with grouped spacing.
               Groups: (1) Frontmatter, (2) BAB I-IV,
               (3) Daftar Pustaka.
*/

// Menampilkan judul daftar isi dengan format heading level 1
= DAFTAR ISI
#v(1cm)
#align(right)[#text(weight: "bold", style: "italic")[Hal.]]
#v(0.3em)

// Pelacak BAB untuk membedakan spasi BAB I (4 enter) vs BAB II-IV (2 enter)
#let bab-tracker = counter("bab-toc")

// Kustomisasi spasi antar kelompok entri di Daftar Isi
#show outline.entry: it => {
  context {
    let s = repr(it)

    // Deteksi via body text di dalam struktur repr
    // repr(it) ≈ entry(level: N, element: heading(... body: [TEKS] ...), ...)
    let is-kata-pengantar = s.contains("body: [KATA PENGANTAR]")
    let is-daftar-pustaka = s.contains("body: [DAFTAR PUSTAKA]")

    // BAB level 1: numbering bukan "none", dan body text-nya
    // adalah judul bab (bukan sub-bab). Deteksi spesifik per BAB.
    let is-bab1 = s.contains("body: [PENDAHULUAN]") and not s.contains("numbering: none")
    let is-bab2 = s.contains("body: [PROFIL INSTANSI DAN PESERTA]") and not s.contains("numbering: none")
    let is-bab3 = s.contains("body: [RANCANGAN AKTUALISASI]") and not s.contains("numbering: none")
    let is-bab4 = s.contains("body: [RENCANA JADWAL KEGIATAN AKTUALISASI]") and not s.contains("numbering: none")
    let is-bab-level1 = is-bab1 or is-bab2 or is-bab3 or is-bab4

    if is-kata-pengantar {
      it  // no extra spacing, now the first entry
    } else if is-bab1 {
      block(above: 4.25em, it)  // 4 enter setelah daftar frontmatter
    } else if is-bab2 or is-bab3 or is-bab4 {
      block(above: 2.5em, it)  // double enter setelah BAB sebelumnya
    } else if is-daftar-pustaka {
      block(above: 2.5em, text(weight: "bold", it))  // double enter setelah BAB IV
    } else {
      it
    }
  }
}

// Fungsi bawaan outline untuk mengekstraksi struktur dokumen
#outline(
  title: none, // Title diset 'none' karena sudah direpresentasikan oleh heading di atas
  depth: 3,
)

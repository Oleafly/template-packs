// ============================================================
// WAJIB EDIT — Biodata penulis (foto 4×6, riwayat pendidikan, prestasi)
// ============================================================

#import "../template/lib.typ": headz

// ISI BIODATA — EDIT DI SINI
#let isi(data) = [
  // Bagian 1: foto + teks yang sejajar dengan foto
  // Isi teks di sini secukupnya agar setara tinggi foto (±6 cm).
  // Teks yang terlalu panjang akan tetap di kolom kanan.
  #grid(
    columns: (4cm, 1fr),
    column-gutter: 1.5em,
    align: (top, top),

    image("../assets/figures/foto-penulis.png", width: 4cm, height: 6cm, fit: "cover"),

    // Teks sejajar foto
    [
      *#data.mahasiswa.nama* lahir di [Kota Kelahiran] dan merupakan mahasiswa #data.institusi.departemen.id, #data.institusi.fakultas.id (FTEIC), #data.institusi.nama angkatan [TAHUN] dengan NRP #data.mahasiswa.nrp.

      Selama masa perkuliahan, Penulis aktif dalam organisasi [Nama Himpunan/Organisasi], serta menjadi [Asisten Dosen/Asisten Laboratorium] di [Nama Laboratorium]. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.
    ],
  )

  // Bagian 2: teks lanjutan, lebar penuh di bawah foto
  Selain aktif di bidang akademik, Penulis juga mengikuti berbagai kompetisi nasional dan berhasil meraih [Deskripsi Prestasi]. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit.

  Penulis memiliki minat di bidang [Bidang Minat 1], [Bidang Minat 2], dan [Bidang Minat 3]. Informasi lebih lanjut mengenai portofolio dan karya Penulis dapat diakses melalui #link("https://example.com")[example.com].
]

// ============================================================
// Layout — tidak perlu diedit
// ============================================================

#let biodata-penulis(data) = {
  headz[BIODATA PENULIS]
  v(1cm)
  set par(first-line-indent: 0pt)
  isi(data)
}

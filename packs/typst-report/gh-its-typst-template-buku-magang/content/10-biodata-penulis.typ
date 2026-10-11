// ============================================================
// WAJIB EDIT — Biodata penulis. Data dasar diambil dari data.yaml.
// Foto: simpan di assets/figures/foto-penulis.png lalu hapus komentar.
// ============================================================

#import "../template/lib.typ": *

#let biodata-penulis(data) = {
  headz[BIODATA PENULIS]
  v(0.8cm)
  set par(first-line-indent: 0pt, justify: false)

  // #align(center, image("../assets/figures/foto-penulis.png", width: 3.5cm))
  // #v(0.6cm)

  entry-fields(
    (
      ([Nama], [#data.mahasiswa.nama]),
      ([Tempat, Tanggal Lahir], [#data.mahasiswa.tempat-lahir, #data.mahasiswa.tanggal-lahir]),
      ([Jenis Kelamin], [#data.mahasiswa.jenis-kelamin]),
      ([Telepon], [#data.mahasiswa.telepon]),
      ([Email], [#data.mahasiswa.email]),
    ),
    col-widths: (4.3cm, 0.3cm, 1fr),
  )

  v(0.8cm)
  text(weight: "bold")[AKADEMIS]
  v(0.4cm)
  entry-fields(
    (
      ([Kuliah], [#data.institusi.departemen -- #data.institusi.nama]),
      ([Angkatan], [#data.mahasiswa.angkatan]),
      ([Semester], [#data.mahasiswa.semester]),
    ),
    col-widths: (4.3cm, 0.3cm, 1fr),
  )
}

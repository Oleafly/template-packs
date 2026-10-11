// ============================================================
// WAJIB EDIT — BAB II PROFIL PERUSAHAAN
// ============================================================

#import "../../template/lib.typ": *
#let data = yaml("../../data.yaml")

= PROFIL PERUSAHAAN

== Profil #data.instansi.nama

[Tuliskan profil singkat instansi/perusahaan tempat kerja praktik. Mencakup latar belakang
berdirinya instansi/perusahaan, bidang usaha atau tugas pokok, visi dan misi, serta
struktur organisasi jika diperlukan.]

== Lokasi

#data.instansi.alamat

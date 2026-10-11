// ============================================================
// WAJIB EDIT — Kata pengantar (maks. 1 halaman)
// ============================================================

#import "../template/lib.typ": *

// ISI KATA PENGANTAR — EDIT DI SINI
#let isi(data) = [
  Puji syukur kehadirat Allah SWT atas rahmat dan karunia-Nya, penulis dapat menyelesaikan Tugas Akhir ini dengan judul *#data.judul.id* sebagai salah satu syarat untuk memperoleh gelar Sarjana Komputer di Institut Teknologi Sepuluh Nopember.

  Penulisan Tugas Akhir ini tidak akan terlaksana dengan baik tanpa bimbingan, dukungan, dan motivasi dari berbagai pihak. Oleh karena itu, penulis ingin menyampaikan ucapan terima kasih yang sebesar-besarnya kepada:

  + Tuhan Yang Maha Esa atas segala rahmat, kesehatan, kekuatan, dan kemudahan yang diberikan sehingga penulis dapat menyelesaikan Tugas Akhir ini.
  + Keluarga, khususnya orang tua dan saudara, yang senantiasa memberikan doa, kasih sayang, dukungan, serta semangat yang tiada henti selama proses penyusunan Tugas Akhir ini.
  + Dosen pembimbing yang telah memberikan bimbingan, arahan, masukan, serta motivasi dengan penuh kesabaran selama proses penyusunan Tugas Akhir ini.
  + Dosen ko-pembimbing yang telah memberikan bimbingan, arahan, dukungan, serta berbagai masukan yang berharga selama proses penelitian dan   penyusunan Tugas Akhir ini.
  + Dosen penguji yang telah memberikan kritik, saran, dan masukan yang konstruktif sehingga penelitian dan Tugas Akhir ini dapat menjadi lebih baik.
  + Seluruh dosen dan tenaga kependidikan di lingkungan program studi yang telah memberikan ilmu, pengalaman, pelayanan, serta dukungan selama penulis menempuh pendidikan.
  + Semua pihak yang telah memberikan bantuan, dukungan, doa, maupun kontribusi, baik secara langsung maupun tidak langsung, sehingga penyusunan Tugas Akhir ini dapat diselesaikan dengan baik.

  PPenulis menyadari bahwa Tugas Akhir ini masih jauh dari sempurna. Oleh karena itu, penulis mengharapkan kritik dan saran yang membangun untuk perbaikan di masa mendatang. Semoga hasil penelitian ini dapat bermanfaat bagi perkembangan ilmu pengetahuan dan teknologi.

  #v(1cm)
  #align(right)[
    *Hormat saya,* \
    *#data.mahasiswa.nama*
  ]
]

// ============================================================
// Layout — tidak perlu diedit
// ============================================================

// halaman-kosong() dipasang eksplisit di main.typ setelah pemanggilan ini
#let kata-pengantar(data) = {
  headz[KATA PENGANTAR]
  v(1cm)
  set par(first-line-indent: 0pt)
  isi(data)
}

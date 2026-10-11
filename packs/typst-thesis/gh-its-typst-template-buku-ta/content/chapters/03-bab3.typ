// ============================================================
// WAJIB EDIT — BAB 3: Metodologi
// ============================================================

= METODOLOGI

== Metode yang Digunakan

Penelitian ini menggunakan pendekatan _Design Thinking_ dalam proses pengembangan antarmuka dan pengalaman pengguna aplikasi “Aicareer”. Pendekatan ini dipilih karena berfokus pada eksplorasi solusi secara kreatif dan iteratif dengan menempatkan pengalaman dan kebutuhan pengguna sebagai prioritas utama dalam merespons setiap permasalahan yang dihadapi.

Lorem Ipsum Dolor Sit Amet.

=== _Empathize_

Fase ini bertujuan membangun pemahaman yang mendalam terhadap pengguna aplikasi Aicareer. Fokus utama fase _Empathize_ adalah menggali data kuantitatif dan kualitatif untuk memahami motivasi, kendala, serta kebutuhan pengguna dalam mempersiapkan karir di era digital. Proses pengumpulan data dilakukan melalui metode survei, observasi, dan wawancara dengan pengguna. Hasil dari tahap ini berupa temuan permasalahan (_pain point_) yang dialami pengguna dalam proses persiapan karir, yang menjadi dasar analisis pada tahap _Define_.

Lorem Ipsum Dolor Sit Amet.

=== _Define_

Lorem Ipsum Dolor Sit Amet.

=== _Ideate_

Lorem Ipsum Dolor Sit Amet.

=== Lorem Ipsum Dolor Sit Amet.

Lorem Ipsum Dolor Sit Amet.

== Instrumen Penelitian

Pada penelitian ini, instrumen yang digunakan meliputi panduan pertanyaan wawancara yang dirancang untuk menggali informasi secara mendalam terkait kebutuhan pengguna, tantangan dalam proses pengembangan karir, serta validasi terhadap solusi yang ditawarkan oleh sistem Aicareer. Sebagai kelanjutan dari riset kebutuhan pengguna tahap awal, pengumpulan data pada penelitian tugas akhir ini dilakukan melalui _in-depth interview_ kepada sepuluh pengguna yang terdiri dari lima mahasiswa tingkat akhir dan lima _fresh graduate_, yang mewakili dua kelompok pengguna yang berada pada fase transisi menuju dunia kerja, serta wawancara dengan seorang praktisi _Human Resource_ (HR).

Lorem Ipsum Dolor Sit Amet.

== Bahan dan Peralatan yang Digunakan

Dalam pelaksanaan penelitian ini, peneliti menggunakan sejumlah bahan dan peralatan untuk mendukung proses pengembangan antarmuka dan pengalaman pengguna aplikasi “Aicareer”. Instrumen penelitian mencakup alat bantu untuk perancangan desain, dokumentasi, serta pengujian prototipe fungsional. Seluruh kebutuhan tersebut diklasifikasikan ke dalam dua kategori utama, yaitu perangkat keras dan perangkat lunak.

=== Perangkat Keras

Perangkat keras yang digunakan dalam penelitian ini mencakup perangkat komputasi utama untuk menjalankan dan mengembangkan aplikasi berupa laptop serta perangkat pendukung lainnya. Spesifikasi perangkat keras disajikan pada @tabel-spesifikasi-perangkat-keras.

#figure(
  table(
    columns: (1fr, 2fr),
    inset: 6pt,
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#D9D9D9") } else { none },
    align: (col, row) => if row == 0 { center } else if col == 0 { left } else { left },
    [*Komponen*], [*Spesifikasi*],
    [Tipe], [Legion 5 15IAH7],
    [Processor], [Intel Core i5 12500H],
    [RAM], [DDR5 (SO-DIMM) 16.0 GB],
    [Storage], [SSD 512 GB],
    [Layar], [15.6" FHD (1920×1080) IPS 300nits Anti-glare, 165Hz, 100% sRGB, Dolby Vision, G-SYNC, DC dimmer],
    [Sistem Operasi], [Windows 11 Home],
  ),
  caption: [Spesifikasi Perangkat Keras],
  supplement: [Tabel],
) <tabel-spesifikasi-perangkat-keras>

=== Perangkat Lunak

Lorem Ipsum Dolor Sit Amet.

== Urutan Pelaksanaan Penelitian

// Hanya digunakan ketika Proposal Tugas Akhir. Untuk Laporan Tugas Akhir tidak menggunakan subbab ini. Hapus subbab ini jika tidak diperlukan.
Penelitian ini direncanakan berlangsung selama enam bulan, terhitung mulai bulan Maret hingga September 2026. Rincian lini masa pengerjaan penelitian disajikan pada @tabel-lini-masa.

#figure(
  table(
    columns: (1cm, 5fr, 0.7fr, 0.7fr, 0.7fr, 0.7fr, 0.7fr, 0.7fr, 0.7fr),
    inset: 6pt,
    stroke: 0.5pt,
    fill: (col, row) => {
      let jadwal = (
        (1,2),
        (2,3),
        (3,4),
        (4,4),(4,5),(4,6),
        (5,5),(5,6),
        (6,6),(6,7),(6,8),
        (7,4),(7,5),(7,6),(7,7),(7,8),
      )
      if row == 0 { rgb("#D9D9D9") }
      else if jadwal.any(p => p.at(0) == row and p.at(1) == col) { rgb("#9CC2E5") }
      else { none }
    },
    align: (col, row) => if row == 0 or col == 0 { center } else if col == 1 { left } else { center },
    [*No*], [*Aktivitas*], [*Mar*], [*Apr*], [*Mei*], [*Jun*], [*Jul*], [*Agu*], [*Sep*],
    [1], [Studi literatur], [], [], [], [], [], [], [],
    [2], [Empati konteks permasalahan], [], [], [], [], [], [], [],
    [3], [Definisi spesifikasi kebutuhan], [], [], [], [], [], [], [],
    [4], [Ideasi solusi], [], [], [], [], [], [], [],
    [5], [Pembuatan purwarupa solusi], [], [], [], [], [], [], [],
    [6], [Evaluasi], [], [], [], [], [], [], [],
    [7], [Penulisan laporan Tugas Akhir], [], [], [], [], [], [], [],
  ),
  caption: [Lini Masa Pengerjaan Tugas Akhir],
  supplement: [Tabel],
) <tabel-lini-masa>

// ============================================================
// WAJIB EDIT — BAB 2: Tinjauan Pustaka
// ============================================================

#import "../../template/lib.typ": *

= TINJAUAN PUSTAKA

== Hasil Penelitian Terdahulu

Penelitian mengenai pengembangan antarmuka dan pengalaman pengguna dengan pendekatan _Design Thinking_ telah banyak dilakukan. Terdapat enam penelitian terdahulu yang memiliki kedekatan topik dan menjadi rujukan dalam penelitian ini, baik dari aspek metodologi perancangan _User Interface_ (UI) dan _User Experience_ (UX), pendekatan _Design Thinking_, maupun pemanfaatan kecerdasan buatan untuk karir.

#figure(
  table(
    columns: (1cm, 2fr, 2fr, 2fr, 2fr),
    inset: 6pt,
    align: (col, row) => if row == 0 { center } else if col == 0 { center } else { left },
    stroke: (x, y) => (top: 0.5pt, bottom: 0.5pt, left: none, right: none),
    fill: (_, row) => if row == 0 { rgb("#D9D9D9") } else { none },
    [*No*], [*Judul*], [*Hasil*], [*Metode*], [*Keterbatasan*],
    [1],
    [Metode Design Thinking Untuk Perancangan UI/UX Pada Aplikasi Konsultasi Karir @aji2023metode],
    [Redesign antarmuka aplikasi KonsultasiKarir yang diuji pada 20 pengguna menggunakan SUS, memperoleh skor rata-rata 90,1.],
    [_Design Thinking_],
    [Luaran penelitian terbatas pada purwarupa desain menggunakan Figma; belum menyentuh validasi fungsionalitas sistem secara langsung .],

    [2], [...], [...], [...], [...],
    [3], [...], [...], [...], [...],
  ),
  caption: [Perbandingan Penelitian Terdahulu],
  supplement: [Tabel],
) <tabel-perbandingan-penelitian-terdahulu>

Berdasarkan @tabel-perbandingan-penelitian-terdahulu hasil penelitian terdahulu, dapat disimpulkan bahwa pendekatan _Design Thinking_ efektif dalam merancang antarmuka dan pengalaman pengguna. Namun, penelitian sebelumnya memiliki keterbatasan, seperti fokus pada purwarupa desain dan kurangnya validasi fungsionalitas sistem secara langsung. Lorem Ipsum Dolor Sit Amet.

== Dasar Teori

Subbab ini membahas tinjauan pustaka sebagai landasan teoritis penelitian. Pembahasan dimulai dari konsep _Design Thinking_, karir digital, serta antarmuka dan pengalaman pengguna. Selanjutnya, pembahasan mengenai perangkat teknis yang digunakan meliputi Figma, Visual Studio Code, prototipe fungsional, dan Maze, serta ditutup dengan metode evaluasi sistem dan kebergunaan yang mencakup Single Ease Question (SEQ), System Usability Scale (SUS), analisis Confidence Interval, Heuristic Evaluation, dan Google Lighthouse.

=== _Design Thinking_

_Design Thinking_ merupakan sebuah pendekatan penyelesaian masalah yang berpusat pada manusia. Pendekatan ini tidak hanya terbatas pada penciptaan benda fisik, tetapi juga mencakup aspek konseptual dan sistemik. Menurut @wolniak2023design, proses Design Thinking didasari oleh empat aturan utama yang menjadi landasan pola pikir inovasi, yaitu:

+ _The Human Rule_ menjelaskan bahwa semua aktivitas desain pada dasarnya bersifat sosial. Aturan ini menekankan bahwa inovasi harus didasarkan pada kebutuhan manusia atau pengguna sebagai aset paling berharga dalam proses desain.
+ Lorem Ipsum Dolor Sit Amet.

Dalam perkembangannya, terdapat variasi model _Design Thinking_ yang dikemukakan oleh berbagai institusi. @gibbons2016design mengusulkan enam fase yang mencakup tahap _Implement_, sementara @idf2025design menggunakan lima fase inti yang lebih berfokus pada siklus iteratif desain sebelum implementasi. Penelitian ini mengadopsi model lima fase dari @idf2025design sebagai kerangka kerja utama, sebagaimana ditunjukkan pada @gambar-design-thinking-process.

#gambar(
  "/assets/figures/design-thinking-process.jpg",
  caption: [Diagram Proses Design Thinking (Sumber: Interaction Design Foundation, 2025)],
  width: 75%,
) <gambar-design-thinking-process>

Lorem Ipsum Dolor Sit Amet.

=== Karir Digital

Perkembangan teknologi telah memicu pergeseran fundamental dari sistem tradisional menuju digital, yang secara langsung mendorong terciptanya berbagai lapangan kerja baru. Transformasi ini diperkirakan akan mengubah 44% keterampilan pekerja dalam lima tahun ke depan. Profesi seperti _AI and Machine Learning Specialists_, _Sustainability Specialists_, dan _Business Intelligence Analysts_ masuk dalam daftar pekerjaan yang berkembang paling pesat @wef2023jobs.

Lorem Ipsum Dolor Sit Amet.

=== Antarmuka Pengguna

Antarmuka pengguna atau _User Interface_ (UI) merupakan komponen fundamental dalam sistem interaktif yang berperan sebagai penghubung antara pengguna dan sistem. Antarmuka mencakup seluruh elemen yang dapat ditangkap oleh indra manusia serta memungkinkan interaksi secara langsung. Dalam konteks sistem digital, antarmuka pengguna merepresentasikan bagaimana desain grafis dan struktur visual diatur untuk memfasilitasi interaksi pengguna dengan aplikasi atau situs web. Seluruh elemen yang ditampilkan kepada pengguna, seperti teks, ikon, gambar, tombol, serta sistem navigasi yang dapat dioperasikan, merupakan bagian dari antarmuka pengguna @faridha2024metode.

Lorem Ipsum Dolor Sit Amet.

=== Lorem Ipsum Dolor Sit Amet

Lorem Ipsum Dolor Sit Amet.

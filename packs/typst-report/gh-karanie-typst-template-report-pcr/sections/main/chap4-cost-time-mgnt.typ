= Jadwal dan Aggaran Biaya
== Jadwal
Waktu proyek akhir ditargetkan dari bulan Januari 2024 sampai dengan Juli 2024. Berikut penjadwalan pelaksanaan proyek akhir pada @jadwal-pelaksanaan.

#figure(
  [
    #let redd() = [#table.cell(fill: rgb(220, 50, 50, 255))[]]
    #table(
      columns: (auto, auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, left, left, left, left, left, left, left, left),
      table.header(
        table.cell(fill: gray)[#strong[No.];],
        table.cell(fill: gray)[#strong[Tahapan];],
        table.cell(fill: gray)[#strong[Jan];],
        table.cell(fill: gray)[#strong[Feb];],
        table.cell(fill: gray)[#strong[Mar];],
        table.cell(fill: gray)[#strong[Apr];],
        table.cell(fill: gray)[#strong[Mei];],
        table.cell(fill: gray)[#strong[Jun];],
        table.cell(fill: gray)[#strong[Jul];],
      ),
      table.hline(),
      [1],
      [Bimbingan],
      redd(),
      redd(),
      [],
      [],
      [],
      [],
      [],
      [2],
      [Pembuatan Proposal],
      redd(),
      redd(),
      [],
      [],
      [],
      [],
      [],
      [3],
      [Seminar Proposal],
      [],
      [],
      redd(),
      [],
      [],
      [],
      [],
      [4],
      [Revisi Proposal],
      [],
      [],
      redd(),
      [],
      [],
      [],
      [],
      [5],
      [Pengembangan],
      [],
      [],
      redd(),
      redd(),
      redd(),
      redd(),
      [],
      [6],
      [Pengujian],
      [],
      [],
      [],
      [],
      [],
      redd(),
      [],
      [7],
      [Penulisan Laporan],
      [],
      [],
      [],
      [],
      [],
      redd(),
      redd(),
      [8],
      [Sidang PA],
      [],
      [],
      [],
      [],
      [],
      [],
      redd(),
    )
  ],
  caption: [Jadwal Pelaksanaan],
  kind: "tabel",
  supplement: "Tabel",
) <jadwal-pelaksanaan>

== Anggaran Biaya
Terdapat beberapa variabel yang mempengaruhi biaya. Variabel tersebut dapat berubah tergantung kebutuhan. Berikut asumsi variabel dari sistem yang dibangun.

+ Jumlah #emph[developer];: 1

+ Sistem yang dibangun berjalan dalam satu server

+ Server memiliki 2 Core CPU, 2 GB RAM, dan 20GB penyimpanan

+ Server dikaitkan dengan 1 alamat IP publik dengan #emph[bandwidth] tidak terbatas

+ Alamat IP dipasang dengan #emph[subdomain] dari domain perusahaan yang sudah ada

+ #emph[Let’s Encrypt] digunakan sebagai sertifikat SSL

+ Semua perangkat lunak yang dipakai dalam sistem dan yang dipakai untuk pengembangan bersifat gratis dan #emph[open source]

Perkiraan biaya yang diperkirakan dari variabel yang diasumsikan ditampilkan pada @cost-breakdown.

#figure(
  [
    #set par(justify: false)
    #set align(start)
    #table(
      columns: (1.25fr, 1fr),
      table.header(
        table.cell(fill: gray)[#strong[Jenis Biaya];],
        table.cell(fill: gray)[#strong[Estimasi Biaya];]
      ),
      table.hline(),
      table.cell(colspan: 2, fill: luma(85%))[#strong[Biaya Muka];],
      [Biaya pengembangan], [Rp. 10.000.000,00/Bulan x 4 Bulan],
      [#strong[Total];], [#strong[Rp. 40.000.000,00];],
      table.cell(colspan: 2, fill: luma(85%))[#strong[Biaya Berulang];],
      [1xVPS 2 CPUs, 2GB RAM, 20GB Storage], [Rp. 87.000,00/Bulan],
      [1xSubdomain], [Gratis],
      [1xSertifikat SSL], [Gratis],
      [#strong[Total];], [#strong[Rp. 87.000,00/Bulan];],
    )
  ],
  caption: [Estimasi Anggaran Biaya],
  kind: "tabel",
  supplement: "Tabel"
) <cost-breakdown>

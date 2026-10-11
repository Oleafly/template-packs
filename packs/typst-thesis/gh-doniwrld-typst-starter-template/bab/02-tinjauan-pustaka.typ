= Tinjauan Pustaka

== Konsep Utama

Jelaskan teori, konsep, atau penelitian terdahulu yang relevan di sini. Untuk memasukkan kutipan, cukup tulis tanda `@` diikuti citation key, misalnya @tufte2001. Typst akan membentuk nomor sitasi dan daftar pustaka secara otomatis.

== Contoh Tabel

#table(
  columns: 3,
  stroke: .5pt,
  align: center,
  table.header([*No.*], [*Penulis*], [*Temuan*]),
  [1], [Nama Penulis], [Ringkasan temuan],
)

== Contoh Gambar

Simpan file gambar di folder `assets`, lalu sisipkan seperti ini:

```typst
#figure(image("assets/nama-gambar.png", width: 70%), caption: [Keterangan gambar])
```

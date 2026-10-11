// ============================================================
// WAJIB EDIT — BAB 4: Hasil dan Pembahasan
// ============================================================

#import "../../template/lib.typ": kode-sumber, kode-semu

= HASIL DAN PEMBAHASAN

== Antarmuka Pengguna Iterasi Pertama (_Functionality_)

Pada tahap ini, pengembangan aplikasi Aicareer dilakukan menggunakan pendekatan _Design Thinking_, dengan fokus utama pada pengujian fungsionalitas sistem serta kesesuaian fitur terhadap kebutuhan pengguna. Selain itu, beberapa solusi yang telah dirancang pada tahap awal disesuaikan dan disempurnakan kembali berdasarkan hasil riset lanjutan serta ruang lingkup penelitian tugas akhir ini.

=== _Empathize_

Pada tahap _Empathize_, penelitian dilakukan untuk memperoleh pemahaman mendalam mengenai kebutuhan dan permasalahan yang dialami pengguna agar aplikasi Aicareer dapat memberikan solusi yang sesuai dengan kebutuhan pengguna. Lorem Ipsum Dolor Sit Amet.

=== Lorem Ipsum Dolor Sit Amet

Lorem Ipsum Dolor Sit Amet.

=== Hasil Penelitian

Algoritma pencarian jalur karir yang digunakan dalam sistem dapat dideskripsikan sebagai berikut.

#kode-semu(caption: "Algoritma Rekomendasi Jalur Karir")[
  ```
  1. INPUT  : profil pengguna P, basis data karir K
  2. OUTPUT : daftar rekomendasi karir terurut R
  3. FOR EACH karir k IN K:
       s(k) <- cosine_similarity(vektor_pengguna(P), vektor_karir(k))
  4. SORT K DESCENDING BY s(k)
  5. RETURN top 5 dari K
  ```
] <kode-algoritma-rekomendasi>

Berdasarkan @kode-algoritma-rekomendasi, kompleksitas algoritma adalah O(|K| log |K|) dengan |K| adalah jumlah karir dalam basis data.

=== Hasil Penelitian A

Lorem Ipsum Dolor Sit Amet.

=== Hasil Penelitian B

Lorem Ipsum Dolor Sit Amet.

== Pembahasan

Lorem Ipsum Dolor Sit Amet.

=== Pembahasan A

Implementasi algoritma rekomendasi dilakukan menggunakan bahasa Python dengan memanfaatkan pustaka `scikit-learn` untuk menghitung kemiripan kosinus.

#kode-sumber(caption: "Implementasi Fungsi Rekomendasi Karir")[
  ```python
  from sklearn.metrics.pairwise import cosine_similarity
  import numpy as np

  def rekomendasikan_karir(profil_pengguna, basis_data_karir, top_k=5):
      skor = cosine_similarity([profil_pengguna], basis_data_karir)[0]
      indeks_terurut = np.argsort(skor)[::-1]
      return indeks_terurut[:top_k]
  ```
] <kode-rekomendasi-karir>

Fungsi pada @kode-rekomendasi-karir menerima vektor profil pengguna dan matriks basis data karir, kemudian mengembalikan indeks dari `top_k` karir dengan skor tertinggi.

=== Pembahasan B

Lorem Ipsum Dolor Sit Amet.

#set page(paper: "a4", margin: 0cm, header: none, footer: none)

#let kaynak = "./00_on_sayfalar.pdf"
#let ekle_sayfa(no) = {
  image(kaynak, page: no, width: 100%, height: 100%)
  pagebreak()
}

#ekle_sayfa(1) // 1. Ön Kapak
#ekle_sayfa(2) // 2. Birinci Sayfa
#ekle_sayfa(3) // 3. İkinci Sayfa
#ekle_sayfa(4) // 4. Değerlendirme Formu

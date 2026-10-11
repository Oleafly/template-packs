// =============================================================================
// HİTİT ÜNİVERSİTESİ ENDÜSTRİ MÜHENDİSLİĞİ BÖLÜMÜ
// 1. STAJ DEFTERİ (TYPST)
// =============================================================================

#let meta = (
  title: "Hitit Üniversitesi Endüstri Mühendisliği 1. Staj Defteri",
  author: "Öğrenci Adı Soyadı",
)

#set document(
  title: meta.title,
  author: meta.author,
)

// Kılavuz Standartları: Times New Roman, 12 pt, Türkçe
#set text(
  font: ("TeXGyreTermesX", "Liberation Serif"),
  size: 12pt,
  lang: "tr",
)

// Kılavuz Standartları: 1.5 Satır Aralığı, İki Yana Yaslı, 1.2 cm Paragraf Girintisi (1 Tab)
#set par(
  justify: true,
  leading: 0.85em,
  first-line-indent: 1.2cm,
)

// Kılavuz Standartları: Başlıklar 12 pt ve Kalın (Bold)
#set heading(numbering: "1.1.")
#show heading: it => block(above: 1.5em, below: 0.8em)[
  #set text(size: 12pt, weight: "bold")
  #it
]

// Şekil ve Tablo İsimlendirmeleri: 12 pt, Kalın etiket
#show figure.caption: set text(size: 12pt)
#show figure.caption: it => [
  *#it.supplement #it.counter.display(it.numbering)*: #it.body
]

// =============================================================================
// 1. ÖN SAYFALAR (Kapak, 1. Sayfa, 2. Sayfa, Değerlendirme Formu)
// =============================================================================
#include "sections/00_on_sayfalar.typ"

// =============================================================================
// 2. İÇİNDEKİLER TABLOSU
// =============================================================================
#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 3cm, left: 2.5cm, right: 1.5cm),
  numbering: "i",
  footer: align(center, context counter(page).display("i")),
)
#counter(page).update(1)

#show outline.entry.where(level: 1): it => {
  v(0.6em)
  strong(it)
}

#outline(
  title: [İÇİNDEKİLER],
  indent: auto,
)
#pagebreak()

// =============================================================================
// 3. DEFTERİN ANA GÖVDESİ (13 ZORUNLU BÖLÜM)
// =============================================================================
#set page(
  numbering: "1",
  footer: align(center, context counter(page).display("1")),
)
#counter(page).update(1)

#let bolumler = (
  "01_isyeri_bilgisi",
  "02_em_faaliyetleri",
  "03_tesis_yeri_secimi",
  "04_uretim_sistemi",
  "05_imalat_usulleri",
  "06_urun_akisi_tasimalar",
  "07_uretim_planlama_kontrol",
  "08_kalite_kontrol",
  "09_yonetim_bilisim_sistemleri",
  "10_maliyet_unsurlari",
  "11_verimlilik_olcumu",
  "12_ar_ge_ur_ge",
  "13_degerlendirme_sonuc",
)

#for bolum in bolumler {
  include "sections/" + bolum + ".typ"
}

// =============================================================================
// 4. EKLER
// =============================================================================
#pagebreak()
#heading(numbering: none, outlined: true)[EKLER]
#include "sections/ekler.typ"

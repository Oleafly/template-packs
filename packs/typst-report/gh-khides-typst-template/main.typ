#import "template/template_doc.typ": *

#show: project.with(
  title: [
    #text(font: ("Harano Aji Mincho", "Noto Serif"))[]
    #v(30pt)

    #text(font: ("Harano Aji Mincho", "Noto Serif"))[]
  ],
  title-header: "",
  datetime: "",
  authors: (
    (
      name-ja: "",
      presenting: false,
    ),
  ),
  notes: none,
  lang: "jp",
  date: datetime(year: 2024, month: 12, day: 2),
  abstract: [
  ],
  font-size: 10.5pt,
  body-font: ("Harano Aji Mincho", "Noto Serif", "FreeSerif"),
  sans-font: ("Harano Aji Gothic", "Noto Sans", "FreeSans"),
  math-font: ("STIX Math", "Latin Modern Math", "TeX Gyre Termes Math"),
  leading: 1.0em,
  margin: (left:1in, top:1in, right:1in, bottom:1in),
  keywords:none,
  JEL: none
)

// 章ごとのインクルード
// #include "chaps/chapter1.typ"
// #pagebreak()

#bibliography(
  "bibliography.bib",
  title: [参考文献],
  style: "ieee",
)
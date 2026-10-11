// Referenz: https://github.com/citation-style-language/styles/blob/master/apa-6th-edition.csl
#import "../config/sections.typ": arabic_section

#let bibliography_section() = {
  arabic_section(
    "Literaturverzeichnis",
    [
      #bibliography(
        "../bibliography.bib",
        style: "../apa-6th-edition.csl",
        title: none,
      )
    ],
    header_title: "Literaturverzeichnis",
  )
}

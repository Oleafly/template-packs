#set page(
  paper: "a4",
  margin: (top: 2.2cm, bottom: 2.5cm, left: 2.55cm, right: 2.55cm),
  numbering: "i",
  number-align: end
)

#set text(
  size: 12pt,
  font: "Arial",
  lang: "de",
  hyphenate: true
)

#show cite: it => [
  #{
    show "(": "(vgl. "
    show ")": ""
    it
  }).
]

#set par(
  justify: true,
  leading: 1.3em,
  spacing: 6pt
)

#set block(spacing: 6pt)

#set heading(numbering: "1.1")

#include "deckblatt.typ"

#counter(page).update(1)

#include "Einleitung/ewerkl.typ"
#include "Einleitung/kierkl.typ"
#[
#set page(margin: (top: 0cm, bottom: 0cm, left: 0cm, right: 0cm))
#image("public/files/hilfsmittelangabe_seite_1.svg", width: 100%)
#image("public/files/hilfsmittelangabe_seite_2.svg", width: 100%)
#image("public/files/hilfsmittelangabe_seite_3.svg", width: 100%)

]

#outline(title: [
  Inhaltsverzeichnis

  \
])

#pagebreak()

#include "Einleitung/abkverz.typ"
#include "Einleitung/abbverz.typ"
#include "Einleitung/tabverz.typ"
#include "Einleitung/abstract.typ"

#set page(numbering: "1")
#counter(page).update(1)

#include "Einleitung/einleitung.typ"
#include "Hauptteil/patterns.typ"
#include "Hauptteil/kapitel_eins.typ"
#include "Hauptteil/kapitel_zwei.typ"
#include "Hauptteil/kapitel_drei.typ"
#include "Hauptteil/kapitel_vier.typ"
#include "Hauptteil/kapitel_fuenf.typ"
#include "Hauptteil/kapitel_sechs.typ"
#include "Hauptteil/kapitel_sieben.typ"

#include "Schluss/litverz.typ"

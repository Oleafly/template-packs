#include "abschnitte/deckblatt.typ"


#set text(font: "Cambria", size: 12pt, lang: "de")
#set page(margin: (inside: 4cm, outside: 2.5cm))
#set par(justify: true)

#set heading(numbering: none)
#show heading: set text(
  font: "Calibri",
  weight: "medium",
  fill: color.rgb(51, 51, 153),
)
#show heading: it => {
  let kapitel = it.level == 1
  if kapitel {
    pagebreak(weak: true)
    v(15%)

    block(sticky: true)[
      #text(font: "Calibri", weight: "medium", fill: color.rgb(51, 51, 153))[
        #if it.numbering != none and it.numbering == "1." {
          [Kapitel #counter(heading).display("1"): ]
        }
        #it.body
      ]
      
      #v(0.5em)
      #line(length: 100%, stroke: 0.5pt)
    ]
  } else {
    it
  }
  v(2em / it.level)
}
#show heading.where(level: 1): set heading(supplement: [Kapitel])

#set page(numbering: "i")

#include "abschnitte/selbstständigkeitserklärung.typ"
#include "abschnitte/abstract.typ"

// Füllpunkte (Leader) für Level-1-Einträge deaktivieren
#show outline.entry.where(level: 1): set outline.entry(fill: none)

// 1em Abstand vor Level-1-Einträgen einfügen
#show outline.entry.where(level: 1): it => {
  v(1em, weak: true)
  it
}

= Inhaltsverzeichnis
#outline(title: none, depth: 2)

// --- ÜBERGANG ZUM HAUPTTEIL ---
#set heading(numbering: "1.")

#pagebreak(weak: true)
#set page(numbering: none, footer: none)
#pagebreak(to: "odd", weak: true)

#set page(
  numbering: "1",
  footer: context {
    let p = here().page()
    let chapter-here = query(heading.where(level: 1)).any(h => h.location().page() == p)
    let c = counter(page).display("1")
    
    if chapter-here {
      align(center)[#c]
    } else if calc.odd(p) {
      align(right)[Seite #c]
    } else {
      align(left)[Seite #c]
    }
  }
)
#counter(page).update(1)
#include "abschnitte/schriftteil.typ"


// --- ÜBERGANG ZUM ANHANG ---
#set heading(numbering: "A")
#counter(heading).update(0)

#pagebreak(weak: true)
#set page(numbering: none, footer: none)
#pagebreak(to: "odd", weak: true)

// Anhang wenn nicht benötigt auskommentieren
#set page(footer: auto, numbering: "a")
#counter(page).update(1)
#include "abschnitte/anhang.typ"

#set heading(numbering: none)

// Diese werden bei der Verwendung von `figure` automatisch ausgefüllt.
= Abbildungsverzeichnis
#outline(target: figure.where(kind: image), title: none)

= Tabellenverzeichnis
#outline(target: figure.where(kind: table), title: none)


= Literaturverzeichnis
// Quellen in das Biblatex Format aus Citavi/Zotero/... in `literatur.bib` exportieren und im Text mit `@schluessel` referenzieren
#bibliography("literatur.bib", title: none)

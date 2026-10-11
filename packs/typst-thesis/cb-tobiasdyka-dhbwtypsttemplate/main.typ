// =============================================================
// main.typ
// Einstiegspunkt der Arbeit.
// Kompilieren: typst compile main.typ
// Watch-Modus: typst watch main.typ
// =============================================================

#import "template.typ": *
#import "metadata.typ": meta

#show: dhbw-vorlage

// 1. Titelblatt (einzige Seite ohne Header/Footer)
#titelblatt()
#counter(page).update(1)

// 2. Sperrvermerk (flag-gesteuert via metadata.typ)
#if meta.zeige-sperrvermerk {
  include "chapters/00_sperrvermerk.typ"
}

// 3. Erklärung
#include "chapters/00_erklaerung.typ"

// 4. Danksagung (optional)
// #include "chapters/00_danksagung.typ"

// 4. Zusammenfassung
#include "chapters/00_zusammenfassung.typ"

// 5. Abstract (optional - Kommentar entfernen um zu aktivieren)
// #include "chapters/00_abstract.typ"

// 6. Inhaltsverzeichnis
#pagebreak()
#outline(depth: 3, indent: 1em)

// 7+8. Abbildungs- und Tabellenverzeichnis (optional - vorne)
// #pagebreak()
// #outline(title: [Abbildungsverzeichnis], target: figure.where(kind: image))
// #pagebreak()
// #outline(title: [Tabellenverzeichnis], target: figure.where(kind: table))

// 9. Abkürzungsverzeichnis (optional - vorne)
// #pagebreak()
// #include "chapters/00_abkuerzungen.typ"

// 10. Hauptteil - arabische Nummerierung ab 1
#set page(numbering: "1", footer: dhbw-footer("1"))
#counter(page).update(1)

#include "chapters/01_einleitung.typ"
#include "chapters/02_grundlagen.typ"
#include "chapters/03_konzept.typ"
#include "chapters/04_umsetzung.typ"
#include "chapters/05_fazit.typ"

// 11. Anhang
#pagebreak()
#counter(page).update(1)
#set page(
  numbering: (..nums) => "A-" + str(nums.pos().first()),
  footer: dhbw-footer("1", prefix: "A-"),
)
#include "appendix/A_anhang.typ"

// 12. Glossar
#pagebreak()
#heading(numbering: none, outlined: true)[Glossar]
#include "chapters/00_glossar.typ"

// 13. Literaturverzeichnis
#pagebreak()
#heading(numbering: none, outlined: true)[Literaturverzeichnis]
#bibliography("literature.bib", title: none, style: "ieee")

// 14. Abbildungsverzeichnis (hinten)
#pagebreak()
#heading(numbering: none, outlined: true)[Abbildungsverzeichnis]
#outline(title: none, target: figure.where(kind: image))

// 15. Tabellenverzeichnis (hinten)
#pagebreak()
#heading(numbering: none, outlined: true)[Tabellenverzeichnis]
#outline(title: none, target: figure.where(kind: table))

// 16. Abkürzungsverzeichnis (hinten)
#pagebreak()
#heading(numbering: none, outlined: true)[Abkürzungsverzeichnis]
#include "chapters/00_abkuerzungen.typ"
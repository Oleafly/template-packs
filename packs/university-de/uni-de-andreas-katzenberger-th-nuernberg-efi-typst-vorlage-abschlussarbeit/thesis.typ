// =============================================================================
//  thesis.typ  --  Hauptdokument der Abschlussarbeit (Typst)
// -----------------------------------------------------------------------------
//  Kompilieren:   typst compile thesis.typ
//  Live-Vorschau: typst watch thesis.typ
//  (In VS Code mit der Tinymist-Erweiterung genuegt Speichern.)
// =============================================================================

#import "lib.typ": *

// -----------------------------------------------------------------------------
#let titel = [Vollstaendiger Titel]
#let artderarbeit = [Bachelor-Arbeit]
#let autor = [Vorname Nachname]
#let autorBinding = [Vorname#h(0.3cm)N a c h n a m e]
#let studiengang = [Medizintechnik]
#let vertiefung = [Elektrotechnik/Informationstechnik]
#let matrikelnr = [xxxxxxx]
#let semester = [Sommersemester 20xx]
#let abgabedatum = [xx\. Monat 20xx]
#let erstgutachter = [Prof.#sym.space.thin Dr.#sym.space.nobreak Vorname Nachname]
#let zweitgutachter = [Prof.#sym.space.thin Dr.#sym.space.nobreak Vorname Nachname]
#let betreuer = [Dr.#sym.space.thin #sym.space.nobreak Vorname Nachname]
#let unternehmen = [Name Unternehmen]
#let schlagworte = [Schlagwort1, Schlagwort2, SW3, SW4, SW5]
#let logo = "figures/Miscellaneous/01_Ohm_Logo.png"
#let hochschule = [Technische Hochschule Nürnberg Georg Simon Ohm]
#let fakultaet = [Fakultät Elektrotechnik Feinwerktechnik Informationstechnik]

// -----------------------------------------------------------------------------
//  Globales Layout aktivieren
// -----------------------------------------------------------------------------
#show: thesis.with(
  titel: titel,
  autor: "Vorname Nachname",
  keywords: ("Schlagwort1", "Schlagwort2", "SW3", "SW4", "SW5"),
)

// =============================================================================
//  FRONTMATTER
// =============================================================================

// --- Binding-Cover (Einband) + Leerseite ---
#binding-cover(
  logo: logo, hochschule: hochschule, fakultaet: fakultaet,
  studiengang: studiengang, artderarbeit: artderarbeit,
  autorBinding: autorBinding, titel: titel, semester: semester,
)

// --- Deckblatt (Cover) ---
#cover(
  logo: logo, hochschule: hochschule, fakultaet: fakultaet,
  studiengang: studiengang, vertiefung: vertiefung, artderarbeit: artderarbeit,
  autor: autor, matrikelnr: matrikelnr, titel: titel, semester: semester,
  abgabedatum: abgabedatum, erstgutachter: erstgutachter,
  zweitgutachter: zweitgutachter, betreuer: betreuer, unternehmen: unternehmen,
  schlagworte: schlagworte,
)

// --- Offizielle pruefungsrechtliche Erklaerung (PDF der TH Nuernberg) ---
//  Typst kann keine PDF-Seiten direkt einbetten.
//  Beim make-Befehl wird hier absichtlich eine deutliche Platzhalter-Seite angezeigt.
//  Das Build-Skript ersetzt exakt diese Seite spaeter durch die echte PDF.
#let declaration_placeholder_marker = "DECLARATION_PLACEHOLDER_RUN_BUILD_PS1"
#page(margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 2cm), header: none, footer: none, numbering: none)[
  #align(center + horizon)[
    #block(inset: 14pt, stroke: 1.5pt + rgb("#b00020"), radius: 4pt)[
      #set text(fill: rgb("#b00020"), weight: "bold", size: 17pt)
      WARNING: Declaration PDF is not embedded in this quick build.
      #v(0.9em)
      #set text(fill: black, weight: "regular", size: 12pt)
      Run ./buildFinalPDF.ps1 (Windows) or ./buildFinalPDF.sh (Linux) before handing in or sharing the final thesis PDF.
      #v(0.9em)
      #set text(fill: luma(70%), size: 8pt)
      #declaration_placeholder_marker
    ]
  ]
]

// --- Abstract & Disclaimer: arabische Seitenzahlen ab 4 ---
#set page(numbering: "1")
#counter(page).update(4)

#include "content/0_abstract.typ"
#pagebreak(weak: false)
#include "content/disclaimer.typ"

// --- Inhaltsverzeichnis: roemische Seitenzahlen ---
#set page(numbering: "I")
#table-of-contents()

// =============================================================================
//  MAINMATTER: arabische Seitenzahlen (Zaehler laeuft fort)
// =============================================================================
#pagebreak(weak: false)
#set page(numbering: "1")

#include "content/1_intro.typ"
#include "content/2_first_content_chapter.typ"
#include "content/3_second_content_chapter.typ"
#include "content/4_third_content_chapter.typ"
#include "content/5_fourth_content_chapter.typ"
#include "content/6_summary.typ"
#include "content/7_outlook.typ"

// =============================================================================
//  BACKMATTER: Literaturverzeichnis + Verzeichnisse
// =============================================================================
#{
  show link: set text(ligatures: false)
  bibliography("refs.bib", style: "styles/ieee-typst.csl", title: [Bibliography])
}

#list-of-figures()
#list-of-tables()
#list-of-listings()

// =============================================================================
//  APPENDIX: Kapitel "Appendix A ...", Seitenzahlen "A-1" (pro Kapitel neu)
// =============================================================================
#in-appendix.update(true)
#counter(heading).update(0)
#set heading(numbering: "A.1")
#set page(numbering: (..n) => context {
  let c = calc.max(counter(heading).get().first(), 1)
  [#numbering("A", c)-#n.pos().first()]
})

#include "content/appendix_figures.typ"
#include "content/appendix_listings.typ"
#include "content/appendix_digital_appendix.typ"

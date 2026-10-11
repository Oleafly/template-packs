#import "tubaf_template.typ" as tubaf


// function for table of symbols and acronyms
#let table_of_symbols() = {
  show outline: set heading(outlined: true)
  outline(
    title: "Symbol- und Abkürzungsverzeichnis",
    target: figure.where(caption: "-")
  )

  text()[*Formelzeichen*]
  grid(
    columns: (1fr, 1cm, 8fr),
    gutter: .5em,
    $bb(Z)$, "", [Menge der ganzen Zahlen],
    $bb(R)$, "", [Menge der reellen Zahlen],
  )

  linebreak()
  text()[*Abkürzungen*]
  grid(
    columns: (1fr, 1cm, 8fr),
    gutter: .5em,
    "Cobot", "", [kollaborativer Roboter],
  )
}


// report template
#show: tubaf.report.with(
  type: "Praktikumsbericht",
  title: "Fachpraktikum Robotik bei wichtigem Unternehmen",
  subtitle: "Subtitel des Berichts",
  authors: ((
    name: "Shorton Kreditz",
    studentID: "12345",
  ),),
  supervisors: ((
    title: "Dipl.-Ing.",
    name: "Max Slacker",
  ),(
    title: "M. Sc.",
    name: "Needa Jobson"
  )),
  examiners: ((
    title: "Prof. Dr.-Ing. Dr. h.c.",
    name: "Nick Nayme",
  ),),
  lang: "de",
  extra_outlines: (table_of_symbols,),
  //references: "references.bib"
)

= Einleitung
#figure(
  image("TUBAF_Logo_blau.svg"),
  caption: tubaf.flex-caption(
    long: [Das Markenlogo ist das zentrale, identitätsstiftende Kernelement im visuellen Auftritt der Universität.],
    short: [Markenlogo])
)
#lorem(100)


= Wissensstand
#lorem(200)


*Die folgenden Hinweise sind eher nicht in einer Abschlussarbeit zu verwenden, da sie zu informell sind, aber für Praktika etc. vlt:*
#tubaf.note(lang: "de", [Dies ist ein informeller Hinweis])
#tubaf.tip(lang: "de", [Verwende diese Sektion, für Tipps.])
#tubaf.warning(lang: "de", [Dies ist eine Warnung.])

= Untersuchungen
#lorem(50)
== Lösungsweg
#lorem(200)
=== Berechnungen
#lorem(100)
== Planung
#lorem(200)
== Durchführung
#lorem(200)

= Ergebnisse
#lorem(300)

= Zusammenfassung
#lorem(100)

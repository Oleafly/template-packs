#import "@preview/abbr:0.3.0"
#import "macros.typ"
// latex style
#set par(leading: 0.6em, spacing: 1.1em, first-line-indent: 0em, justify: true)
#set text(font: "New Computer Modern", lang: "de")
#show raw: set text(font: "FiraMono Nerd Font")
#show heading: set block(above: 1.4em, below: 1em)
#set math.equation(numbering: "1.")

// Überschriften von Figuren und Bildbreite einstellen
#set figure.caption(position: top)
#show figure.caption: set text(size: 1.1em)
#show figure.where(kind: image): set block(width: 80%)

// page setup
#set page(
  paper: "a4",
  number-align: center,
  numbering: "1",
)

#show: abbr.show-rule

#macros.titlePage(
  fachbereich: "Distributed Systems Group",
  titel: "Eine Bachelorarbeit",
  name: "Max Mustermann",
  matikelnummer: "1234567",
  email: "max-mustermann@student.uni-kassel.de",
  erstprüfer: "Prof. Charles",
  zweitprüfer: "Prof. Bob",
  betreuer: "Alice",
)

// Abkürzungen
#abbr.make(
  ("HTML", "Hypertext Markup Language"),
)

#counter(page).update(1)

#pagebreak()
#heading("Abstract", numbering: "I.")

#lorem(100)

#pagebreak()

#outline(depth: 3)
#set heading(numbering: "1.")
#counter(heading).update(0)
#pagebreak()

= Typst

Typst @noauthor_typst_2025 ist eine moderne Alternative zu LaTeX.

Schreibt sich wie Markdown, mit live Preview, und Scripting im Text.

== Mit Unterüberschriften

Kapitel sind ganz einfach anzulegen.

#lorem(100)

== Ein etwas Quellcode

Code kann mit dem Macro `#macros.codeBlock` erstellt werden.

#macros.codeBlock(
  ```py
  print('Hello World')
  ```,
  caption: "Mit Überschrift",
  subtext: [Und optionalem Kommentar.],
) <block1>

Zusätzlich kann man @block1 einfach referenzieren.

== Abbildungen

Einfach mit figure ein Bild einfügen.

#figure(
  image("assets/cat.jpg"),
  caption: [eine Katze],
)

== Abkürzungen
@HTML ist eine Abkürzung, sie wird automatisch übernommen.

== Mathe

Formeln gehen Inline $a^2 + b^2=c^2$
$
  f(x) = cases(
    x &"if" x < 0,
    1 &"if" x=0,
    -x &"if" x>0
  )
$ <formel1>


Oder als eigene Linie dargestellt und referenziert werden, wie in @formel1.

// Ende der Arbeit, setze die Überschriften neu und
#set heading(numbering: "I.")
#counter(heading).update(1)
#abbr.list(title: "Abkürzungsverzeichnis")
#pagebreak()

= Abbildungsverzeichnis
#outline(
  title: none,
  target: figure.where(kind: image),
)

= Tabellenverzeichnis
#outline(
  title: none,
  target: figure.where(kind: table),
)

= Codeverzeichnis
#outline(
  title: none,
  target: figure.where(kind: "code"),
)
#pagebreak()


= Bibliographie
#bibliography("references.bib", full: true, style: "ieee", title: none)



#pagebreak()
#set par(spacing: 1.55em, first-line-indent: 0em, justify: true)
#heading("Ehrenwörtliche Erklärung", outlined: false, numbering: none)
Ich versichere hiermit, dass ich die vorliegende Arbeit selbständig und ohne Benutzung anderer als der
angegebenen Quellen und Hilfsmittel verfasst habe. Wörtlich übernommene Sätze oder Satzteile sind als
Zitat belegt, andere Anlehnungen, hinsichtlich Aussage und Umfang, unter Quellenangabe kenntlich
gemacht.

Die Arbeit hat in gleicher oder ähnlicher Form noch keiner Prüfungsbehörde vorgelegen und ist
nicht veröffentlicht. Sie wurde nicht, auch nicht auszugsweise, für eine andere Prüfungs- oder
Studienleistung verwendet
#v(4em)
#grid(
  rows: 1,
  columns: 2,
  column-gutter: (0.5fr, 0.5fr),
  grid.cell(
    [#line(length: 70%) #v(-1em) Ort, Datum],
  ),
  grid.cell(
    align: right,
    [#line(length: 70%) #v(-1em) Unterschrift],
  ),
)

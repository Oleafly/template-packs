#import "../../globals.typ": lightblue, lighterblue, mainblue
#import "../../utils/prompt_figure.typ": prompt-figure

#let figure_outline_entry(kind, supplement) = it => {
  let el = it.element
  if el.func() != figure or el.kind != kind {
    it
  } else {
    let loc = el.location()
    let prefix = context {
      let chapter = counter(heading.where(level: 1)).at(loc).first()
      let num = counter(figure.where(kind: kind)).at(loc).first()
      [#supplement #chapter.#num]
    }
    link(loc, it.indented(prefix, it.inner()))
  }
}

= Verzeichnisse

== Abbildungsverzeichnis

#show outline.entry: figure_outline_entry(image, [Abbildung])
#outline(title: none, target: figure.where(kind: image))

#pagebreak()

== Tabellenverzeichnis

#show outline.entry: figure_outline_entry(table, [Tabelle])
#outline(title: none, target: figure.where(kind: table))

#pagebreak()

== Code-Verzeichnis

#show outline.entry: figure_outline_entry("codeblock", [Code])
#outline(title: none, target: figure.where(kind: "codeblock"))

#pagebreak()

== Abkürzungsverzeichnis

// Add your abbreviations here.
#table(
  columns: (3cm, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 4pt),
  [*Abkürzung*], [*Bedeutung*],
  [FSM], [Finite State Machine],
  [PCB], [Printed Circuit Board],
  [PID], [Proportional-Integral-Differential],
  // Add more rows as needed...
)

#pagebreak()

== Promptverzeichnis <chap:prompt>

// Document every AI tool you used, with the exact prompt.
// This is required by BULME's academic honesty guidelines.
// Use the prompt-figure() function from utils/prompt_figure.typ.
// Example:

#prompt-figure(
  title: "Example: Find sources",
  tool: "Claude AI",
  model: "claude-sonnet-4-6",
  "Context: [describe your thesis topic and chapter].

Find 3–5 primary sources on: [your topic].
For each source: full BibTeX entry.

Chapter text: ✓ attached
Existing references.bib: ✓ attached",
)

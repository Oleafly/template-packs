#import "utils.typ": wbh-colors

// --- Helper Functions for Solutions ---

// Counter for tasks
#let task-counter = counter("task")

// Function to create a task header
#let task(points: none, title: none, ..args) = {
  let body = args.pos().at(0, default: none)
  task-counter.step()
  v(1.5em)
  block(
    width: 100%,
    stroke: (bottom: 1pt + wbh-colors.primary),
    inset: (bottom: 0.5em),
    [
      #text(
        1.2em,
        weight: "bold",
        fill: wbh-colors.primary,
      )[Aufgabe #context task-counter.display()]
      #if title != none [ : #title ]
      #if points != none [ #h(1fr) #text(style: "italic")[#points Punkte] ]
    ],
  )
  v(0.5em)
  if body != none {
    block(
      fill: luma(245),
      inset: 10pt,
      radius: 4pt,
      width: 100%,
      text(style: "italic", body),
    )
    v(1em)
  }
}

// Function for sub-tasks (a, b, c...)
#let subtask(title: none, points: none, body) = {
  v(0.5em)
  block(
    fill: luma(245),
    inset: 8pt,
    radius: 4pt,
    width: 100%,
    grid(
      columns: (auto, 1fr, auto),
      gutter: 0.5em,
      text(weight: "bold", title),
      text(style: "italic", body),
      if points != none {
        align(right, text(style: "italic")[#points Pkt.])
      },
    ),
  )
  v(0.5em)
}

// Function to format the solution
#let solution(body) = {
  pad(left: 1.5em)[
    #body
  ]
  v(2em)
}

// Function to add a source reference (superscript citation)
#let source(key, supplement: none, model: none, prompt: none) = {
  super(cite(label(key), supplement: supplement))
  if prompt != none {
    footnote[
      #if model != none [*Modell:* #model. ]
      *Prompt:* "#prompt"
    ]
  }
}

// Bibliography section with optional clickable inline-cite anchors.
//
// IMPORTANT: the `bib` argument must be a pre-constructed bibliography
// element from the caller's own file, because Typst resolves bib paths
// relative to the file in which `bibliography(...)` is called. If we
// called it from inside the template, paths would resolve against the
// template directory — wrong.
//
// Usage:
//   #bibliography_section(
//     bibliography("references.bib", style: "apa", title: "Literaturverzeichnis", full: true),
//     cite_display: _bib_display,
//   )
//
// - Emits a pagebreak before the bibliography.
// - If `cite_display` is non-empty, emits one hidden `bib_<key>` anchor per
//   entry so the `show cite:` rule installed by `project` can link to them.
#let bibliography_section(
  bib,
  cite_display: (:),
) = [
  #pagebreak()
  #if cite_display.len() > 0 [
    #hide[
      #for key in cite_display.keys() [
        #box[.]#label("bib_" + key)
      ]
    ]
  ]
  #bib
]

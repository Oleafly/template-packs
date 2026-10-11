// Shared styling and reusable components for homework submissions.
// Import into each homework file with:
//   #import "template.typ": *
//   #show: homework.with(hw: 1, date: "Month DD, YYYY")

#let base-size = 12pt
#let base-font = "New York"

// --- Reusable boxes for Definitions, Theorems, Lemmas, and Proofs ---

#let definition(title: none, body) = {
  let label = if title == none { "Definition." } else { "Definition (" + title + ")." }
  block(
    width: 100%,
    fill: rgb("#eaf2fb"),
    stroke: 1pt + rgb("#4a7fb5"),
    radius: 5pt,
    inset: 12pt,
    above: base-size,
    below: base-size,
  )[#text(weight: "bold", fill: rgb("#2c5885"))[#label] #body]
}

#let theorem(title: none, body) = {
  let label = if title == none { "Theorem." } else { "Theorem (" + title + ")." }
  block(
    width: 100%,
    fill: rgb("#fbf1e4"),
    stroke: 1pt + rgb("#b5792a"),
    radius: 5pt,
    inset: 12pt,
    above: base-size,
    below: base-size,
  )[#text(weight: "bold", fill: rgb("#8a5a1f"))[#label] #body]
}

#let lemma(title: none, body) = {
  let label = if title == none { "Lemma." } else { "Lemma (" + title + ")." }
  block(
    width: 100%,
    fill: rgb("#f0eef5"),
    stroke: 1pt + rgb("#6b5b95"),
    radius: 5pt,
    inset: 12pt,
    above: base-size,
    below: base-size,
  )[#text(weight: "bold", fill: rgb("#4a3d69"))[#label] #body]
}

#let proof(title: none, body) = {
  let label = if title == none { "Proof." } else { "Proof (" + title + ")." }
  block(above: base-size, below: base-size)[
    #text(weight: "bold")[#label] #body #h(1fr) $square.stroked$
  ]
}

#let remark(title: none, body) = {
  let label = if title == none { "Remark." } else { "Remark (" + title + ")." }
  block(
    width: 100%,
    stroke: (left: 2pt + rgb("#595959")),
    inset: (left: 12pt, rest: 6pt),
    above: base-size,
    below: base-size,
  )[#text(weight: "bold", style: "italic", fill: rgb("#404040"))[#label] #text(style: "italic")[#body]]
}

#let wip(message: "Work in progress: this section is still being written/reviewed.") = block(
  fill: rgb("#fdecea"),
  inset: 8pt,
  radius: 3pt,
  above: base-size,
  below: base-size,
)[#text(fill: rgb("#b3261e"), style: "italic", weight: "bold")[#message]]

// --- Solutions and final answers ---

// General-purpose solution write-up: computation, derivation, short-answer, etc.
// Use `proof` instead when the problem specifically asks for a proof.
#let solution(title: none, body) = {
  let label = if title == none { "Solution." } else { "Solution (" + title + ")." }
  block(above: base-size, below: base-size)[
    #text(weight: "bold")[#label] #body
  ]
}

// Highlight a final numeric/symbolic answer so it's easy for a grader to find.
#let answer(body) = align(center)[
  #box(stroke: 1pt + black, inset: (x: 14pt, y: 8pt))[#body]
]

// --- Problem / part / subpart numbering ---
// #problem[...] starts a new problem and resets part/subpart counters.
// #part[...] gives lettered subquestions: (a), (b), (c), ...
// #subpart[...] gives numbered sub-subquestions: (1), (2), ...

#let problem-counter = counter("problem")
#let part-counter = counter("part")
#let subpart-counter = counter("subpart")

#let problem(title: none, body) = {
  problem-counter.step()
  part-counter.update(0)
  subpart-counter.update(0)
  block(above: 1.6em, below: 0.8em)[
    #line(length: 100%, stroke: 0.6pt + rgb("#bbbbbb"))
    #v(0.4em)
    #text(size: 1.15em, weight: "bold")[
      Problem #context problem-counter.display()#if title != none [: #title]
    ]
  ]
  body
}

#let part(body) = {
  part-counter.step()
  subpart-counter.update(0)
  pad(left: 1.5em, top: 0.4em, bottom: 0.4em)[
    #text(weight: "bold")[(#context part-counter.display("a"))] #h(0.4em) #body
  ]
}

#let subpart(body) = {
  subpart-counter.step()
  pad(left: 3em, top: 0.3em, bottom: 0.3em)[
    #text(weight: "bold")[(#context subpart-counter.display("1"))] #h(0.4em) #body
  ]
}

// Parse "MM/DD/YYYY" into a full written-out date, e.g. "September 30, 2026".
#let format-date(s) = {
  let parts = s.split("/")
  let m = int(parts.at(0))
  let d = int(parts.at(1))
  let y = int(parts.at(2))
  datetime(year: y, month: m, day: d).display("[month repr:long] [day padding:none], [year]")
}

// --- Page template: shared setup + title block for every homework ---

#let homework(
  course: "course name",
  hw: 1,
  name: "Stan Ford",
  due: "",
  body,
) = {
  set document(title: course + " -- Homework " + str(hw), author: name)
  set page(numbering: "1", margin: 1in)
  set text(lang: "en", size: base-size, font: base-font)
  set par(justify: true, leading: 0.75em)
  show link: it => text(fill: rgb("#1a5fb4"), underline(it))

  problem-counter.update(0)
  part-counter.update(0)
  subpart-counter.update(0)

  align(center)[
    #text(size: base-size * 1.5, weight: "bold")[#course] #linebreak()
    #text(size: base-size * 1.25, weight: "bold")[Homework #hw] #linebreak()
    #text(size: base-size)[#name]
    #if due != "" [#linebreak() #text(size: base-size)[Due #format-date(due)]]
  ]

  v(12pt)

  body
}

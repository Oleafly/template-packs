#import "@preview/ctheorems:1.1.3": *
#import "@preview/equate:0.2.1": equate
#import "@preview/fletcher:0.5.6" as fletcher: diagram, node, edge

// colors inspired by the swiss bank notes, larger denominations used for
// more important statments
// https://www.snb.ch/de/the-snb/mandates-goals/cash/new-banknotes/design/design-overview
// original colors: https://coolors.co/00ad6b-2282e2-8400b8-dc2c3d-e6a100-8f6b28
// new colors: https://coolors.co/c9ffef-ddebfb-efceff-f8dee2-fcf0d7-f2e9da

#let mypurple = rgb("#efceff")
#let mybrown = rgb("#f2e9da")
#let myblue = rgb("#ddebfb")
#let mygreen = rgb("#c9ffef")
#let myred = rgb("#f8dee2")
#let myyellow = rgb("#fcf0d7")

// base document settings
#let base_document(
  dark-mode: false,
  doc,
) = {
  // dark mode support
  set page(fill: rgb("#32313d")) if dark-mode
  set text(fill: rgb("fdfdfd")) if dark-mode
  set line(stroke: white) if dark-mode
  set text(font: "New Computer Modern", size: 10pt)


  // bibliography settings
  show bibliography: x => { pagebreak() + x }

  // numbering
  set heading(numbering: "1.1")

  // equation numbering
  set math.equation(
    supplement: none,
    numbering: x => {
      numbering(
        "(1.1)",
        counter(heading).get().first(),
        x,
      ) // numbering will be of the form (SECTION.EQUATION)
    },
  )
  // reset equation counter at each section
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }

  // square as qed symbol
  show: thmrules.with(qed-symbol: $square$)

  // spacing settings
  set list(indent: 1.5em)
  set enum(indent: 1.5em)

  // settings for headings
  // specify heading font and spacing
  show heading: set block(above: 1.2em, below: 1.2em)

  // make chapter titles have two lines chapter number on top
  show heading.where(level: 1): it => {
    set text(size: 16pt)
    counter(math.equation).update(0)
    if it.numbering != none {
      [Chatper #counter(heading).get().at(0) \ #block(it.body + v(1em))]
    } else {
      it
    }
  }

  // add pagebreak before new chapters unless its the first chapter or the
  // chatper is unnumbered
  show heading.where(level: 1): it => {
    if (
      it.numbering != none and counter(heading).get() != (1,)
    ) {
      pagebreak() + it
    } else {
      it
    }
  }

  // better styling for table of contents
  set outline.entry(
    fill: box(width: 1fr, repeat(h(2pt) + "." + h(2pt))) + h(2pt),
  )
  show outline.entry.where(level: 1): it => {
    if it.at("label", default: none) == <modified-entry> {
      it // prevent infinite recursion
    } else {
      v(0.5em) // add spacing before each section with level 1
      // make level 1 sections bold
      strong([#outline.entry(
          it.level,
          it.element,
          fill: none, // remove fill
        ) <modified-entry>])
    }
  }

  doc
}


// settings specific to lecture notes
#let lecture_notes(
  lecture: none,
  lecturer: none,
  lecture_id: none,
  authors: none,
  semester: none,
  institution: none,
  toc: true,
  date: none,
  dark-mode: false,
  doc,
) = {
  show: base_document.with(dark-mode: dark-mode)

  // geometry settings
  set page(margin: (left: 5cm, right: 5cm, top: 6cm, bottom: 7cm))
  set par(
    leading: 0.6em,
    spacing: 1.2em,
    first-line-indent: 1.5em,
    justify: true,
  )

  // title page
  set align(center)
  text(20pt, "Lecture Notes:\n" + lecture)
  v(0em)

  let lecture_info = ""
  if lecture_id != none {
    lecture_info += lecture_id + " \n"
  }
  if semester != none {
    lecture_info += "Semester: " + semester + " \n"
  }
  if lecturer != none {
    lecture_info += "Lecturer: " + lecturer + " \n"
  }
  text(14pt, lecture_info)

  v(1em)

  let show_author(author) = {
    [
      #author.name \
      #smallcaps(author.affiliation) \
      #link("mailto:" + author.email)
    ]
  }

  grid(
    columns: (1fr,) * calc.min(authors.len(), 3),
    row-gutter: 24pt,
    ..authors.map(author => show_author(author))
  )

  // add institution and date
  v(1fr)
  if institution != none {
    text(10pt, institution + "\n")
  }
  if date == none {
    date = datetime.today()
  }
  text(
    10pt,
    "Last Edited: "
      + date.display("[day padding:none]. [month repr:long] [year]"),
  )
  v(1em)

  // start the document
  set align(left)
  set page(margin: (left: 4cm, right: 4cm, top: 5cm, bottom: 5cm))

  if toc {
    pagebreak()
    outline(
      title: [Table of Contents],
      indent: auto,
    )
  }

  set page(margin: (left: 2cm, right: 2cm, top: 5cm, bottom: 5cm))

  set page(numbering: "1")
  counter(page).update(1)

  doc
}


// theorem environments
#let thmbox = thmbox.with(
  breakable: true,
  radius: 0em, // no rounded corners
  inset: 0em,
  separator: [*.*], // add a period after the theorem number
  base_level: 1,
)

#let thmproof = thmproof.with(
  breakable: true, // allow breakable proofs
  inset: 0em,
  separator: [.], // add a period after the proof
)

#let thmframed = thmbox.with(
  inset: (left: 0.6em, right: 0.6em, top: 0.8em, bottom: 1em),
  padding: (left: -0.6em, right: -0.6em, top: 0em, bottom: 0em),
)


// colored environments
#let theorem = thmframed(
  "theorem",
  "Theorem",
  titlefmt: x => strong([#x]),
  bodyfmt: x => emph(x),
)

#let corollary = thmframed(
  "theorem",
  "Corollary",
  titlefmt: x => strong([#x]),
  bodyfmt: x => emph(x),
)

#let proposition = thmframed(
  "theorem",
  "Proposition",
  titlefmt: x => strong([#x]),
  bodyfmt: x => emph(x),
)

#let lemma = thmframed(
  "theorem",
  "Lemma",
  titlefmt: x => strong([#x]),
  bodyfmt: x => emph(x),
)

#let definition = thmframed(
  "theorem",
  "Definition",
  titlefmt: x => strong([#x]),
)


// proofs
#let proof = thmproof(
  "proof",
  "Proof",
)

#let proofidea = thmproof(
  "proof",
  "Proof Idea",
  bodyfmt: body => [
    #body #h(1fr) $minus.square$
  ],
)


// uncolored environments
#let solution = thmbox(
  "theorem",
  "Solution",
  separator: ".",
  titlefmt: x => emph([#x]),
).with(numbering: none)

#let exercise = thmbox(
  "theorem",
  "Exercise",
  titlefmt: x => strong([#x]),
)

#let example = thmbox(
  "theorem",
  "Example",
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: x => emph([#x]),
)

#let remark = thmbox(
  "theorem",
  "Remark",
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: x => emph([#x]),
)

#let recap = thmframed(
  "theorem",
  "Recap",
  fill: myyellow,
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: x => emph([#x]),
)

#let important = thmbox(
  "theorem",
  "Important",
  separator: ".",
  namefmt: name => smallcaps([(#name)]),
  titlefmt: x => smallcaps([#x]),
)


// custom math fonts
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

// custom operations

#let argmin = math.op("arg min", limits: true)
#let argmax = math.op("arg max", limits: true)

#let vee = $or$
#let wedge = $and$
#let acts = $#rotate(180deg)[$arrow.cw$]$
#let isom = $tilde.equiv$
#let rank = math.op("rank")


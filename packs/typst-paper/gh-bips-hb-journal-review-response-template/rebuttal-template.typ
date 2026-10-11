// === Point-by-point reply template ===
// Import into a reply document with:
//   #import "rebuttal-template.typ": *
//   #show: conf.with(manuscript-id: "...", paper-title: "...")
// then use #reviewer / #issue / #answer / #changed / #issuetodo / #issueothers.

// --- Colors (matching LaTeX version) ---
#let mygray = rgb("#EBEBEB")
#let mygreen = rgb("#75D279")
#let mycyan = rgb("#00C6F5")        // custom cyan
#let myorange = rgb("#FFB300")

// --- Counters ---
#let _reviewer-counter = counter("reviewer")
#let _question-counter = counter("question")

#let _current-label() = {
  let r = _reviewer-counter.get().first()
  let q = _question-counter.get().first()
  "R" + str(r) + "-Q" + str(q)
}

// --- Rebuttal box helpers ---

// Radius for issue and answer boxes
#let box-radius = 3pt

#let _rebuttal-box(fill: white, label: none, label-align: right, body) = {
  v(0.3em)
  block(
    width: 100%,
    fill: fill,
    inset: 8pt,
    radius: box-radius,
    breakable: false,
    {
      if label != none {
        align(label-align, text(size: 0.8em, style: "italic", label))
        v(0.2em)
      }
      body
    },
  )
}

// #reviewer(n: N) sets the reviewer number used in R<n>-Q<q> tags and the
// "Reviewer N" heading. name: appends a parenthetical to that heading, e.g.
// #reviewer(n: 1, name: "1-review-5") -> "Reviewer 1 (1-review-5)".
#let reviewer(n: none, name: none) = {
  if n == none {
    _reviewer-counter.step()
  } else {
    _reviewer-counter.update(n)
  }
  _question-counter.update(0)
  context {
    let num = "Reviewer " + str(_reviewer-counter.get().first())
    let title = if name != none { num + " (" + name + ")" } else { num }
    heading(level: 1, numbering: none, title)
  }
}

#let issue(lbl: none, body) = {
  _question-counter.step()
  v(0.3em)
  context {
    let tag = _current-label()
    let fig = figure(
      kind: "issue",
      supplement: none,
      numbering: _ => tag,
      block(
        stroke: 0.1pt,
        width: 100%,
        fill: white,
        inset: 8pt,
        radius: box-radius,
        {
          text(weight: "bold", size: 0.9em, tag)
          v(0.2em)
          body
        },
      ),
    )
    if lbl != none { [#fig #lbl] } else { fig }
  }
}

#let answer(body) = {
  context _rebuttal-box(
    fill: mygray,
    label: _current-label() + ": Response",
    label-align: left,
    body,
  )
}

#let changed(body) = _rebuttal-box(
  fill: mygreen,
  label: "Quote from new version of manuscript",
  body,
)

#let issuetodo(body) = _rebuttal-box(
  fill: mycyan,
  label: "TODO (main author)",
  body,
)

#let issueothers(body) = _rebuttal-box(
  fill: myorange,
  label: "TODO (co-authors)",
  body,
)

// --- Document configuration ---
// Holds the page/text set rules, cross-reference show rule, and title block.
#let conf(
  title: "Point-by-point reply to the reviewer comments",
  manuscript-id: none,
  paper-title: none,
  body,
) = {
  set page(margin: 3cm, numbering: "1")
  set text(font: "New Computer Modern", size: 11pt)
  set par(spacing: 0.65em)
  show heading.where(level: 1): set block(above: 1.2em, below: 0.5em)
  // Issue figures: no caption, no extra spacing, left-aligned
  show figure.where(kind: "issue"): set figure(gap: 0pt)
  show figure.where(kind: "issue"): set align(left)
  show figure.where(kind: "issue"): it => it.body
  // Cross-references: @R1-Q1 prints "R1-Q1" as link
  show ref: it => {
    if it.element != none and it.element.func() == figure and it.element.has("kind") and it.element.kind == "issue" {
      link(it.element.location(), it.element.counter.display(it.element.numbering))
    } else {
      it
    }
  }

  align(center)[
    #text(size: 17pt, weight: "bold")[#title]
    #v(3mm)
    #if manuscript-id != none [ #text(size: 12pt)[Manuscript ID: #manuscript-id] \ ]
    #if paper-title != none [ #text(size: 12pt)[Title: #paper-title] ]
    #v(1em)
    #datetime.today().display("[month repr:long] [day], [year]")
  ]

  v(1em)

  body
}

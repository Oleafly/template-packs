// Shared page setup and layout components, ported from cv.tex's macros.

#let cv-accent = rgb("#4169e1")

// Vertical rhythm, centralized here since these get re-tuned often.
#let space-section-above = 22pt
#let space-section-after-rule = 12pt
#let space-subsection-above = 14pt
#let space-subsection-after = 8pt
#let space-entry-below = 22pt
#let space-pub-below = 18pt
#let space-list-gap = 14pt
#let space-item-gap = 8pt

// Page/typography setup + section heading styling, applied once per document.
#let cv-setup(body) = {
  set page(paper: "us-letter", margin: (left: 0.75in, right: 0.75in, top: 0.8in, bottom: 0.8in))
  set text(size: 11pt)
  set par(leading: 1.15em, justify: false)
  show link: set text(fill: cv-accent)
  set list(marker: text(fill: cv-accent)[•], indent: 0pt, body-indent: 0.6em, spacing: space-item-gap, tight: false)
  set enum(indent: 0pt, body-indent: 0.6em, spacing: space-item-gap, tight: false)

  show heading.where(level: 1): it => {
    v(space-section-above, weak: true)
    text(size: 1.15em, weight: "bold", fill: cv-accent)[#it.body]
    v(4pt, weak: true)
    line(length: 100%, stroke: 0.6pt + cv-accent)
    v(space-section-after-rule, weak: true)
  }
  show heading.where(level: 2): it => {
    v(space-subsection-above, weak: true)
    text(size: 1em, weight: "bold")[#it.body]
    v(space-subsection-after, weak: true)
  }

  body
}

// Splits a string on **markers** and bolds the marked portion.
// Used to bold the CV owner's name inside publication author lists.
#let render-authors(s) = {
  let parts = s.split("**")
  let result = []
  for (i, p) in parts.enumerate() {
    if calc.odd(i) {
      result += strong(p)
    } else {
      result += [#p]
    }
  }
  result
}

#let header(personal) = {
  align(center)[
    #text(size: 2em, weight: "bold")[#link(personal.homepage)[#personal.name]]
  ]
  v(16pt)
  align(center)[
    #table(
      columns: (1fr, 1fr, 1fr),
      stroke: none,
      align: left,
      [*E-mail*: #link("mailto:" + personal.email)[#personal.email]],
      [*Homepage*: #link(personal.homepage)[#personal.homepage_label]],
      [],
      [*LinkedIn*: #link(personal.linkedin)[#personal.linkedin_label]],
      [*GitHub*: #link(personal.github)[#personal.github_label]],
      [*X*: #link(personal.x)[#personal.x_label]],
    )
  ]
  v(16pt)
}

// Generic dated entry: professional / research / teaching experience, honors.
#let entry(title, dates, org, body) = {
  block(below: space-entry-below)[
    #strong(title) #h(1fr) #dates
    #linebreak()
    #emph(org)
    #linebreak()
    #body
  ]
}

// Education entry: header line, plain institution line(s), then small detail bullets.
#let eduentry(degree, dates, institution-lines, details) = {
  block(below: space-entry-below)[
    #strong(degree) #h(1fr) #dates
    #for line in institution-lines [
      #linebreak()
      #line
    ]
    #linebreak()
    #text(size: 0.9em)[
      #list(marker: [·], indent: 0pt, body-indent: 0.5em, tight: true, ..details)
    ]
  ]
}

// Renders a publication list with descending numbering, matching the
// reverse \pubitem counter in cv.tex (first item labeled [N], last [1]).
#let pub-list(items) = {
  let total = items.len()
  for (i, item) in items.enumerate() {
    let label = str(total - i)
    block(below: space-pub-below)[
      [#label] #render-authors(item.authors) (#item.year). #item.title #emph(item.venue)#if item.extra != "" [, #item.extra].
    ]
  }
}

// Filters a list of entries by variant tag, defaulting to "both" when untagged.
#let for-variant(items, variant) = {
  items.filter(item => variant in item.at("include", default: ("academic", "short")))
}

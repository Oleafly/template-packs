#let accent = rgb("4F71BE")
#let ink = rgb("202632")
#let muted = rgb("667085")
#let pale = rgb("F3F6FC")
#let rule = rgb("D8E0F0")

#let safe-text(value) = if value == none { "" } else { value }

#let cover-row(label, value) = if value != none and value != "" {
  grid(
    columns: (28%, 72%),
    gutter: 10pt,
    text(size: 9pt, weight: "semibold", fill: muted, upper(label)),
    text(size: 10.5pt, fill: ink, value),
  )
  v(7pt)
}

#let academic-block(
  body,
  heading: [],
  kind: "proof",
  supplement: "Proof",
  label-name: none,
) = {
  let is-proof = kind == "proof" or kind == "solution"
  let tint = if is-proof { luma(248) } else { pale }
  let border = if is-proof { rgb("AEB8C8") } else { accent }
  block(
    width: 100%,
    breakable: true,
    fill: tint,
    stroke: (left: 2.2pt + border, rest: 0.45pt + rule),
    radius: 2pt,
    inset: (x: 11pt, y: 9pt),
    above: 10pt,
    below: 10pt,
  )[
    #set figure(placement: none)
    #set figure.caption(position: top)
    #show figure.caption: it => text(
      size: 9.5pt,
      weight: "bold",
      fill: if is-proof { ink } else { accent },
      it,
    )
    #figure(
      kind: kind,
      supplement: supplement,
      numbering: "1",
      gap: 5pt,
      [#set align(left); #body],
      caption: heading,
    )
    #if label-name != none { label(label-name) }
  ]
}

#let callout-block(body, heading: [Note], important: false) = {
  let border = if important { rgb("B54708") } else { accent }
  let background = if important { rgb("FFF7ED") } else { pale }
  block(
    width: 100%,
    breakable: true,
    fill: background,
    stroke: (left: 2pt + border),
    inset: (x: 11pt, y: 8pt),
    above: 9pt,
    below: 9pt,
  )[
    #text(size: 9.5pt, weight: "bold", fill: border, heading)
    #v(4pt)
    #body
  ]
}

#let lecture-notes(
  title: "Lecture Notes",
  subtitle: none,
  authors: none,
  date: none,
  course: none,
  professor: none,
  institution: none,
  semester: none,
  paper-size: "a4",
  compact: false,
  show-toc: true,
  toc-depth: 3,
  body,
) = {
  let body-size = if compact { 9.3pt } else { 10.5pt }
  let page-margin = if compact {
    (top: 1.45cm, bottom: 1.4cm, left: 1.55cm, right: 1.55cm)
  } else {
    (top: 2cm, bottom: 1.8cm, left: 2.1cm, right: 2.1cm)
  }
  let running-title = if course != none and course != "" { course } else { title }
  let running-term = safe-text(semester)

  set document(title: title, author: if authors == none { "" } else { authors })
  set text(font: ("Libertinus Serif", "New Computer Modern"), size: body-size, fill: ink, lang: "en")
  set par(justify: true, leading: if compact { 0.55em } else { 0.7em })
  set page(paper: paper-size, margin: page-margin, numbering: none)
  set heading(numbering: (..args) => {
    let visible = args.pos().filter(value => value > 0)
    numbering("1.1", ..visible)
  })
  set math.equation(numbering: "(1)")
  set figure(numbering: "1")
  set footnote(numbering: "1")
  set list(indent: 1.1em, body-indent: 0.55em)
  set enum(indent: 1.1em, body-indent: 0.55em)
  show link: set text(fill: accent)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(above: 6pt, below: 12pt)[
      #text(size: if compact { 16pt } else { 19pt }, weight: "bold", fill: accent, it)
      #v(3pt)
      #line(length: 100%, stroke: 0.7pt + rule)
    ]
  }
  show heading.where(level: 2): it => block(above: 12pt, below: 6pt, text(size: 13pt, weight: "bold", fill: ink, it))
  show heading.where(level: 3): it => block(above: 9pt, below: 4pt, text(size: 11pt, weight: "semibold", fill: ink, it))
  show raw.where(block: true): it => block(
    width: 100%,
    breakable: true,
    fill: rgb("F7F8FA"),
    stroke: 0.45pt + rgb("D0D5DD"),
    radius: 2pt,
    inset: 9pt,
    above: 8pt,
    below: 8pt,
    it,
  )
  show table: it => block(above: 8pt, below: 8pt, it)
  show figure.caption: set text(size: 9pt, fill: muted)

  // Cover page
  align(left + horizon)[
    #block(width: 100%)[
      #line(length: 54pt, stroke: 3pt + accent)
      #v(18pt)
      #text(size: if compact { 25pt } else { 30pt }, weight: "bold", fill: ink, title)
      #if subtitle != none and subtitle != "" {
        v(8pt)
        text(size: 15pt, fill: muted, subtitle)
      }
      #v(28pt)
      #cover-row("Course", course)
      #cover-row("Author", authors)
      #cover-row("Professor", professor)
      #cover-row("Institution", institution)
      #cover-row("Semester", semester)
      #cover-row("Date", date)
    ]
  ]
  pagebreak()

  if show-toc {
    outline(title: [Contents], depth: toc-depth, indent: auto)
    pagebreak()
  }

  set page(
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, auto),
          text(size: 8pt, fill: muted, running-title),
          text(size: 8pt, fill: muted, running-term),
        )
        v(3pt)
        line(length: 100%, stroke: 0.45pt + rule)
      }
    },
    footer: context text(size: 8pt, fill: muted, counter(page).display()),
  )
  counter(page).update(1)

  body
}

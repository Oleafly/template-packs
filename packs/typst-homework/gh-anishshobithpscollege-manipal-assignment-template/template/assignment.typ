#import "theme.typ": theme
#import "components.typ": code-setup

#let config = json("/config.json")

// Per-kind course/code overrides, keyed by the `kind` string ("Theory"/"Lab")
// under a `kinds` object in config.json. Falls back to the given value.
#let _by-kind(kind, field, fallback) = {
  let overrides = if kind == none { (:) } else {
    config.at("kinds", default: (:)).at(kind, default: (:))
  }
  overrides.at(field, default: fallback)
}

#let _meta-table(pairs) = {
  let rows = pairs.filter(p => p.at(1) != none)
  if rows.len() == 0 { return none }
  grid(
    columns: (auto, auto),
    row-gutter: 6pt,
    column-gutter: 12pt,
    align: (right, left),
    ..rows
      .map(p => (
        text(fill: theme.muted, weight: "bold")[#p.at(0)],
        [#p.at(1)],
      ))
      .flatten()
  )
}

#let assignment(
  title: none,
  number: none,
  kind: none,
  course: auto,
  course-code: auto,
  author: config.author,
  reg-no: config.reg_no,
  institution: config.institution,
  logo: image(config.logo, alt: "Institution logo", width: config.logo_width_cm * 1cm),
  date: datetime.today(),
  keywords: (),
  toc: true,
  body,
) = {
  // Resolve subject name/code: an explicit argument wins, else the per-kind
  // entry in config.json, else the top-level config value.
  let course = if course == auto {
    _by-kind(kind, "course", config.at("course", default: none))
  } else { course }
  let course-code = if course-code == auto {
    _by-kind(kind, "course_code", config.at("course_code", default: none))
  } else { course-code }

  let fmt-date = d => if type(d) == datetime {
    d.display("[day] [month repr:long] [year]")
  } else { d }

  set document(
    title: title,
    author: author,
    date: if type(date) == datetime { date } else { auto },
    keywords: keywords,
  )
  set text(font: theme.fonts.body, size: theme.size, fill: theme.ink, lang: "en")
  set par(justify: true, leading: 0.72em)
  set heading(numbering: "1.")
  show raw: set text(font: theme.fonts.mono)
  show link: it => if type(it.dest) == str { text(fill: theme.link, it) } else { it }
  show: code-setup

  set table(stroke: 0.5pt + theme.rule, inset: 7pt)
  set table(fill: (_, row) => if row == 0 { theme.head-fill })
  show table.cell: set par(justify: false)
  show table.cell: set text(hyphenate: false)
  show table.cell.where(y: 0): set text(weight: "bold")

  show heading.where(level: 1): it => block(above: 1.4em, below: 0.7em, text(size: 1.2em, it))

  let page-header = {
    set text(9pt, fill: theme.muted)
    grid(
      columns: (1fr, auto),
      align(left)[#if course-code != none [#course-code | ]#course],
      align(right)[#if kind != none [#kind ]#number],
    )
    v(3pt)
    line(length: 100%, stroke: 0.4pt + theme.rule)
  }
  let body-footer = context {
    line(length: 100%, stroke: 0.4pt + theme.rule)
    v(3pt)
    set text(9pt, fill: theme.muted)
    grid(
      columns: (1fr, auto),
      align(left)[#author | #reg-no],
      align(right)[#counter(page).display()],
    )
  }
  let fm-footer = context {
    set text(9pt, fill: theme.muted)
    align(center)[#counter(page).display()]
  }

  set page(
    paper: "a4",
    margin: theme.margin,
    header: page-header,
    footer: body-footer,
  )

  page(margin: 3cm, header: none, footer: none, numbering: none, {
    set align(center)
    v(1fr)
    if logo != none {
      logo
      v(1.4em)
    }
    text(13pt, fill: theme.muted)[#institution]
    v(6pt)
    line(length: 38%, stroke: 0.6pt + theme.rule)
    v(1.2em)
    text(15pt, weight: "medium")[#course]
    if course-code != none {
      v(3pt)
      text(11pt, fill: theme.muted)[#course-code]
    }
    v(2.4fr)
    {
      let parts = ()
      if kind != none { parts.push(upper(kind)) }
      if number != none { parts.push(upper(number)) }
      if parts.len() > 0 {
        text(12pt, fill: theme.muted, tracking: 1.5pt)[#parts.join(" ")]
        v(0.9em)
      }
    }
    text(26pt, weight: "bold")[#title]
    v(2.4fr)
    _meta-table((
      ("Student", author),
      ("Reg. No.", reg-no),
      ("Date", fmt-date(date)),
    ))
    v(1fr)
  })

  let fm-heading = title => heading(level: 1, numbering: none, outlined: true)[#title]

  set page(numbering: "i", footer: fm-footer)
  counter(page).update(1)

  if toc {
    fm-heading("Table of Contents")
    outline(title: none, depth: 3, indent: auto)
    pagebreak(weak: true)
  }
  context {
    if query(figure.where(kind: image)).len() > 0 {
      fm-heading("List of Figures")
      outline(title: none, target: figure.where(kind: image))
      pagebreak(weak: true)
    }
  }
  context {
    if query(figure.where(kind: table)).len() > 0 {
      fm-heading("List of Tables")
      outline(title: none, target: figure.where(kind: table))
      pagebreak(weak: true)
    }
  }

  set page(numbering: "1.", footer: body-footer)
  counter(page).update(1)
  counter(heading).update(0)

  body
}

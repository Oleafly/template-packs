#let default-color = white.darken(10%)
#let header-color = default-color.lighten(75%)
#let body-color = white.darken(10%)
#let code_font = "Ubuntu Mono"
#let code_theme = "halcyon.tmTheme"

#let layouts = (
  "small": ("height": 9cm, "space": 1.4cm),
  "medium": ("height": 10.5cm, "space": 1.6cm),
  "large": ("height": 12cm, "space": 1.8cm),
)

#let slides(
  content,
  title: none,
  subtitle: none,
  comment: none,
  date: none,
  authors: (),
  layout: "medium",
  ratio: 4/3,
  title-color: none,
  background: none,
) = {

  // Parsing
  if layout not in layouts {
      panic("Unknown layout " + layout)
  }
  let (height, space) = layouts.at(layout)
  let width = ratio * height

  // Colors
  if title-color == none {
      title-color = default-color
  }

  // Setup
  set document(
    title: title,
    author: authors,
  )
  //
  set text(
    font: "Ubuntu",
    fill: white,
    size: 14pt,

  )
  set page(
    width: width,
    height: height,
    margin: (x: 0.5 * space, top: 1.5 * space, bottom: 0.6 * space),
    background: image("../images/" + background),
    header: context {
      let page = here().page()
      let headings = query(selector(heading.where(level: 2)))
      let heading = headings.rev().find(x => x.location().page() <= page)
      if heading != none {
        set align(top + center)
        set text(1.0em, weight: "bold", fill: title-color)
        v(space * 0.2)
        upper(title)
        v(space * 0.05)
        text(size: 0.6em, upper(heading.body))
      }
    },
    header-ascent: 0%,
    footer: [
      #set text(0.6em)
      #set align(left)
      #counter(page).display("1/1", both: true)
    ],
    footer-descent: 0.8em,
  )
  set outline(
    target: heading.where(level: 1),
    title: none,
  )
  set bibliography(
    title: none
  )

  // Rules
  show heading.where(level: 1): x => {
    set page(header: none, footer: none)
    set align(center + horizon)
    set text(1.2em, weight: "bold", fill: title-color)
    v(- space / 2)
    x.body
  }
  show heading.where(level: 2): pagebreak(weak: true)
  show heading: set text(1.1em, fill: title-color)

  // Title
  if (title == none) {
    panic("A title is required")
  }
  else {
    if (type(authors) != array) {
      authors = (authors,)
    }
    set page(footer: none)
    set align(horizon + center)
    v(- space / 2)
    block(
      text(2.0em, weight: "bold", fill: title-color, title) +
      v(1.0em, weak: true) +
      if subtitle != none { text(1.4em, weight: "bold", fill: title-color, subtitle) } +
      v(1.0em, weak: true) +
      if comment != none { text(1.0em, weight: "bold", fill: title-color, comment) } +
      if subtitle != none and date != none { text(1.1em)[ \- ] } +
      if date != none {text(1.1em, date)} +
      v(1.6em, weak: true) +
      align(center,text(fill: title-color, authors.join(", ", last: " and ")))
    )
  }

  // Raw
  set raw(
      theme: code_theme,
      tab-size: 4,
      )
  show raw.where(block: true): (item) => {
    set block(fill: rgb("#1d2433"))
    box(
      fill: rgb("#1d2433"),
      inset: 8pt,
      radius: 8pt,
      text(fill: rgb("#a2aabc"), font: code_font, size: 10pt, item)
    )
  }
  show raw.where(block: false): (item) => box(
    fill: rgb("#1d2433"),
    inset: 2pt,
    radius: 2pt,
    text(fill: rgb("#a2aabc"), font: code_font, size: 10pt, item)
  )

  // Content
  content
}

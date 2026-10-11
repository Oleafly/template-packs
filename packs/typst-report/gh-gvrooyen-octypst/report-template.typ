#let body-font = sys.inputs.at(
  "body-font",
  default: ("Lato", "Open Sans", "Liberation Sans"),
)
#let heading-font = sys.inputs.at("heading-font", default: "Liberation Sans")
#let mono-font = sys.inputs.at("mono-font", default: "Liberation Mono")

#let report-template(brand) = {
let primary-color = brand.colors.heading
let secondary-color = brand.colors.subheading
let caption-color = brand.colors.caption

let fig-caption(body, at: center) = align(at)[
  #text(font: body-font, size: 9pt, fill: caption-color, style: "italic")[#body]
]

let checkbox(checked: false) = box(
  width: 0.9em,
  height: 0.9em,
  inset: 0pt,
  stroke: 0.7pt + black,
  radius: 1pt,
)[
  #if checked {
    align(center + horizon)[
      #text(size: 0.8em, fill: primary-color)[#sym.checkmark]
    ]
  }
] + h(0.5em)

let O = checkbox()
let X = checkbox(checked: true)

let notice(
  body,
  title: none,
  fill: luma(245),
  stroke: 0.6pt + primary-color,
  radius: 4pt,
  inset: 12pt,
  above: 18pt,
) = [
  #v(above)
  #block(
    inset: inset,
    fill: fill,
    stroke: stroke,
    radius: radius,
  )[
    #if title != none {
      strong(title) + h(0.25em)
    }
    #body
  ]
]

let callout(body) = block(
  inset: 10pt,
  stroke: (left: 3pt + primary-color),
  fill: rgb("#f8f3f8"),
)[#body]

let footer-rule(logo: brand.logo, confidential: false) = context {
  if counter(page).get().first() > 1 {
    box(width: 100%)[
      #line(length: 100%, stroke: 0.55pt + primary-color)
      #v(4pt)
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, bottom),
        image(logo, width: 1.12in),
        if confidential { align(center + bottom)[#text(size: 10pt)[CONFIDENTIAL]] },
        align(right + bottom)[#text(size: 10pt)[#counter(page).display("1")]],
      )
    ]
  }
}

let report(body, document-title: none, document-author: none, confidential: false) = {
  if document-title == none {
    set document(author: document-author)
  } else {
    set document(author: document-author, title: document-title)
  }
  set page(
    paper: "a4",
    margin: (x: 1in, y: 1in),
    footer-descent: 0.34in,
    footer: footer-rule(confidential: confidential),
  )
  set text(font: body-font, size: 11pt, lang: "en")
  set par(spacing: 1em, justify: true)
  set enum(spacing: 1em, indent: 0.25in, body-indent: 0.15in)
  set list(spacing: 1em, indent: 0.25in, body-indent: 0.15in)
  set footnote.entry(indent: 0em)
  show footnote.entry: it => {
    let location = it.note.location()
    let number = numbering(it.note.numbering, ..counter(footnote).at(location))
    let back-link = link.with(location)
    par(back-link(super(number)) + h(0.5em) + it.note.body)
  }
  show enum: it => v(0.5em) + it + v(0.25em)
  show list: it => v(0.5em) + it + v(0.25em)
  set heading(numbering: (..nums) => {
    if nums.pos().len() <= 4 {
      numbering("1.1.1.1", ..nums)
    }
  })

  show heading.where(level: 1): it => block(above: 1.4em, below: 0.8em)[
    #text(font: heading-font, size: 16pt, fill: primary-color)[#it]
  ]
  show heading.where(level: 2): it => block(above: 1.2em, below: 0.65em)[
    #text(font: heading-font, size: 13pt, fill: primary-color)[#it]
  ]
  show heading.where(level: 3): it => block(above: 1.35em, below: 1.05em)[
    #text(font: heading-font, size: 12pt, fill: secondary-color)[#it]
  ]
  show heading.where(level: 5): it => block(above: 0.9em, below: 0.75em)[
    #text(font: heading-font, size: 11pt, weight: "semibold", fill: black)[#it.body]
  ]
  // show raw: set text(font: mono-font, size: 1.2em)
  show raw: it => h(0.25em) + text(font: mono-font, size: 1.25em)[#it] + h(0.25em)
  show math.equation: set text(size: 1.1em)
  show quote: set text(style: "italic")
  show quote: it => block(inset: (x: 1em))[#it]
  show figure.caption: it => align(center)[
    #text(font: body-font, size: 9pt, fill: caption-color, style: "italic")[
      #context [#it.supplement #it.counter.display(it.numbering): #it.body]
    ]
  ]
  show table: it => {
    set par(justify: false)
    text(size: 9pt)[#it]
  }
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: it => block(above: 2em, below: 2em)[#it]
  show figure.caption.where(position: top): it => align(center)[
    #text(font: body-font, size: 11pt, fill: caption-color, style: "italic")[
      #context [#it.supplement #it.counter.display(it.numbering): #it.body]
    ]
  ]

  body
}

let h1(title, numbered: true, outlined: true) = {
  if numbered {
    heading(level: 1, outlined: outlined)[#title]
  } else {
    heading(level: 1, outlined: outlined, numbering: none)[#title]
  }
}

let h2(title, numbered: true, outlined: true) = {
  if numbered {
    heading(level: 2, outlined: outlined)[#title]
  } else {
    heading(level: 2, outlined: outlined, numbering: none)[#title]
  }
}

let h3(title, numbered: true, outlined: true) = {
  if numbered {
    heading(level: 3, outlined: outlined)[#title]
  } else {
    heading(level: 3, outlined: outlined, numbering: none)[#title]
  }
}

let cover-page(
  title: "",
  subtitle: "",
  classification: none,
  background: brand.front-page-image,
) = {
  set page(paper: "a4", margin: 0pt, footer: none)
  place(top + left, image(background, width: 100%, height: 100%))
  place(bottom + right, dx: -0.72in, dy: -1.04in)[
    #align(right)[
      #text(font: heading-font, size: 25pt, weight: "bold", fill: white)[#title]
      #linebreak()
      #v(8pt)
      #text(font: heading-font, size: 17pt, fill: white)[#subtitle]
      #if classification != none [
        #v(18pt)
        #align(right)[
          #text(font: heading-font, size: 12pt, fill: white)[#classification]
        ]
      ]
    ]
  ]
  pagebreak()
}

let title-page(
  title-lines: (),
  prepared: "",
  version: "",
  author: "",
) = {
  v(0.16in)
  for line in title-lines {
    block(height: 34pt, below: 0pt)[#text(font: heading-font, size: 28pt)[#line]]
  }
  v(2pt)
  text(size: 11pt)[#prepared]

  v(12pt)
  grid(
    columns: (1.5in, auto),
    row-gutter: 3pt,
    text(weight: "bold")[Document Version:], version,
    text(weight: "bold")[Primary Author:], author,
  )
}

let report-outline(depth: 3) = {
  h1("Contents", numbered: false, outlined: false)
  v(-2pt)
  outline(title: none, depth: depth)
}

let report-figure(image-path, caption, width: 100%, placement: none) = figure(
  placement: placement,
  image(image-path, width: width),
  caption: caption,
)

let reference-counter = counter("reference-counter")

let cite(label) = context {
  let entry = query(label).first()
  link(label, "[" + str(entry.value) + "]")
}

let reference(label, body) = context {
  reference-counter.step()
  let number = reference-counter.get().first() + 1
  [#body #metadata(number) #label]
}

(
  report: report,
  fig-caption: fig-caption,
  checkbox: checkbox,
  O: O,
  X: X,
  notice: notice,
  callout: callout,
  cover-page: cover-page,
  title-page: title-page,
  report-outline: report-outline,
  report-figure: report-figure,
  h1: h1,
  h2: h2,
  h3: h3,
  cite: cite,
  reference: reference,
)
}

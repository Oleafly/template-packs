#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2"
#let sect(s) = toolbox.register-section(s)
#let settings(
  title: [Presentation title, set via title:],
  subtitle: [],
  author: [Author McAuthorface],
  shortauthor: none,
  presdate: datetime.today(),
  doc,
) = {
  if shortauthor == none { shortauthor = author.text }
  let presbg = rgb("00142a")
  let sections-band = toolbox.all-sections((sections, current) => {
    set text(fill: white, size: 10pt, font: "Eau", weight: "extralight")
    show link: set text(weight: "regular", fill: presbg)
    sections
      .map(s => if s == current {
        show link: set text(weight: "extrabold", fill: luma(85%))
        s
      } else {
        show link: set text(weight: "extralight", fill: luma(85%))
        s
      })
      .join([ • ])
    h(1fr)
    set text(size: 18pt, fill: luma(92%), weight: "regular")
    [#counter(page).display("1")]
  })
  let header-band = {
    text(fill: white, size: 10pt, weight: "extralight", [#shortauthor: #title])
    v(0.75em)
  }
  show heading.where(level: 1): set text(weight: "extrabold", size: 36pt, fill: presbg)
  show heading.where(level: 2): set text(weight: "bold", size: 26pt)
  show heading.where(level: 3): set text(weight: "bold", size: 22pt)
  show heading.where(level: 4): set text(weight: "medium", size: 18pt)
  show heading: cont => {
    cont
    {
      v(-1.1em)
      line(start:(-1%,0%), end:(70%,0%), stroke: (thickness: 0.25pt, paint: gradient.linear(presbg, white)))
    }
    v(-0.25em)
  }
  show footnote.entry: set text(weight: "regular", size: 10pt)
  set footnote(numbering: "a")
  show link: set text(weight: "semibold", fill: navy)
  set page(
    paper: "presentation-16-9",
    margin: (
      top: 1.25cm,
      left: 1.25cm,
      right: 1.25cm,
      bottom: 0.8cm,
    ),
  )
  set text(size: 18pt, font: "Eau")
  set list(spacing: 1.15em)

  set page(background: image("assets/title-bg-optim.svg"))
  slide[
    #place(
      top + left,
      [
        #text(
          [#title\
          ],
          size: 40pt,
          fill: white,
        )
        #text(
          [#subtitle],
          size: 28pt,
          fill: white,
        )
      ],
      dx: 30mm,
      dy: 50mm,
    )
    #place(
      bottom + left,
      [
        #text(
          author,
          size: 20pt,
          fill: white,
        )
      ],
      dx: 30mm,
      dy: -50mm,
    )
    #place(
      bottom + left,
      [
        #text(presdate.display("[day]. [month repr:long] [year repr:full]"), fill: white, size: 16pt)
      ],
      dx: 20mm,
      dy: -0mm,
    )
  ]
  set page(
    background: image("assets/main-bg.svg"),
    margin: (
      top: 1.4cm,
      left: 1.325cm,
      right: 0.8cm,
      bottom: 1cm,
    ),
    footer: sections-band,
    header: header-band,
  )
  doc
}

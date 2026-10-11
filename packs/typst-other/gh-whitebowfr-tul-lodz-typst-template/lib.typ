// This function gets your whole document as its `body` and formats
// it as an article in the style of the IEEE.
#import "@preview/wrap-it:0.1.1": wrap-content

#let ieee(
  // The paper's title.
  title: [Paper Title],

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),

  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  // The article's paper size. Also affects the margins.
  paper-size: "us-letter",

  // The result of a call to the `bibliography` function or `none`.
  bibliography: none,

  // How figures are referred to from within the text.
  // Use "Figure" instead of "Fig." for computer-related publications.
  figure-supplement: [Fig.],
  supervisor: (),
  accentcolor: blue,
  index-terms: (),

  // The paper's content.
  body
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(author => author.firstname + " " + author.lastname))

  // Set the body font.
  // As of 2024-08, the IEEE LaTeX template uses wider interword spacing
  // - See e.g. the definition \def\@IEEEinterspaceratioM{0.35} in IEEEtran.cls
  set text(font: "TeX Gyre Termes", size: 10pt, spacing: .35em)

  // Enums numbering
  set enum(numbering: "1)a)i)")

  // Tables & figures
  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)
  show figure.where(kind: table): set figure.caption(position: top, separator: [\ ])
  show figure.where(kind: table): set text(size: 8pt)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: image): set figure(supplement: figure-supplement, numbering: "1")
  show figure.caption: set text(size: 8pt)
  show figure.caption: set align(start)
  show figure.caption.where(kind: table): set align(center)

  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    }
  )

  show table: tab => {
    line(length: 100%)
    v(-1.5em)
    line(length: 100%)
    v(-1.5em)
    tab
  }
  // Adapt supplement in caption independently from supplement used for
  // references.
  set figure.caption(separator: [. ])
  show figure: fig => {
    let prefix = (
      if fig.kind == table [TABLE]
      else if fig.kind == image [Fig.]
      else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    // Wrap figure captions in block to prevent the creation of paragraphs. In
    // particular, this means `par.first-line-indent` does not apply.
    // See https://github.com/typst/templates/pull/73#discussion_r2112947947.
    show figure.caption: it => block[#prefix~#numbers#it.separator#it.body]
    show figure.caption.where(kind: table): smallcaps
    fig
  }

  // Code blocks
  show raw: set text(
    font: "TeX Gyre Cursor",
    ligatures: false,
    size: 8pt,
    spacing: 100%,
  )

  // Configure the page and multi-column properties.
  set columns(gutter: 12pt)
  set page(
    columns: 2,
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 200%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
    header: {
      align(right)[#grid(columns: 2, gutter: 10pt,image("image1.png", height: 40pt),image("image2.png", height: 40pt))]
      v(-10pt)
      line(length: 100%)
      text(top-edge: 0pt)[TEAM PROJECT - Final Report 2025, Team X, Course XX]
    },
    footer: context [
      #set text(6pt)
      #upper("IFE Team project 2026")
      #h(1fr)
      #counter(page).display("1")
  ]
  )

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      // Other references as usual.
      it
    }
  }

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "I.A.a)")
  show heading: it => {
    // Find out the final number of the heading counter.
    let levels = counter(heading).get()
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(11pt, weight: 800)
    if it.level == 1 {
      // First-level headings are centered smallcaps.
      // We don't want to number the acknowledgment section.
      let is-ack = it.body in ([Acknowledgment], [Acknowledgement], [Acknowledgments], [Acknowledgements], [Author bios and contributions])
      set text(if is-ack { 13pt } else { 15pt }, fill: accentcolor, weight:
     "bold")
      show: block.with(above: 15pt, below: 13.75pt, sticky: true)
      show: smallcaps
      if it.numbering != none and not is-ack {
        numbering("I.", deepest)
        h(5pt, weak: true)
      }
      it.body
    } else if it.level == 2 {
      // Second-level headings are run-ins.
      set text(style: "italic", weight: 600)
      show: block.with(spacing: 10pt, sticky: true)
      show: smallcaps
      if it.numbering != none {
        numbering("A.", deepest)
        h(7pt, weak: true)
      }
      it.body
    } else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 {
        numbering("a)", deepest)
        [ ]
      }
      _#(it.body):_
    ]
  }

  // Style bibliography.
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(10pt)[References], style: "ieee")

  // Display the paper's title and authors at the top of the page,
  // spanning all columns (hence floating at the scope of the
  // columns' parent, which is the page).
  place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      show std.title: set align(left)
      show std.title: set par(leading: 0.5em)
      show std.title: set text(size: 24pt, weight: "extrabold", fill: accentcolor)
      show std.title: set block(below: 8.35mm)
      std.title()

      // Display the authors list.
      set text(11pt, weight: "bold")
      for i in range(authors.len()) {
        let is-last = i == (authors.len() - 1)
        if (is-last) {
          text("and ")
        }
        upper(text(authors.at(i).firstname.first()) + ". " + authors.at(i).lastname + ", ")
      }

      set text(11pt, style: "italic", weight: "regular")
      linebreak()
      if ("name" in supervisor) {
        "Supervisor : "
        supervisor.name
        " (e-mail : "
        supervisor.email
        ")"
      }
    }
  )

  set par(justify: true, first-line-indent: (amount: 1em, all: true), spacing: 0.5em, leading: 0.5em)

  // Display abstract and index terms.
  if abstract != none {
    set par(spacing: 0.45em, leading: 0.45em)
    set text(9pt, weight: 700, spacing: 150%)

    // [_Abstract_---#h(weak: true, 0pt)#abstract]
    place(
      top,
      scope: "parent",
      float: true,
      [#text(fill: accentcolor, weight: "bold")[ABSTRACT] #h(weak: true, 5pt)#abstract]
    )

    if index-terms != () {
      parbreak()
      place(
        top,
        scope: "parent",
        float: true,
        [#text(fill: accentcolor, weight: "bold")[KEYWORDS] #h(weak: true, 5pt)#index-terms.join[, ]]
      )
    }

    v(2pt)
  }

  // Display the paper's contents.
  body

  // Display bibliography.
  bibliography

  [= Author bios and contributions]

  for i in range(authors.len()) {
    wrap-content(image(authors.at(i).image, height: 3.26cm, width: 2.56cm, fit: "cover"), [#smallcaps(text(weight: "bold", authors.at(i).firstname.first() + ". " + authors.at(i).lastname))
          #authors.at(i).description])
    }
}

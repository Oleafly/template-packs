#import "@preview/tidy:0.4.3"
#import "@preview/alexandria:0.2.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/glossy:0.8.0": *
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/algorithmic:1.0.3": style-algorithm
#import "cover.typ": balance, cover
#import "@preview/outrageous:0.4.0"

/// Repeat the given content to fill the full space.
///
/// Custom function instead of the built-in to support fixed-size gaps.
///
/// Parameters:
/// - gap: The gap between repeated items. (Default: none)
/// - justify: Whether to increase the gap to justify the items. (Default: false)
///
/// Returns: The repeated content.
///
/// Based on https://github.com/EpicEricEE/typst-plugins/blob/b13b0e1bc30beba65ff19d029e2dad61239a2819/outex/src/outex.typ#L1-L27
#let custom-repeat(
  gap: none,
  justify: false,
  body,
) = layout(size => context {
  // function to measure length in `pt` unit
  let pt-length(len) = measure(h(len)).width

  // width of the body to repeat
  let width = measure(body).width
  // how often the body should be repeated
  let repeat-count = calc.floor(
    pt-length(size.width + gap) / pt-length(width + gap),
  )

  // justify the gap
  let gap = if not justify { gap } else {
    (size.width - repeat-count * width) / (repeat-count - 1)
  }

  let items = ((box(body),) * repeat-count)
  if type(gap) == length and gap != 0pt {
    // add gap between items
    items = items.intersperse(h(gap))
  }

  items.join()
})

/// Template for a thesis document.
/// -> content
#let template(
  /// The specialization -> str
  specialization: "<Your Specialization>",
  /// The thesis' title. -> str
  title: "<Project Title>",
  /// The date of the thesis defense. -> datetime
  defense-date: datetime.today(),
  /// The candidate's name. -> str
  name: "<Your Name>",
  /// The lab in which you perfomed the research project. -> str
  lab: "<Your Lab>",
  /// The supervisor (or multiple supervisors) of the thesis. -> str | list(str)
  supervisor: "<Your Supervisor(s)>",
  /// The list of members of the jury. -> dictionary
  jury: (
    president: "<President of the Jury>",
    members: ("<Jury Member 1>", "<Jury Member 2>", "<Jury Member 3>"),
  ),
  /// The abstract of the thesis, both an English and a French version are
  /// required. -> dictionary
  abstract: (
    en: [],
    fr: [],
  ),
  /// The acknowledgments of the thesis -> content | none
  acknowledgements: none,
  /// Call to the bibliography function
  bib-func: none,
  /// Wether to include the list of tables. -> bool
  list-of-tables: false,
  /// Wether to include the list of figures. -> bool
  list-of-figures: false,
  /// Wether to include the list of code listings. -> bool
  list-of-listings: false,
  /// A glossary can be included in the document if needed. -> yaml | none
  glossary-entries: none,
  body,
) = {
  set document(title: title, author: name)

  set text(font: "New Computer Modern", lang: "en", size: 11pt)

  set page(paper: "a4", margin: 3.5cm)

  show figure.caption: emph
  // Floating figures appear as `place` instead of `block` so we
  // need this workaround, see https://github.com/typst/typst/issues/6095
  show figure.caption: balance.with(is-figure: true)
  show figure: it => {
    if it.placement == none {
      block(it, inset: (y: .75em))
    } else {
      place(
        it.placement + center,
        float: true,
        block(it, inset: (y: .75em)),
      )
    }
  }

  set par(justify: true, first-line-indent: 1.8em)

  show figure.where(kind: table): set figure.caption(position: top)
  show table.cell.where(y: 0): strong
  show table.cell.where(y: 0): smallcaps
  show table: it => {
    set par(justify: false)
    it
  }
  set table(
    stroke: (_, y) => (
      top: if y == 0 { 1pt } else if y == 1 { none } else { 0pt },
      bottom: .5pt,
    ),
    align: center + horizon,
  )

  set math.equation(numbering: "(1)")

  // Used to have numbering appear only on pages with actual content, kudos to
  // https://github.com/typst/typst/discussions/3122#discussioncomment-13936086
  let headings-on-odd-page(it) = {
    show heading.where(level: 1): it => {
      set par(justify: false)
      {
        set page(header: none, numbering: none)
        pagebreak(to: "odd")
      }
      balance(it)
    }
    it
  }
  set heading(numbering: "1.1")
  show heading: smallcaps
  show heading: set block(above: 1.4em, below: 1em)
  show heading: balance

  cover(
    specialization: specialization,
    title: title,
    defense-date: defense-date,
    name: name,
    lab: lab,
    supervisor: supervisor,
    jury: jury,
  )
  {
    set par(justify: false)
    align(center)[
      #smallcaps(text(
        balance(title),
        size: 1.5em,
        weight: "bold",
      ))

      #smallcaps(text(name, size: 1.2em, weight: "bold"))
    ]
  }

  show: alexandria(prefix: "x-")

  bib-func

  show: init-glossary.with(glossary-entries, term-links: true)

  // https://tex.stackexchange.com/a/525297
  let my-red = rgb("800006")
  let my-green = rgb("2E7E2A")
  let my-blue = rgb("131877")
  let my-magenta = rgb("8A0087")
  let my-cyan = rgb("137776")

  let my-okabe-ito = lq.color.map.okabe-ito.map(it => it.darken(40%))
  let my-okabe-ito = (
    // my-blue,
    lq.color.map.okabe-ito.at(0),
    // green,
    lq.color.map.okabe-ito.at(0),
    // my-green,
    lq.color.map.okabe-ito.at(2),
    // lq.color.map.petroff8.at(5).darken(40%),
    lq.color.map.okabe-ito.at(3),
    my-magenta,
    // my-red,
    // green,
    // lq.color.map.petroff8.at(2),
    lq.color.map.okabe-ito.at(5),
  )
  // let my-okabe-ito = {
  //   let x = lq.color.map.petroff8.map(it => it.darken(40%))
  //   (x.at(6), x.at(0), x.at(1), x.at(7), x.at(7), x.at(2))
  // }

  show link: it => {
    if type(it.dest) == str {
      // web links
      show text: underline
      set text(my-okabe-ito.at(0))
      it
    } else if type(it.dest) != label or not str(it.dest).starts-with("x-") {
      // glossary
      if not str(repr(it.dest)).starts-with(".") {
        set text(fill: black)
        it
      } else {
        it
      }
    } else {
      // bibliography
      set text(my-okabe-ito.at(2))
      it
    }
  }
  show ref: set text(my-okabe-ito.at(5))

  v(1fr)

  heading(level: 2, numbering: none, outlined: false, "Abstract")
  abstract.en

  heading(level: 2, numbering: none, outlined: false, text(
    "Resumé",
    lang: "fr",
  ))
  {
    set text(lang: "fr")
    abstract.fr
  }

  v(4fr)

  pagebreak(weak: true, to: "odd")

  if acknowledgements != none {
    heading(level: 2, numbering: none, outlined: false, "Acknowledgments")
    acknowledgements
  }

  pagebreak(weak: true, to: "odd")

  show outline.entry: set par(justify: true)
  // show outline.entry: outrageous.show-entry.with(
  //   fill: (
  //     none,
  //     align(right, custom-repeat(gap: .2em)[#sym.dot.c]),
  //   ),
  //   fill-right-pad: 0cm,
  // )
  set outline.entry(fill: repeat(gap: .2em)[#sym.dot.c])
  show outline.entry.where(level: 1): it => {
    if it.element.func() != heading {
      return it
    }
    set block(above: 2em)
    set text(weight: "bold")
    link(it.element.location(), it.indented(it.prefix(), {
      (it.body() + h(1fr) + it.page())
    }))
  }

  let in-outline = state("in-outline", false)
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  {
    show link: set text(black)
    show ref: set text(black)
    outline(title: "Table of Contents")
  }

  if list-of-tables {
    pagebreak(weak: true, to: "odd")
    outline(target: figure.where(kind: table), title: "List of Tables")
  }

  if list-of-figures {
    pagebreak(weak: true, to: "odd")
    outline(target: figure.where(kind: image), title: "List of Figures")
  }

  if list-of-listings {
    pagebreak(weak: true, to: "odd")
    outline(target: figure.where(kind: raw), title: "List of Listings")
  }

  // TODO: disable link boxes when printing, possibly automatically
  // very hacky but it works

  // // https://tex.stackexchange.com/a/525297
  // let my-red = rgb("800006")
  // let my-green = rgb("2E7E2A")
  // let my-blue = rgb("131877")
  // let my-magenta = rgb("8A0087")
  // let my-cyan = rgb("137776")

  // let my-okabe-ito = lq.color.map.okabe-ito.map(it => it.darken(40%))

  // show link: it => {
  //   if type(it.dest) == str {
  //     // web links
  //     show text: underline
  //     // set text(my-blue)
  //     set text(my-okabe-ito.at(0))
  //     it
  //   } else if type(it.dest) != label or not str(it.dest).starts-with("x-") {
  //     // glossary
  //     // set text(my-cyan)
  //     set text(my-okabe-ito.at(3))
  //     it
  //   } else {
  //     // bibliography
  //     // set text(my-green)
  //     set text(my-okabe-ito.at(2))
  //     it
  //   }
  //   // if type(it.dest) != str {
  //   //   if it.body.has("text") {
  //   //     // glossy links
  //   //     it
  //   //   } else {
  //   //     // bibliography citations
  //   //     highlight(stroke: 0.5pt + red, fill: none, it)
  //   //   }
  //   // } else { underline(it) } // web links
  // }
  // show ref: set text(my-okabe-ito.at(5))


  // show link: underline
  // show link: set text(fill: rgb("#800006"))
  // show link: it => {it.fields()}

  // // sections, figures and equations
  // // show ref: it => { highlight(stroke: 0.5pt + green, fill: none, it) }

  show raw: set text(font: "Fira Code")
  show raw.where(block: true): set text(0.8em)
  show: codly-init.with()
  codly(
    breakable: true,
    languages: codly-languages,
    aliases: ("cuda": "c++"),
    zebra-fill: none,
    // lang-outset: (x: -5pt, y: 5pt),
    number-align: right + horizon,
    number-format: it => text(fill: luma(200), str(it)),
  )

  show: style-algorithm.with(hlines: (
    grid.hline(stroke: 1pt + black),
    grid.hline(stroke: .5pt + black),
    grid.hline(stroke: 1pt + black),
  ))

  // show bibliography: it => {
  //   show text: it => {
  //     // we must not attempt to evaluate text that is not valid markup
  //     // thankfully most text _is_, but unbalanced closing brackets don't work
  //     if it.text == "]" { return it }

  //     // evaluate any formatting
  //     let result = eval(it.text, mode: "markup")
  //     // if nothing was formatted, return the original content
  //     // to avoid infinite recursion
  //     if result.func() == text { return it }

  //     // emit the formatted content
  //     result
  //   }
  //   it
  // }

  set page(numbering: "1")
  show: headings-on-odd-page

  counter(page).update(0)

  body

  set page(numbering: none)

  heading(level: 1, "Bibliography")

  set heading(numbering: none, offset: 1)

  context {
    let (references, ..rest) = get-bibliography("x-")
    let tags = ("web", "blog", "repository")
    let is-internet-source(x) = {
      return (
        x.details.type in tags
          or if "parent" in x.details.keys() {
            x.details.parent.type in tags
          } else { false }
      )
    }

    [= Scientific Literature]

    {
      set text(0.8em)
      render-bibliography(title: none, (
        references: references.filter(x => not is-internet-source(x)),
        ..rest,
      ))
    }

    [= Internet Sources]

    {
      set text(0.8em)
      render-bibliography(title: none, (
        references: references.filter(x => is-internet-source(x)),
        ..rest,
      ))
    }
  }

  let custom = (
    // Renders the main glossary section as a single column
    // Parameters:
    //   title: The glossary section title
    //   body: Content containing all groups and entries
    section: (title, body) => {
      heading(level: 1, title)
      set text(size: 0.8em)
      body
    },
    // Renders a group of related glossary terms
    // Parameters:
    //   name: Group name (empty string for ungrouped terms)
    //   index: Zero-based group index
    //   total: Total number of groups
    //   body: Content containing the group's entries
    group: (name, index, total, body) => {
      if name != "" and total > 1 {
        heading(level: 2, name)
      }
      body
    },
    // Renders a single glossary entry with term, definition, and page references
    // Parameters:
    //   entry: Dictionary containing term data:
    //     - short: Short form of term
    //     - long: Long form of term (optional)
    //     - description: Term description (optional)
    //     - label: Term's dictionary label
    //     - pages: Linked page numbers where term appears
    //   index: Zero-based entry index within group
    //   total: Total entries in group
    entry: (entry, index, total) => {
      let long-form = if entry.long == none [] else [, #entry.long]
      let description = if (
        entry.description == none
      ) [] else [: #text(style: "italic")[#entry.description]]

      block(
        below: 1em,
      )[*#entry.short*#entry.label#long-form#description #h(1em) [pp. #entry.pages]]
    },
  )


  if (glossary != none) {
    glossary(title: "Glossary", theme: custom)
  }
}

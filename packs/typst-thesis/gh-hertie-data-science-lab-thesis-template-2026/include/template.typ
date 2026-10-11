#import "@preview/equate:0.3.1": equate, share-align
#import "snippets.typ": figurespace
#import "@preview/codly:1.3.0": codly, codly-init
#import "@preview/codly-languages:0.1.1": codly-languages

/////////////////////////////////////////////////////////////////////////
//  MAIN DOCUMENT CLASS
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


#let the_body(
  title: "",
  subtitle: "",
  author: (),
  supervision: (),
  statements: (),
  date: "",
  meta: (),
  bibliography_files: ("papers.bib", "packages.bib"),
  abstract: [],
  acknowledgements: [],
  body,
) = {
  // Document's basic properties.
  set document(
    author: author.name,
    title: title,
  )
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
    numbering: "i",
    footer: none,
  )
  set text(
    size: 12pt,
    font: "New Computer Modern",
    weight: 400,
    lang: "en",
    region: "gb",
  )
  set par(
    spacing: 1em,
    leading: 0.65em,
  )

  // Equations
  show math.equation: set text(weight: 400)
  show: equate.with(breakable: false, sub-numbering: true, number-mode: "label")
  set math.equation(numbering: "(1.1)")
  show math.equation.where(block: false): box // force inline eq's to be unbreakable
  set math.lr(size: 110%)

  //show math.equation.where(block: true): set block(spacing: 1.3em)
  show math.equation.where(block: true): it => {
    let multiline = (
      it.body.func() == [].func() and linebreak() in it.body.children and sym.note.quarter.alt not in it.body.children
    )
    set block(spacing: 2em) if multiline
    set block(spacing: 1em) if not multiline
    it
  }

  // Figures
  show figure: it => layout(
    sz => {
      let w = measure(it.body, width: sz.width).width
      set par(justify: true, spacing: .65em)
      set text(size: 10pt)
      show figure.caption: cap => box(
        width: w,
        align(left, [
          #v(.3em)
          #cap
        ]),
      )
      it
    },
  )
  show: figurespace.with(figure_spacing: 2.5em)

  // Tables
  set table(
    stroke: .3pt,
    align: left + horizon,
  )
  set table.header(
    repeat: true,
  )
  //show table.cell.where(y: 0): strong

  // Images
  show image: it => text(font: "New Computer Modern Sans", it)


  // Headings (with run-in subheadings from level 4 onwards)
  show heading: obj => {
    if obj.level > 4 {
      parbreak()
      text(
        12pt,
        style: "italic",
        weight: "regular",
        obj.body + ".",
      )
    } else if obj.level == 4 {
      parbreak()
      let threshold = 1% // minimum proportion of page still unfilled, otherwise pagebreak
      //block(breakable: false, height: threshold)
      //v(-threshold, weak: true)
      block(text(
        12pt,
        style: "italic",
        weight: "regular",
        obj.body + "." + linebreak(),
      ))
    } else if obj.level == 1 {
      pagebreak(weak: true)
      obj
    } else if obj.level == 2 {
      let threshold = 1% // minimum proportion of page still unfilled, otherwise pagebreak
      //block(breakable: false, height: threshold)
      //v(-threshold, weak: true)
      obj
    } else {
      // 3
      let threshold = 1% // minimum proportion of page still unfilled, otherwise pagebreak
      //block(breakable: false, height: threshold)
      //v(-threshold, weak: true)
      obj
    }
  }
  show heading.where(level: 1): set block(below: 2em)
  show heading.where(level: 2): set block(above: 2em, below: 1.3em)
  show heading.where(level: 3): set block(above: 2em, below: 1em)
  show heading.where(level: 4): set block(above: 1.3em, below: .6em)

  show selector(<nonumber>): set heading(numbering: none)

  // Links
  show link: set text(fill: rgb("#ba0020"))
  show ref: set text(fill: rgb("#ba0020"))
  show cite: set text(fill: rgb("#ba0020"))

  // Code
  show raw: set text(font: "New Computer Modern Mono")
  show: codly-init.with()
  codly(languages: codly-languages)

  // Footnotes
  // let show-footnote = state("show-footnote", true)
  // //let footnote(..args) = context if show-footnote.get() { std.footnote(..args) }

  // let clean-footnote(it) = context {
  //   let origin-value = show-footnote.get()
  //   context (show-footnote.update(false) + it)
  //   show-footnote.update(origin-value)
  // }

  // show outline: clean-footnote

  show footnote.entry: it => context {
    let loc = it.note.location()
    box(
      super(numbering("1", ..counter(footnote).at(loc))) + h(.3em) + it.note.body,
    )
  }


  /////////////////////////////////////////////////////////////////////////
  // TITLE PAGE


  {
    show heading: none
    heading(numbering: none, outlined: false, bookmarked: true)[Title Page]
  }

  v(0.03fr)

  // Title & subtitle.
  align(center, block(
    text(
      weight: 700,
      2em,
      [#title],
    ),
    width: 100%,
  ))
  v(0.22fr)
  align(center, block(
    text(
      weight: 700,
      1.5em,
      [#smallcaps[#subtitle]],
    ),
  ))
  v(0.25fr)

  // Author information.

  grid(
    columns: 1fr,
    gutter: 1em,
    align(center)[
      *#author.name*
      #link("mailto:" + author.email)[#emoji.email] \ \
      #author.affiliation \
      #author.program \ \
      Submitted on #date \
      Words: #meta.words
    ]
  )
  v(.55fr)

  // Supervision information.
  grid(
    columns: 1fr,
    gutter: 1em,
    align(center)[
      #smallcaps[Main Supervisor] \
      #supervision.supervisor \
      #supervision.supervisor_affiliation
      #if supervision.practice_partner != none {
        [\ \ #smallcaps[Practice Partner] \ #supervision.practice_partner]
      }
    ],
  )

  pagebreak()


  /////////////////////////////////////////////////////////////////////////
  // ABSTRACT


  set page(
    footer: context align(
      center,
      numbering(
        page.numbering,
        ..counter(page).get(),
      ),
    ),
  )
  set heading(numbering: none)
  set par(justify: true)
  heading(outlined: false, bookmarked: true)[Abstract]

  [#abstract]
  v(1fr)

  [
    #[
      #if statements.coi != none [
        #heading(level: 3)[Conflict of interest statement]
        #statements.coi
      ]
      #if statements.da != none [
        #heading(level: 3)[Data availability statement]
        #statements.da
      ]
      #if meta.jel != none [
        #heading(level: 3)[JEL classification]
        #meta.jel
      ]
      #if meta.keywords != none [
        #heading(level: 3)[Keywords]
        #meta.keywords
      ]
    ]
  ]


  /////////////////////////////////////////////////////////////////////////
  // ACKNOWLEDGEMENTS


  heading(outlined: false, bookmarked: true)[Acknowledgements]
  emph[#acknowledgements <no-wc>]
  pagebreak(weak: true)


  /////////////////////////////////////////////////////////////////////////
  // TABLE OF CONTENTS


  set outline(indent: 1em)
  show outline.entry.where(level: 1): set block(above: 1.5em)
  {
    set footnote.entry(
      separator: none,
    )
    show footnote.entry: hide
    show ref: none
    show footnote: none

    outline(depth: 2)
  }


  /////////////////////////////////////////////////////////////////////////
  // MAIN BODY


  // Page & Section numbering
  set heading(numbering: "1.1  ")
  set page(
    numbering: "1",
    number-align: center,
  )
  counter(page).update(1)

  // Main body.
  body
}


/////////////////////////////////////////////////////////////////////////
//  BIBLIOGRAPHY CLASS
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


#let the_bibliography(
  meta: (),
  bibliography_files: ("papers.bib", "packages.bib"),
  ..rest,
  body,
) = {
  set heading(numbering: none)
  pagebreak(weak: true)
  heading[Bibliography]
  {
    set text(size: 10pt)
    [
      #[All online resources were last accessed on #meta.last_accessed. \ \ ]
      <no-wc>
    ]
    bibliography(bibliography_files, style: "american-psychological-association", title: none)
  }
  body
}


/////////////////////////////////////////////////////////////////////////
//  APPENDIX CLASS
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


#let the_appendix(body) = {
  set heading(numbering: "A1.1  ", supplement: "Appendix")
  counter(heading).update(0)

  show heading: obj => {
    if obj.level == 2 {
      let threshold = 85% // minimum proportion of page still unfilled, otherwise pagebreak
      block(breakable: false, height: threshold)
      v(-threshold, weak: true)
      obj
    } else {
      obj
    }
  }

  [#body <no-wc>]
}

/////////////////////////////////////////////////////////////////////////
//  STATEMENT OF AUTHORSHIP CLASS
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


#let the_statement(
  author: (),
  statements: (),
  ..rest,
  body,
) = {
  set heading(numbering: none)
  pagebreak(weak: true)
  heading(outlined: false, bookmarked: true)[Statement of Authorship]
  [
    #set par(justify: true)
    #statements.authorship

    #v(2em)
    DATE: #h(1fr) \
    #v(1em)
    NAME: #h(1fr) #author.name \
    #v(1em)
    SIGNATURE: #h(1fr) \
    <no-wc>
  ]
  body
}

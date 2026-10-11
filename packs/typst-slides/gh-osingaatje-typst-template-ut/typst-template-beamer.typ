// Original author: Flavio Barisi (@preview/minimal-presentation:0.7.0)
// secondary author: Femke Weijsenfeld
// fine-tuning and refactoring by Douwe Osinga

#import "shared/typst-ut.typ": *

#let appendix = appendix

#let main-color-state = state("main-color-state", colors.darkblue) // is set in the "project" function

#let default-title-decoration(fillcol: white) = polygon(fill: fillcol,
  (60%, 0%),
  (100%, 0%),
  (100%, 100%),
  (86.5%, 100%),
)
#let default-section-decoration(fillcol: white) = polygon(fill: fillcol,
  (87.5%, 0%),
  (100%, 0%),
  (100%, 100%),
  (65%, 100%),
)

#let logo(version: "black", logo-width: 8%) = {
  let ut-logo-path = "shared/pics/UT_Logo_Black-crop.pdf"
  if version == "white" {
      ut-logo-path = "shared/pics/UT_Logo_White-crop.pdf"
  }
  image(ut-logo-path, width: logo-width)
}

#let set-main-color(main-color) = {
  main-color-state.update(main-color)
}

// example usage: #columns-content [col1 content] [col2 content] [...etc.]
#let columns-content(align: horizon, ..args) = {
  let argdict = args.named() // "horizon": <value>, "col-widths": <value>, ...
  let bodies = args.pos() // [col1 content] [col2 content] [...etc]
  
  let column-sizes = argdict.at("column-sizes", default: (1fr,) * bodies.len() )
  if column-sizes.len() != bodies.len() {
    panic("Please provide column sizes for all column bodies!")
  }

  grid(
    columns: column-sizes,
    gutter: argdict.at("gutter", default: 1cm),
    align: align,
    ..bodies
  )
}

#let project(
  titletext: [Title],
  sub-titletext: [Subtitle],
  author: [ Author ],
  date: none,
  bibstyle: none, // default == none - THIS IS A RELATIVE PATH FROM WITHIN THE `shared` FOLDER!
  citestyle: none, // default == none - THIS IS A RELATIVE PATH FROM WITHIN THE `shared` FOLDER!
  background-img-path: "shared/pics/oo.png",
  aspect-ratio: "16-9",
  main-color: blue,
  content-margin: 1.5cm,
  body
) = {
  // set bibliography styles
  show: styling.with(citestyle: citestyle, bibstyle: bibstyle) // show shared font styling etc.

  // align everything to vertical center
  set align(horizon)

  // show the opening page in white text, show title in specific size
  show title: set text(size: 2em)
  show heading.where(level: 1): set text(size: 1.75em)
  show heading.where(level: 2): set text(size: 1.5em)
  show heading.where(level: 3): set text(size: 1.25em)

  set text(size: 1.5em)
  show title: set par(leading: 0.3em)
  show figure.caption: set text(size: 0.8em)

  // figure / bib styling
  set figure(gap: 10pt)
  show bibliography: set heading(level: 2)
  set underline(offset: 3pt)

  set document(title: titletext, author: author)
  main-color-state.update(main-color)

  // METADATA HELPERS
  // Returns the 'value' dictionary for this particular page.
  // Example: metadata((page: <this page>, value: <dict> ) returns <dict>
  let get_page_metadata(pageno: int) = { 
    let md = query(<meta:page>).filter(f => f.value.at("page",default: 0) == pageno)
    if md.len() == 0 {
      (nothing: true)
    } else {
      md.first().value
    }
  }

  // DEFAULT PAGE SETTINGS
  set page(
    margin: 0pt,
    paper: "presentation-" + aspect-ratio,
    footer: context if (counter(page).get() != 0) {
      let fillcol = black
      if get_page_metadata(pageno: here().page()).at("is_section", default:false) == true {
        fillcol = main-color-state.get()
      }

      place(bottom+right, dx: 0pt, dy: -.75*content-margin, [
        #set text(fill: fillcol)

        #numbering(
          "1 / 1",
          ..counter(page).get(),
          ..counter(page).final(),
        )])
    },
    background: context{
      if get_page_metadata(pageno: here().page()).at("is_section", default: false) {
        // BG color
        rect(width: 100%, height: 100%, fill: main-color-state.at(here()))

        // BG decoration
        place(right+horizon, box(width: 100%, height: 100%+2*content-margin, default-section-decoration()))  
      }
      // UT logo
      place(top+right, dx: -1*content-margin, dy: 1*content-margin, logo())
    })

  set list(
      tight:true, indent: 0.27cm, body-indent: 0.7cm, 
      marker: (
        context place(top+center, dy: -0.25em,
          text(size: 1.5em, fill: main-color-state.at(here()), "▶")), 

        context place(top+center, dy: -0.25em,
          text(size: 1.25em, fill: main-color-state.at(here()), "■"))
      ))

  set enum(numbering: (..args) => context{text(fill:main-color-state.at(here()), numbering("1.", ..args))})

  // TITLE PAGE:
  page(footer: [] /* no page numbering etc.*/, [
    #set text(fill: white) // set text to white for title page

    #counter(page).update(0)

    // background image
    #if (background-img-path != none) {
      place(image(width: 100%, height: 100%, background-img-path))

      // semi-transparent rectangle to make contrast nice
      place(block(fill: rgb("000000AA"), width: 100%, height: 100% + 1pt))
    }

    // decoration to break up the background picture
    #place(default-title-decoration(fillcol: blue))

    // title + author
    #place(left+horizon, 
      block(inset: (left: content-margin), width: 60%, [
        #title()
        #block(inset: (top: -1em), [#sub-titletext])

        #if author != none { block(text(size: 1.25em, author)) }
      ])
    )

    // UT logo
    #place(right+top, dx: -1*content-margin, dy: 1*content-margin, logo(version: "white", logo-width: 15%))

    // date
    #if date != none { place(bottom+left, block(inset: (left: 1.5cm, bottom: content-margin),date)) }

  ])


  // Link
  show link: it => underline(
    context text(fill: main-color-state.at(here()), it)
  )

  show heading.where(level: 1): it => [
    #set text(fill: white)
    #pagebreak(weak: true)
    #metadata((page: here().page(), is_section: true))<meta:page>
    #it
  ]

  show heading.where(level: 2): it => [
    #pagebreak()
    #place(top+left, float: true, it)
  ]

  show heading.where(level: 3): it => [
    /*#pagebreak()
    #place(top+left,*/#it
  ]

  // -------- FINISHING TOUCHES -------- //
  set page(margin: content-margin)
  body // rest of the document
}

// Table of contents
#let table-of-contents(
  logo: none,
  index-title: "Content",
  heading-2-size: 1.9em,
) = {
    show underline: it => it.body // no underline
    show heading.where(level: 1): h => h.body // no separate title page

    heading(level: 1, [Table of Contents])
    context{
      let elements = query(selector(heading.where(level: 1)).after(here()))
      enum(tight: false, ..elements.map(elem =>
        link((page: elem.location().page() + 1, x: 0pt, y: 0pt), elem.body))
      )
    }
  } 

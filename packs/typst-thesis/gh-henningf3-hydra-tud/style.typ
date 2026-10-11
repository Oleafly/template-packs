#import "@preview/hydra:0.6.3": hydra

// typst-style fonts:
#let font-libertinus = "Libertinus Serif" // = font-typst
#let font-libertinus-math = "Libertinus Math" // not bundled with typst, must be installed manually
#let font-libertinus-code = "Libertinus Mono" // not bundled with typst, must be installed manually

#let font-typst-code = "DejaVu Sans Mono"

// latex fonts:
#let font-latex = "New Computer Modern"
#let font-latex-math = "New Computer Modern Math" // = font-typst-math
#let font-latex-code = "Computer Modern Typewriter" // not bundled with typst, must be installed manually

// TUD corporate fonts:
#let font-tud-corporate = "Noto Sans"
#let font-tud-corporate-math = "Noto Sans Math" // not bundled with typst, must be installed manually
#let font-tud-corporate-math = "Noto Sans Mono" // not bundled with typst, must be installed manually

// Margins
#let print-margin = (inside: 3cm, outside: 2cm, top: 2.5cm, bottom: 2.5cm)
#let digital-margin = (inside: 2.5cm, outside: 2.5cm, top: 2.5cm, bottom: 2.5cm)


#let tud-doc(
  /*
   * Front Page Entries
   */
  title: none,
  subtitle: none,
  authors: (), // e.g., ((first_name: "Max", surname: "Mustermann", matriculationno: "123", email: "x@y"), ...); matriculationno and email are optional
  faculty: none,
  institute: none,
  chair: none,
  supervisors: (), // e.g., ((name: "Dr. X", email: "x@y"), ...)
  language: "en",  // "de" (German) or "en" (English)
  print_compile: false,
  date: none, // pass a datetime; if none, the date block is omitted. Can be used for instance as a submission date

  /*
   * Content Settings
   */
  equation-numbering-always: false, // if true, every equation will get a numbering; if false, only tagged equations will get a numbering
  equation-supplement: "Equation",
  equation-numbering-body: "(1.1)",
  equation-numbering-appendix: "(A.1)",
  figure-supplement: "Figure",
  figure-numbering-body: "1.1",
  figure-numbering-appendix: "A.1",

  /*
   * Optional Branding Overrides
   */
  logo_de: "logo/TUD_Logo_RGB_horizontal_schwarz_de.svg",
  logo_en: "logo/TUD_Logo_RGB_horizontal_schwarz_en.svg",
  logo_height: 2cm,
  font-text: font-latex,  // text font
  font-math: font-latex-math,  // math font
  font-code: font-typst-code,
  math-weight: 400,
  body-size: 11pt,
  info-size: 10pt,
  doc
) = {
  state("font-text").update(font-text)
  state("body-size").update(body-size)
  state("info-size").update(info-size)

  /*
   * Document Meta Information
   */
  let author-string = authors.map(a => a.first_name + " " + a.surname).join(", ")
  set document(title: title, description: subtitle, author: author-string)

  /*
   * Text Flow
   */
  set text(
    font: font-text,
    lang: language,
    size: body-size,
    costs: (widow: 1000%, orphan: 1000%),
  )

  let bs = body-size

  // line spacing: https://github.com/typst/typst/issues/106#issuecomment-2041051807

  // Text is from left to .right. edge of the content space
  set par(justify: true, leading: 0.8em)
  set page(numbering: "I")

  // blank pages after pagebreaks for print
  show selector.or(
    pagebreak.where(to: "odd"),
    pagebreak.where(to: "even"),
  ): set page(header: none, footer: none, numbering: none)

  // Heading size and spacing settings, breaks in print mode
  show heading: it => {
    if (it.level == 1) {
      if (print_compile) {
        pagebreak(weak: true, to: "odd") + text(size: 1.6em)[#it] + v(1em)
      } else {
        pagebreak(weak: true) + text(size: 1.6em)[#it] + v(1em)
      }
    } else if (it.level == 2) {
      text(size: 1.4em)[#it] + v(0.7em)
    } else if (it.level == 3) {
      text(size: 1.2em)[#it] + v(0.6em)
    } else {
      // Heading only numbered up to level 3
      block(it.body)
    }
  }
  // Prevent headings of level 4 or higher to appear in the bookmarks of the PDF
  // Apparently there is not better solution than writing theses lines explicitly,
  // using a loop does not work!
  show heading.where(level: 4): set heading(bookmarked: false)
  show heading.where(level: 5): set heading(bookmarked: false)
  show heading.where(level: 6): set heading(bookmarked: false)
  show heading.where(level: 7): set heading(bookmarked: false)

  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 and el.supplement != [Appendix] {
      link(
        el.location(),
        "Chapter "
          + numbering(
            el.numbering,
            ..counter(heading).at(el.location()),
          ),
      )
    } else { it }
  }

  //
  // Numbering
  //

  // set heading scheme
  set heading(numbering: "1.1")

  // set figure numbering, depends on state "backmatter"
  set figure(numbering: n => {
    let appx = state("backmatter", false).get()
    let hdr = counter(heading).get()
    let format = if appx { figure-numbering-appendix } else { figure-numbering-body }
    numbering(format, hdr.first(), n)
  })
  set figure(supplement: figure-supplement) // change default supplement

  //
  // Equations
  //
  show math.equation: set text(font: font-math) // set math font
  set math.equation(supplement: equation-supplement) // change default supplement
  show math.equation: set block(breakable: true)

  //
  // Code
  //
  show raw: set text(font: font-code)

  // set equation numbering scheme, depending if we are within the appendix or not
  set math.equation(
    numbering: n => {
      let appx = state("backmatter", false).get()
      let hdr = counter(heading).get()
      let format = if appx { equation-numbering-appendix } else { equation-numbering-body }
      numbering(format, hdr.first(), n)
    },
    supplement: equation-supplement
  )

  // only show equation numbering for labeled (tagged) block equations
  // https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations/977/18
  show math.equation: it => {
    if not equation-numbering-always and it.block and not it.has("label") and it.numbering != none [
      #counter(math.equation).update(v => calc.max(0, v - 1))
      #math.equation(it.body, block: true, numbering: none)
    ] else {
      it // just pass the iterator without modifying it
    }
  }


  //
  // Reset All Counters with each major heading
  //
  show heading.where(level: 1): hdr => {
    counter(figure.where(kind:image)).update(0)
    counter(figure.where(kind:table)).update(0)
    counter(math.equation).update(0)
    hdr
  }


  //
  // Front Page
  //

  // Format Page, No Numbering on Title Page
  set page(margin: print-margin, numbering: none) if print_compile
  set page(margin: digital-margin, numbering: none) if not print_compile



  // Place structure unit below (only if something provided)
  if faculty != none or institute != none or chair != none [
    #box(
      width: 100%,
      outset: (y: 4pt),
      stroke: (top: black, bottom: black),
      height: logo_height
    )[
      #align(left + horizon)[
        #if faculty != none [ *#faculty* \ ]
        #if institute != none and faculty != none [
          #institute \
          #chair
        ] else if institute != none [
          #institute
        ] else if chair != none [
          #chair
        ]
      ]
      #place(
          top + right,
          image(if language == "de" {logo_de} else if language == "en" {logo_en} , height: logo_height),
      )
    ]
  ]

  // Place Title
  if title != none or subtitle != none [
    #place(
      dy: 15%,
      [
        #if title != none and subtitle != none [
          #text(30pt, weight: "bold", title)

          #text(20pt, subtitle)
        ] else if title != none [
          #text(30pt, weight: "bold", title)
        ] else if subtitle != none [
          #text(20pt, subtitle)
        ]
      ]
    )
  ]

  // Author placement
  if authors.len() > 0 {
    place(
      dy: 45%,
      grid(
        row-gutter: 4%,
        ..authors.map((author) => [
          *#author.first_name #author.surname*\
          #if author.keys().contains("matriculationno") and language == "de" [_Matrikelnummer:_ #author.matriculationno \ ]
          #if author.keys().contains("matriculationno") and language == "en" [_Matriculation No.:_ #author.matriculationno \ ]
          #if author.keys().contains("email") [_E-Mail:_ #link("mailto:" + author.email)]
        ]),
      )
    )
  }

  // Submission date and Supervisor placement
  if (date != none) or (supervisors.len() > 0) {
    place(
      bottom,
      {
        if language == "de" {
          if date != none [
            *Abgabedatum*\
            #date.display("[day].[month].[year]")
            #v(5%)
          ]
          if supervisors.len() > 0 [
            *Betreuer:*\
            #list(
              tight: true,
              ..supervisors.map((sup) => [
                - #sup.name#if sup.keys().contains("email") and sup.email != "" [ #link("mailto:" + sup.email) ]
              ])
            )
          ]
        }
        if language == "en" {
          if date != none [
            *Date of Submission*\
            #date.display("[day].[month].[year]")
            #v(5%)
          ]
          if supervisors.len() > 0 [
            *Supervisor#if supervisors.len() > 1 [s]:*\
            #list(
              tight: true,
              ..supervisors.map((sup) => [
                #sup.name#if sup.keys().contains("email") and sup.email != "" [ (#link("mailto:" + sup.email)) ]
              ])
            )
          ]
        }
      }
    )
  }

  pagebreak() // end of title page

  //
  // Content
  //
  doc
}


#let create-tud-outline(
  font-text: context state("font-text").get(),
  body-size: context state("body-size").get(),
  info-size: context state("info-size").get()
) = context {
  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    context {
      set block(above: 2 * state("info-size").get())
      set text(font: state("font-text").get(), weight: "bold", size: state("info-size").get())
    }
    link(
      it.element.location(),    // make entry linkable
      it.indented(it.prefix(), it.body() + box(width: 1fr,) +  strong(it.page()))
    )
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set block(above: 0.8 * state("body-size").get())
    set text(font: state("font-text").get(), size: state("info-size").get())
    link(
      it.element.location(),  // make entry linkable
      it.indented(
          it.prefix(),
          it.body() + "  " +
            box(width: 1fr, repeat([.], gap: 2pt)) +
            "  " + it.page()
      )
    )
  }

  // show outline, hide all sections with a level greater 3
  outline(indent: auto, depth: 3)

  pagebreak() // end of outline
}

#let tud-preamble(print_compile: false, doc) = {
  let target-margin = if print_compile { print-margin } else { digital-margin }

  // Break to odd page before setting Roman numeral counter
  if print_compile {
    pagebreak(to: "odd", weak: true)
  } else {
    pagebreak(weak: true)
  }

  //
  // Set Page Style
  // Chapter in Page Header, Page Number in Footer
  //
  set page(
    margin: target-margin,
    numbering: "i", // roman page numbers for preamble
    header: [#context hydra(1) \ #line(start: (0%, 0% -.2cm), length: 100%)],
    footer: context[#line(start: (0%, 0% -.2cm) ,length: 100%) #align(center, counter(page).display("i"))],
  )

  // Unnumbered headings in preamble
  set heading(numbering: none)

  counter(page).update(1)

  //
  // Content
  //
  doc
}

#let tud-body(print_compile: false, doc) = {
  let target-margin = if print_compile { print-margin } else { digital-margin }

  // Break to odd page before setting Roman numeral counter
  if print_compile {
    pagebreak(to: "odd", weak: true)
  } else {
    pagebreak(weak: true)
  }

  //
  // Set Page Style
  // Chapter in Page Header, Page Number in Footer
  //
  set page(
    margin: target-margin,
    numbering: "1", // needed for outline
    header: [#context hydra(1) \ #line(start: (0%, 0% -.2cm), length: 100%)],
    footer: context[#line(start: (0%, 0% -.2cm) ,length: 100%) #align(center, counter(page).display("1"))],
  )
  counter(page).update(1)

  set heading(numbering: "1.1")
  counter(heading).update(0)


  //
  // Content
  //
  doc
}


#let tud-appendix(doc) =  {
  set heading(numbering: "A.1", supplement: "Appendix")
  counter(heading).update(0)
  state("backmatter").update(true)
  //
  // Content
  //
  doc
}

#outline(target: heading.where(supplement: [Appendix]), title: [Appendix])

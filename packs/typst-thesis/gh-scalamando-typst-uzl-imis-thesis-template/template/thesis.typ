#import "@preview/acrostiche:0.7.0"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/drafting:0.2.2"
#import "@preview/glossy:0.9.1"
#import "@preview/hydra:0.6.2" // Maybe later, doesn't work very well atm
#import "@preview/i-figured:0.2.4"
#import "@preview/icu-datetime:0.2.2": fmt
#import "@preview/outrageous:0.4.1"
#import "/acronyms.typ": acronyms
#import "/glossary.typ": glossar-list
#import "utils.typ"


#let (margin-left, margin-top, margin-right, margin-bottom) = (
  3.5cm,
  3.5cm,
  2.5cm,
  4cm,
)

/// Produces a new thesis document from the given metadata and body content.
///
/// - title (de: str, eng: str): German and English title of this thesis
/// - thesis-type (str): type of thesis, e.g. Bachelorarbeit or Masterarbeit
/// - author (str): author of this thesis
/// - prof (str): professor responsible for this thesis
/// - support (str): person who supported you while writing this thesis
/// - company (show-company: bool, name: str): company information for the title page
/// - date (datetime): finalized date of this thesis, defaults to today
/// - abstract (de: content, eng: content): German and English abstract of this thesis
/// - keywords (de: str, eng: str): German and English keywords belonging to this thesis
/// - print (bool): whether to optimize the document for print
/// - one-sided (bool): whether to use one-sided page layout
/// - body (content): thesis content
#let thesis(
  title: (de: "", eng: ""),
  thesis-type: "",
  author: "",
  prof: "",
  support: "",
  company: (show-company: true, name: ""),
  date: datetime.today(),
  abstract: (de: "", eng: ""),
  keywords: (de: "", eng: ""),
  print: false,
  one-sided: true,
  body,
) = {
  // Set the document's basic properties.
  set document(author: author, title: title.de)
  set page(paper: "a4", margin: (
    left: margin-right, // same as right for title page
    right: margin-right,
    top: margin-top,
    bottom: margin-bottom,
  ))

  ////////////////////////////
  //// -- General setup-- ////
  ////////////////////////////

  // --- glossy: Glossarium ---
  show: glossy.init-glossary.with(glossar-list)

  // --- acrostiche: Achronyms ---
  acrostiche.init-acronyms(acronyms)

  // --- drafting: notes for drafts ---
  drafting.set-page-properties(
    margin-left: margin-left,
    margin-right: margin-right,
  )

  // --- codly: styled code listings ---
  show: codly-init
  codly(
    zebra-fill: color.hsl(0deg, 0%, 98%),
    stroke: 1pt + color.hsl(0deg, 0%, 85%),
    languages: codly-languages,
  )

  // -- i-figured: per chapter figure numbering
  show figure: i-figured.show-figure

  ////////////////////////////////////////////
  //// -- General Typography and Style -- ////
  ////////////////////////////////////////////

  // Line height and font
  set par(leading: 0.85em)
  set text(
    font: "Libertinus Serif",
    lang: "de",
    size: 12pt,
    hyphenate: auto,
  )

  // Only do heading numbering for the first three levels (e.g. 1.1.1, but not 1.1.1.1)
  set heading(
    numbering: (..nums) => {
      if nums.pos().len() < 4 {
        numbering("1.1", ..nums)
      }
    },
  )

  // Only underline external links in digital exports
  show link: it => {
    if type(it.dest) == label or print {
      it
    } else {
      underline[#it]
    }
  }

  // Figure caption
  set figure(placement: auto)
  show figure.caption: c => context [
    #set text(size: 0.9em, hyphenate: false)
    #text(weight: "bold")[#c.supplement #c.counter.display(c.numbering)]#c.separator#c.body
  ]

  // Tables
  show table: set text(font: "Inter")
  show table.cell: it => {
    if it.y == 0 {
      set text(white)
      it
    } else {
      it
    }
  }
  set table(
    stroke: 0.5pt + gray.darken(20%),
    fill: (_, y) => if y == 0 {
      gray.darken(40%)
    } else if calc.odd(y) {
      gray.lighten(80%)
    },
  )

  // Add spacing between placed content
  set place(clearance: 2em)

  // Indent lists
  set list(indent: 1em)
  set enum(indent: 1em)

  // Enable numbering for bibliography
  show bibliography: set heading(numbering: "1")

  /////////////////////////
  //// -- Title Page-- ////
  /////////////////////////

  align(center)[
    #set par(leading: 0.65em, spacing: 0.85em)

    #image("imis-logo.png")

    #v(3em, weak: true)

    #par(
      text(
        title.de,
        weight: 700,
        size: 1.75em,
      ),
      leading: 0.6em,
    ) #v(1.5em, weak: true)

    #par(
      text(
        title.eng,
        weight: 400,
        size: 1.25em,
      ),
    ) #v(3.5em, weak: true)

    *#thesis-type* #v(1.5em, weak: true)

    im Rahmen des Studiengangs \ *Medieninformatik* \ der Universität zu Lübeck

    #v(3em, weak: true)

    vorgelegt von:

    *#author*

    #v(3em, weak: true)

    ausgegeben und betreut von:

    *#prof*

    #v(2em, weak: true)

    mit Unterstützung von:

    *#support*

    #v(1fr, weak: true)

    #if company.show-company {
      text(
        "Die Arbeit ist im Rahmen einer Tätigkeit bei der Firma " + company.name + " entstanden.",
      )
      v(1fr, weak: true)
    }

    Lübeck, #fmt(date, locale: "de", length: "long")
  ]

  if not one-sided { pagebreak(to: "odd") }

  ////////////////////////////////////////////////////
  //// -- Typography and Style for Main Content-- ////
  ////////////////////////////////////////////////////

  // Justify paragraphs and add one line of spacing between paragraphs
  set par(justify: true, spacing: 2em)

  // Setup page for the rest of the thesis
  set page(
    // Display roman page numbering in preamble
    header: context {
      let page-is-odd = calc.odd(here().page())
      let show-numbering = one-sided or page-is-odd
      if show-numbering {
        align(right, counter(page).display("i"))
        v(-1em)
        line(length: 100%, stroke: color.hsl(0deg, 0%, 70%))
      }
    },
    margin: if one-sided {
      (
        left: margin-left,
        right: margin-right,
        top: margin-top,
        bottom: margin-bottom,
      )
    } else {
      (
        inside: margin-left,
        outside: margin-right,
        top: margin-top,
        bottom: margin-bottom,
      )
    },
  )

  // -- drafting: Setup after final margin adjustments
  drafting.set-page-properties()

  ////////////////////////
  //// -- Abstract -- ////
  ////////////////////////

  [
    #set heading(numbering: none, outlined: false)
    #show heading.where(level: 1): set heading(bookmarked: true)
    #show heading.where(level: 1): it => [
      #v(1.5em)
      #it
      #v(1.5em)
    ]
    #show heading.where(level: 2): it => [
      #v(1.5em)
      #it
      #v(0.75em)
    ]

    = Kurzfassung
    #abstract.de

    == Schlüsselwörter
    #keywords.de.split(regex(",\s?")).join("\n")

    #if one-sided {
      pagebreak()
    } else {
      pagebreak(to: "odd")
    }

    = Abstract
    #abstract.eng

    == Keywords
    #keywords.eng.split(regex(",\s?")).join("\n")

    #if one-sided {
      pagebreak()
    } else {
      pagebreak(to: "odd")
    }

    #include "../foreword.typ"

    #pagebreak(to: if not one-sided { "odd" })
  ]

  /////////////////////////////////
  //// -- Table of Contents -- ////
  /////////////////////////////////

  {
    show heading.where(level: 1): it => [
      #pagebreak(weak: true)
      #text(size: 1.5em, pad(it, top: 0.5em))
      #v(1em)
    ]
    show outline.entry: outrageous.show-entry.with(
      ..outrageous.presets.typst,
      font-weight: (700, 400),
      vspace: (2em, 1em),
    )
    outline(depth: 3)
  }

  ////////////////////////////
  //// -- Main Content -- ////
  ////////////////////////////

  // Reset page counter for main part
  counter(page).update(0)

  set page(
    numbering: none,
    header: context {
      let loc = locate(here())
      let hydra-heading-1 = hydra.hydra(1)
      let hydra-heading-2 = hydra.hydra(2)
      let page-is-odd = calc.odd(here().page())

      if one-sided {
        // Display current chapter heading and page number on every page
        grid(
          columns: (1fr, 12pt),
          rows: auto,
          align(
            left,
            hydra-heading-1,
          ),
          align(right, counter(page).display()),
        )
      } else {
        // Display current chapter headings on even pages and section headings on odd pages
        grid(
          columns: 1fr,
          rows: auto,
          if page-is-odd {
            align(
              right,
              if hydra-heading-2 != none {
                hydra-heading-2
              } else {
                // Fallback in case hydra doesn't find a section heading
                hydra-heading-1
              },
            )
          } else {
            align(
              left,
              hydra-heading-1,
            )
          }
        )
      }

      v(-0.7em)

      if hydra-heading-1 != none {
        line(length: 100%, stroke: color.hsl(0deg, 0%, 70%))
      }
    },
    footer: context if not one-sided {
      // Display page numbers in the pages outer corner
      let page-is-odd = calc.odd(here().page())
      align(
        if page-is-odd {
          right
        } else {
          left
        },
        counter(page).display("1"),
      )
    },
  )

  // Odd page breaks are placed between chapters in the two-sided version.
  // The inserted empty page shouldn't contain header or footer.
  show pagebreak.where(to: "odd"): set page(header: none, footer: none)

  {
    // Body Heading styles
    show heading.where(level: 1): it => context [
      #if one-sided {
        pagebreak(weak: true)
      } else {
        pagebreak(to: "odd")
      }
      #text(
        size: 1.65em,
        pad(
          [
            #set par(leading: 0.75em)
            #text(
              counter(heading).display(),
              size: 72pt,
              fill: color.hsl(0deg, 0%, 60%),
            ) \
            #it.body
          ],
          top: 4em,
        ),
      )
      #i-figured.reset-counters(it, return-orig-heading: false)
      #v(2em)
    ]
    // References to level 1 headings should say 'Kapitel'
    show heading.where(level: 1): set heading(supplement: [Kapitel])

    show heading.where(level: 2): it => [
      #v(1.5em)
      #text(size: 1.25em, it)
      #v(1.5em)
    ]
    show heading.where(level: 3): it => [
      #v(1em)
      #text(size: 1.25em, it)
      #v(1em)
    ]
    show heading.where(level: 4): it => [
      #v(1em)
      #it
      #v(0.75em)
    ]

    body
  }

  ///////////////////////////////////////
  //// -- Bibliography and others -- ////
  ///////////////////////////////////////

  // Hide heading numbering from now on
  set heading(numbering: none)
  show heading.where(level: 1): it => [
    #if one-sided {
      pagebreak(weak: true)
    } else {
      pagebreak(to: "odd")
    }
    #text(size: 1.5em, it)
    #v(2em)
  ]
  show heading.where(level: 2): it => [
    #v(1.5em)
    #text(size: 1.25em, it)
    #v(1.5em)
  ]

  show bibliography: set heading(numbering: none)

  // -- Bibliography --
  bibliography(
    "../bibliography/references.bib",
    title: [Literaturverzeichnis],
    style: "apa",
  )

  bibliography(
    "../bibliography/normen.bib",
    title: [Normenverzeichnis],
    style: "apa",
  )

  // -- Software directory --
  include "/software.typ"

  // -- Outlines --
  context {
    show outline: set heading(outlined: true)
    show outline.entry.where(level: 1): it => {
      v(0.25em)
      it
    }

    let fig-count(kind) = counter(figure.where(kind: i-figured._prefix + repr(kind))).get().at(0)

    // Only show outlines for figure types that have entries

    // -- Table of Images --
    if (fig-count(image) > 0) {
      i-figured.outline(target-kind: image, title: [Abbildungsverzeichnis])
    }

    // -- Table of Tables --
    if (fig-count(table) > 0) {
      i-figured.outline(target-kind: table, title: [Tabellenverzeichnis])
    }

    // -- Table of Listing --
    if (fig-count(raw) > 0) {
      i-figured.outline(target-kind: raw, title: [Listingverzeichnis])
    }
  }

  // -- Acronyms --
  context {
    let used-acronyms = acrostiche._acronyms.final().pairs().filter(((_, state)) => state.at(2)).map(((acr, _)) => acr)
    if (used-acronyms.len() > 0) {
      acrostiche.print-index(
        title: [Abkürzungen],
        delimiter: "",
        outlined: true,
        sorted: "up",
        row-gutter: 1em,
        used-only: true,
      )
    }
  }

  // -- Glossar --
  context {
    // HACK: glossy doesn't expose used entries, so we copied the internals
    // This is prone to breaking with new glossy releases
    let __is_term_ever_referenced(key, location: none) = {
      let __gloss_label_prefix = "__gloss:"
      let c = counter(__gloss_label_prefix + key)
      c = if location == none { c.final() } else { c.at(location) }
      c.at(0) > 0
    }
    let all_entries = state("__gloss_entries", (:)).final()
    let used-glossary-terms = all_entries.keys().filter(key => __is_term_ever_referenced(key))

    if (used-glossary-terms.len() > 0) {
      glossy.glossary(title: [Glossar], sort: true)
    }
  }

  ////////////////////////
  //// -- Addendum -- ////
  ////////////////////////

  show figure: it => i-figured.show-figure(it, numbering: "A.1")

  {
    show heading.where(level: 2): set heading(
      numbering: (
        first,
        ..numbers,
      ) => if numbers.pos().len() > 0 {
        numbering("A", ..numbers)
      },
      supplement: [Anhang],
    )
    // Add pagebreaks after the first addendum
    show heading.where(level: 2): it => context {
      if counter(heading).get().at(1) > 1 { pagebreak(weak: true) }
      it
    }

    counter(heading).update(1)

    include "/addendum/addendum.typ"
  }

  ////////////////////////////////////////
  //// -- Eidesstattlicheerklärung -- ////
  ////////////////////////////////////////

  page(header: none, footer: none)[
    #heading(text([Erklärung], size: 20pt), outlined: false, numbering: none)

    Ich versichere an Eides statt, die vorliegende Arbeit selbstständig verfasst und nur die angegebenen Quellen benutzt zu haben.

    #v(8em)

    #line(length: 50%, stroke: color.hsl(0deg, 0%, 50%))
    #v(-1.0em)
    #author.replace("B.Sc.", "") // Remove title for the signature

    #v(1em)

    Lübeck, #fmt(date, locale: "de", length: "long")
  ]
}


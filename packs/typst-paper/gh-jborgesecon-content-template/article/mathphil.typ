// mathphil.typ — Typst template for the Journal of Mathematical Philosophy (JMP)
// Targets ISO B5 paper, STIX Two Text/Math, Roboto display, and JMP color tokens.

// Color tokens matching the JMP website and LaTeX template
#let jmpink = rgb("#000000")
#let jmpinkii = rgb("#5A5246")
#let jmpinkiii = rgb("#8C8474")
#let jmprule = rgb("#505050")
#let jmpblue = rgb("#233f9d")

// Shared counter for theorem-like environments (matching JMP / amsthm specification)
#let thm-counter = counter("mathphil-theorem")

// Theorem environment (Italic body)
#let theorem(title: none, body) = {
  thm-counter.step()
  block(width: 100%, breakable: true, above: 1em, below: 1em)[
    #context {
      let num = thm-counter.display()
      let title-part = if title != none [ (#title)] else []
      text(weight: "bold")[Theorem #num#title-part.]
    }
    #h(0.5em)
    #emph(body)
  ]
}

// Proposition environment (Italic body)
#let proposition(title: none, body) = {
  thm-counter.step()
  block(width: 100%, breakable: true, above: 1em, below: 1em)[
    #context {
      let num = thm-counter.display()
      let title-part = if title != none [ (#title)] else []
      text(weight: "bold")[Proposition #num#title-part.]
    }
    #h(0.5em)
    #emph(body)
  ]
}

// Lemma environment (Italic body)
#let lemma(title: none, body) = {
  thm-counter.step()
  block(width: 100%, breakable: true, above: 1em, below: 1em)[
    #context {
      let num = thm-counter.display()
      let title-part = if title != none [ (#title)] else []
      text(weight: "bold")[Lemma #num#title-part.]
    }
    #h(0.5em)
    #emph(body)
  ]
}

// Definition environment (Upright body)
#let definition(title: none, body) = {
  thm-counter.step()
  block(width: 100%, breakable: true, above: 1em, below: 1em)[
    #context {
      let num = thm-counter.display()
      let title-part = if title != none [ (#title)] else []
      text(weight: "bold")[Definition #num#title-part.]
    }
    #h(0.5em)
    #body
  ]
}

// Example environment (Upright body)
#let example(title: none, body) = {
  thm-counter.step()
  block(width: 100%, breakable: true, above: 1em, below: 1em)[
    #context {
      let num = thm-counter.display()
      let title-part = if title != none [ (#title)] else []
      text(weight: "bold")[Example #num#title-part.]
    }
    #h(0.5em)
    #body
  ]
}

// Proof environment with Halmos Q.E.D. symbol
#let proof(body) = block(width: 100%, breakable: true, above: 0.9em, below: 0.9em)[
  #text(style: "italic")[Proof.] #h(0.5em)
  #body
  #h(1fr) $square$
]

// Back matter environment for Acknowledgements, Funding, Conflicts of interest
#let jmp-backmatter(title, body, sans-font: ("Roboto", "Liberation Sans", "DejaVu Sans")) = block(
  width: 100%,
  breakable: true,
  above: 1.8em,
  below: 0.8em,
)[
  #text(
    font: sans-font,
    size: 10.5pt,
    weight: "bold",
  )[#title]
  #v(0.6em)
  #text(size: 10pt)[#body]
]

#let acknowledgements(body) = jmp-backmatter("Acknowledgements", body)
#let funding(body) = jmp-backmatter("Funding", body)
#let conflictsofinterests(body) = jmp-backmatter("Conflicts of interest", body)

// Main document wrapper
#let mathphil-article(
  title: "",
  short-title: none,
  short-authors: none,
  authors: (),
  abstract: none,
  keywords: (),
  msc: none,
  doi: none,
  issue: "2026",
  year: "2026",
  copyright-holders: none,
  paper-size: "iso-b5",
  font: ("STIX Two Text", "New Computer Modern", "Latin Modern Roman", "Liberation Serif"),
  math-font: ("STIX Two Math", "New Computer Modern Math", "Latin Modern Math"),
  sans-font: ("Roboto", "Liberation Sans", "DejaVu Sans"),
  mono-font: ("Latin Modern Mono", "DejaVu Sans Mono", "FiraCode Nerd Font"),
  body,
) = {
  let display-short-title = if short-title != none { short-title } else { title }
  let display-short-authors = if short-authors != none {
    short-authors
  } else if authors.len() > 0 {
    authors.map(a => a.name.split(" ").last()).join(", ", last: " & ")
  } else {
    ""
  }
  let copyright-text = if copyright-holders != none {
    copyright-holders
  } else if authors.len() > 0 {
    authors.map(a => a.name).join(", ", last: " & ")
  } else {
    ""
  }

  // Page geometry: ISO B5 (176mm x 250mm), 22mm lateral margins, 25mm top, 18mm bottom
  set page(
    paper: paper-size,
    margin: (left: 22mm, right: 22mm, top: 25mm, bottom: 18mm),

    header: context {
      let page-num = counter(page).get().first()

      if page-num > 1 {
        align(right + bottom)[
          #text(
            font: sans-font,
            size: 8.1pt,
            fill: jmpinkii,
          )[ #str(page-num) ]
        ]
      }
    },
  )

  // Typography & Paragraph rules
  set text(
    font: font,
    size: 11pt,
    lang: "en",
    fill: jmpink,
  )
  show math.equation: set text(font: math-font)
  show raw: set text(font: mono-font, size: 9.5pt)
  show link: set text(fill: jmpblue)
  show ref: set text(fill: jmpblue)

  // Paragraph spacing and first-line indentation
  set par(
    justify: true,
    leading: 0.65em,
    spacing: 0.65em,
    first-line-indent: (amount: 17pt, all: false),
  )

  // Headings styling (Sentence case, trailing periods, Roboto bold)
  set heading(numbering: "1.1.")
  show heading: set text(font: sans-font)

  show heading.where(level: 1): it => block(
    above: 2.2em,
    below: 1.4em,
    text(size: 12.7pt, weight: "bold")[
      #if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.4em)
      }
      #it.body
    ],
  )

  show heading.where(level: 2): it => block(
    above: 1.8em,
    below: 1.0em,
    text(size: 11pt, weight: "bold")[
      #if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.3em)
      }
      #it.body
    ],
  )

  show heading.where(level: 3): it => block(
    above: 1.8em,
    below: 1.0em,
    text(
      font: font,
      size: 11pt,
      weight: "regular",
      style: "italic",
    )[
      #if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.3em)
      }
      #it.body
    ],
  )

  // Bibliography settings: Chicago Author-Date, 10pt font, unnumbered References heading
  set bibliography(title: "References", style: "chicago-author-date")
  show bibliography: set text(size: 10pt)

  // Quotes and tabular formatting
  show quote: set text(size: 10pt)
  set quote(block: true)
  show table: set text(size: 10pt)


  // --- Title block on first page ---
  {
    align(left)[
      #text(
        font: sans-font,
        size: 20pt,
        weight: "bold",
      )[#title]

      #v(27.5pt)

      #for author in authors [
        #block(spacing: 9pt)[
          #text(
            font: sans-font,
            size: 12.7pt,
            weight: "bold",
          )[#author.name]

          #if "orcid" in author and author.orcid != none and author.orcid != "" [
            #h(0.3em)
            #link("https://orcid.org/" + author.orcid)[
              #text(size: 9pt, fill: rgb("#a6ce39"))[(iD)]
            ]
          ]

          #v(1pt)

          #if "affiliation" in author [
            #text(
              size: 10.5pt,
              style: "italic",
              fill: jmpinkii,
            )[#author.affiliation] \
          ]

          #if "email" in author [
            #text(
              font: sans-font,
              size: 10pt,
              fill: jmpinkii,
            )[
              #link("mailto:" + author.email)[
                #text(fill: jmpblue)[#author.email]
              ]
            ]
          ]
        ]
      ]
    ]

    v(26.5pt)

    if abstract != none [
      #align(left)[
        #text(
          font: sans-font,
          size: 8.1pt,
          weight: "bold",
          tracking: 0.14em,
        )[ABSTRACT]

        #v(6.5pt)

        #block(width: 100%)[
          #set par(
            first-line-indent: 0pt,
            justify: true,
            leading: 0.65em,
          )
          #text(size: 10.8pt)[#abstract]
        ]
      ]

      #if keywords.len() > 0 [
        #v(0.6em)
        #text(size: 9.5pt)[
          #text(weight: "bold")[Keywords:]
          #keywords.join(", ")
        ]
      ]

      #if msc != none [
        #v(0.3em)
        #text(size: 9.5pt)[
          #text(weight: "bold")[MSC (2020):]
          #msc
        ]
      ]

      #v(16.5pt)
    ]
  }

  body
}

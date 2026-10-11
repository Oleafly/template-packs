#import "@preview/pergamon:0.7.2": *

#let orcid(id) = {
  link("https://orcid.org/" + id, box(image("ORCID-iD_icon_vector.svg", width: 1em)))
}

/// Text snippets for the EG license options
#let licenses = (
  cc-by: [
    © #datetime.today().year() The Author(s). Computer Graphics Forum published by Eurographics - The European Association for Computer Graphics and John Wiley & Sons Ltd.\
    This is an open access article under the terms of the Creative Commons Attribution License, which
    permits use, distribution and reproduction in any medium, provided the original work is properly cited.
  ],
  cc-by-nc: [
    © #datetime.today().year() The Author(s). Computer Graphics Forum published by Eurographics - The European Association for Computer Graphics and John Wiley & Sons Ltd.\
    This is an open access article under the terms of the Creative Commons Attribution-NonCommercial License, which
    permits use, distribution and reproduction in any medium, provided the original work is properly cited and is not used for commercial purposes.
  ],
  cc-by-nc-nd: [
    © #datetime.today().year() The Author(s). Computer Graphics Forum published by Eurographics - The European Association for Computer Graphics and John Wiley & Sons Ltd.\
    This is an open access article under the terms of the Creative Commons Attribution-NonCommercial-NoDerivs License, which
    permits use, distribution and reproduction in any medium, provided the original work is properly cited, the use is non-commercial and no modifications or adaptations are made.
  ],
)

#let eg-paper(
  authors: [
    Ömercan Yazici#super([1])#orcid("0000-0003-0306-757X"),
    Pascal Grittmann#super([1])#orcid("0000-0002-5325-3744") and
    Philipp Slusallek#super([1,2])#orcid("0000-0002-2189-2429")
  ],
  short-authors: [
    Ömercan Yazici, Pascal Grittmann & Philipp Slusallek
  ],
  affiliations: [
    #super([1])Saarland University, Saarland Informatics Campus, Saarbrücken, Germany \
    #super([2])DFKI, Saarland Informatics Campus, Saarbrücken, Germany
  ],
  submission-id: [paper1042],
  anonymous: false,
  title: [Typst Author Guidelines for EUROGRAPHICS Proceedings Manuscripts],
  short-title: [Typst Author Guidelines],
  abstract: [
    #lorem(100)

    #lorem(50)
  ],
  CCS-concepts: [
    • *Computing methodologies* $->$ Ray tracing; Rendering;
  ],
  short-venue: [EUROGRAPHICS 2026],
  venue: [
    EUROGRAPHICS 2026 / B. Masia and J. Thies\
    (Guest Editors)
  ],
  teaser-image: image("/figures/eg_new.jpg", width: 100%),
  teaser-caption: [This image shows quite clearly that our method is superior to doing nothing at all, which is a good start.],
  license: licenses.cc-by,
  document,
) = {
  let cite-style = format-citation-alphabetic(
    labelalphaothers: "*",
    maxalphanames: 4,
    minalphanames: 3,
    labelalpha: 3,
  )
  show: doc => refsection(format-citation: cite-style.format-citation, doc)
  show link: set text(fill: rgb("#0000FF"))
  show ref: set text(fill: rgb("#0000FF"))

  set page(
    paper: "a4",
    margin: (x: 17mm, top: 30mm, bottom: 42mm),

    header: context {
      if here().page() == 1 {
        // No header on the first page
      } else {
        set text(size: 8pt)
        let pageCtr = counter(page).display("1 of 1", both: true)
        let txt = emph[#short-authors / #short-title]

        if calc.even(here().page()) {
          grid(
            columns: (10em, 1fr, 10em),
            align: (left, center, right),
            pageCtr, txt, [],
          )
        } else {
          grid(
            columns: (10em, 1fr, 10em),
            align: (left, center, right),
            [], txt, pageCtr,
          )
        }
      }
    },

    footer: context {
      if anonymous {
        text(size: 6pt, [submitted to #short-venue])
      } else {
        set text(size: 6pt)
        let txt = [
          #sym.copyright #datetime.today().year() The Author(s).\
          Computer Graphics Forum published by Eurographics and John Wiley & Sons Ltd.
        ]
        if here().page() == 1 {
          txt = license
        }
        if calc.even(here().page()) {
          grid(
            columns: (85mm, 1fr, 85mm),
            align: (left, center, right),
            [], [], txt,
          )
        } else {
          grid(
            columns: (85mm, 1fr, 85mm),
            align: (left, center, right),
            txt, [], [],
          )
        }
      }
    },

    header-ascent: 5mm,
    footer-descent: 5mm,
  )

  set page(columns: 2)
  set columns(gutter: 8mm)

  set par(justify: true, first-line-indent: 1em)
  set text(
    font: "TeX Gyre Termes",
    size: 9pt,
  )
  show math.equation: set text(font: "TeX Gyre Termes Math")

  set heading(numbering: "1.1.")
  show heading: it => context {
    set text(size: 9pt, weight: "bold")
    [ #v(2.4em, weak: true) #it #v(0.6em)]
  }
  show heading.where(level: 3): it => text(
    size: 9pt,
    weight: "bold",
    it.body + [.],
  )

  show figure.caption: it => context [
    #v(6pt)
    #let txt = [ *#it.supplement~#it.counter.display()#it.separator* #emph(it.body) ]
    #layout(size => {
      // Center-align if there is just a single line
      // We detect that by comparing the layouted height to single line height of the caption text
      let actual-height = measure(txt, width: size.width).height
      let single-line-height = measure(txt).height
      let single = actual-height < 1.1 * single-line-height
      set align(if single { center } else { left })
      txt
    })
    #v(12pt)
  ]
  set figure(placement: auto)

  set math.equation(numbering: "(1)")

  // Numbered lines in light gray
  set par.line(numbering-scope: "document", numbering: (..nums) => {
    if not anonymous [] else {
      text(
        size: 0.7em,
        fill: black.lighten(50%),
      )[#nums.at(
        0,
      )]
    }
  })

  // Title page: comprises a special header, title, author list, teaser, and abstract
  place(
    top + center,
    float: true,
    scope: "parent",
    clearance: 2em,
  )[
    #set text(size: 8pt)
    #grid(
      align: (left, right),
      columns: (1fr, 1fr),
      venue,
      [
        #text(font: "TeX Gyre Heros", size: 9pt)[COMPUTER GRAPHICS] _forum_ \
        _Volume 45 (2026), Number 2_
      ],
    )
    #set text(size: 9pt)
    #v(12mm)
    #align(center, block(width: 90%, text(17pt)[*#title*]))
    \
    #v(6mm)
    #align(center, text(9pt)[
      #if anonymous {
        submission-id
      } else {
        authors + [ \ \ ]
        affiliations
      }
    ])
    \
    #if teaser-image != none [
      #figure(placement: none, teaser-image, caption: teaser-caption)<fig-teaser>
    ]

    #line(length: 100%, stroke: 0.5pt)
    #block(width: 90%)[
      #set align(left)
      #set par(justify: true, first-line-indent: 0em, spacing: 0.5em)
      *Abstract* \
      #emph(abstract)
      #v(4pt)
      *CCS Concepts*

      #emph[
        #CCS-concepts
      ]
    ]
    #line(length: 100%, stroke: 0.5pt)
  ]

  document

  print-bibliography(
    title: [References],
    format-reference: (index, reference) => {
      let original = format-reference(
        name-format: "{family}, {g}.",
        maxnames: 4,
        minnames: 3,
        reference-label: cite-style.reference-label,
        format-fields: (
          "author": (dffmt, value, reference, field, options, style) => {
            let formatted-names = value.map(d => {
              let name = format-name(d, format: "{family}, {g}.")
              smallcaps(name)
            })
            concatenate-names(formatted-names, maxnames: 999)
          },
        ),
        bibstring: ("in": ""),
        print-doi: true,
        link-titles: false,
      )(index, reference)

      // Put label and text into a single grid cell
      let label = original.at(0).children.at(1)
      let txt = original.at(1).children.at(1)
      return (
        [
          #set par(hanging-indent: 1em)
          [#label] #h(0.25em) #txt
        ],
      )
    },
    label-generator: cite-style.label-generator,
  )
}

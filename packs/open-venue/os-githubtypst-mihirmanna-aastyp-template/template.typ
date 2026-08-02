#let aas_blue = rgb(0x2e, 0x30, 0x8d)

#let template(
  // Positional arguments (required)
  title,
  authors,
  abstract,
  keywords,
  doc,
  // Keyword arguments (optional)
  line_numbers: false,
  two_column: false,
  collab: none,
  short_title: none,
  watermark: none,
) = [

  // Page format
  #set page(
    paper: "us-letter",
    margin: (x: 0.75in, y: 1in),
  )
  // Toggleable two-column format (on by default)
  #set page(columns: 2) if two_column

  // Watermark (none by default)
  #set page(
    background: rotate(
      -60deg,
      par(
        justify: false,
        leading: 2em,
        text(100pt, fill: luma(200))[#watermark],
      ),
    ),
  )

  // Author string
  #let author_string = if authors.len() > 3 {
    str(authors.first().last) + " et al."
  } else {
    authors.map(x => x.last).join(", ", last: ", and ")
  }

  // Alternate page header, starting at page 2
  #set page(
    header: context {
      let page_number = counter(page).get().first()
      if page_number > 1 {
        grid(columns: (2em, 1fr, 2em), align: (left, center, right))[
          #if calc.rem-euclid(page_number, 2) == 0 { page_number }
        ][
          #if calc.rem-euclid(page_number, 2) == 0 { smallcaps(author_string) } else { smallcaps(short_title) }

        ][
          #if calc.rem-euclid(page_number, 2) != 0 { page_number }
        ]
      }
    },
  )

  // Text format
  #let text_size = 11pt
  #set text(size: text_size)

  // Line numbering (toggleable)
  #set par.line(numbering: n => text(raw(str(n)), size: 0.67 * text_size)) if line_numbers

  // Paragraph format
  #set par(
    first-line-indent: (amount: 1em, all: true),
    leading: 0.5em,
    spacing: 0.5em,
    justify: true,
  )

  // Heading format
  #set heading(numbering: "1.")
  #show heading: it => {
    if it.level == 1 {
      align(center)[#text(upper(it), weight: "regular", size: text_size, hyphenate: false)]
    } else {
      align(center)[#text(it, weight: "regular", size: text_size, style: "italic", hyphenate: false)]
    }

    v(0.5em)
  }

  // Figure format
  #show figure.where(placement: none): it => { v(1em) + it + v(1em) }
  #set figure.caption(separator: ".")
  #show figure.caption: it => align(left)[
    #text(size: text_size - 1pt)[#it]
  ]
  #set figure(supplement: [*Figure*])
  #set figure(numbering: n => text(str(n), weight: "bold"))
  #show figure.where(kind: table): set figure.caption(position: top)
  #show figure.where(kind: table): set figure(supplement: [*Table*])

  // Hyperlink format
  #show link: it => text(it, fill: aas_blue)

  // Footnote format
  #set footnote.entry(separator: none, indent: 0em)

  // Numbered list format
  #show enum: it => [ #v(0.5em) #it #v(0.5em) ]
  #set enum(spacing: 1em)

  // Equation format
  #set math.equation(numbering: "(1)")
  #show math.equation.where(block: true): it => [ #v(1em) #it #v(1em) ]

  // Code block format
  #show raw.where(block: true): it => [ #v(1em) #it #v(1em) ]

  // Citation and bibliography style
  // TODO: Implement AAS style
  #set cite(style: "apa")
  #set bibliography(style: "apa")

  #place(
    top + left,
    scope: "parent",
    float: true,
    dy: -2em,
  )[
    /*
     * Annotations
     */
    #align(
      left,
      par(first-line-indent: 0em)[
        #set text(size: text_size - 1pt)
        #smallcaps[Draft version #datetime.today().display("[month repr:short] [day], [year]")] \
        Typeset using Typst #{ if two_column [*twocolumn*] else [*default*] } style in AASTyp
      ],
    )

    #v(1em)
  ]

  // Paper header (title, authors, abstract, keywords)
  // Typst does not currently support footnotes or line numbering in floating environments.
  #place(
    top + center,
    scope: "parent",
    float: true,
  )[
    /*
     * Title
     */

    #text(weight: "bold", size: text_size + 1pt, title)

    #v(0.5em)

    /*
     * Authors, collaborations, and affiliations
     */

    // FIXME: Handle `none` affiliations
    // TODO: Display alternate affiliations

    #let numbered_affiliations = authors.map(x => x.affiliation).flatten().dedup().enumerate().map(array.rev).to-dict()
    #(
      authors
        .map(x => {
          if x.at("orcid", default: none) != none {
            link("https://orcid.org/" + x.orcid)[#smallcaps()[#x.first #x.last #box(
                  image("assets/orcid-ID.png", width: 1em),
                )#h(0.125em)]]
          } else {
            smallcaps[#x.first #x.last]
          }

          let aff_nums = () // Affiliation numbers for each author
          for aff in x.affiliation.flatten() {
            if numbered_affiliations.keys().contains(aff) { aff_nums.push(numbered_affiliations.at(aff)) }
          }
          super[#aff_nums.map(x => str(x + 1)).join(",")]
        })
        .map(x => box(x)) // Boxing prevents ORCID and author name from being split across lines
        .join(", ", last: smallcaps[, and ])
    )

    #if collab != none { v(0.5em) + smallcaps[The #collab collaboration] }

    #v(1em)

    #text(
      size: text_size - 1pt,
      {
        for key in numbered_affiliations.keys() {
          super[#(numbered_affiliations.at(key) + 1)] + emph(key) + v(0.25em)
        }
      },
    )

    #v(0.5em)

    // Update footnote counter for manuscript body to avoid conflicts with affiliation footnotes
    #context (counter(footnote)).update(numbered_affiliations.keys().len())

    /*
     * Abstract and keywords
     */

    #heading(level: 1, numbering: none)[Abstract]
    #box(width: 90%)[
      #par(justify: true)[#abstract]

      #v(2em)

      // Keywords
      #grid(
        columns: 2,
        align: top + left,
        column-gutter: 0.5em
      )[_Keywords:_][
        #(
          keywords
            .split(", ")
            .map(x => link("https://astrothesaurus.org/uat/" + x.split("(").at(1).split(")").at(0))[#x])
            .join([ --- ])
        )
      ]
    ]
  ]

  // First author email
  #footnote(numbering: _ => [])[Email: #authors.first().email]
  #counter(footnote).update(n => n - 1)
  #v(-1.75em) // Fixes extra line introduced by footnote

  #doc
]

#let appendix(doc) = {
  set page(columns: 1)

  // Heading format
  counter(heading).update(0)
  counter(math.equation).update(0)
  set heading(numbering: "A.")

  // Reset equation count for each appendix section
  show heading.where(level: 1): it => {
    it
    counter(math.equation).update(0)
  }

  // Prepend appendix section letter to equation numbers
  set math.equation(numbering: num => [(#counter(heading).get().map(x => numbering("A", x)).at(0)#num)])

  doc
}

#let doi(identifier) = link("https://doi.org/" + identifier)

#let facilities(facs) = [_Facilities:_ #facs.join(", ")]

#let software(sw) = [_Software:_ #sw.join(", ")]

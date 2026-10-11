// ##########################################################
//   _         _____                    _       _
//  | |    __ |_   _|__ _ __ ___  _ __ | | __ _| |_ ___
//  | |   / _` || |/ _ \ '_ ` _ \| '_ \| |/ _` | __/ _ \
//  | |__| (_| || |  __/ | | | | | |_) | | (_| | ||  __/
//  |_____\__,_||_|\___|_| |_| |_| .__/|_|\__,_|\__\___|
//                               |_|
// ##########################################################
#import "lalib.typ": insert_toc

/*
  Global setup and definitions
*/
#let latemplate(
  title: none,
  title_size: 23pt,
  show_header: true,
  header_content: (
    left: [Document Header _project_],
    right: none,
  ),
  authors: (), //Extended, list of (name:"", (email):"", (affiliations):("",), (contribution_symbol):"")
  authors_flat: (), // Flat, list of (name="", (contribution_symbol):"")
  abstract: [],
  column_count: 2,
  paper_format: "a4",
  margins: (top: 1cm, bottom: 2cm, left: 1.5cm, right: 1.5cm),
  page_numbering: "1/1", // none or e.g. "1/1"
  heading_numbering: "I.1.a",
  heading_colors: (
    color.rgb("1f4e79"),
    color.rgb("2f5f97"),
    color.rgb("4472c4"),
    color.rgb("5b9bd5"),
    color.rgb("8faadc"),
    color.rgb("bdd7ee"),
  ),
  figure_reference_color: color.darken(color.rgb(235, 130, 125), 15%),
  doc,
) = {
  // Function to create header content
  let create_header() = [
    #set text(size: 9pt)
    #grid(
      columns: (1fr, 1fr),
      align: (left + horizon, right + horizon),
      [
        // Left side
        #if (
          "left" in header_content and header_content.left != none and header_content.left != ""
        ) [#header_content.left]
      ],
      [
        // Right side: custom content and page numbering
        #if "right" in header_content and header_content.right != none and header_content.right != "" [
          #box(baseline: 50%, header_content.right)
          #if page_numbering != none [
            #h(0.5em)
          ]
        ]
        #if page_numbering != none [
          #box(baseline: 50%)[
            #context [
              Page #numbering(page_numbering, counter(page).get().first(), counter(page).final().first())
            ]
          ]
        ]
      ],
    )
    #line(length: 100%, stroke: (thickness: 0.5pt, paint: color.rgb("111111"), dash: "dotted"))
    #v(0.5cm)
  ]

  // Dynamic header setup using the pattern you provided
  context {
    let header_block = if show_header {
      pad(y: 0.5cm, create_header())
    } else {
      []
    }

    let header_height = if show_header {
      let left_margin = if "left" in margins { margins.left } else { 1.5cm }
      let right_margin = if "right" in margins { margins.right } else { 1.5cm }
      measure(width: page.width - left_margin - right_margin, header_block).height
    } else {
      0pt
    }

    set page(
      paper: paper_format,
      margin: (
        top: header_height + (if "top" in margins { margins.top } else { 2cm }),
        left: if "left" in margins { margins.left } else { 1.5cm },
        right: if "right" in margins { margins.right } else { 1.5cm },
        bottom: if "bottom" in margins { margins.bottom } else { 2cm },
      ),
      header: header_block,
      header-ascent: 0pt,
      numbering: if page_numbering != none and not show_header { page_numbering } else { none },
      columns: column_count,
    )

    let doc_content = [
      // Create title/author block if there's content to display
      #if title != none or authors.len() > 0 or abstract != [] {
        let author_columns = calc.min(authors.len(), 3)

        place(
          top + center,
          float: true,
          scope: "parent",
          clearance: 2em,
        )[
          #if title != none [
            #align(center, text(title_size)[
              *#title*
            ])
          ]
          #if (title != none and (authors.len() > 0 or authors_flat.len() > 0)) [
            #v(-1em)
          ]

          #if authors.len() > 0 [
            #grid(
              columns: (1fr,) * author_columns,
              row-gutter: 24pt,
              ..authors.map(author => [
                #author.name
                #if ("contribution_symbol" in author) and (author.contribution_symbol != none) [#super(
                  author.contribution_symbol,
                )] \
                #if ("affiliations" in author) and (author.affiliations != none) [
                  #author.affiliations.join(linebreak())
                  \
                ]
                #if ("email" in author) and (author.email != none) [
                  #link("mailto:" + author.email)
                ]
              ]),
            )
          ]
          #if authors_flat.len() > 0 [
            #text(size: 13pt, fill: color.rgb("444444"))[
              #(
                authors_flat
                  .map(it => (
                    it.name
                      + (
                        if ("contribution_symbol" in it) and (it.contribution_symbol != none) {
                          super(it.contribution_symbol)
                        } else { "" }
                      )
                  ))
                  .join(", ")
              )
            ]
          ]

          #if abstract != [] [
            #align(center, text(13pt)[
              *Abstract*
            ])
            #par(justify: true)[
              #abstract
            ]
          ]
        ]
      }
      #doc
    ]

    // Set up colored headings if enabled

    set heading(numbering: heading_numbering)

    // Match a reference's color to the type of its target.
    // References to bibliography entries and all other elements keep their
    // normal text color.
    show ref: it => {
      let target = it.element
      if target != none and target.func() == figure and target.kind == "appendix" {
        text(fill: heading_colors.first())[#it]
      } else if target != none and target.func() == figure {
        text(fill: figure_reference_color)[#it]
      } else if target != none and target.func() == heading {
        let level = target.level
        let heading_color = if level <= heading_colors.len() {
          heading_colors.at(level - 1)
        } else {
          black
        }
        text(fill: heading_color)[#it]
      } else {
        it
      }
    }

    show heading: it => {
      let heading_color = if it.level <= heading_colors.len() {
        heading_colors.at(it.level - 1)
      } else {
        black
      }

      set text(
        font: "Georgia", // Square serif font
        size: 14pt,
        weight: "bold",
        fill: heading_color,
      )
      set par(justify: true, hanging-indent: 0pt, first-line-indent: 0pt)
      set text(hyphenate: false)

      v(0.2em)
      [
        #if it.numbering != none [
          #numbering(it.numbering, ..counter(heading).at(it.location()))
          #h(0.5em)
        ]
        #smallcaps(it.body)
      ]
      v(0em)
    }
    doc_content
  }


  set align(left)
  set par(justify: true)
}

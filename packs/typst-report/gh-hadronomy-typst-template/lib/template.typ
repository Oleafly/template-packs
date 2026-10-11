#import "@preview/chic-hdr:0.5.0": *
#import "@preview/scienceicons:0.1.0": orcid-icon

#let conf(
  title: none,
  affiliations: (),
  authors: (),
  authornote: none,
  show-email-section: false,
  date: none,
  accent: none,
  abstract: lorem(100),
  spacing: 0.55em,
  first-line-indent: 1.8em,
  doc,
) = {
  // ---------------------------------------------------------------------------
  // Global layout & typography
  // ---------------------------------------------------------------------------

  set document(
    title: title,
    description: abstract,
    author: if authors != none { authors.map(a => str(a.name)) } else { () },
  )

  set page(
    margin: 1in,
    paper: "a4",
  )

  let accent_color = {
    if type(accent) == str {
      rgb(accent)
    } else if type(accent) == color {
      accent
    } else {
      rgb("#DC143C")
    }
  }

  set par(
    leading: 0.55em,
    first-line-indent: first-line-indent,
    justify: true,
    spacing: spacing,
  )

  set text(
    font: "Libertinus Serif",
    size: 10pt,
  )

  show raw: set text(font: "Maple Mono NF")
  show heading: set block(above: 2em, below: 1.4em)

  // ---------------------------------------------------------------------------
  // Header / footer via chic-hdr
  // ---------------------------------------------------------------------------

  show: chic.with(
    skip: 1,
    chic-header(
      center-side: [
        #text(size: 8pt)[#upper(title)]
      ],
    ),
    chic-separator(1pt),
    chic-height(10em),
  )

  // ---------------------------------------------------------------------------
  // Authors, affiliations, abstract metadata
  // ---------------------------------------------------------------------------

  let emails = authors.map(a => link("mailto:" + a.email)[#a.email])
  let emails-string = emails.join(", ")

  show footnote: it => text(blue, it)

  set cite(style: "chicago-author-date")
  set bibliography(style: "ieee", title: "References")

  set table(
    stroke: (_, y) => if y > 0 { (top: 0.8pt) } else { none },
  )
  show table.cell.where(y: 0): set text(weight: "bold")

  show figure.caption: it => [
    *#it.supplement #it.counter.display(it.numbering)*: #it.body
  ]

  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    set align(center)
    v(12.5pt, weak: true)
    if it.has("caption") {
      it.caption
      v(0.25em)
    }
    it.body
    v(1em)
  }

  show figure.where(kind: image): it => {
    set align(center)
    show: pad.with(x: 13pt)
    v(12.5pt, weak: true)
    it.body
    if it.has("caption") {
      it.caption
    }
    v(1em)
  }

  show list: it => {
    // Space between list items
    set par(leading: 0.48em)
    // Space around whole list
    set block(
      spacing: spacing * 1.2,
      inset: (left: first-line-indent, right: first-line-indent),
    )
    it
  }

  // ---------------------------------------------------------------------------
  // Headings
  // ---------------------------------------------------------------------------

  set heading(numbering: "1. ")

  show heading.where(level: 1): it => {
    set align(left)
    set text(size: 10pt, weight: "semibold")
    upper(it)
  }

  show heading.where(level: 2): it => {
    set align(left)
    set text(size: 10pt, weight: "semibold")
    upper(it)
  }

  show heading.where(level: 3): it => {
    set align(left)
    set text(size: 10pt, weight: "semibold")
    upper(it)
  }

  // ---------------------------------------------------------------------------
  // Page numbering (odd/even in footer)
  // ---------------------------------------------------------------------------

  set text(size: 8pt)

  set page(
    footer: context {
      let page-counter = counter(page)
      let number = page-counter.get()
      if calc.odd(number.first()) {
        align(right, page-counter.display())
      } else {
        align(left, page-counter.display())
      }
    },
  )

  // ---------------------------------------------------------------------------
  // Title block & first-page layout
  // ---------------------------------------------------------------------------

  let footnote_non_numbered(body) = {
    footnote(numbering: _ => [], body)
    counter(footnote).update(n => if n > 0 { n - 1 } else { 0 })
  }

  // Collect author metadata once
  let corresponding_authors = if authors != none {
    authors.filter(a => (
      // If key not present → treat as true
      not a.keys().contains("corresponding") or a.at("corresponding") == true
    ))
  } else { () }

  let equal_authors = if authors != none {
    authors.filter(a => (
      a.keys().contains("equal-contributor") and a.at("equal-contributor") == true
    ))
  } else { () }

  let first_corresponding_idx = if corresponding_authors.len() > 0 {
    authors.position(a => corresponding_authors.contains(a))
  } else { none }

  let first_equal_idx = if equal_authors.len() > 1 {
    authors.position(a => equal_authors.contains(a))
  } else { none }

  // Helper: render affiliation ids as superscripts (e.g., [1,2] -> ¹,²)
  let affiliation_superscript(ids) = {
    if ids == none {
      ""
    } else if type(ids) == "array" {
      super(ids.join(", "))
    } else {
      super(ids)
    }
  }

  // Author display using affiliations.id and authors.affiliation: [id]
  let author_display = if authors != none {
    let result = authors
      .enumerate()
      .map(((idx, a)) => {
        let parts = ()

        // Name wrapped in an unstyled mailto link
        if a.keys().contains("email") {
          parts.push(
            link("mailto:" + a.email)[#a.name],
          )
        } else {
          parts.push(a.name)
        }

        // Superscript affiliation ids if present
        if a.keys().contains("affiliation") {
          parts.push(affiliation_superscript(a.affiliation))
        }

        // Corresponding author mark / footnote
        if corresponding_authors.contains(a) and idx == first_corresponding_idx {
          parts.push(footnote(numbering: _ => "*")[
            Autor(a/es) de correspondencia:
            #h(4pt)
            #(
              corresponding_authors.map(b => [#b.name "#b.email"]).join(", ", last: " y ")
            )
            .
          ])
        } else if corresponding_authors.contains(a) {
          parts.push(super("*"))
        }

        // Equal-contributor mark / footnote
        if equal_authors.len() > 1 and equal_authors.contains(a) and idx == first_equal_idx {
          parts.push(footnote(numbering: _ => "†")[
            #equal_authors.map(b => b.name).join(", ", last: " y ")
            contribuyeron de manera equivalente a este trabajo.
          ])
        } else if equal_authors.len() > 1 and equal_authors.contains(a) {
          parts.push(super("†"))
        }

        // Optional ORCID
        if a.keys().contains("orcid") {
          parts.push(
            link(a.orcid, orcid-icon(color: rgb("a6ce39"), height: 0.8em)),
          )
        }

        parts.join()
      })
      .join(", ", last: " y ")

    if authornote != none {
      result + footnote_non_numbered(authornote)
    } else {
      result
    }
  } else { none }

  if author_display != none {
    hide(author_display)
    counter(footnote).update(n => if n > 0 { n - 1 } else { 0 })
    v(-2.4em)
  }

  set align(center)

  place(center + top, scope: "parent", float: true, {
    pad(top: 15em, bottom: 2em)[
      #align(center)[
        #block(width: 65%, stroke: none)[
          #par(justify: false)[
            #text(size: 12pt, weight: "bold")[#upper(title)]
          ]

          #v(1em)
          #par(justify: false)[
            #set text(size: 10pt, weight: "semibold")
            #text(size: 10pt, weight: "semibold")[
              #author_display
            ]
            #super(size: 0.8em)[1]
          ]

          #for affiliation in affiliations {
            v(1em)
            text(size: 9pt)[
              #super(size: 0.8em)[#affiliation.id]
              #text(size: 8pt, style: "italic")[
                #affiliation.full
              ]
            ]
          }

          #if show-email-section == true {
            v(1em)
            text(size: 9pt)[
              E-mail:
              #show link: it => text(fill: black, it)
              #text(size: 8pt, style: "italic", fill: black)[#emails-string]
            ]
          }

          #v(1em)

          #{
            if date != none {
              align(center, table(
                columns: (auto, auto),
                stroke: none,
                gutter: 0pt,
                align: (right, left),
                [#text(size: 11pt, "Entregado:")],
                [#text(
                    size: 11pt,
                    fill: accent_color,
                    weight: "semibold",
                    date.display("[month repr:long] [day padding:zero], [year repr:full]"),
                  )
                ],

                text(size: 11pt, "Última Actualización:"),
                text(
                  size: 11pt,
                  fill: accent_color,
                  weight: "semibold",
                  datetime.today().display("[month repr:long] [day padding:zero], [year repr:full]"),
                ),
              ))
            } else {
              align(
                center,
                text(size: 11pt)[Última Actualización:#h(5pt)]
                  + text(
                    size: 11pt,
                    weight: "semibold",
                    fill: accent_color,
                    datetime
                      .today()
                      .display(
                        "[month repr:long] [day padding:zero], [year repr:full]",
                      ),
                  ),
              )
            }
          }
        ]
      ]

      #v(2em)

      #[
        #show heading.where(level: 1): it => block(below: 0pt) + box(strong(it.body))

        #block()[
          #heading()[
            Resumen
          ]
          #text(size: 10pt)[
            #abstract
          ]
        ]
      ]

      #counter(heading).update(0)
    ]
  })

  v(2em)

  // ---------------------------------------------------------------------------
  // Main document content
  // ---------------------------------------------------------------------------

  set text(size: 10pt)
  set align(left)

  [
    #show link: it => text(fill: blue)[#it.body]
    #doc
  ]
}

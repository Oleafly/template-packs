#let project-plan(
  author: (),
  course: "Opintojakso",
  cover: "",
  date: none,
  degree: "Tutkinto",
  keywords: (),
  monospace: "Monospace",
  title: none,
  doc,
) = {
  set document(
    author: author,
    date: date,
    keywords: keywords,
    title: title,
  )

  set heading(
    numbering: "1.1" + sym.space.quad + sym.space.third,
  )

  set list(
    body-indent: 2em,
    spacing: 2.25em,
  )

  set outline(
    depth: 2,
    indent: auto,
  )

  set page(
    header-ascent: 1.75em,
    margin: (
      bottom: 2.5cm,
      left: 4.3cm,
      right: 1.5cm,
      top: 2cm + 0.5cm,
    ),
    number-align: top + right,
    numbering: (..nums) => calc.max(0, nums.pos().first() - 2),
  )

  set par(
    justify: true,
    leading: 1.2em,
    spacing: 2.25em,
  )

  set raw(
    tab-size: 8,
    theme: "comments.tmTheme",
  )

  set text(
    font: ("Calibri", "Carlito"),
    hyphenate: false,
    lang: "fi",
    size: 11pt,
  )

  show heading.where(outlined: false): it => {
    set block(
      spacing: 2.25em,
    )

    set text(
      size: 11pt,
      weight: "regular",
    )

    it
  }

  show heading.where(outlined: true): it => {
    set block(
      spacing: calc.max(2.25em, (5.25 - it.level) * 1em),
    )

    set text(
      size: 11pt,
      weight: "regular",
    )

    it
  }

  show link: it => {
    set text(
      fill: blue,
    )

    underline(it)
  }

  show raw.where(block: false): it => {
    set text(
      features: (calt: 0),
      font: monospace,
    )

    box(
      fill: rgb("#eaeaea"),
      inset: (x: 0.5em),
      outset: (y: 0.5em),
      radius: 2pt,
      it,
    )
  }

  show raw.where(block: true): it => {
    // line spacing
    let s = 0.8em

    // line column width
    let w = str(it.lines.len()).len() * 1em

    set par(
      justify: false,
      leading: s,
    )

    set text(
      features: (calt: 0),
      font: monospace,
    )

    block(
      fill: rgb("#eaeaea"),
      inset: (
        left: -w - 1em,
        rest: 1em,
      ),
      outset: (
        left: w + 1em,
      ),
      radius: 2pt,
      grid(
        align: (right, start),
        column-gutter: 1em,
        columns: (w, 1fr),
        row-gutter: s,
        ..it.lines.enumerate().map(((i, line)) => (
          text(
            fill: gray,
            str(i + 1),
          ),
          line,
        )).flatten()
      )
    )
  }

  show outline.entry.where(level: 1): it => {
    parbreak()

    it
  }

  page(
    margin: 0cm,
    numbering: none,
    grid(
      columns: (1fr, 6.1cm),
      {
        v(1fr)

        pad(
          left: 2cm,
          {
            text(
              fill: rgb("009aa6"),
              weight: "bold",
              if type(author) == "string" {
                author
              } else if (author.len() == 0) {
                "Tekijä / Tekijät"
              } else {
                author.join(
                  ", ",
                  last: " & ",
                )
              },
            )

            v(-2.5em)

            text(
              fill: rgb("009aa6"),
              size: 18pt,
              weight: "bold",
              if type(title) == "none" {
                "Projektisuunnitelman nimi"
              } else {
                title
              },
            )
          },
        )

        v(5.25cm)

        if cover == "" {
          v(13.25cm)
        } else {
          image(
            cover,
            height: 13.25cm,
            width: 100%,
          )
        }
      },
      rect(
        fill: rgb("009ab2"),
        height: 100%,
        inset: 0pt,
        width: 100%,
        {
          v(1fr)

          block(
            height: 13.25cm,
            inset: (
              bottom: 0.75cm,
              x: 0.75cm,
            ),
            width: 100%,
            {
              v(1fr)

              pad(
                right: 0.75cm,
                align(
                  right,
                  text(
                    fill: white,
                    size: 10pt,
                    {
                      par(
                        justify: false,
                        leading: 0.70em,
                        course
                      )

                      v(-1em)

                      par(
                        justify: false,
                        leading: 0.70em,
                        degree
                      )

                      v(-1em)

                      par(
                        justify: false,
                        leading: 0.70em,
                        if type(date) == "none" {
                          "Päivämäärä"
                        } else if type(date) == "auto" {
                          datetime.today().display("[day padding:none].[month padding:none].[year padding:none]")
                        } else {
                          date.display("[day padding:none].[month padding:none].[year padding:none]")
                        }
                      )
                    },
                  )
                )
              )

              // golden ratio
              v((1 + calc.sqrt(5)) / 2 * 1fr)

              image(
                "kamk-logo.png",
                fit: "contain",
              )
            }
          )
        }
      )
    )
  )

  page(
    numbering: none,
    {
      v(2.25em)

      outline()
    }
  )

  doc
}

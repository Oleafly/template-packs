#let d = state("enableDates", false)
#let b = state("blankPages", true)

#let section(name: "", body) = {
  if name != "" {
    text(size: 9pt, weight: "bold")[
      #name
    ]
    linebreak()
    body
    // linebreak()
  } else {
    body
  }
}

#let recipe(
  title: none,
  details: "",
  ingredients: [],
  method: [],
  body,
) = (
  {
    set page(
      width: 148mm,
      height: 105mm,
      margin: (x: 3mm, y: 6mm, top: 4mm),
      footer: context [
        #if d.get() {
          let currPos = counter(page).get().at(0)
          if calc.odd(currPos) {
            place(
              left,
              dy: -4pt,
              dx: 5pt,
              text(size: 8pt, fill: rgb("000000"))[
                #datetime.today().display("[day]-[month]-[year]")
              ],
            )
          }
        }
      ],
    )
    set text(size: 5.5pt)
    align(center)[
      #stack(
        spacing: 5pt,
        text(size: 24pt, weight: "bold")[#title],
        text(size: 12pt, fill: luma(100))[#details],
        line(length: 100%),
      )
    ]
    grid(
      columns: (1fr, 2fr),
      block(
        inset: (x: 6pt),
        // stroke: 0.5pt,
      )[
        // Left Column: Ingredients
        #stack(
          spacing: 8pt,
          text(size: 14pt, weight: "bold")[Ingredients:],
          text(size: 8pt)[
            #ingredients
          ],
        )
      ],
      grid.vline(),
      block(
        inset: (x: 6pt),
        // stroke: 0.5pt,
      )[
        #stack(
          spacing: 8pt,
          text(size: 14pt, weight: "bold")[Method:],
          text(size: 8pt)[
            #method
          ],
        )
      ],
    )

    context {
      if b.get() {
        pagebreak(to: "odd", weak: true)
      }
    }
  }
)

#let recipes(date: false, blankPages: true, body) = {
  b.update(blankPages)
  d.update(date)
  body
}

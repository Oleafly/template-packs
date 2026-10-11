#let cell-size = 2.6cm
#let rows = csv("prompts.csv")
#let pool = rows.map(r => r.first())
#let n = pool.len()
#let n-cards = 6
#let title = "Icebreaker Bingo"
#let subtitle = "Get a full row—vertical, horizontal, or diagonal—and yell “BINGO!”
You can use each person’s name only once, so choose carefully!"
#let instructions = "Find someone who:"

#set page(
  paper: "a5",
  margin: (x: 0.7cm, y: 1.8cm)
  )

#set text(font: "Source Sans 3")

#let prompt-cell(txt) = block(
  width: cell-size, height: cell-size, inset: 8pt,
  fill: gray.lighten(80%),
  [
    #place(top + left)[
      #text(size: 8.8pt)[#txt]
    ]
    #place(bottom + center)[
      #line(length: 100%, stroke: (dash: (2pt, 2pt), thickness: 0.8pt, paint: gray.darken(50%)))
    ]
  ]
)

#let free-cell = block(
  width: cell-size, 
  height: cell-size, 
  inset: 7pt,
  image("logomark.png", width: 100%)
)

#let bingo-card(prompts) = {
  let cells = prompts.map(p => prompt-cell(p))
  cells.insert(12, free-cell)
  grid(columns: 5, rows: 5, column-gutter: 3pt, row-gutter: 3pt, ..cells)
}


#import "@preview/suiji:0.5.1": gen-rng-f, shuffle-f
#let base-seed = 2026   // change to regenerate

// Build one card from its own seed value.
#let make-card(seed) = {
  let rng = gen-rng-f(seed)    // fresh RNG per card
  let (_, shuffled) = shuffle-f(rng, pool)
  let picked = shuffled.slice(0, 24) // 24 distinct prompts
  

  align(left)[
    #stack(dir: ltr, spacing: 2pt,)[
      #stack(dir: ttb)[
        #box(image("logotype.png", width: 2cm)) 
        #text(size: 22pt, font: "Space Grotesk", weight: "bold")[#title]
        #v(2pt)
        #text(size: 12pt)[#subtitle]
        #v(18pt)
        #text(size: 10pt)[#instructions]
      ]
    ]
    #bingo-card(picked)
  ]
}

#for k in range(n-cards) {
  make-card(base-seed + k)          // different seed per card
  v(1.2cm)
  if k != n-cards - 1 { pagebreak() }
}
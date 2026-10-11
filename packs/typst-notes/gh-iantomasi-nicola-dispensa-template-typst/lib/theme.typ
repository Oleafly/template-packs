#let darkmode = sys.inputs.at("dark", default: "false") == "true"

// --- Font ---
#let f-sans = "IBM Plex Sans"
#let f-sans-bold = "IBM Plex Sans SmBld"
#let f-mono = "IBM Plex Mono"
#let f-serif = "Source Serif 4"

// --- Palette ---
#let tone(light, dark) = if darkmode { dark } else { light }

#let bg-color = tone(rgb("#ffffff"), rgb("#1a1a1a"))
#let c-ink = tone(rgb("#111111"), rgb("#e6e6e6"))
#let c-gray = tone(rgb("#767676"), rgb("#9a9a9a"))
#let c-body = tone(rgb("#3a3a3a"), rgb("#c9c9c9"))
#let c-line = tone(rgb("#d4d4d4"), rgb("#3a3a3a"))
#let c-line-l = tone(rgb("#e2e2e2"), rgb("#262626"))

// --- Blocchi di codice ---
#let raw-num-color = c-gray
#let raw-tag-bg = tone(
  rgb("#111111").transparentize(94%),
  rgb("#e6e6e6").transparentize(88%),
)
#let raw-tag-fg = c-ink
#let raw-bg-even = c-line-l
#let raw-bg-odd = bg-color

// --- Tabelle ---
#let table-stroke = c-ink
#let bg-table-even = c-line-l

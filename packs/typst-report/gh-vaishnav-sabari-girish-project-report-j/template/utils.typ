// ============================================================
//  utils.typ — Reusable helper functions
// ============================================================

/// Renders a term inline and registers it in the Nomenclature list.
/// Usage: #term("BLE", "Bluetooth Low Energy")
#let term(symbol, meaning) = [
  #metadata((symbol, meaning)) <nomenclature>
  #symbol
]

/// Full-page chapter divider with centred heading.
/// Usage: #chapter-page("Chapter 1")
#let chapter-page(title) = [
  #pagebreak()
  #align(center)[
    #v(1fr)
    #heading(level: 1, numbering: none)[#title]
    #v(1fr)
  ]
]

/// Embed pages from a PDF file.
/// landscape: set true for landscape pages (e.g. Form 1)
/// Usage: #include-pdf("appendices/form.pdf", 3)
#let include-pdf(path, pages, landscape: false) = {
  for p in range(1, pages + 1) {
    if landscape {
      page(flipped: true)[
        #image(path, page: p, width: 100%, height: 100%)
      ]
    } else {
      image(path, page: p, width: 100%, height: 100%)
    }
  }
}

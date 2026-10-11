// Index: rows with a topic and a page number. SKELETON – the look still needs work.
#import "/lib/notebook.typ": *

#let index-page(title: L.index.title, row-height: 6mm, number-width: 9mm) = {
  page-title(title)
  block(height: 1fr, width: 100%, layout(size => {
    let n = calc.floor(size.height / row-height)
    let stroke = cfg.ink.line-width + cfg.ink.line
    grid(
      columns: (1fr, number-width),
      rows: (row-height,) * n,
      stroke: (x, y) => (bottom: stroke, left: if x == 1 { stroke }),
    )
  }))
}

// --- preview ---
#show: insert.with(title: "Preview: index")
#index-page()

// Entry point for inserts and templates:
//   #import "/lib/notebook.typ": *
//   #show: insert.with(title: "…")

#import "config.typ": cfg
#import "grids.typ": fill-grid
#import "numbering.typ": no-number, page-number
#import "graphics.typ": asset, ornament, page-background
#import "calendar.typ" as cal
#import "i18n.typ": L

#let insert(title: L.insert, body) = {
  set document(title: title)
  set page(
    width: cfg.width,
    height: cfg.height,
    margin: cfg.margin,
    binding: left,
    foreground: page-number(),
  )
  set text(font: cfg.font.family, size: cfg.font.size, lang: cfg.lang, fill: cfg.ink.text)
  set par(leading: 0.5em)
  body
}

// Joins pages: each item is the content of one page.
#let pages(..items) = items.pos().join(pagebreak(weak: true))

// The next content starts on a left (even) page – for spreads.
#let to-left-page = pagebreak(to: "even", weak: true)

// A thin line in the "ink" colour.
#let rule(length: 100%) = line(length: length, stroke: cfg.ink.line-width + cfg.ink.line)

// Page heading: small and light.
#let page-title(body) = block(below: 2mm, text(size: cfg.font.size * 1.25, body))

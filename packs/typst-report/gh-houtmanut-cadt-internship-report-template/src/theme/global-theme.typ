#import "@preview/mmdr:0.2.2": mermaid
#import "../config.typ": (
  body-font, body-font-size, caption-size, code-bg, code-border, code-font,
  code-inset, code-lang-label-size, code-radius, code-text-fill,
  folder-char-outset, folder-char-size, folder-char-width, folder-leading,
  grey-dark, grey-light, inline-code-inset-x, inline-code-outset-y,
  inline-code-radius, list-body-indent, list-indent, outline-color,
  par-first-line-indent, par-leading, primary-color, table-border,
  table-header-color, table-inset, table-stroke,
)
// Values live in config.typ; this file is the structural show-rules that use them.

#let main-style(body) = {
  // == Figures ===============================================================
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: set block(breakable: true)
  show figure.caption: set text(size: caption-size, style: "italic")

  // == Links =================================================================
  show link: set text(fill: primary-color)

  // == Tables ================================================================
  set table(
    inset: table-inset,
    stroke: table-stroke,
    fill: (x, y) => if y == 0 { table-header-color } else { white },
    align: (col, row) => if row == 0 { center + horizon } else {
      left + horizon
    },
  )
  show table: set par(justify: false)
  show table.header: set align(center + horizon)
  show table: it => context {
    block(
      radius: 8pt,
      stroke: table-border,
      clip: true,
      it,
    )
  }


  // == Raw blocks ================================================================
  // Quick and dirty mermaid compiler. Avoid using since it's kinda not good
  show raw.where(lang: "mermaid"): it => mermaid(it.text)

  // custom highlighter for folder structure codes, see example
  show raw.where(lang: "folder", block: true): it => {
    show regex("#.*"): set text(fill: grey-light)
    show regex("/"): set text(fill: grey-dark)
    show regex("[├─│└]"): char => box(
      width: folder-char-width,
      outset: (top: folder-char-outset, bottom: folder-char-outset),
      {
        set text(fill: grey-dark.lighten(50%), size: folder-char-size)
        char
      },
    )
    set par(leading: folder-leading)
    it
  }

  show raw.where(block: false): it => box(
    fill: code-bg,
    inset: (x: inline-code-inset-x),
    outset: (y: inline-code-outset-y),
    radius: inline-code-radius,
    stroke: code-border,
    text(fill: code-text-fill, it, font: code-font),
  )
  show raw.where(block: true): it => {
    if it.lang == "mermaid" {
      return box(width: 100%, align(center, it))
    }
    if it.lang == "folder" {
      return box(
        fill: code-bg,
        stroke: code-border,
        inset: code-inset,
        radius: code-radius,
        width: 100%,
        it,
      )
    }

    box(
      fill: code-bg,
      stroke: code-border,
      inset: code-inset,
      radius: code-radius,
      width: 100%,
      {
        if it.has("lang") {
          place(
            top + right,
            text(
              size: code-lang-label-size,
              fill: primary-color.desaturate(50%),
              weight: "bold",
              upper(it.lang),
            ),
          )
        }
        it
      },
    )
  }
  // == Heading reference =====================================================
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      let num = numbering(el.numbering, ..counter(heading).at(el.location()))
      let clean-num = if num.ends-with(".") { num.slice(0, -1) } else { num }
      show link: set text(weight: "bold", fill: black)
      link(it.target, [#el.supplement #clean-num])
    } else {
      it
    }
  }

  // == Base text =============================================================
  set text(font: body-font, size: body-font-size, lang: "en")
  set par(
    justify: true,
    first-line-indent: (amount: par-first-line-indent, all: true),
    leading: par-leading,
  )
  set enum(indent: par-first-line-indent, body-indent: list-body-indent)
  set list(indent: par-first-line-indent, body-indent: list-body-indent)
  show list: it => {
    set list(indent: list-indent, marker: [◦])
    it
  }


  show footnote: it => {
    if it.numbering == "*" {
      it
      counter(footnote).update(n => n - 1)
    } else {
      it
    }
  }

  show cite: it => text(fill: primary-color, it)
  show ref: it => text(weight: "bold", it)

  body
}

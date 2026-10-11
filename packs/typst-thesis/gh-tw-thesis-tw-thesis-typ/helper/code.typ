// Code blocks in the style of latex's minted: a light background, no frame and
// no line numbers -- pdf text is always copyable, so numbers would end up in
// anything pasted out of the listing. Caption position is configured by the
// thesis template.
//
//   #show: code-style          // once, applied by helper/mod.typ
//   #code(caption: [...], ```typ ... ```)

#let code-theme = (
  font: ("DejaVu Sans Mono",), // typst ships this one; add your own first
  size: 0.95em,
  fill: luma(248),
  inline: rgb("#4b69c6"), // same blue the block highlighter uses for flags
  inset: 0.6em,
)

// Inline code shares the surrounding text size and baseline.
#let code-style(body) = {
  show raw: set text(font: code-theme.font + ("TW-MOE-Std-Kai",))
  show raw.where(block: false): set text(size: 1em, baseline: 0pt, fill: code-theme.inline)
  show raw.where(block: false): it => {
    // Cancel raw's 0.8em scale only for CJK; Latin monospace stays compact.
    show regex("[\\p{Han}\\x{3000}-\\x{303f}\\x{ff00}-\\x{ffef}]+"): set text(size: 1em / 0.8)
    it
  }
  show raw.where(block: true): set text(size: code-theme.size)

  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: code-theme.fill,
      inset: (x: code-theme.inset, y: code-theme.inset),
      breakable: true,
      {
        // the thesis body runs at 1.5 line height and indents paragraphs; code
        // wants neither
        set par(leading: 0.5em, spacing: 0.5em, first-line-indent: 0em, justify: false)
        set text(top-edge: "ascender", bottom-edge: "descender")
        // a figure centres its body; code reads left-aligned
        std.align(left, it)
      },
    )
    // Restore consecutive-paragraph indentation after a standalone listing.
    ""
    context v(-par.spacing - measure("").height)
  }

  // Allow long listings to continue onto the next page.
  show figure.where(kind: "code"): set block(breakable: true)

  body
}

// A captioned listing. `#code(caption: [...])[```typ ... ```]`, or without a
// caption just write the ``` block on its own.
#let code(caption: none, supplement: [程式碼], body) = figure(
  body,
  caption: caption,
  kind: "code",
  supplement: supplement,
)

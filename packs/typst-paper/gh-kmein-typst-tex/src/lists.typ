// itemize and enumerate.
//
// A LaTeX list at level one puts the item body at \leftmargini (2.5em = 25pt)
// and right-aligns the label so that it ends \labelsep (0.5em = 5pt) earlier,
// at \labelwidth = 20pt. Vertically, measured against pdflatex:
//
//   between items      \itemsep + \parsep + \baselineskip  =  4 + 4 + 12 = 20pt
//   above/below list   \topsep + \partopsep + \baselineskip =  8 + 2 + 12 = 22pt
//
// Since this template's line boxes already carry \baselineskip as their
// top-edge, the block spacings below are just the LaTeX skips.

#import "units.typ": tp
#import "base.typ": size-of
#import "fonts.typ": quad

#let list-rules(st, body) = {
  let g = st.g
  let nsz = size-of(st, "normal")
  let leftmargin = 2.5 * quad(nsz)      // \leftmargini
  let labelsep = 0.5 * quad(nsz)        // \labelsep
  let labelwidth = leftmargin - labelsep

  // Typst puts the body at indent + marker width + body-indent, so `indent`
  // has to be labelwidth minus the marker's own width for the label to end at
  // \labelwidth and the body to begin at \leftmargini.
  // \textbullet is not a text glyph in OT1: LaTeX takes it from cmsy, where it
  // is 0.5em wide. Typst's default marker is U+2022 out of the roman font,
  // which in Latin Modern is 0.778em -- wide enough to push the item body
  // 2.8pt past \leftmargini. Latin Modern Math is cmsy's OpenType successor,
  // so the bullet operator there is the same glyph at the same width.
  let marker-width = 0.5 * nsz
  let number-width = 0.5 * nsz + 0.278 * nsz  // "1." -- digit plus period

  set list(
    indent: tp(labelwidth - marker-width),
    body-indent: tp(labelsep),
    spacing: tp(g.sizes.itemsep + g.sizes.parsep),
    marker: text(font: st.fonts.math)[\u{2219}],
  )
  set enum(
    indent: tp(labelwidth - number-width),
    body-indent: tp(labelsep),
    spacing: tp(g.sizes.itemsep + g.sizes.parsep),
    numbering: "1.",
    number-align: end,
  )
  show list: set block(above: tp(g.sizes.topsep + g.sizes.partopsep),
                       below: tp(g.sizes.topsep + g.sizes.partopsep))
  show enum: set block(above: tp(g.sizes.topsep + g.sizes.partopsep),
                       below: tp(g.sizes.topsep + g.sizes.partopsep))
  body
}

// Shared style plumbing: the resolved style object and size switching.
//
// Kept separate from lib.typ so that title.typ and floats.typ can use it
// without importing the template entry point.

#import "units.typ": tp, tex-pt, ex-ratio
#import "geometry.typ": layout
#import "fonts.typ": stacks, optical-family, quad

/// Bundles everything the style rules need. Built once by `article`.
#let style(paper: "a4", size: "10", twoside: false, portable: false, optical: true) = {
  let g = layout(paper: paper, size: size, twoside: twoside)
  (
    g: g,
    fonts: if portable { stacks.portable } else { stacks.system },
    optical: optical and not portable,
    // 1ex, resolved in the body font, as \@startsection skips are.
    ex: ex-ratio * g.sizes.normal.at(0),
    // See lib.typ: the top-margin correction that restores \topskip.
    top-fix: g.sizes.normal.at(1) - g.topskip,
  )
}

/// The family to use at a given size in TeX points. Bold matters because CM's
/// bold cuts stop at cmbx12 while the roman cuts go up to cmr17.
#let rm-family(st, size-tp, bold: false) = {
  if st.optical { optical-family(size-tp, bold: bold) } else { st.fonts.rm }
}

/// TeX's `em` at one of LaTeX's named sizes, in TeX points.
#let em-of(st, name, bold: false) = quad(st.g.sizes.at(name).at(0), bold: bold)

/// Switch to one of LaTeX's named sizes, putting `body` on that size's grid.
#let sized(st, name, body) = {
  let (sz, bls) = st.g.sizes.at(name)
  set text(size: tp(sz), top-edge: tp(bls), bottom-edge: "baseline", font: rm-family(st, sz))
  set par(leading: 0pt, spacing: 0pt)
  body
}

/// The size in TeX points of one of LaTeX's named sizes.
#let size-of(st, name) = st.g.sizes.at(name).at(0)

/// The \baselineskip in TeX points of one of LaTeX's named sizes.
#let baseline-of(st, name) = st.g.sizes.at(name).at(1)

/// A paragraph of literally zero height.
///
/// LaTeX indents every paragraph except the one right after a heading; Typst's
/// `first-line-indent(all: false)` instead skips the indent after *any* block,
/// which for headings, display math and lists agrees with LaTeX's usual style.
/// It disagrees at the very start of the body, where there is no preceding
/// paragraph at all. Emitting this first restores the chain without moving
/// anything down the page.
#let chain = {
  set text(top-edge: 0pt, bottom-edge: 0pt)
  par(box())
}

/// Whether `body` opens with a block-level element, in which case LaTeX would
/// not have indented anything and `chain` must not be emitted.
#let starts-with-block(body) = {
  let seq = [].func()
  let items = if body.func() == seq { body.children } else { (body,) }
  for c in items {
    // Markup content opens with a parbreak; it is not the element we mean.
    if c.func() in ([ ].func(), parbreak) or c == [] { continue }
    return c.func() in (heading, figure, math.equation, table, list.item, enum.item, terms.item)
  }
  false
}

/// Split `body` into its paragraphs.
///
/// Needed because `first-line-indent` cannot be set from a nested scope: a
/// plain `set`, and even a show-set, fails to reach paragraphs inside a padded
/// container when the styling comes from a helper function rather than the
/// document root. An explicitly constructed `par` element carries the field
/// directly and always wins, so the abstract builds its paragraphs by hand.
#let paragraphs(body) = {
  let seq = [].func()
  let items = if body.func() == seq { body.children } else { (body,) }
  let out = ()
  let cur = ()
  for c in items {
    if c.func() == parbreak {
      if cur.len() > 0 { out.push(cur.join()) }
      cur = ()
    } else {
      cur.push(c)
    }
  }
  if cur.len() > 0 { out.push(cur.join()) }
  out
}

/// A block of no size at all, the mirror of `chain`.
///
/// Breaks the "follows a paragraph" chain so that the paragraph after it is
/// not first-line indented -- which is what a run-in \paragraph heading needs,
/// since LaTeX sets it flush against the left margin.
#let break-chain = block(width: 0pt, height: 0pt, above: 0pt, below: 0pt)[]

/// The level of a heading that opens `body`, or `none`.
#let leading-heading-level(body) = {
  let seq = [].func()
  let items = if body.func() == seq { body.children } else { (body,) }
  for c in items {
    if c.func() in ([ ].func(), parbreak) or c == [] { continue }
    // `level` is not resolved before layout for a markup heading; it is
    // `offset + depth`, both of which are.
    return if c.func() == heading {
      c.at("offset", default: 0) + c.at("depth", default: 1)
    } else { none }
  }
  none
}

// Page geometry, transcribed from size10.clo / size11.clo / size12.clo.
//
// These are not hardcoded measurements -- they are LaTeX's own algorithm, so
// every paper/size combination it supports comes out right.

#import "units.typ": settopoint, tex-in, tex-mm

/// Paper sizes named by LaTeX's class options, in TeX points.
#let papers = (
  a4:        (w: 210 * tex-mm, h: 297 * tex-mm),
  a5:        (w: 148 * tex-mm, h: 210 * tex-mm),
  b5:        (w: 176 * tex-mm, h: 250 * tex-mm),
  letter:    (w: 8.5 * tex-in, h: 11 * tex-in),
  legal:     (w: 8.5 * tex-in, h: 14 * tex-in),
  executive: (w: 7.25 * tex-in, h: 10.5 * tex-in),
)

// LaTeX's point-size macros (latex.ltx): a 1.2-ratio scale, not round numbers.
#let pt-v = 5.0
#let pt-vi = 6.0
#let pt-vii = 7.0
#let pt-viii = 8.0
#let pt-ix = 9.0
#let pt-x = 10.0
#let pt-xi = 10.95
#let pt-xii = 12.0
#let pt-xiv = 14.4
#let pt-xvii = 17.28
#let pt-xx = 20.74
#let pt-xxv = 24.88

/// Font size tables. Each entry is (size, baselineskip) in TeX points, exactly
/// as the `\@setfontsize` calls in the corresponding size1X.clo give them.
#let sizes = (
  "10": (
    normal: (pt-x, 12.0),
    small: (pt-ix, 11.0),
    footnotesize: (pt-viii, 9.5),
    scriptsize: (pt-vii, pt-viii),
    tiny: (pt-v, pt-vi),
    large: (pt-xii, 14.0),
    Large: (pt-xiv, 18.0),
    LARGE: (pt-xvii, 22.0),
    huge: (pt-xx, 25.0),
    Huge: (pt-xxv, 30.0),
    topskip: 10.0,
    // \@listI and \partopsep, from the same .clo -- used by list environments
    // and by every `center`/`quotation` trivlist.
    topsep: 8.0,
    // \small redefines \@listi with its own, tighter \topsep.
    small-topsep: 4.0,
    parsep: 4.0,
    itemsep: 4.0,
    partopsep: 2.0,
    parindent: 15.0,
    target-width: 345.0,
  ),
  "11": (
    normal: (pt-xi, 13.6),
    small: (pt-x, pt-xii),
    footnotesize: (pt-ix, 11.0),
    scriptsize: (pt-viii, 9.5),
    tiny: (pt-vi, pt-vii),
    large: (pt-xii, 14.0),
    Large: (pt-xiv, 18.0),
    LARGE: (pt-xvii, 22.0),
    huge: (pt-xx, 25.0),
    Huge: (pt-xxv, 30.0),
    topskip: 11.0,
    // \@listI and \partopsep, from the same .clo -- used by list environments
    // and by every `center`/`quotation` trivlist.
    topsep: 9.0,
    // \small redefines \@listi with its own, tighter \topsep.
    small-topsep: 6.0,
    parsep: 4.5,
    itemsep: 4.5,
    partopsep: 3.0,
    parindent: 17.0,
    target-width: 360.0,
  ),
  "12": (
    normal: (pt-xii, 14.5),
    small: (pt-xi, 13.6),
    footnotesize: (pt-x, pt-xii),
    scriptsize: (pt-viii, 9.5),
    tiny: (pt-vi, pt-vii),
    large: (pt-xiv, 18.0),
    Large: (pt-xvii, 22.0),
    LARGE: (pt-xx, 25.0),
    huge: (pt-xxv, 30.0),
    Huge: (pt-xxv, 30.0),
    topskip: 12.0,
    // \@listI and \partopsep, from the same .clo -- used by list environments
    // and by every `center`/`quotation` trivlist.
    topsep: 10.0,
    // \small redefines \@listi with its own, tighter \topsep.
    small-topsep: 9.0,
    parsep: 5.0,
    itemsep: 5.0,
    partopsep: 3.0,
    // \parindent is 1.5em, and the 12pt class's em is cmr12's QUAD (0.9791565)
    // times 12pt, not 12pt itself.
    parindent: 1.5 * 0.9791565 * 12.0,
    target-width: 390.0,
  ),
)

// Fixed in every size1X.clo.
#let headheight = 12.0
#let headsep = 25.0
#let footskip = 30.0

/// Run LaTeX's geometry algorithm. All returned values are in TeX points.
#let layout(paper: "a4", size: "10", twoside: false, twocolumn: false) = {
  let p = papers.at(paper)
  let s = sizes.at(size)
  let (pw, ph) = (p.w, p.h)
  let bls = s.normal.at(1)

  // \textwidth: the target width, unless the paper is too narrow for it.
  let avail = pw - 2 * tex-in
  let target = s.target-width * (if twocolumn { 2 } else { 1 })
  let textwidth = settopoint(calc.min(avail, target))

  // \textheight: a whole number of baselines, plus \topskip for the first.
  let lines = calc.floor((ph - 3.5 * tex-in) / bls)
  let textheight = lines * bls + s.topskip

  // \oddsidemargin, measured from the 1in origin. The truncation here is what
  // makes LaTeX's margins asymmetric.
  let odd = settopoint((if twoside { 0.4 } else { 0.5 }) * (pw - textwidth) - tex-in)
  let even = if twoside {
    settopoint(pw - 2 * tex-in - textwidth - odd)
  } else { odd }

  // \topmargin, likewise: the leftover vertical space, halved and truncated.
  let leftover = ph - 2 * tex-in - headheight - headsep - textheight - footskip
  let topmargin = settopoint(0.5 * leftover)

  let left = tex-in + odd
  let top = tex-in + topmargin + headheight + headsep

  (
    paper: (w: pw, h: ph),
    textwidth: textwidth,
    textheight: textheight,
    // Body-text block edges, measured from the paper edges.
    left: left,
    right: pw - left - textwidth,
    even-left: tex-in + even,
    top: top,
    bottom: ph - top - textheight,
    // Vertical metrics the body needs.
    lines: lines,
    topskip: s.topskip,
    baselineskip: bls,
    parindent: s.parindent,
    footskip: footskip,
    headheight: headheight,
    headsep: headsep,
    sizes: s,
  )
}

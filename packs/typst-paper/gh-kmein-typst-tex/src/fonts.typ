// Font stacks.
//
// Latin Modern is the OpenType descendant of Computer Modern and is metric-
// compatible with it, so it is the closest match to what pdflatex actually
// puts on the page. New Computer Modern ships inside the Typst binary, so the
// `portable` stack compiles anywhere at a small cost in fidelity.

#let stacks = (
  system: (
    rm: ("Latin Modern Roman",),
    sf: ("Latin Modern Sans",),
    tt: ("Latin Modern Mono",),
    math: ("Latin Modern Math",),
  ),
  // Typst bundles New Computer Modern's serif and math faces, but no NCM sans
  // or mono -- so those prefer Latin Modern if it is installed and otherwise
  // land on a bundled face.
  portable: (
    rm: ("New Computer Modern",),
    sf: ("Latin Modern Sans", "DejaVu Sans"),
    tt: ("Latin Modern Mono", "DejaVu Sans Mono"),
    math: ("New Computer Modern Math",),
  ),
)

/// Computer Modern's optical cuts, and the TFM parameters TeX resolves units
/// against.
///
/// pdflatex does not scale one master design: NFSS picks a cut per size. The
/// mapping is an exact-size lookup, not a range -- from ot1cmr.fd:
///
///   cmr  m/n:  <5><6><7><8><9><10><12>gen*cmr  <10.95>cmr10  <14.4>cmr12
///              <17.28><20.74><24.88>cmr17
///   cmr bx/n:  <5><6><7><8><9>gen*cmbx  <10><10.95>cmbx10
///              <12><14.4><17.28><20.74><24.88>cmbx12
///
/// Note that bold stops at cmbx12: there is no cmbx17, and correspondingly
/// Latin Modern Roman 17 ships no bold face.
///
/// `quad` is the TFM QUAD parameter of the cut, in design-size units. TeX's
/// `em` is QUAD x the current size, *not* the size itself -- CM's bold cuts
/// have a quad of 1.125-1.15em, which is why the \quad after a section number
/// is wider than the heading's font size. Ignoring this puts every numbered
/// heading's text ~1.8pt too far left.
#let cm-cuts = (
  (size: 5.0,   rm: "Latin Modern Roman 5",  rm-quad: 1.361133,  bf: "Latin Modern Roman 5",  bf-quad: 1.516638),
  (size: 6.0,   rm: "Latin Modern Roman 6",  rm-quad: 1.222209,  bf: "Latin Modern Roman 6",  bf-quad: 1.387029),
  (size: 7.0,   rm: "Latin Modern Roman 7",  rm-quad: 1.138894,  bf: "Latin Modern Roman 7",  bf-quad: 1.294442),
  (size: 8.0,   rm: "Latin Modern Roman 8",  rm-quad: 1.062515,  bf: "Latin Modern Roman 8",  bf-quad: 1.225010),
  (size: 9.0,   rm: "Latin Modern Roman 9",  rm-quad: 1.027771,  bf: "Latin Modern Roman 9",  bf-quad: 1.183319),
  (size: 10.0,  rm: "Latin Modern Roman",    rm-quad: 1.000003,  bf: "Latin Modern Roman",    bf-quad: 1.149994),
  (size: 10.95, rm: "Latin Modern Roman",    rm-quad: 1.000003,  bf: "Latin Modern Roman",    bf-quad: 1.149994),
  (size: 12.0,  rm: "Latin Modern Roman 12", rm-quad: 0.9791565, bf: "Latin Modern Roman 12", bf-quad: 1.125),
  (size: 14.4,  rm: "Latin Modern Roman 12", rm-quad: 0.9791565, bf: "Latin Modern Roman 12", bf-quad: 1.125),
  (size: 17.28, rm: "Latin Modern Roman 17", rm-quad: 0.917237,  bf: "Latin Modern Roman 12", bf-quad: 1.125),
  (size: 20.74, rm: "Latin Modern Roman 17", rm-quad: 0.917237,  bf: "Latin Modern Roman 12", bf-quad: 1.125),
  (size: 24.88, rm: "Latin Modern Roman 17", rm-quad: 0.917237,  bf: "Latin Modern Roman 12", bf-quad: 1.125),
)

/// The cut entry NFSS would select for a size in TeX points. Sizes the classes
/// never ask for fall back to the largest cut at or below them.
#let cm-cut(size-tp) = {
  let chosen = cm-cuts.first()
  for c in cm-cuts {
    if size-tp + 0.001 >= c.size { chosen = c }
  }
  chosen
}

/// The family LaTeX would use at this size.
#let optical-family(size-tp, bold: false) = {
  let c = cm-cut(size-tp)
  if bold { c.bf } else { c.rm }
}

/// The greatest CHARDP in Computer Modern's roman cuts, in em.
///
/// TeX measures the space above a block (a float, a display, a list) from the
/// bottom of the preceding line -- \prevdepth -- not from its baseline. This
/// template's line boxes end at the baseline, so that depth has to be added
/// back explicitly. Every descending glyph in cmr has exactly this depth and
/// none is deeper, so the constant is exact for any line containing one.
#let cm-depth = 0.194445

/// TeX's `em` at this size, in TeX points: the cut's QUAD times the size.
#let quad(size-tp, bold: false) = {
  let c = cm-cut(size-tp)
  size-tp * (if bold { c.bf-quad } else { c.rm-quad })
}

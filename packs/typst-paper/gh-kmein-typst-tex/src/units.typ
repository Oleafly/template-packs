// Units.
//
// TeX measures in points of 1/72.27in.  Typst, like PostScript and PDF, uses
// points of 1/72in.  Every dimension lifted out of a LaTeX class file must be
// scaled before it reaches Typst, or the page comes out 0.37% too large --
// which is the single most common reason a "LaTeX-like" template is not.

/// One TeX point, as a Typst length.
#let tex-pt = (72.0 / 72.27) * 1pt

/// One TeX inch, in TeX points.
#let tex-in = 72.27

/// One millimetre, in TeX points.
#let tex-mm = 72.27 / 25.4

/// Interpret `x` as a measurement in TeX points.
#let tp(x) = x * tex-pt

/// TeX's `\@settopoint`, defined in latex.ltx as
///     \def\@settopoint#1{\divide#1\p@\multiply#1\p@}
/// i.e. truncation toward zero at whole-point granularity.  LaTeX rounds
/// several page dimensions this way, which is why its left and right margins
/// are not equal.
#let settopoint(x) = calc.trunc(x)

/// x-height of Computer Modern as recorded in cmr10.tfm.  LaTeX's `ex` unit
/// resolves against this, and every `\@startsection` skip is expressed in it.
#let ex-ratio = 0.430555

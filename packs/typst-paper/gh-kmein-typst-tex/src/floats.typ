// Floats and captions.
//
// article.cls:
//   \setlength\abovecaptionskip{10\p@}
//   \setlength\belowcaptionskip{0\p@}
//   \long\def\@makecaption#1#2{\vskip\abovecaptionskip
//     \sbox\@tempboxa{#1: #2}%
//     \ifdim \wd\@tempboxa >\hsize  #1: #2\par
//     \else \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}\fi
//     \vskip\belowcaptionskip}
//
// So: "Figure 1: text" at \normalsize, centred when it fits on one line and
// set as an ordinary justified paragraph when it does not.
//
// size10.clo float separations:
//   \floatsep 12pt, \textfloatsep 20pt, \intextsep 12pt

#import "units.typ": tp
#import "base.typ": size-of, baseline-of, chain
#import "fonts.typ": cm-depth

#let above-caption-skip = 10.0
#let below-caption-skip = 0.0
#let float-sep = 12.0
#let text-float-sep = 20.0
#let in-text-sep = 12.0

// TeX widens the space after a colon: \sfcode`\: is 2000, which adds the
// font's EXTRASPACE to the interword glue. For cmr that is 0.111112em on top
// of the 0.333334em normal space. Everywhere else this template inherits
// Typst's uniform spacing, but the caption separator is ours to set.
#let colon-extra-space = 0.111112

#let caption-rules(st, body) = {
  let g = st.g

  // LaTeX's default float specifier is [tbp].
  set figure(placement: auto, gap: tp(above-caption-skip))

  show figure.caption: it => {
    let line = {
      it.supplement
      [ ]
      context it.counter.display(it.numbering)
      [:]
      [ ]
      h(colon-extra-space * 1em)
      it.body
    }
    context {
      // \sbox\@tempboxa{#1: #2}\ifdim\wd\@tempboxa>\hsize
      let fits = measure(line).width <= tp(g.textwidth)
      set par(justify: true, leading: 0pt, spacing: 0pt, first-line-indent: 0pt)
      if fits {
        // \hb@xt@\hsize{\hfil\box\@tempboxa\hfil} -- the figure already
        // centres its contents, so the line only has to be handed over.
        line
      } else {
        // A caption too wide for one line is set as an ordinary paragraph.
        // \@caption wraps \@makecaption in \@parboxrestore, which undoes the
        // float's \centering and zeroes \parindent, so it is justified and
        // flush left -- last line included.
        align(left, block(width: 100%, line))
      }
    }
  }

  show figure: it => {
    // A float that ends up in the text gets \intextsep; one that is moved to
    // the top or bottom of a page gets \textfloatsep.
    let sep = if it.placement == none { in-text-sep } else { text-float-sep }
    // The float is not preceded by interline glue, so the gap above it starts
    // at \prevdepth -- the bottom of the previous line -- rather than at its
    // baseline. Below, TeX's interline glue cancels the depth again, so only
    // the space above needs the correction.
    let prevdepth = cm-depth * size-of(st, "normal")
    set block(above: tp(sep + prevdepth), below: tp(sep))
    it
    // A paragraph after an in-text float is a fresh, indented paragraph in
    // LaTeX. Typst drops the indent after any block, so restore the chain.
    // Floats that move to the top or bottom of a page leave the surrounding
    // text as one paragraph, and get no chain.
    if it.placement == none { chain }
  }

  body
}

// A metrically exact rendering of LaTeX's `article` class.
//
// ---------------------------------------------------------------------------
// The vertical model
// ---------------------------------------------------------------------------
// LaTeX puts baselines on a rigid \baselineskip grid. Typst derives line
// height from font metrics: baseline-to-baseline = (top-edge - bottom-edge) +
// leading. Pinning
//
//     top-edge = \baselineskip,  bottom-edge = baseline,  leading = 0
//
// makes the grid rigid, and has a second payoff: a line's box now runs from
// the previous baseline to its own, so every gap Typst inserts between blocks
// is numerically the *same* number as the corresponding LaTeX \vskip. Section
// skips can then be transcribed straight out of article.cls.
//
// The one place this disagrees with TeX is the first line of a page, which
// LaTeX places \topskip -- not \baselineskip -- below the top of the body. We
// raise the top margin by the difference and leave the bottom margin alone.
// That is not a fudge: LaTeX's last baseline sits exactly \textheight below
// the top of the body, so in a model whose line boxes run baseline-to-baseline
// the body must be (\baselineskip - \topskip) taller to hold the same number
// of baselines. Measured against pdflatex, this is what makes the 50th line of
// an a4/10pt page fall on page one rather than page two.

#import "units.typ": tp, tex-pt, ex-ratio
#import "base.typ": style, sized, rm-family, size-of, baseline-of, chain, break-chain, starts-with-block
#import "fonts.typ": quad
#import "title.typ": maketitle, abstract-block, today
#import "floats.typ": caption-rules
#import "lists.typ": list-rules
#import "notes.typ": note-rules

// \@startsection parameters, from article.cls. `before` and `after` are in ex;
// a negative `after` in LaTeX means a run-in heading.
/// \setcounter{secnumdepth}{3} -- \paragraph and \subparagraph are unnumbered.
#let secnumdepth = 3

#let section-specs = (
  (size: "Large", before: 3.5, after: 2.3, run-in: false, after-em: false),
  (size: "large", before: 3.25, after: 1.5, run-in: false, after-em: false),
  (size: "normal", before: 3.25, after: 1.5, run-in: false, after-em: false),
  // \paragraph's afterskip is -1em, and em here is the bold cut's quad.
  (size: "normal", before: 3.25, after: -1.0, run-in: true, after-em: true),
)

#let article(
  title: none,
  authors: (),
  date: auto,
  abstract: none,
  paper: "a4",
  size: "10",
  twoside: false,
  portable: false,
  optical: true,
  page-numbers: true,
  body,
) = {
  let st = style(paper: paper, size: size, twoside: twoside, portable: portable, optical: optical)
  let g = st.g
  let (nsz, nbls) = g.sizes.normal
  let fix = st.top-fix

  set page(
    width: tp(g.paper.w),
    height: tp(g.paper.h),
    margin: (
      left: tp(g.left),
      right: tp(g.right),
      top: tp(g.top - fix),
      bottom: tp(g.bottom),
    ),
    // \@outputpage sets \baselineskip\footskip before appending the footer
    // box, so the footer *baseline* sits \footskip below the body's bottom
    // edge. The footer line's own top-edge accounts for \baselineskip of that.
    footer-descent: tp(g.footskip - nbls),
    footer: if page-numbers {
      set text(
        size: tp(nsz),
        top-edge: tp(nbls),
        bottom-edge: "baseline",
        font: rm-family(st, nsz),
      )
      set par(leading: 0pt, spacing: 0pt)
      context align(center, counter(page).display("1"))
    } else { none },
  )

  set text(
    font: rm-family(st, nsz),
    size: tp(nsz),
    top-edge: tp(nbls),
    bottom-edge: "baseline",
    lang: "en",
    hyphenate: true,
    // Typst lets line-final punctuation hang into the margin by about 2.2pt.
    // pdflatex without `microtype` does not protrude at all, so turn it off.
    overhang: false,
  )
  set par(
    justify: true,
    leading: 0pt,
    spacing: 0pt,
    first-line-indent: (amount: tp(g.parindent), all: false),
  )
  show math.equation: set text(font: st.fonts.math)
  show raw: set text(font: st.fonts.tt)

  // \setcounter{secnumdepth}{3}: \paragraph and below are not numbered.
  set heading(numbering: "1.1.1")
  show heading: it => {
    let lv = calc.min(it.level, section-specs.len())
    let spec = section-specs.at(lv - 1)
    let (sz, bls) = g.sizes.at(spec.size)
    let numbered = it.numbering != none and it.level <= secnumdepth
    let head = {
      set text(
        size: tp(sz),
        top-edge: tp(bls),
        bottom-edge: "baseline",
        weight: "bold",
        font: rm-family(st, sz, bold: true),
      )
      set par(leading: 0pt, spacing: 0pt, first-line-indent: 0pt)
      if numbered {
        // \@seccntformat is `\thesection\quad`, and \quad is one `em` of the
        // *bold* cut in force, which for CM is 1.125-1.15 times the size.
        context counter(heading).display(it.numbering)
        h(tp(quad(sz, bold: true)))
      }
      it.body
    }
    // The skip above a heading is \addvspace, which TeX drops at the top of a
    // page and otherwise merges with adjacent glue by taking the maximum --
    // exactly Typst's weak spacing. Using it here instead of the block's own
    // `above` keeps a heading that opens a page flush with the top margin.
    v(tp(spec.before * st.ex), weak: true)
    if spec.run-in {
      // \@startsection with a negative afterskip: the heading runs into the
      // paragraph that follows, |afterskip| of horizontal space away. The
      // content has to stay inline -- no block, and no paragraph-level `set`
      // -- for Typst to merge it with the text that follows. The empty block
      // first keeps that merged paragraph from being first-line indented.
      break-chain
      text(
        size: tp(sz),
        top-edge: tp(bls),
        bottom-edge: "baseline",
        weight: "bold",
        font: rm-family(st, sz, bold: true),
        it.body,
      )
      h(tp(calc.abs(spec.after) * quad(sz, bold: true)))
    } else {
      block(above: 0pt, below: tp(spec.after * st.ex), sticky: true, head)
    }
  }

  show: caption-rules.with(st)
  show: list-rules.with(st)
  show: note-rules.with(st)

  let the-date = if date == auto { today() } else { date }
  if title != none {
    maketitle(st, title, authors, the-date)
  }
  if abstract != none {
    abstract-block(st, abstract, after-title: title != none)
  }
  // LaTeX indents the body's first paragraph; Typst has no preceding paragraph
  // to chain it to, so supply a zero-height one.
  if not starts-with-block(body) { chain }
  body
}

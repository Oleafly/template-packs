// \maketitle and the abstract environment.
//
// article.cls:
//   \def\@maketitle{\newpage \null \vskip 2em
//     \begin{center}%
//       {\LARGE \@title \par}%      \vskip 1.5em%
//       {\large \begin{tabular}[t]{c}\@author\end{tabular}\par}% \vskip 1em%
//       {\large \@date}%
//     \end{center}\par \vskip 1.5em}
//
// The \vskip amounts sit *outside* the size-switching groups, so their `em` is
// the body font's, not the title's. \and separates authors into side-by-side
// tabular columns 1em apart, not onto separate lines.

#import "units.typ": tp, tex-pt
#import "base.typ": sized, size-of, baseline-of, rm-family, paragraphs
#import "fonts.typ": quad

#let month-names = (
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
)

/// \today, in LaTeX's English format.
#let today() = {
  let d = datetime.today()
  [#month-names.at(d.month() - 1) #d.day(), #d.year()]
}

#let maketitle(st, title, authors, date) = {
  let g = st.g
  let nsz = size-of(st, "normal")
  let nbls = baseline-of(st, "normal")
  // Top of body to the title's baseline: \topskip for the \null box, \vskip
  // 2em, then the title line's own \baselineskip -- which our vertical model
  // already supplies as the line's top-edge. `top-fix` compensates for the
  // raised page margin (see lib.typ).
  let lead = g.topskip + 2 * nsz + st.top-fix

  v(tp(lead))
  align(center, sized(st, "LARGE", par(justify: false, title)))

  let people = if authors == none { () } else { authors }
  if people.len() > 0 {
    v(tp(1.5 * nsz))
    align(center, sized(st, "large", {
      let gap = tp(size-of(st, "large"))  // \and's \hskip 1em, in the \large font
      grid(
        columns: people.len(),
        column-gutter: gap,
        align: top + center,
        ..people.map(a => par(justify: false, a)),
      )
    }))
  }

  if date != none {
    // The date is the one line here whose position TeX does not put on a fixed
    // grid. `{\large \@date}` closes its group *before* \end{center} triggers
    // \par, so the line box is appended with \baselineskip at \normalsize --
    // 12pt, not \large's 14pt. Against the author tabular's 4.2pt depth that
    // usually leaves no room for interline glue, and TeX falls back to
    // \lineskip, which makes the date's position depend on its own ink height.
    let lsz = size-of(st, "large")
    let depth = 0.3 * baseline-of(st, "large")  // \strutbox depth at \large
    let lineskip = 1.0
    let styled = {
      set text(
        size: tp(lsz),
        top-edge: "bounds",
        bottom-edge: "baseline",
        font: rm-family(st, lsz),
      )
      set par(leading: 0pt, spacing: 0pt, justify: false)
      date
    }
    context {
      let h = measure(styled).height / tex-pt
      let glue = calc.max(nbls - depth - h, lineskip)
      v(tp(depth + 1.0 * nsz + glue))
      align(center, styled)
    }
  }

  // \end{center} is \endtrivlist, which adds \topsep + \partopsep (8pt + 2pt
  // at \@listi) before \@maketitle's closing \vskip 1.5em.
  v(tp(st.g.sizes.topsep + st.g.sizes.partopsep + 1.5 * nsz))
}

/// The abstract environment.
///
///   \small
///   \begin{center}{\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}\end{center}
///   \quotation ... \endquotation
///
/// Two different list mechanisms are at work, and they do not use the same
/// parameters. `center` is a \trivlist, which does not run \@listi and so
/// contributes the ambient \topsep + \partopsep (8pt + 2pt). `quotation` is a
/// real \list, which does run \@listi and therefore picks up \small's tighter
/// \topsep. Measured against pdflatex, this reproduces the gaps exactly.
/// \listparindent for the abstract, in TeX points. `article` needs it to place
/// the show-set at its own level (see the note there).
#let abstract-listparindent(st) = 1.5 * quad(size-of(st, "small"))

#let abstract-block(st, body, after-title: true) = {
  let g = st.g
  let nsz = size-of(st, "normal")
  let ssz = size-of(st, "small")
  let sbls = baseline-of(st, "small")
  // \leftmargini is 2.5em, fixed at class-load size; \listparindent is 1.5em
  // of the *abstract's* \small font.
  let leftmargini = 2.5 * quad(nsz)
  let listparindent = 1.5 * quad(ssz)

  // \begin{center} issues \addvspace{\topsep+\partopsep}, which \maketitle's
  // trailing \vskip 1.5em already exceeds -- \addvspace takes the maximum, so
  // nothing more is added. Without a title there is no preceding glue.
  if not after-title { v(tp(g.sizes.topsep + g.sizes.partopsep), weak: true) }

  align(center, sized(st, "small", text(weight: "bold", "Abstract")))

  // \vspace{-.5em} in the \bfseries group -- and CM's bold quad is 1.183em at
  // 9pt -- followed by \end{center}'s \topsep + \partopsep.
  v(tp(-0.5 * quad(ssz, bold: true) + g.sizes.topsep + g.sizes.partopsep))

  // `pad`, not `block(inset: ..)`: a block drops first-line indentation for the
  // paragraphs inside it. \quotation indents every paragraph by
  // \listparindent, the first one included (\itemindent is set to the same
  // value), so `all` must be true.
  pad(left: tp(leftmargini), right: tp(leftmargini), {
    set text(
      size: tp(ssz),
      top-edge: tp(sbls),
      bottom-edge: "baseline",
      font: rm-family(st, ssz),
    )
    set par(justify: true, leading: 0pt, spacing: 0pt)
    // \quotation indents every paragraph by \listparindent -- \itemindent is
    // set to the same value, so the first one is included. The indent has to
    // be put on each `par` element directly; see `paragraphs`.
    for p in paragraphs(body) {
      par(first-line-indent: (amount: tp(listparindent), all: true), p)
    }
  })

  // \endlist adds \topsep + \partopsep, here from \small's \@listi. It is an
  // \addvspace, which merges with whatever follows by taking the maximum
  // rather than adding to it -- Typst's weak spacing, exactly.
  v(tp(g.sizes.small-topsep + g.sizes.partopsep), weak: true)
}

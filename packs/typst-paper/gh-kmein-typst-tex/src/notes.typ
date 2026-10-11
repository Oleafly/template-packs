// Footnotes and displayed equations.
//
// size10.clo:
//   \footnotesep 6.65pt          strut at the head of every footnote
//   \skip\footins 9pt plus4 minus2   space between the body and the footnotes
//   \abovedisplayskip 10pt plus2 minus5, \belowdisplayskip the same
// article.cls:
//   \footnoterule  \kern-3pt \hrule width .4\columnwidth \kern2.6pt
//   \@makefntext   \parindent 1em \noindent \hb@xt@1.8em{\hss\@makefnmark}#1

#import "units.typ": tp
#import "base.typ": size-of, baseline-of, rm-family
#import "fonts.typ": quad, cm-depth

#let footins-skip = 9.0
#let footnote-sep = 6.65
#let rule-kern-above = -3.0
#let rule-kern-below = 2.6
#let rule-width-ratio = 0.4
#let rule-thickness = 0.4
#let fnmark-box = 1.8      // em, \hb@xt@1.8em
// LaTeX's \DeclareMathSizes{10}{10}{7}{5}: a superscript in 10pt text is set
// in cmr7. The shift is \fontdimen14 (sup2) of cmsy, 0.363em, because a text
// superscript is set in \textstyle.
#let script-ratio = 0.7
#let sup-shift = 0.363

#let above-display-skip = 10.0
#let below-display-skip = 10.0

#let note-rules(st, body) = {
  let g = st.g
  let nsz = size-of(st, "normal")
  let fsz = size-of(st, "footnotesize")
  let fbls = baseline-of(st, "footnotesize")

  // \@makefnmark is \@textsuperscript, i.e. a math superscript, not Typst's
  // default 0.6em raise.
  set super(size: script-ratio * 1em, baseline: -sup-shift * 1em)

  set footnote.entry(
    separator: {
      v(tp(rule-kern-above))
      line(length: rule-width-ratio * tp(g.textwidth), stroke: tp(rule-thickness))
      v(tp(rule-kern-below))
    },
    // \prevdepth is -1000pt at the head of \footins, so no interline glue is
    // added before the first footnote: its baseline sits \footnotesep (the
    // strut) below the rule, not \baselineskip. Fold that difference into the
    // clearance. Between entries the normal interline glue does apply, so the
    // line's own top-edge already supplies the whole gap.
    clearance: tp(footins-skip - (fbls - footnote-sep)),
    gap: 0pt,
    indent: 0pt,
  )

  show footnote.entry: it => {
    set text(
      size: tp(fsz),
      top-edge: tp(fbls),
      bottom-edge: "baseline",
      font: rm-family(st, fsz),
    )
    // \@makefntext: \parindent 1em for continuation paragraphs, the mark set
    // flush right in a 1.8em box, and the first line not indented beyond it.
    set par(leading: 0pt, spacing: 0pt, first-line-indent: (amount: tp(quad(fsz)), all: false))
    let num = context {
      let n = counter(footnote).at(it.note.location()).first()
      // Inside \footnotesize text the script size is 6pt, not 0.7 x 8pt, so
      // the mark is built explicitly rather than via `super`.
      text(
        size: tp(6.0),
        baseline: -tp(sup-shift * fsz),
        numbering(it.note.numbering, n),
      )
    }
    box(width: tp(fnmark-box * quad(fsz)), align(right, num))
    it.note.body
  }

  // \abovedisplayskip / \belowdisplayskip. As with floats, the space above is
  // measured from \prevdepth rather than from the previous baseline.
  show math.equation.where(block: true): set block(
    above: tp(above-display-skip + cm-depth * nsz),
    below: tp(below-display-skip),
  )

  body
}

// ═══════════════════════════════════════════════════════════════════════════
// APPENDIX
// ═══════════════════════════════════════════════════════════════════════════
//
// Applied near the end of main.typ:
//
//     #show: appendix
//
// From that line on, chapters are lettered (A, B, C ...) and figures, tables
// and equations are numbered A.1, A.2, ... — the usual convention for
// supplementary material.

#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  show heading.where(level: 1): set heading(supplement: [Appendix])

  let lettered(n) = numbering("A.1", counter(heading).get().first(), n)
  set figure(numbering: lettered)
  set math.equation(numbering: n => [(#lettered(n))])

  body
}

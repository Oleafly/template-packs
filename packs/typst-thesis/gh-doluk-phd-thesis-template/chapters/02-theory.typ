// ═══════════════════════════════════════════════════════════════════════════
// CHAPTER 2 — Theory: how to write mathematics
// ═══════════════════════════════════════════════════════════════════════════

#import "../lib/blocks.typ": note

= Theory <ch:theory>

Typst has its own maths syntax. It is shorter than LaTeX and, unlike LaTeX, it
is the same language as the rest of the document — no separate maths mode with
its own rules.

== Inline and display equations

Maths goes between dollar signs. With no spaces inside the dollars it stays
_inline_: `$s = v / (omega^2 r)$` renders as $s = v / (omega^2 r)$. With a
space after the opening dollar and before the closing one it becomes a
_display_ equation on its own line, numbered automatically:

$ (partial c) / (partial t) = 1 / r (partial) / (partial r)
  [r D (partial c) / (partial r) - s omega^2 r^2 c] $ <eq:lamm>

Note the label `<eq:lamm>` after the equation. Writing `@eq:lamm` then gives a
link to it — @eq:lamm is the Lamm equation. Equation numbers restart in every
chapter, so the first equation of this chapter is numbered 2.1, and you never
have to keep track of that yourself.
#note[If you look at this chapter in preview.typ, `@eq:lamm` will be displayed as `(1.1)`, because in the preview this chapter is the first chapter.]

== Symbols

Greek letters and operators are written by name: `alpha beta gamma` gives
$alpha beta gamma$, `<=` gives $<=$, `->` gives $->$, `oo` gives $oo$ and
`integral` gives $integral$. Sub- and superscripts use `_` and `^`, with
braces or parentheses for anything longer than one character:
`s_(20,w)^"exp"` renders as $s_(20,w)^"exp"$.

Text inside an equation goes in quotes — `$D_"eff"$` gives $D_"eff"$ — and a
few things need `upright()` or `italic()` to get the right shape.

Multi-line equations are aligned on `&`, exactly as in LaTeX:

$ f / f_0 &= (f) / (6 pi eta (3 M overline(v) / (4 pi N_A))^(1/3)) \
        s &= (M (1 - overline(v) rho)) / (N_A f) $ <eq:svedberg>

#note(title: "Where to look things up")[
  The full symbol list is in the Typst documentation under
  #link("https://typst.app/docs/reference/symbols/sym/")[Reference → Symbols].
  If you know the LaTeX name, the Typst name is usually the same without the
  backslash.
]

== Matrices, cases and fractions

$ bold(A) = mat(a_11, a_12; a_21, a_22), quad
  f(x) = cases(1 quad &x > 0, 0 quad &"otherwise") $

Fractions are written with `/`, which keeps the source readable:
`(a + b) / (c + d)` gives $(a + b) / (c + d)$.

== Physical quantities

For units, either write them as text — $2.4 " S"$ — or add the
#link("https://typst.app/universe/package/unify")[`unify`] package to get
`#qty(2.4, "S")` with correct spacing. Adding a package is one import line;
see the README for how.

== Referring to symbols

If your thesis uses many symbols, keep a List of Symbols in the appendix —
`appendix/symbols.typ` shows how. Define every symbol once, there, and refer
back to it instead of re-explaining it in each chapter.


== Chemical formulas and more
Typst has growing ecosystem of packages, called "universe". There are packages for chemical formulas, circuit diagrams, music notation and more.
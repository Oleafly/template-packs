// main.typ
// Master showcase demonstrating components modeled directly after Charlie's LaTeX template

#import "prelude.typ": *

#show: document-template.with(
  title: "Generic Document & Notes Template",
  subtitle: "Inspired by Charlie's LaTeX Template with Full Typst Power",
  author: "Charlie & Co.",
  date: auto,
  abstract: [
    This template provides a modular, generic suite of beautifully styled document components in Typst. Directly matching Charlie's classic LaTeX math template, it features attached tab badges, rivet cards, sharp-cornered theorem blocks with left accent rules, ribbon callouts, and elegant code formatting. It works for any document---technical notes, research papers, lecture summaries, or project documentation---with built-in support for both *Light* and *Dark* themes.
  ],
  theme: sys.inputs.at("theme", default: "light"),
  cover-page: true,
  toc: true,
  toc-pagebreak: true,
)

= Vector Spaces & Topology

== Vector Spaces

#dfn("Vector Spaces", tag: "1.19 in the book")[
  A vector space (over a field $bbF$) is a set $V$ together with an operation of addition:
  $
               V times V & arrow.r V \
    (arrow(u), arrow(v)) & arrow.bar.r arrow(u) + arrow(v)
  $
  and scalar multiplication:
  $
           bbF times V & arrow.r V \
    (lambda, arrow(v)) & arrow.bar.r lambda arrow(v)
  $

  Satisfying the following properties:
  #set enum(numbering: circled-num)
  + Commutativity: $arrow(u) + arrow(v) = arrow(v) + arrow(u), quad forall arrow(u), arrow(v) in V$
  + Associativity: $(arrow(u) + arrow(v)) + arrow(w) = arrow(u) + (arrow(v) + arrow(w)), quad forall arrow(u), arrow(v), arrow(w) in V$
  + Additive Identity: There exists a unique element $arrow(0) in V$ such that $arrow(v) + arrow(0) = arrow(v), quad forall arrow(v) in V$
  + Additive Inverse: For every $arrow(v) in V$, there exists a unique $arrow(u) in V$ such that $arrow(v) + arrow(u) = arrow(0)$
  + Multiplicative Identity: $1 arrow(v) = arrow(v), quad forall arrow(v) in V$
  + Distributivity: $a(arrow(u) + arrow(v)) = a arrow(u) + a arrow(v)$ and $(a + b)arrow(u) = a arrow(u) + b arrow(u), quad forall a, b in bbF, arrow(u), arrow(v) in V$

  We call the elements of $V$ *vectors* or *points* of $V$.
]

#ex("1.4.1", tag: "Familiar: 1.2 in the book")[
  + $bbR^2 = { (x, y) mid(|) x, y in bbR }$
    - Addition: $(x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)$
    - Scalar multiplication: $lambda (x, y) = (lambda x, lambda y)$
    - Identity: $arrow(0) = (0, 0)$
    - Vector Space properties: follow from field properties of $bbR$
  + $bbR^3 = { (x, y, z) mid(|) x, y, z in bbR }$
    - Addition: $(x_1, y_1, z_1) + (x_2, y_2, z_2) = (x_1 + x_2, y_1 + y_2, z_1 + z_2)$
    - Scalar multiplication: $lambda (x, y, z) = (lambda x, lambda y, lambda z)$
    - Identity: $arrow(0) = (0, 0, 0)$

  In general, let $bbF$ denote scalar field --- we take $bbF$ to be $bbR$ or $bbC$.
]

== Subspaces and Span

#note(title: "Note:-")[
  Given $arrow(v) in V$, we define $span(arrow(v)) = { a arrow(v) mid(|) a in bbF }$ is a subspace. Given $arrow(v)_1, ..., arrow(v)_n in V$,
  $ span(arrow(v)_1, ..., arrow(v)_n) = span(arrow(v)_1) + ... + span(arrow(v)_n) quad "by definition" $
]

#mprop("2.7")[
  For any $arrow(v)_1, ..., arrow(v)_n in V$, $span(arrow(v)_1, ..., arrow(v)_n)$ is the smallest subspace of $V$ containing $arrow(v)_1, ..., arrow(v)_n$.
]

#pf[
  First, we prove $span(arrow(v)_1, ..., arrow(v)_n)$. Since sums of subspaces are subspaces, $span(arrow(v)_1, ..., arrow(v)_n) = span(arrow(v)_1) + ... + span(arrow(v)_n)$ is a subspace.

  #note(title: "Note:-")[
    *Why is it the smallest?* \
    Let $W$ be any subspace containing $arrow(v)_1, ..., arrow(v)_n$. Because $W$ is a subspace, $a_i arrow(v)_i in W, forall a_i in bbF, forall i = 1, ..., n$, thus $span(arrow(v)_i) subset.eq W, forall i = 1, ..., n$. So, $span(arrow(v)_1, ..., arrow(v)_n) = span(arrow(v)_1) + ... + span(arrow(v)_n) subset.eq W$.
  ]
]

#nt[
  In fact, every linear map $bbF^n |-> bbF^m$ is of this form.
]

#dfn("3.1.2", tag: "3.3 in the book")[
  If $V, W$ vector spaces over $bbF$, $cal(L)(V, W) = { "all linear maps" T : V |-> W }$.
  Given $V, W, T, S in cal(L)(V, W), lambda in bbF$, define:
  + Addition: $(T + S)(arrow(v)) = T(arrow(v)) + S(arrow(v))$
  + Scalar multiplication: $(lambda T)(arrow(v)) = lambda T(arrow(v)), forall arrow(v) in V$

  Check: $(T + S), (lambda T) in cal(L)(V, W)$.
]

= Finite Dimensional Spaces & Linear Maps

== Fundamental Theorem of Linear Maps

#thm("3.2.1", tag: "3.22: Fundamental Theorem of Linear Maps")[
  Suppose $T in cal(L)(V, W)$, and $V$ is finite dimensional. Then, the $null T$, $range T$ are both finite dimensional.
  $ dim(V) = dim(null(T)) + dim(range(T)) $

  Recall question 2: Can there be a surjective linear map $T : V |-> W$ if $dim(V) < dim(W)$? No by 3.24. $dim(V) < dim(W)$ then
  $
    dim(range(T)) & <= dim(V) - dim(null(T)) \
                  & <= dim(V) < dim(W) \
                  & "range " T != W, "thus " T "is not surjective."
  $
]

#thmcon[
  Recall question 1: Can there be an injective linear map $T : V |-> W$ if $dim(V) > dim(W)$? No by 3.23.
  $ dim(null(T)) = dim(V) - dim(range(T)) >= dim(V) - dim(W) > 0 $
  So $null(T) != {arrow(0)}$, thus $T$ is not injective by 3.16.
]

== Academic Math Suite: Corollaries, Lemmas & Claims

#mlemma("Linear Independence Extension")[
  Every linearly independent list of vectors in a finite-dimensional vector space can be extended to a basis of the space.
]

#cor("Basis Existence")[
  Every finite-dimensional vector space $V$ possesses a basis.
]

#clm("Intersection of Subspaces")[
  If $U_1, U_2$ are subspaces of $V$, then $U_1 inter U_2$ is also a subspace of $V$.
]

#iclm[
  The union of two subspaces is a subspace if and only if one is contained in the other.
]

#mer("Cauchy-Schwarz Inequality")[
  Let $x, y in bbR^m$. Prove that:
  $ inner(x, y)^2 <= inner(x, x) inner(y, y) $
]

#rmk("Proof Strategy")[
  For linear map dimensions, applying the Fundamental Theorem of Linear Maps usually resolves existence and surjectivity questions immediately.
]

#wc("Inverse of Sum")[
  Assuming $(A + B)^(-1) = A^(-1) + B^(-1)$ for invertible matrices $A, B$ is generally false! Matrix inversion does not distribute across addition.
]

== Questions, Solutions & Circled Lists

#qs("Closed Sets on the Plane")[
  Is the set $x"-axis" without { (0, 0) }$ a closed set in $bbR^2$?
]

#sol[
  We take its complement $S^c = bbR^2 without (x"-axis" without { (0, 0) })$. The origin $(0, 0)$ is a boundary point belonging to $S^c$, but any open ball $B_r ((0, 0))$ contains points on the punctured $x$-axis. Hence $S^c$ is not open, which implies the set is not closed.
]

#solbox(title: "Boxed Alternative")[
  Alternatively, consider the sequence of points $x_n = (1/n, 0)$ for $n >= 1$. Every point $x_n$ lies in the set, but their limit $lim_(n -> oo) x_n = (0, 0)$ does not. Since the set does not contain all its limit points, it cannot be closed.
]

Circled lists without double numbering:
#clist[
  $norm(x) = 0 <==> x = 0$ for all $x in V$
][
  $norm(lambda x) = abs(lambda) norm(x)$ for all $lambda in bbR, x in V$
][
  $norm(x + y) <= norm(x) + norm(y)$ for all $x, y in V$ (Triangle Inequality)
]

= Rivet Cards & Admonition Components

== The Complete Rivet Suite: Note, Tip, Info, Warning & Caution

The signature rivet component from Charlie's LaTeX template features a top badge flanked by two circular metallic rivet screws on the border line. All semantic variants inherit this layout with tuned colors:

#note(title: "Note:-")[
  The default `#note` card uses Charlie's neutral slate gray border and soft gray card background.
]

#tip(title: "Tip:-")[
  Import everything with `#import "prelude.typ": *`. You can use `#clist[...]` or `#set enum(numbering: circled-num)` to automatically format numbered lists with circled badges and zero duplicate numbers.
]

#info(title: "Info:-")[
  The Table of Contents entries are fully clickable hyperlinks. Click any chapter or section line to navigate directly to it in your PDF viewer.
]

#warning(title: "Warning:-")[
  Always ensure that the scalar field $bbF$ is algebraically closed when looking for eigenvalues of arbitrary linear operators.
]

#caution(title: "Caution:-")[
  Dividing by a zero determinant matrix is undefined. Ensure $det(A) != 0$ before computing inverses.
]

= Generic Components, Code & Themes

== Blockquotes, Epigraphs and Pull Quotes

#blockquote(
  title: "The Art of Writing Systems",
  author: "Donald E. Knuth",
  source: "The TeXbook",
)[
  Science is what we understand well enough to explain to a computer. Art is everything else we do. If we want to build lasting documents, typography and structure must work in harmony.
]

#quote-box(
  author: "Richard Feynman",
  source: "The Character of Physical Law",
)[
  Nature uses only the longest threads to weave her patterns, so each small piece of her fabric reveals the organization of the entire tapestry.
]

#epigraph(author: "Euclid", source: "Elements")[
  There is no royal road to geometry.
]

== Code Listings and Shell Consoles

#codeblock(
  title: "linear_map.py",
  lang: "python",
  line-numbers: true,
  "import numpy as np

def rank_nullity(A: np.ndarray) -> tuple[int, int]:
    \"\"\"Compute rank and nullity of matrix A satisfying rank-nullity theorem.\"\"\"
    n = A.shape[1]
    rank = np.linalg.matrix_rank(A)
    nullity = n - rank
    return rank, nullity",
)

#plaincodeblock(
  "// Plain code snippet without line numbers
const double EPSILON = 1e-9;",
)

#consoleblock(
  title: "bash - compilation workflow",
  cmd: "make build\nmake dark\nmake previews",
  output: [✓ Light & dark PDFs compiled successfully in 72ms],
)

Inline code example: #codeinline[rank_nullity(A)].

== Universal Admonition Callouts

#callout(
  type: "info",
  style: "left-bar",
  title: "Info Callout",
)[
  A left-bar callout using muted steel-blue tones.
]

#callout(
  type: "tip",
  style: "badge",
  title: "Tip Callout",
  tag: "Modular",
)[
  A badge callout with an attached colored tab.
]

#callout(
  type: "warning",
  style: "ribbon",
  title: "Warning Callout",
)[
  A ribbon callout spanning across the top of the box.
]

== Native Dark Mode

Configure `#show: document-template.with(theme: "dark")` or use the Makefile target `make dark` to produce publication-grade dark documents.

#block(
  fill: rgb("#16181d"),
  inset: 14pt,
  radius: 3pt,
  stroke: 1pt + rgb("#2e3440"),
  {
    set text(fill: rgb("#d1d5db"))

    text(weight: "bold", size: 10.5pt, fill: rgb("#7da2c6"))[Dark Mode Preview]
    v(4pt)

    definition(
      title: "Inner Product Space",
      tag: "6.1 in the book",
      theme: "dark",
    )[
      An inner product on $V$ is a function assigning each pair of vectors $(u, v)$ a scalar $inner(u, v) in bbF$ satisfying positivity, definiteness, additivity, and conjugate symmetry.
    ]

    note(
      title: "Note:-",
      theme: "dark",
    )[
      In dark mode, the rivet card maintains subtle contrast without glowing or oversaturated colors.
    ]
  },
)

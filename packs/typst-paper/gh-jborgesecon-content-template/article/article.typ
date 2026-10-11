#import "mathphil.typ": *
#import "@preview/subpar:0.2.1"
#import "assets/equations/e.typ": eq-e
#import "assets/equations/var.typ": eq-var

#show: mathphil-article.with(
  title: "On the Expressive Limits of Formal Truth Predicates",
  short-title: "Expressive Limits of Truth Predicates",
  short-authors: "Doe",
  authors: (
    (
      name: "Alex Doe",
      affiliation: "Munich Center for Mathematical Philosophy",
      email: "alex.doe@lmu.de",
    ),
  ),
  abstract: [
    We re-evaluate the axiomatic theories of truth extending Peano Arithmetic. By
    restricting reflection principles to grounded syntactic formulae, we preserve
    classical logic while resisting Tarskian semantic hierarchies.
  ],
  keywords: ("Axiomatic Truth", "Kripke-Feferman", "Incompleteness", "Model Theory"),
  msc: "03C90, 03B42",
)

= Introduction

Formal theories of truth face classical diagonal limits, as originally formulated by
#cite(<tarski1936>, form: "prose"). A recurrent difficulty concerns whether typed
semantic structures are mandatory to avoid paradox @halbach2014.

= Formal preliminaries

Let $cal(L)$ denote the first-order language of arithmetic, and let $cal(L)_T = cal(L) union {T}$
be the extension obtained by adding a unary truth predicate $T(x)$.

#definition(title: "Arithmetical Coding")[
  For any formula $phi in cal(L)_T$, let $corner(phi)$ denote its canonical Gödel number
  under a fixed primitive recursive coding scheme.
]

The standard axiomatization over Peano Arithmetic ($sans("PA")$) requires compositional
truth clauses:

$ sans("PA") tack.rr T(corner(phi and psi)) <==> T(corner(phi)) and T(corner(psi)). $

#theorem(title: "Semantic Triviality")[
  If a theory $Sigma supset sans("PA")$ satisfies unrestricted capture and release:
  $ Sigma tack phi <==> T(corner(phi)), $
  then $Sigma$ is inconsistent under classical logic.
]

#proof[
  By the diagonal lemma, construct a sentence $lambda$ such that
  $sans("PA") tack lambda <==> not T(corner(lambda))$.
  Applying release yields $Sigma tack lambda arrow not lambda$, from which
  $Sigma tack bot$ follows by reductio.
]

= Applications

To demonstrate further analytical and empirical extensions, we examine the following components:
- The asymptotic formulation of the natural exponential base $e$ via infinitesimal change of variables.
- Dynamic modeling using a Vector Autoregressive ($sans("VAR")$) framework.
- Comparative analysis of bivariate distributions under varying correlation regimes.

The natural exponential base $e$ can be defined asymptotically. Setting $k = 1/n$, as $n -> oo$, we have $k -> 0$:

#eq-e

Furthermore, a Vector Autoregressive ($sans("VAR")$) model of order $p$ is specified as:

#eq-var

Finally, following the bivariate normal comparison in @subfigures, @a illustrates the case where $rho = 1$ while @b presents the uncorrelated case where $rho = 0$:

#subpar.grid(
  figure(
    image("assets/images/plot2a.pdf", width: 85%),
    caption: [Bivariate Normal with $rho = 1$],
  ),
  <a>,
  figure(
    image("assets/images/plot2b.pdf", width: 85%),
    caption: [Bivariate Normal with $rho = 0$],
  ),
  <b>,
  columns: (1fr, 1fr),
  caption: [Adding subfigures],
  label: <subfigures>,
)

#bibliography("references.bib")

#import "../lib.typ": paper, nneq, caption-note, caption-with-note, table-note, theorem, proof, prop, lem, asp

#show: doc => paper(
  title: [Your Paper Title],
  subtitle: [A Subtitle],
  authors: (
    (name: [Author One], affiliation: [University A]),
    (name: [Author Two], affiliation: [University B]),
  ),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  abstract: [
    This is a template for academic papers using the r2 Typst style.
    It includes numbered equations, theorem environments, APSA-style
    bibliography, and sensible defaults for social science manuscripts.
  ],
  doc,
)

= Introduction

Start writing here. Equations are numbered automatically:

$ y_(i t) = alpha_i + delta_t + beta D_(i t) + epsilon_(i t) $ <eq:did>

Reference them with `@eq:did`: see @eq:did.

Unnumbered equations use `nneq`:

#nneq[$E[y | D = 1] - E[y | D = 0] = "ATT" + "bias"$]

= Theory

Use theorem environments for formal results:

#asp[
  Players are risk-neutral and share a common discount factor $delta in (0, 1)$.
]

#prop[
  Under Assumption 1, there exists a unique equilibrium in which the
  challenger mobilizes if and only if $theta > theta^*$.
]

#proof[
  The proof follows from backward induction.
]

= Results

#figure(
  block(width: 100%)[#set text(size: 0.8em)
    #table(
      columns: (1fr, 1fr, 1fr, 1fr),
      align: (left, center, center, center),
      stroke: none,
      table.hline(stroke: 0.8pt),
      table.header[][*(1)*][*(2)*][*(3)*],
      table.hline(stroke: 0.4pt),
      [Treatment],        [0.234\*\*\*], [0.198\*\*],   [0.211\*\*\*],
      [],                 [(0.045)],     [(0.062)],     [(0.048)],
      [Log(Population)],  [],            [0.087\*],     [0.092\*\*],
      [],                 [],            [(0.041)],     [(0.039)],
      [Income per capita], [],           [],            [$-$0.003],
      [],                 [],            [],            [(0.011)],
      table.hline(stroke: 0.4pt),
      [Unit FE],          [Yes],         [Yes],         [Yes],
      [Year FE],          [Yes],         [Yes],         [Yes],
      [Observations],     [2,450],       [2,450],       [2,450],
      [$R^2$],            [0.423],       [0.431],       [0.433],
      table.hline(stroke: 0.8pt),
    )
  ],
  caption: caption-with-note(
    [Treatment Increases Organizational Growth],
    [Unit of observation is region-year. Standard errors clustered at the unit level in parentheses. \* $p < 0.10$, \*\* $p < 0.05$, \*\*\* $p < 0.01$.]
  ),
) <tab:main>

= Conclusion

Wrap up here.

#heading(outlined: false, numbering: none, level: 1)[References]

#bibliography(
  "ref.bib",
  style: "american-political-science-association",
  title: none
)

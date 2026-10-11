#import "oup-template.typ": *

#show: oup-template.with(
  journal-title:  "Journal Title Here",
  doi:            "https://doi.org/10.1093/xxx/xxxxx",
  copyright-year: "2025",
  pub-year:       "2025",
  vol:            "XX",
  issue:          "x",
  access:         "Published: Date added during production",
  app-notes:      "Paper",
  first-page:     "1",
  title:          [Article Title],
  short-title:    [Short Article Title],
  authors: (
    (name: "First Author",  affil: ("1", "*"), orcid: none),
    (name: "Second Author", affil: ("2"),      orcid: none),
    (name: "Third Author",  affil: ("3"),      orcid: none),
    (name: "Fifth Author",  affil: ("4"),      orcid: "0000-0000-0000-0000"),
  ),
  abstract: [
    Check the journal's online author guidelines for guidance on requirements
    for the abstract and other components of the submitted manuscript.
    Abstracts must be able to stand alone and so cannot contain citations to
    the paper's references, equations, etc.
  ],
  keywords:      ("keyword1", "keyword2", "keyword3", "keyword4"),
  abbreviations: ("abbreviation1", "abbreviation2", "abbreviation3"),
  other-abstracts: (
    (
      title:   "Graphical Abstract",
      content: rect(width: 100%, height: 50pt, fill: rgb("#cccccc"), stroke: 0.5pt + gray)
    ),
  ),
  key-messages-content: [
    - Key message here.
    - Key message here.
    - Key message here.
  ],
  show-toc: true,
  style:    "contemporary",
)

= Introduction

The introduction introduces the context and summarizes the manuscript @bahdanau2014neural.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.

This is an example with a footnote#footnote[https://www.academic.oup.com/] and another.#footnote[Example footnote text.]

= First Level Head <sec2>

Lorem ipsum dolor sit amet (refer @sec5) @krizhevsky2012imagenet @lecun2015deep.

== Second Level Head <subsec1>

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

=== Third Level Head <subsubsec1>

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

==== Fourth Level Head

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

= Equations <sec4>

Inline: $H psi = E psi$.

$ norm(tilde(X)(k))^2 <= (
    sum_(i=1)^p norm(tilde(Y)_i (k))^2 +
    sum_(j=1)^q norm(tilde(Z)_j (k))^2
  ) / (p+q) $ <eq1>

$ D_mu &= partial_mu - i g lambda^a / 2 A^a_mu \
  F^a_(mu nu) &= partial_mu A^a_nu - partial_nu A^a_mu + g f^(a b c) A^b_mu A^a_nu $ <eq2>

$ Y_infinity = (m / "GeV")^(-3) [1 + (3 ln(m\/"GeV")) / 15 + ln(c_2\/5) / 15] $

= Tables <sec5>

See @tab1 and @tab2.

#figure(
  stack(
    table(
      columns: 4, stroke: none,
      table.hline(stroke: 1pt),
      [Column 1], [Column 2], [Column 3], [Column 4],
      table.hline(stroke: 0.5pt),
      [row 1], [data 1], [data 2],          [data 3],
      [row 2], [data 4], [data 5#super[a]], [data 6],
      [row 3], [data 7], [data 8],          [data 9#super[b]],
      table.hline(stroke: 1pt),
    ),
    tablenotes[
      Source: Example. \
      #super[a] First footnote. \
      #super[b] Second footnote.
    ]
  ),
  caption: [Caption text],
  kind: table,
) <tab1>


= Figures <sec6>

See @fig1.

#figure(
  rect(width: 100%, height: 60pt, fill: rgb("#cccccc"), stroke: none),
  caption: [This is a figure caption example.],
) <fig1>

= Algorithms and Code <sec7>

#algorithm([Algorithm 1: Calculate $y = x^n$])[
  *Require:* $n >= 0 or x != 0$ \
  *Ensure:* $y = x^n$ \
  1. $y <- 1$ \
  2. *if* $n < 0$: $X <- 1\/x$, $N <- -n$ else $X <- x$, $N <- n$ \
  3. *while* $N != 0$: update $X$, $N$, $y$ \
  4. *return* $y$
]

#figure(
  rect(width: 100%, height: 80pt, fill: rgb("#cccccc"), stroke: none),
  caption: [Replace with your code figure or image.],
) <fig2>

= Cross Referencing <sec8>

See @fig1, @eq1, @tab1.

== Reference Citations <subsec3>

Citations: @bahdanau2014neural. Multiple: @krizhevsky2012imagenet @lecun2015deep.

= Lists <sec9>

+ First item.
+ Second item.
  + Sub-item.
- Bullet item.
- Another bullet.

= Theorem Environments <sec10>

#theorem(name: "Theorem subhead")[
  Example theorem text. Example theorem text.
]

#proposition[Example proposition text.]

#example[Example text here.]

#remark[Remark text here.]

#definition(name: "Definition sub head")[Example definition text.]

#proof[Example proof text.]

#blockquote[Quoted text example. Aliquam porttitor quam a lacus.]


#figure(
  stack(
    table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      stroke: none,
      inset: (x: 5pt, y: 4pt),
      // Top rule
      table.hline(stroke: 1pt),
      // Header row 1: blank + Element 1 (3 cols) + Element 2 (3 cols)
      [],
      table.cell(colspan: 3, align: center)[Element 1#super[1]],
      table.cell(colspan: 3, align: center)[Element 2#super[2]],
      // Sub-rules under Element 1 and Element 2 groups
      table.hline(start: 1, end: 4, stroke: 0.5pt),
      table.hline(start: 4, end: 7, stroke: 0.5pt),
      // Header row 2: column labels
      [Project],
      [Energy], [$sigma_"calc"$], [$sigma_"expt"$],
      [Energy], [$sigma_"calc"$], [$sigma_"expt"$],
      // Mid rule
      table.hline(stroke: 0.5pt),
      // Data rows
      [Element 3], [990 A], [1168], [$1547 plus.minus 12$], [780 A], [1166], [$1239 plus.minus 100$],
      [Element 4], [500 A], [961],  [$922 plus.minus 10$],  [900 A], [1268], [$1092 plus.minus 40$],
      // Bottom rule
      table.hline(stroke: 1pt),
    ),
    tablenotes[
      Note: This is an example of table footnote this is an example of table footnote this is an example of table footnote this is an example of table footnote this is an example of table footnote \
      #super[1] Example for a first table footnote. \
      #super[2] Example for a second table footnote.
    ]
  ),
  caption: [Example of a lengthy table which is set to full textwidth.],
  kind: table,
  placement: top,
  scope: "parent",
) <tab2>

#figure(
  rect(width: 100%, height: 80pt, fill: rgb("#cccccc"), stroke: none),
  caption: [Replace with your figure.],
  placement: top,
  scope: "parent",
) <fig3>


= Conclusion

Some conclusions here.

= Conflicts of Interest

The authors declare that they have no competing interests.

= Funding

Supported by National Funding Body (NFB: \#XXXXXXX).

= Data Availability

Data available at [repository] at [URL].

= Author Contributions Statement

S.R. and D.A. conceived the experiment(s) and wrote the manuscript.

= Acknowledgments

The authors thank the anonymous reviewers for their valuable suggestions.

#set heading(numbering: "A.")
#counter(heading).update(0)

= Section Title of First Appendix <sec11>

Nam dui ligula, fringilla a, euismod sodales. Morbi auctor lorem non justo.

== Subsection of First Appendix

Nam dui ligula, fringilla a, euismod sodales.

= Section Title of Second Appendix <sec12>

Fusce mauris. Vestibulum luctus nibh at lectus.

$ p &= (gamma^2 - (n_C - 1) H) / ((n_C - 1) + H - 2 gamma) \
  theta &= ((gamma - H)^2 (gamma - n_C - 1)^2) / (n_C - 1 + H - 2 gamma)^2 $

#set page(columns: 1)
#bibliography("reference.bib", title: "References", style: "apa")

// ============================================================
// Example manuscript — OUP Bioinformatics Typst Template
// Mirrors the demo content from the official OUP LaTeX template
// ============================================================

#import "oup-bioinformatics-template.typ": *

#show: oup-article.with(
  journal-title:  "Bioinformatics",
  doi:            "10.1093/bioinformatics/XXXXXXX",
  pub-year:       "2025",
  volume:         "41",
  issue:          "1",
  pages:          "1–10",
  article-type:   "Paper",

  title:       [Article Title],
  short-title: "Short Article Title",
  // subtitle: [Subject Section],

  authors: (
    (name: "First Author",  affil: (1,), corr: true),
    (name: "Second Author", affil: (2,)),
    (name: "Third Author",  affil: (3,)),
    (name: "Fourth Author", affil: (3,)),
    (name: "Fifth Author",  affil: (4,), orcid: "0000-0000-0000-0000"),
  ),

  affiliations: (
    (id: 1, dept: "Department", org: "Organization",
     address: "Street, Postcode, State, Country"),
    (id: 2, dept: "Department", org: "Organization",
     address: "Street, Postcode, State, Country"),
    (id: 3, dept: "Department", org: "Organization",
     address: "Street, Postcode, State, Country"),
    (id: 4, dept: "Department", org: "Organization",
     address: "Street, Postcode, State, Country"),
  ),

  corr-author: [email-id.com],

  received: "Date Month Year",
  revised:  "Date Month Year",
  accepted: "Date Month Year",

  abstract: [Check the journal's online author guidelines for guidance on requirements
  for the abstract and other components of the submitted manuscript.
  Abstracts must be able to stand alone and so cannot contain citations to
  the paper's references, equations, etc. An abstract must consist of a single
  paragraph and be concise. Because of online formatting, abstracts must appear
  as plain as possible.],

  // Structured abstract alternative (comment out plain abstract above):
  // abstract-structured: (
  //   Motivation: [Why this work matters.],
  //   Results:    [What you found.],
  //   Availability: [Code at #link("https://github.com/example")[github.com/example].],
  //   Contact:    [email\@institution.edu],
  // ),

  keywords: ("keyword1", "keyword2", "keyword3", "keyword4"),
  abbreviations: ("abbreviation1", "abbreviation2", "abbreviation3", "abbreviation4"),

  additional-abstract: [Use this element for elements such as Graphical abstract, Lay summary,
  Translated abstract etc. Que cum aut etum qui ium dolupta ssequia autati odis
  demporepe ad et es alit rem repudaerae min et volorum re volupta nobit volectur aut fuga.],

  // graphical-abstract: image("graphical-abstract.png", width: 80%),

  key-messages: [
    - Key boxed text here.
    - Key boxed text here.
    - Key boxed text here.
  ],

  bibliography-file:  "references.bib",
  bibliography-style: "vancouver",

  biographies: (
    (name: "Author Name.", bio: [This is sample author biography text. The values provided in the optional argument are meant for sample purposes. There is no need to include the width and height of an image in the optional argument for live articles. This is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text.]),
    (name: "Author Name.", bio: [This is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text this is sample author biography text.]),
  ),
)


// ── Introduction ─────────────────────────────────────────────
= Introduction

The introduction introduces the context and summarizes the manuscript. It is importantly to clearly state the contributions of this piece of work. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

This is an example of a new paragraph with a numbered footnote#footnote[#link("https://www.academic.oup.com/")] and a second footnote marker.#footnote[Example of footnote text.]


= This is an example for first level head - section head <sec2>

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. 

== This is an example for second level head - subsection head

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

=== This is an example for third level head - subsubsection head

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

==== This is an example for fourth level head - paragraph head

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

===== This is an example for fifth level head - subparagraph head

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


= This is an example for first level head

== This is an example for second level head - subsection head

=== This is an example for third level head - subsubsection head

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

=== Level three heading

==== Level four heading

===== Level five heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


= Equations

Equations in Typst can either be inline or set as display equations. For inline equations use the `$...$` commands. Eg: the equation $H psi = E psi$ is written via the command `$H psi = E psi$`.

For display equations (with auto generated equation numbers) one can use the equation or align environments:

$
  ||tilde(X)(k)||^2 <= frac(
    sum_(i=1)^p ||tilde(Y)_i (k)||^2 + sum_(j=1)^q ||tilde(Z)_j (k)||^2,
    p + q),
$ <eq1>

where,
$
  D_mu &= partial_mu - i g frac(lambda^a, 2) A^a_mu \
  F^a_(mu nu) &= partial_mu A^a_nu - partial_nu A^a_mu + g f^(a b c) A^b_mu A^a_nu .
$ <eq2>

$
  Y_infinity = lr((frac(m, "GeV")))^(-3)
    lr([1 + frac(3 ln(m \/ "GeV"), 15) + frac(ln(c_2 \/ 5), 15)]) .
$

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


= Tables <sec5>

Tables can be inserted via the normal table and tabular environment. To put footnotes inside tables one has to Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. use the additional "tablenotes" environment enclosing the tabular environment. The footnote appears just below the table itself (refer @tab1 and @tab2).

#figure(
  caption: [Caption text],
  table(
    columns: 4,
    table.header([column 1], [column 2], [column 3], [column 4]),
    [row 1], [data 1], [data 2],          [data 3],
    [row 2], [data 4], [data 5#super[1]], [data 6],
    [row 3], [data 7], [data 8],          [data 9#super[2]],
  )
) <tab1>
#block[
  #set text(size: 8pt)
  Source: This is an example of table footnote this is an example of table footnote this is an example of table footnote this is an example of table footnote this is an example of table footnote \
  #super[1]Example for a first table footnote. \
  #super[2]Example for a second table footnote.
]

#figure(
  placement: top,
  scope: "parent",
  caption: [Example of a lengthy table which is set to full textwidth.],
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    table.header(
      [], table.cell(colspan: 3)[Element 1#super[1]],
              table.cell(colspan: 3)[Element 2#super[2]],
      [Project], [Energy], [$sigma_"calc"$], [$sigma_"expt"$],
                 [Energy], [$sigma_"calc"$], [$sigma_"expt"$],
    ),
    [Element 3],[990 A],[1168],[$1547 plus.minus 12$],[780 A],[1166],[$1239 plus.minus 100$],
    [Element 4],[500 A],[961], [$922 plus.minus 10$], [900 A],[1268],[$1092 plus.minus 40$],
  )
) <tab2>


= Figures

Figures are inserted using the standard `figure` environment. For single-column figures use `figure(...)` as usual; for full-width figures use `placement: top, scope: "parent"`.

#figure(
  placement: top,
  scope: "parent",
  rect(width: 100%, height: 50pt, fill: rgb("#DDDDDD")),
  caption: [This is a widefig. This is an example of a long caption this is an example of a long caption this is an example of a long caption this is an example of a long caption],
) <fig1>

#figure(
  rect(width: 100%, height: 40pt, fill: rgb("#CCCCCC")),
  caption: [This is a widefig. This is an example of a long caption this is an example of a long caption this is an example of a long caption this is an example of a long caption],
) <fig2>


= Algorithms, Program Codes and Listings

#algorithm(caption: [Calculate $y = x^n$])[
  *Require:* $n >= 0 or x != 0$ \
  *Ensure:* $y = x^n$ \
  1: $y arrow.l 1$ \
  2: *if* $n < 0$ *then* \
  3: #h(1em) $X arrow.l 1\/x$ \
  4: #h(1em) $N arrow.l -n$ \
  5: *else* \
  6: #h(1em) $X arrow.l x$ \
  7: #h(1em) $N arrow.l n$ \
  8: *end if* \
  9: *while* $N != 0$ *do* \
  10: #h(1em) *if* $N$ is even *then* \
  11: #h(2em) $X arrow.l X times X$ \
  12: #h(2em) $N arrow.l N\/2$ \
  13: #h(1em) *else*[$N$ is odd] \
  14: #h(2em) $y arrow.l y times X$ \
  15: #h(2em) $N arrow.l N - 1$ \
  16: #h(1em) *end if* \
  17: *end while*
]

```pascal
fo r i :=maxint to 0 do
begin
  { do n o t h i ng }
end;
Write( ' Case i n s e n s i t i v e ' ) ;
Write( ' P a s c al keywords . ' ) ;
```


= Cross referencing

Environments such as figure, table, equation, and align can have a label declared via the `<label>` syntax. One can then use the `@label` command to cross-reference them. As an example, consider @fig1, @tab1, @eq1.

== Details on reference citations

With the vancouver bibliography style (default), numbered citations are produced: @rahman2019centroidb. Another example: @bahdanau2014neural @imboden2018cardiorespiratory @motiian2017unified @murphy2012machine @ji20123d. Sample cites @krizhevsky2012imagenet @horvath2018dna and @pyrkov2018quantitative, @wang2018face, @lecun2015deep @zhang2018fine @ravi2016deep.


= Lists

List in Typst can be of three types: numbered, bulleted and unnumbered.

+ This is the 1st item
+ Enumerate creates numbered lists, itemize creates bulleted lists and unnumerate creates unnumbered lists.
  + Second level numbered list. Enumerate creates numbered lists, itemize creates bulleted lists and description creates unnumbered lists.
  + Second level numbered list. Enumerate creates numbered lists, itemize creates bulleted lists and description creates unnumbered lists.
    + Third level numbered list.
    + Third level numbered list.
  + Second level numbered list.
  + Second level numbered list.
+ Enumerate creates numbered lists, itemize creates bulleted lists and description creates unnumbered lists.
+ Numbered lists continue.

Lists in Typst can also be bulleted:

- First level bulleted list. This is the 1st item
- First level bulleted list. Itemize creates bulleted lists and description creates unnumbered lists.
  - Second level dashed list. Itemize creates bulleted lists and description creates unnumbered lists.
  - Second level dashed list.
  - Second level dashed list.
- First level bulleted list.
- First level bulleted list. Bullet lists continue.

Example for unnumbered list items:

#list(marker: [],
  [Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text.],
  [Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text.],
  [sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text. Sample unnumberd list text.],
)


= Examples for theorem-like environments

For theorem-like environments, we require the amsthm package. There are three types of predefined theorem styles.

#theorem(subhead: "Theorem subhead")[Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text. Example theorem text.]

Quisque ullamcorper placerat ipsum. Cras nibh. Morbi vel justo vitae lacus tincidunt ultrices. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In hac habitasse platea dictumst. Integer tempus convallis augue.

#proposition[Example proposition text. Example proposition text. Example proposition text. Example proposition text. Example proposition text. Example proposition text. Example proposition text. Example proposition text. Example proposition text. Example proposition text.]

Nulla malesuada porttitor diam. Donec felis erat, congue non, volutpat at, tincidunt tristique, libero. Vivamus viverra fermentum felis. Donec nonummy pellentesque ante.

#example[Phasellus adipiscing semper elit. Proin fermentum massa ac quam. Sed diam turpis, molestie vitae, placerat a, molestie nec, leo. Maecenas lacinia. Nam ipsum ligula, eleifend at, accumsan nec, suscipit a, ipsum. Morbi blandit ligula feugiat magna. Nunc eleifend consequat lorem.]

Nulla malesuada porttitor diam. Donec felis erat, congue non, volutpat at, tincidunt tristique, libero.

#remark[Phasellus adipiscing semper elit. Proin fermentum massa ac quam. Sed diam turpis, molestie vitae, placerat a, molestie nec, leo. Maecenas lacinia. Nam ipsum ligula, eleifend at, accumsan nec, suscipit a, ipsum. Morbi blandit ligula feugiat magna. Nunc eleifend consequat lorem.]

Quisque ullamcorper placerat ipsum. Cras nibh. Morbi vel justo vitae lacus tincidunt ultrices.

#definition(subhead: "Definition sub head")[Example definition text. Example definition text. Example definition text. Example definition text. Example definition text. Example definition text. Example definition text. Example definition text.]

Apart from the above styles, we have the proof environment — with the proof head in italic style and the body text in roman font with an open square at the end.

#proof[Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text.]

Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo.

#proof(of: [Theorem 1])[Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text. Example for proof text.]

For a quote environment:

#block-quote[Quoted text example. Aliquam porttitor quam a lacus. Praesent vel arcu ut tortor cursus volutpat. In vitae pede quis diam bibendum placerat. Fusce elementum convallis neque. Sed dolor orci, scelerisque ac, dapibus nec, ultricies ut, mi. Duis nec dui quis leo sagittis commodo.]

Donec congue. Maecenas urna mi, suscipit in, placerat ut, vestibulum ut, massa.


= Conclusion

Some Conclusions here.


// ── Back matter ─────────────────────────────────────────────
#competing-interests[
  The authors declare that they have no competing interests.
]

#funding[
  This work is supported in part by funds from the National Funding Body (NFB: \# XXXXXXX and \# YYYYYYY).
]

#data-availability[
  The data underlying this article are available in the GenBank Nucleotide Database at https://example.com, and can be accessed with accession number XXXX.
]

#author-contributions[
  Must include all authors, identified by initials, for example: S.R. and D.A. conceived the experiment(s), S.R. conducted the experiment(s), S.R. and D.A. analysed the results. S.R. and D.A. wrote and reviewed the manuscript.
]

#acknowledgements[
  The authors thank the anonymous reviewers for their valuable suggestions. This work is supported in part by funds from the National Science Foundation (NSF: \# 1636933 and \# 1920920).
]


// ── Appendices ───────────────────────────────────────────────
#appendix[

= Section title of first appendix <sec11>

Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae, ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla.

== Subsection title of first appendix

Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo.

=== Subsubsection title of first appendix <subsubsec3>

Example for an unnumbered figure:

#figure(
  rect(width: 80pt, height: 80pt, fill: rgb("#CCCCCC")),
  caption: none, numbering: none,
)

Fusce mauris. Vestibulum luctus nibh at lectus. Sed bibendum, nulla a faucibus semper, leo velit ultricies tellus, ac venenatis arcu wisi vel nisl.

= Section title of second appendix

Fusce mauris. Vestibulum luctus nibh at lectus. Sed bibendum, nulla a faucibus semper, leo velit ultricies tellus, ac venenatis arcu wisi vel nisl.

#figure(
  rect(width: 100%, height: 70pt, fill: rgb("#BBBBBB")),
  caption: [This is an example for appendix figure],
) <fig4>

#figure(
  caption: [This is an example of Appendix table showing food requirements of army, navy and airforce],
  table(
    columns: 3,
    table.header([col1 head], [col2 head], [col3 head]),
    [col1 text], [col2 text], [col3 text],
    [col1 text], [col2 text], [col3 text],
    [col1 text], [col2 text], [col3 text],
  )
) <tab4>

== Subsection title of second appendix

Sed commodo posuere pede. Mauris ut est. Ut quis purus. Sed ac odio. Sed vehicula hendrerit sem.

=== Subsubsection title of second appendix <subsubsec4>

Example for an equation inside the appendix:

$
  p &= frac(gamma^2 - (n_C - 1)H, (n_C - 1) + H - 2 gamma) , \
  theta &= frac((gamma - H)^2 (gamma - n_C - 1)^2, (n_C - 1 + H - 2 gamma)^2) .
$

= Example of another appendix section

Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi.

$
  cal(L) = i overline(psi) gamma^mu D_mu psi
    - frac(1, 4) F_(mu nu)^a F^(a mu nu) - m overline(psi) psi .
$

]

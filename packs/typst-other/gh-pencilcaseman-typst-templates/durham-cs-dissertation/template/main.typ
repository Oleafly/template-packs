#import "../lib.typ": *

#show: durham_cs_dissertation.with(
  title: [Formatting Template for the L3 CS Project Paper],
  student: "A.N. Other",
  supervisor: "Y.A.A.N. Other",
  degree: [Submitted as part of the degree of BSc Computer Science to the Board of Examiners in the Department of Computer Science, Durham University],
  abstract: [
    These instructions give you guidelines for preparing your project report. DO
    NOT change any settings, such as margins and font sizes. Just use this as a
    template and modify the contents into your final paper. An abstract should be
    100 to 200 words, and should clearly state the nature and significance of the
    paper. Abstracts must not include mathematical expressions or bibliographic
    references. Please note that abstracts are formatted as left justified in our
    editing template (as shown here).
  ],
  keywords: (
    "component",
    "formatting",
    "insert",
    "style",
  ),
  bibliography: bibliography("refs.bib"),
)

= Introduction <sec:introduction>

#ieee_par_start("T", "his")[
  section briefly introduces the general project background, the research
  question you are addressing, and the project objectives. It should be around 2
  pages in length. Do not change the font sizes or line spacing in order to put
  in more text.
]

Note that the whole report, _excluding_ the references, should not be longer
than 16 pages in length. It should be noted that not all the details of the work
carried out in the project can be represented in 16 pages. You may attach an
appendix to the end of your report which will not be marked but provides the
markers with additional reference material and context. References to Web based
pages should be less than 10% of the total reference count.

= Related Work

This section presents a survey of existing work on the problems that this
project addresses. It should be between 2 to 3 pages in length. The rest of this
section shows the formats of subsections as well as some general formatting
information for tables, figures, references and equations.

== Main Text

The font used for the main text should be Palatino and the font size should be
9.5. The first line of all paragraphs should be indented, except for the first
paragraph of each section, subsection, subsubsection etc. (the paragraph
immediately after the header) where no indentation is needed.

== Figures and Tables

In general, figures and tables should not appear before they are cited. Place
figure captions below the figures; place table titles above the tables. If your
figure has two parts, for example, include the labels "(a)" and "(b)" as part of
the artwork. Please verify that figures and tables you mention in the text
actually exist. Make sure that all tables and figures are numbered as shown in
@table_example and @fig:example below.

#figure(
  scope: "column",
  placement: none,
  rect(width: 2.5in, height: 1.5in, stroke: 0.5pt)[
    #align(center + horizon)[_Example Figure_]
  ],
  caption: [Magnetization as a function of applied field. There is a period after the figure number, followed by a space. It is good practice to explain the significance of the figure in the caption.],
) <fig:example>

== References

The list of cited references should appear at the end of the report, listed by
order of appearance in the paper. The required style is to note citations in
individual brackets, followed by a comma, e.g. "@IEEEhowto:bridle,
@IEEEhowto:chen" (as opposed to the more common combined form). Citation ranges
should be formatted as individual entries. When citing a section in a book,
please give the relevant page numbers. In sentences, refer simply to the
reference number. Do not use "Ref." or "reference" at the beginning of a
sentence; use the author names instead.

= Methodology

This section presents the solutions to the problems in detail. The design and
implementation details should all be placed in this section. You may create a
number of sub-sections, each focusing on one issue.

This section should be between 4 to 6 pages in length.

#figure(
  kind: table,
  placement: top,
  caption: [Summary of Page Lengths for Sections],
  table(
    columns: (auto, auto),
    align: (left, center),
    inset: (x: 12pt, y: 5pt),
    stroke: none,
    table.hline(stroke: 0.8pt),
    table.hline(stroke: 0.8pt),
    table.header[*Section*][*Number of Pages*],
    table.hline(stroke: 0.5pt),
    [I. Introduction], [2],
    [II. Related Work], [2--3],
    [III. Methodology], [4--6],
    [IV. Results], [2],
    [V. Evaluation], [1--2],
    [VI. Conclusion], [1],
    table.hline(stroke: 0.8pt),
  ),
) <table_example>

An example equation:

$ E = m c^2 $ <eq:einstein>

As shown in @eq:einstein, the relationship between energy and mass is
fundamental to modern physics.

=== Implementation Details

This is a subsubsection demonstrating the third heading level.

#lorem(40)

= Results

This section presents the results of the solutions. It should include
information on experimental settings. The results should demonstrate the claimed
benefits or disadvantages of the proposed solutions.

This section should be around 2 pages in length.

#lorem(80)

= Evaluation

This section should be between 1 to 2 pages in length.

#lorem(60)

= Conclusion

This section summarises the main points of this paper. Do not replicate the
abstract as the conclusion. A conclusion might elaborate on the importance of the
work or suggest applications and extensions. This section should be no more than
1 page in length.

#lorem(40)

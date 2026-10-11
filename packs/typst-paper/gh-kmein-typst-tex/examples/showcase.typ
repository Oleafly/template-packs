// A document exercising every feature the template supports. Its LaTeX twin is
// tests/reference/showcase.tex; `tools/compare.sh showcase` diffs the two.
#import "../src/lib.typ": article

#show: article.with(
  title: [A Metrically Exact Article],
  authors: ([Kieran Meinhardt],),
  date: [September 5, 2026],
  paper: "a4",
  size: "10",
  abstract: [
    Page geometry, baseline grid, fonts and sectioning are taken from the class
    files themselves, and checked against real output.
  ],
)

= Running text

Body text is set in Computer Modern at ten points on a twelve point baseline
grid.#footnote[The footnote rule and type size come from the class files too.]

== Lists

The itemize and enumerate environments use the class's own list parameters:

- The item body sits two and a half ems in.
- Labels are set flush right, ending half an em earlier.

+ Items are separated by itemsep plus parsep.
+ The list is surrounded by topsep plus partopsep.

=== Displayed material

A displayed equation gets the class's display skips:
$ e^(i pi) + 1 = 0 $
and the text after it stays on the grid.

==== Run-in headings
These are set with a negative afterskip, so the
heading runs into the paragraph rather than standing on its own line.

= Floats

#figure(
  rect(width: 4cm, height: 1.4cm, fill: black, stroke: none),
  caption: [A caption short enough to be centred.],
  placement: none,
)

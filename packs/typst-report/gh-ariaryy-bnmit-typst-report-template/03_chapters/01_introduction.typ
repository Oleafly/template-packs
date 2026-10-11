// Compile main.typ, not this file: on its own a chapter has no cover,
// contents, page numbers or styling.

= Introduction

This chapter doubles as a cheat sheet. Delete everything below and write your
own; the examples show every construct the template styles for you.

#lorem(60)

== Writing sections

A level-2 heading numbers itself `1.1` and appears in the table of contents. A
level-3 heading numbers itself `1.1.1` and does not, which keeps the contents
page to two levels.

#lorem(50)

=== Subsections

The first paragraph after a heading is flush left. Every paragraph after it is
indented, the same way Word's built-in heading styles behave.

#lorem(60)

==== Sub-subsections

Level 4 is the last level the template styles: same size as body text, bold and
italic, since headings are never set smaller than the text they introduce.

== Figures

Put your images in `report-images/` and refer to them with an absolute path.
Figures number themselves per chapter and the caption sits below.

#figure(
  image("../template-images/bnmit.png", width: 40%),
  caption: [The college logo, standing in for a real figure],
) <fig-logo>

Refer to a figure by its label: see @fig-logo.

== Tables

Table captions sit above the table, which is the convention the department
expects.

#figure(
  table(
    columns: 3,
    align: left,
    table.header([*Element*], [*Size*], [*Weight*]),
    [Chapter heading], [16 pt], [Bold],
    [Section heading], [14 pt], [Bold],
    [Body text], [12 pt], [Regular],
    [Caption], [10 pt], [Bold],
  ),
  caption: [The type hierarchy this template applies],
) <tab-type>

== Equations

Display equations number themselves per chapter, right aligned.

$ E = m c^2 $ <eq-mass-energy>

== Citations

Add entries to `references.yml`, then cite them by key @vaswani2017. The
reference list builds itself at the end of the report @typst-docs.
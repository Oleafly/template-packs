= Preliminaries <chap-prelims>

#import "../src/lib.typ": definition

A preliminaries chapter is not necessary, but it may be a good idea to use it
for presenting your theoretical/mathematical framework in a more detailed and
technical way than the introduction, and to perhaps establish some basic
lemmata/observations common to multiple chapters of your thesis.

== Some section

Let's define some concept we'll be using throughout the thesis.

#definition[
  The _von Neumann model_ of a computer, also known as the _Princeton
  architecture_, is an architecture for digital computers, which consists of a
  processing unit, containing an ALU and processing registers; a control unit
  consisting of an instruction register and a program counter; a memory unit
  which stores both data and instructions; and input-and-output mechanisms.
]

== Acronyms and abbreviations

Your thesis will typically have a set of significant terms, abbreviations and
acronyms. Technion guidelines mandate that you place a list of these at the
beginning of your thesis; and that they be defined upon first use. And, indeed,
if you followed and read this sample thesis carefully thus far you should have
seen "Notation and Abbreviations" following the abstract.

When writing your thesis, collect such terms and their corresponding
definitions in the structured list in `front/abbreviations.typ`.

In the body of your thesis, your first use of a term will typically be where
you want to also include the text of its definition. You don't need to repeat
the definition you've already entered! Let's explain with an example: You've
defined the term "Do-It-Yourself" beforehand; when using it in Typst, write the
first-use wording in the text and keep the corresponding abbreviation entry in
sync.#footnote[
  The template keeps notation and abbreviations in ordinary Typst data, so the
  list can be rendered consistently in the front matter. At this stage of the
  port, page references are supplied in that data rather than discovered
  automatically.
] This arrangement does several things:

- It keeps the term DIY in the list of Notation and Abbreviations, at the
  beginning of the thesis.
- It gives you a single structured place for the definition text and page
  reference that should be rendered in the front matter.
- It lets the first occurrence in the chapter spell out the definition and add
  the defined term -- DIY -- in parentheses.

In later mentions, only the short form (DIY) should be printed, not the
definition, and no parentheses. This also means that if you move text around in
your thesis you only need to keep the abbreviation data and first-use wording
in sync.

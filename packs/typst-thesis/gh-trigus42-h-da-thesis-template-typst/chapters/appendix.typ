#import "../template.typ": margin-note, thesis-listing, thesis-table

= Introduction to the ClassicThesis style

The ClassicThesis bundle has two goals:

+ Provide students with an easy-to-use template for their thesis.
+ Provide a classic, high-quality typographic style inspired by Robert Bringhurst's _The Elements of Typographic Style_ @bringhurst-2013.

#margin-note[A well-balanced line width improves the legibility of the text.]
The original bundle is designed around freely available fonts and deliberate typographic constraints. Italics and spaced small capitals establish the hierarchy. The line width is intentionally moderate, and tables avoid vertical and double rules.

== Organization

- `chapters/` contains the thesis content.
- `matter/` contains the front- and back-matter sections: declaration, abstracts, abbreviations, glossary, and bibliography.
- `assets/` contains images and figures.
- `bibliography.bib` stores references.
- `template.typ` implements typography and page composition.

= Appendix Test

Lorem ipsum at nusquam appellantur his, ut eos erant homero concludaturque. Albucius appellantur deterruisset id eam, vivendum partiendo dissentiet ei ius.

== Appendix Section Test

#thesis-table(
  table(
    columns: (1.7fr, 1fr, 1fr),
    align: (left, center, center),
    stroke: (x: none, y: 0.45pt),
    inset: 5pt,
    table.header([*Labitur bonorum pri no*], [*Que vista*], [*Human*]),
    [fastidii ea ius], [germano], [demonstratea],
    [suscipit instructior], [titulo], [personas],
    [quaestio philosophia], [facto], [demonstrated],
  ),
  caption: [Autem usu id.],
)

== Another Appendix Section Test

Equidem detraxit cu nam, vix eu delenit periculis. Eos ut vero constituto, no vidit propriae complectitur sea.

#thesis-listing(
  ```pascal
  for i := maxint downto 0 do
  begin
    { do nothing }
  end;
  ```,
  caption: [A floating example],
)

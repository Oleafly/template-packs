#import "typst/iac.typ": manuscript, unnumbered, manuscript-table
#show: manuscript.with(
  paper-code: "IAC-26-XX.IP.XXX",
  title: [IAC 2026 Manuscript Template and Feature Demonstration],
  authors: (
    (name: "First Author", affiliation: "a", corresponding: true, email: "author@example.org"),
    (name: "Second Author", affiliation: "b"),
  ),
  affiliations: (
    (id: "a", text: [Department, University, City, Country]),
    (id: "b", text: [Department, Organization, City, Country]),
  ),
  copyright: [Copyright statement to be replaced according to the selected IAF copyright assignment.],
  abstract: [
    This demonstration provides a working starting point for an English manuscript submitted to the 77th International Astronautical Congress. It exercises the title block, author information, two-column body, mathematical notation, figures, tables, cross-references, and numeric citations. The example data and references are fictional and are included solely to verify the template. The document uses locally available Times New Roman when possible and bundled TeX Gyre Termes otherwise. Mathematical content uses TeX Gyre Termes Math. Authors should replace every demonstration field before submission and keep the abstract within 400 words. The layout remains subject to comparison against the official 2026 reference document.
  ],
  keywords: ("Manuscript", "Typesetting", "Verification"),
)

#unnumbered[Nomenclature]
$bold(x)$: state vector; $bold(u)$: input vector; $J$: objective function.

#unnumbered[Acronyms/Abbreviations]
IAF: International Astronautical Federation. IAC: International Astronautical Congress.

= Introduction <sec-intro>
This file is the manuscript entry point. Ordinary paragraphs are separated by a blank line in the source. Text is justified and uses a first-line indent. The references in this demonstration are fictional. A journal example is cited here @example-journal.

The second paragraph demonstrates automatic indentation. *Bold*, _italic_, and *_bold italic_* text use the appropriate font faces. Additional reference types are shown by the conference and book examples @example-conference @example-book.

== Scope
The template demonstrates formatting rather than research findings. Its figures contain synthetic curves with no scientific interpretation. All placeholder metadata, captions, and references must be replaced.

=== Cross-references
Use labels to refer to sections, figures, tables, and equations. For example, @sec-method describes the mathematical example, @fig-example shows an image, and @tab-example lists synthetic parameters.

= Material and methods <sec-method>
The inline state $bold(x)_k in RR^3$ evolves according to @eq-state. The transpose and Greek symbols are handled by the math font.

$ bold(x)_(k+1) = bold(A) bold(x)_k + bold(B) bold(u)_k $ <eq-state>

$ bold(A) = mat(0, 1, 0; -omega^2, -2 zeta omega, 0; 0, 0, 1) $ <eq-matrix>

The objective in @eq-cost combines state and input penalties. Equation numbers are generated automatically.

$ J = integral_0^(t_f) (bold(x)^T bold(Q) bold(x) + bold(u)^T bold(R) bold(u)) dif t $ <eq-cost>

== Images and captions
#figure(
  image("assets/example.svg", width: 100%, alt: "Synthetic solid curve and dashed straight line, supplied as a layout example."),
  caption: [Synthetic curves used only to demonstrate image placement.],
) <fig-example>

SVG, PNG, and JPEG images can be inserted using the same image function. Labels embedded in an external image need their own font handling; the sample SVG deliberately contains no text.

== Tables
#manuscript-table(
  table(
    columns: (1fr, auto, auto),
    table.hline(stroke: 0.5pt),
    table.header([Parameter], [Value], [Unit]),
    table.hline(stroke: 0.5pt),
    [Length], [3.0], [m],
    [Tip speed], [30], [mm/s],
    [Position tolerance], [3], [mm],
    table.hline(stroke: 0.5pt),
  ),
  caption: [Synthetic parameter values for table verification.],
  note: [Note: the values above do not define mission requirements.],
) <tab-example>

= Results
The figure and table counters are independent. The selected font family can change line wrapping between environments; bundled mode is available for comparisons. A chapter example is cited here @example-chapter, followed by a web reference @example-web.

== Lists, quotation, and footnotes
The following list illustrates a short sequence:
+ Replace the metadata and abstract.
+ Write the technical content and insert figures.
+ Review the exported PDF.

A short quotation example is provided below. It is original demonstration text, not a quotation from an external source.
#quote(block: true)[A template should make its assumptions visible and its output easy to inspect.]

A footnote is also supported.#footnote[Example footnote. Keep submission-relevant information in the main text.]

= Discussion
A wide illustration can span the page when a single-column figure would be illegible. The following illustration exercises that path; its placement is allowed to float.

#figure(
  image("assets/example.svg", width: 75%, alt: "Wide version of the synthetic curve illustration."),
  scope: "parent", placement: bottom,
  caption: [Full-width figure example. The image is repeated only to test layout.],
) <fig-wide>

See @fig-wide for the full-width example. Floating content may move to a later page. Additional discussion paragraphs follow to exercise column flow and page boundaries.

When preparing a manuscript, begin with a small set of representative content. Include the longest likely equation, the widest table, and a figure with readable labels. These elements reveal layout constraints earlier than ordinary prose alone. Check their appearance in the exported PDF at normal reading size.

A figure may be scaled to fit the column, but its labels must remain legible. Vector artwork preserves sharp curves and lines. Raster images need enough resolution at their final printed size. The demonstration image contains no embedded text; real artwork should use embedded fonts or outlined labels when consistent rendering is required.

Tables should communicate values with clear units and consistent precision. A wide table may require a full-width float like the illustration above. Avoid reducing the font size simply to fit additional columns. Consider whether a second table would make the information easier to read.

Automatic references help maintain numbering after edits. However, the author must still verify that every cited item exists, that each bibliographic field is accurate, and that the final punctuation follows the conference examples. The fictional records provided here are intended only for this verification workflow.

= Conclusions
This demonstration connects manuscript structure, mathematical notation, illustration placement, tabular data, and bibliographic records. It is a starting point for further visual comparison rather than a claim of exact Word reproduction.

#unnumbered[Acknowledgements]
Replace this paragraph or remove the section.

#unnumbered[Appendix A]
Optional appendix content. Repeat citations reuse the same number @example-journal.

#bibliography("references.bib", style: "styles/iac-numeric.csl", title: [References])

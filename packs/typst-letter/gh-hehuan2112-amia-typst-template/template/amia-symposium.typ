// ============================================================
// amia-symposium — Template Function
// ============================================================
// Usage:
//   #import "template/amia-symposium.typ": amia-symposium
//
//   #show: amia-symposium.with(
//     title: "Your Paper Title",
//     authors: (
//       ("John Doe", (1,)),
//       ("Jane Smith", (1, 2)),
//     ),
//     // Optional: insert a hard line break after the specified author positions.
//     author-breaks: (2,),
//     affiliations: (
//       "Dept of Biomedical Informatics, University X, City, State",
//       "Dept of Computer Science, University Y, City, State",
//     ),
//     abstract: [#lorem(80)],
//     // Use `abstract: none` when the abstract is entered separately.
//     keywords: ("NLP", "Clinical Informatics"),
//     bib: bibliography("refs.bib", style: "american-medical-association"),
//   )
// ============================================================

#import "lib.typ": template-styles, title-block, abstract-block, keywords-block, references-heading

#let amia-symposium(
  title: "Title",
  authors: (),
  author-breaks: (),
  affiliations: (),
  abstract: none,
  keywords: (),
  bib: none,
  body,
) = {
  // ---- Apply document-wide styles (page, text, headings, captions, bib) ----
  show: template-styles

  // ---- Title Block ----
  title-block(title, authors, affiliations, author-breaks: author-breaks)

  // ---- Abstract ----
  // Some submission types collect the abstract separately from the paper.
  if abstract != none {
    abstract-block(abstract)
  }

  // ---- Main Body ----
  body

  // ---- References ----
  if bib != none {
    references-heading()
    bib
  }
}

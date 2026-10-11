// =================================
// Abstract Page
// =================================

#let abstract-page(ctx, abstract, keywords: ()) = {
  let labels = ctx.labels
  heading(labels.abstract, numbering: none, outlined: true)
  v(1em)
  abstract
  pagebreak()

  // Keywords
  if keywords.len() > 0 {
    heading(labels.keywords, numbering: none, outlined: false)
    v(0.5em)
    keywords.join(", ")
    pagebreak()
  }
}

// Reconstructed from arXiv_draft_v5.idml and its 18-page PDF.
// Typography deliberately changed to Libertinus.
// Dimensions are points unless otherwise indicated.
#let page-width = 595.276pt
#let page-height = 841.89pt
#let inner-margin = 36pt
#let column-gap = 9.6pt
#let text-column-width = 258pt

#let paper-style(body) = {
  set page(
    paper: "a4",
    margin: (left: 36pt, right: 33.5pt, top: 36pt, bottom: 54pt),
    numbering: "1",
    number-align: center + bottom,
  )
  set text(font: "Libertinus Serif", size: 10pt, fill: black, lang: "en")
  show math.equation: set text(font: "Libertinus Math")
  // Native figure captions retain Typst's counter and cross-reference machinery.
  // Match the InDesign style: "Figure 1 | Bold title. Description..."
  show figure.caption.where(kind: image): it => {
    set par(first-line-indent: 0pt, justify: false, leading: 3pt)
    text(size: 8pt)[*#it.supplement #context it.counter.display(it.numbering) |* #it.body]
  }
  set par(justify: true, first-line-indent: 8.5pt, leading: 4.5pt, spacing: 7pt)
  set heading(numbering: none)
  show heading: it => { set par(first-line-indent: 0pt); it }
  body
}

#let paper-title(body) = {
  set par(first-line-indent: 0pt, justify: false, leading: 6pt)
  text(size: 22pt, weight: "bold", body)
  v(11.34pt)
}

#let paper-authors(body) = {
  set par(first-line-indent: 0pt, justify: false, leading: 5pt)
  text(size: 12pt, weight: "light", body)
  v(12pt)
}

#let paper-abstract(body) = {
  set par(first-line-indent: 0pt, justify: true, leading: 4pt)
  text(size: 10pt, weight: "bold", body)
  v(5pt)
}

#let affiliation-block(body) = {
  set par(first-line-indent: 0pt, justify: false, leading: 1pt)
  text(size: 8pt, body)
}

#let paper-columns(body) = columns(2, gutter: column-gap)[#body]

#let paper-section(title) = {
  v(8pt)
  block(below: 3pt)[#text(size: 10pt, weight: "bold")[#title]]
  v(5pt)
}

#let paper-subtitle(title) = {
  v(5pt)
  block(above: 5.67pt, below: 2.83pt)[#text(style: "italic")[#title]]
  v(5pt)
}
// Create a numbered, referenceable image figure.
// Put a Typst label immediately after the call:  #paper-figure(...) <fig:sample>
// The title is bold; the remaining descriptive caption is regular weight.
// 'content' may be image("..."), a diagram, or any Typst content.
#let paper-figure(
  content,
  title: [],
  caption: [],
  width: 100%,
  placement: none,
  scope: "column",
) = {
  figure(
    block(width: width)[#content],
    caption: [#strong(title) #caption],
    kind: image,
    supplement: [Figure],
    numbering: "1",
    placement: placement,
    scope: scope,
  )
}

#let table-caption(number, body) = {
  set par(first-line-indent: 0pt, justify: false)
  text(size: 8pt)[*Table #number |* #body]
}
#let method-par(label, body) = {
  set par(first-line-indent: 0pt, leading: 2.5pt, spacing: 5.67pt)
  text(size: 9pt)[*#label* #body]
}
#let supplementary-section(title) = {
  block(above: 5.67pt, below: 5.67pt)[#text(size: 16pt, weight: "bold")[#title]]
}
#let supplementary-subsection(title) = {
  block(below: 5.67pt)[#text(size: 13pt)[#title]]
}
#let supplementary-body(body) = {
  set par(justify: true, first-line-indent: 8.65pt, leading: 2.5pt, spacing: 2.83pt)
  pad(left: 28.35pt, right: 28.35pt, body)
}
// Legacy compatibility: prefer paper-figure for automatically numbered figures.
#let wide-figure(image-content, title, caption) = paper-figure(
  image-content, title: title, caption: caption,
)
#let references-heading() = paper-section([References])

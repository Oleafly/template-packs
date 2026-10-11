// Summary page function
// Parameters:
// - content: The summary content
// - keywords (optional): An array of keywords
//   Will error if not an array when provided
#let summary_page(content, keywords: none) = {
  text(size: 1.7em)[
    #heading(level: 1, numbering: none, outlined: false)[Resumo]
  ]
  v(3em)
  content

  // Add keywords if provided
  if keywords != none {
    assert(type(keywords) == array, message: "keywords parameter must be an array of strings")
    v(1fr)
    text(size: 1.2em, weight: "bold")[Palavras-chave:] 
    [ ]
    keywords.join(", ")
    v(24pt)
  }

  pagebreak()
}
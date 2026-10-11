// Acknowledgements page function
// Parameters:
// - content: The acknowledgements content
#let acknowledgements_page(content) = {
  text(size: 1.7em)[
    #heading(level: 1, numbering: none, outlined: false)[Agradecimentos]
  ]
  v(3em)
  content

  pagebreak()
}
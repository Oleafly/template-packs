#let themed_terms(theme, body) = {
  show terms: it => {
    show strong: set text(weight: "bold", fill: black)
    it
  }
  body
}

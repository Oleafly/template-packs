#let epigrafe() = {
  import "/parameters.typ" as param
  set align(right)
  set text(hyphenate: false)
  let epigrafe-dict = dictionary(param).at("epigrafe", default: (
    frase: "",
    autor: "",
  ))
  let frase = epigrafe-dict.at("frase")
  let tipo-frase = type(frase)
  let autor = epigrafe-dict.at("autor")
  if frase == "" {
    return none
  }
  if (
    tipo-frase == content
      and not (frase.has("text") and frase.at("text").len() != 0)
      and not (frase.has("children") and frase.at("children").len() != 0)
  ) {
    return none
  }
  if tipo-frase == content and frase.has("text") {
    frase = frase.at("text")
  } else if tipo-frase == content {
    frase = frase.at("children")
  }
  if type(frase) != str {
    frase = frase.filter(it => it.func() != smartquote)
    let ponto = if repr(frase.last()).ends-with(".]") { "" } else { "." }
    frase = frase.reduce((acc, it) => acc + it) + h(0pt, weak: true) + ponto
  } else {
    frase = frase.trim("\"")
    let ponto = if frase.ends-with(".") { "" } else { "." }
    frase = frase + ponto
  }
  show quote: set pad(x: 0pt)
  v(2fr)
  block(width: 50%)[
    #quote(quotes: true, block: true, attribution: autor)[
      #frase
    ]
  ]
  v(1fr)

  pagebreak()
}

#epigrafe()

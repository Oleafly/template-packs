// Adds todo to highlight todos in the pdf
#let todo(body) = {
  highlight(fill: orange.lighten(60%))[
    *TODO:* #body
  ]
}

// Adds question to highlight questions in the pdf
#let question(body) = {
  highlight(fill: green.lighten(60%))[
    *Question:* #body
  ]
}

// Adds important to highlight important things in the pdf
#let important(body) = {
  set text(size: 15pt)
  highlight(fill: red)[
    *Important:* #body
  ]
}

// Adds citation, mentioned in the guidelines
#let glcite(key) = {
  cite(key, form: "author")
  [ (]
  cite(key, form: "year")
  [) ]
  cite(key)
}

// Adds description (term and body)
#let desc(term, body) = {
  stack(
    dir: ttb,
    spacing: 0.6em,
    [*#term*],
    [#body],
  )
  v(1em)
}

// Helper to safely allow both "strings" and <labels>
#let to-str(key) = if type(key) == label { str(key) } else { key }

// 1. Base citation (Make sure 'note: none' is right here)
#let glcitel(key, note: none) = {
  let k = to-str(key)
  [#cite(label(k), form: "author")~(#cite(label(k), form: "year"))#cite(label(k), supplement: note)]
}

// 2. Compare citation
#let glcfcite(key, note: none) = [
  Vgl.~#glcitel(key, note: note)
]

// 3. Footnote citation
#let glfootcite(key, note: none) = {
  let k = to-str(key)
  footnote[#glcitel(k, note: note)#label("fn:" + k)]
}

// 4. Compare footnote citation
#let glcffootcite(key, note: none) = {
  let k = to-str(key)
  footnote[#glcfcite(k, note: note)#label("fn:" + k)]
}

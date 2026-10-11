// Function for formatted code blocks
#let code(text, lang: "sh") = {
  block(
    fill: luma(240),
    inset: 8pt,
    radius: 4pt,
    raw(text, lang: lang, block: true),
  )
}

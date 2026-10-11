#let default-paper = "a4"
#let default-margin = (x: 25mm, y: 25mm)
#let default-text-fonts = ("Libertinus Serif", "Noto Serif CJK JP")
#let default-text-size = 11pt
#let default-text-lang = "ja"
#let default-line-leading = 1.4em
#let default-par-justify = true
#let default-heading-numbering = "1."
#let default-page-numbering = "1"
#let default-footer-text-size = 9pt
#let default-footer-columns = (1fr, auto, 1fr)
#let default-footer-left = []
#let default-footer-center = context [#counter(page).display()]
#let default-footer-right = []

#let align-left = left + bottom
#let align-center = center + bottom
#let align-right = right + bottom

#let footer-layout(
  left: default-footer-left,
  center: default-footer-center,
  right: default-footer-right,
  size: default-footer-text-size,
  columns: default-footer-columns,
) = {
  set text(size: size)
  block(
    width: 100%,
    grid(
      columns: columns,
      align: (align-left, align-center, align-right),
      left,
      center,
      right,
    ),
  )
}

#let template(
  paper: default-paper,
  margin: default-margin,
  text-fonts: default-text-fonts,
  text-size: default-text-size,
  text-lang: default-text-lang,
  line-leading: default-line-leading,
  par-justify: default-par-justify,
  heading-numbering: default-heading-numbering,
  page-numbering: default-page-numbering,
  footer-left: default-footer-left,
  footer-center: default-footer-center,
  footer-right: default-footer-right,
  footer-text-size: default-footer-text-size,
  footer-columns: default-footer-columns,
  body,
) = {
  set text(
    size: text-size,
    font: text-fonts,
    lang: text-lang,
  )

  set par(
    leading: line-leading,
    justify: par-justify,
  )

  set heading(numbering: heading-numbering)

  set page(
    paper: paper,
    margin: margin,
    numbering: page-numbering,
    footer: footer-layout(
      left: footer-left,
      center: footer-center,
      right: footer-right,
      size: footer-text-size,
      columns: footer-columns,
    ),
  )

  body
}

#let bg       = rgb("#fff8f2")
#let fg       = rgb("#333333")
#let muted    = rgb("#777777")
#let primary  = rgb("#d7b299")

#let section-title(title) = {
  v(10pt)
  text(size: 13pt, weight: "bold", fill: primary, upper(title))
  v(-2pt)
  line(length: 100%, stroke: 0.75pt + primary)
  v(4pt)
}

#let entry(title: "", subtitle: "", location: "", date: "", description: []) = {
  grid(
    columns: (1fr, auto),
    text(weight: "bold", size: 10.5pt, title),
    align(right, text(size: 9pt, fill: muted, date)),
  )
  if subtitle != "" {
    text(style: "italic", size: 9.5pt, fill: muted, [#subtitle, #location])
    linebreak()
  }
  v(2pt)
  description
}

#let sidebar-section(title) = {
  v(10pt)
  text(size: 11pt, weight: "bold", fill: white, upper(title))
  v(-2pt)
  line(length: 100%, stroke: 0.75pt + white.transparentize(40%))
  v(4pt)
}

#let sidebar-item(icon, body) = {
  text(size: 9pt, fill: white.transparentize(10%), [#icon #body])
  linebreak()
  v(2pt)
}

#let sidebar-item-link(icon, body, href) = {
  link(href, text(size: 9pt, fill: white.transparentize(10%), [#icon #body]))
  linebreak()
  v(2pt)
}

#let invisible-text(body) = {
  set text(size: 0pt, fill: rgb(0, 0, 0, 0))
  body
}

#let skill-bar(name, level) = {
  text(size: 9pt, fill: white, name)
  v(2pt)
  box(width: 100%, height: 5pt, {
    place(rect(width: 100%, height: 5pt, fill: white.transparentize(70%), radius: 2pt))
    place(rect(width: level, height: 5pt, fill: white, radius: 2pt))
  })
  v(6pt)
}

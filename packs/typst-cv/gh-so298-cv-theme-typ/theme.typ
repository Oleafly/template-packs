#let mygray = rgb("#6A6A6A")
#let mydarkgray = rgb("#4A4A4A")
#let ja_sans = "Harano Aji Gothic"
#let en_sans = "Open Sans"

#let cv(body) = {
  // styling
  show heading: set text(fill: navy)
  show heading.where(level: 1): it => block(below: 0.8em, {
    set text(size: 18pt)
    it.body
  })
  show heading.where(level: 2): it => block(below: 0.8em, {
    set text(size: 14pt)
    it.body
  })

  // main body
  body
}

#let title(name, page_title: "Curriculum Vitae") = {
  block(text(size: 15pt, page_title))
  v(5pt)
  block(text(size: 35pt, fill: navy, [#name]))
  v(10pt)
}

#let info(attr, value) = block(width: 100%, height: 0pt, {
  set text(size: 9pt)
  box(width: 45pt, text(fill: mygray, [#attr]))
  box(text(weight: "medium", [#value]))
})

#let cventry(year, org, position, detail) = {
  grid(columns: (90pt, 1fr), 
    box(text(font: (en_sans, ja_sans), size: 10pt, fill: mydarkgray, [#year])),
    {
      block(width: 100%, below: 0.8em, {
        box(text(size: 11pt, weight: "medium", [#org]))
        h(5pt)
        box(baseline: 1pt, [#position])
      })
      block(text([#detail]))
    }
  )
  v(4pt)
}

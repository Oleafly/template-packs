#let conf(
  title:[],
  authors:[],
  id:[],
  email:none,
  doc
) = {
  set page(
    paper: "a4",
    numbering: "1 of 1",
    margin: (left: 2cm,right: 2cm,top: 2cm,bottom: 2cm)
  )
  
  set text(
    font: ("TeX Gyre Termes","Noto Sans CJK SC"),
    size: 12pt,
  )

  set heading(
    numbering: "I.a.",
  )

  set align(center)
  text(title,17pt)

  grid(
    columns: 3*(1fr,),
    [#authors],[#id],[#link("mailto:"+email)]
  )

  set align(left)

  doc
}

#let answer(body) = {
  set align(center)
  [#rect(outset: 2pt, stroke: red)[#body]]
}
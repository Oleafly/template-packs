#let configure(
  title: "",
  appVersion: "0.0.0",
  docVersion: "",
  doc,
) = {
  show link: it => [
      #set text(fill: blue)
      #underline(stroke: blue)[#emoji.chain#it]
  ]

  [
    #set align(center+horizon)
    #set text(weight: "bold", size: 1.5em)
    #title
  
    #set text(weight: "regular", size: 0.8em)
    #set align(bottom+right)
    application version: #appVersion
  
    doc version: #docVersion
  
    更新日: #context datetime.today().display("[year]年[month]月[day]日")
    #pagebreak()
  ]


  set page(
    numbering: "1",
    header: [
      #set text(0.8em)
      #h(1fr)
      #title
    ]
  )

  set heading(numbering: "1.")

  pagebreak()
  outline()
  pagebreak()

  doc
}


#let warn(content) = block(
	fill: yellow,
	inset: 1em,
    )[
  #set align(horizon)
  #stack(
    dir: ltr,
    emoji.excl,
    [#content]
  )
]






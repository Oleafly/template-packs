#let wiki(
	title: none,
	doc,
) = context {
  set quote(block: true)
  show link: set text(fill: blue)
  show math.equation: set text(size: 12pt, font: "DejaVu Math TeX Gyre")
  set text(fill: white, font: "DejaVu Sans Mono",  size: 10pt)
  //import "@preview/zebraw:0.6.1": *
  //show: zebraw-init
  //show: zebraw

  //grid(
	//columns: (auto, 1fr),
	//[#pad(y: 10pt, text(title, size: 15pt, weight: "bold"))],
	//grid.hline(stroke: orange)
  //)
	//[#pad(y: 10pt, text(title, size: 15pt, weight: "bold"))]
	//[#text(title, size: 15pt, weight: "bold")]
	//[#heading(title)]
  //html.elem("h2", attrs: (class: "text-3xl font-bold underline text-blue-600"))[
  //  #title
  //]
  let arrow = text("\n\u{2B05}", size: 15pt)
  //[#link("../index.html")[$arrow$]]
  //[#link("../index.html")[#arrow]]
  if target() == "html"{
    show math.equation: html.frame
    show raw: html.code
    html.elem("body", attrs: (class: "text-light bg-dark"))[
      //html.elem("div", attrs: (class: "flex-grow mx-10 md:mx-25 lg:mx-40 min-h-screen justify-center items-center"))[
      #html.elem("div", attrs: (class: "flex-grow mx-5 my-5"))[
        //#html.elem("h2", attrs: (class: "text-3xl font-bold underline text-blue-600"))[
        #html.elem("h2", attrs: (class: "fs-3 fw-bold text-decoration-underline text-info"))[
          #title
        ]
        #link("../index.html")[#arrow]
        #doc
      ]
    ]
  } else {
    set page(paper: "a5", fill: rgb("#262626"))  
    set text(font: "DejaVu Sans Mono",  size: 10pt)
    grid(
	    columns: (auto, 1fr),
	    [#pad(y: 10pt, text(title, size: 15pt, weight: "bold"))],
	    grid.hline(stroke: orange)
    )
    doc

  }
}

#let bquotelink(linkattribution, rawtext) = context {
  if target() == "html" {
    //html.elem("blockquote", attrs: (class: "p-4 my-4 border-s-4 border-default bg-neutral-secondary-soft"))[
    html.elem("blockquote", attrs: (class: "p-3"))[
      #rawtext
      #html.elem("cite")[* #text("\n--" + linkattribution) *]
    ]

  } else {
    
  }
}

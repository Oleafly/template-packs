
#let generateFrontPage(accent, title, authors ) = {
  page(margin : (x : 0pt, y : 0pt))[
    #place(top + left)[
      #block(fill : accent, width : 0.4cm, height : 100%)
    ]
    #block(inset : (x : 2cm, y : 2.5cm), width : 100%, height : 100%)[
      #text(title, size : 26pt, weight : 600)

      #emph(text(authors.join(", "), size : 20pt))
    ]
  ]
}

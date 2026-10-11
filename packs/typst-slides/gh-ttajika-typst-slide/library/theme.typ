#import "@preview/cetz:0.3.1"
#import "functions.typ":*

//--------BlackBoardのテーマ

//Headerスライドのデザイン

#let BB-header_slide(title,now:0, end:0,color:"", tcolor:"", current-headings: "", outline: false) = {
  set text(size: 23pt, weight:700)
  let a =  {if outline == true{1} else {0}}
  if outline == true {pad(top:30pt,bottom:-30pt)[ 
      #heading-outline(color:color, current-headings: current-headings)] 
      v(-13pt)
      }
  pad(left: -20pt, top:30pt)[
   #if title == [] { v(20pt) }else { h(20pt);text(size:1.2em)[#title]; h(1fr); text(size:0.7em)[#now/#end]; v(-15pt) }
#line(
  length: 30cm,
  stroke: 4pt + tcolor.lighten(80%),
)  #v(a*2.5em)
        
  ]
}

//タイトルスライドのデザイン


#let BB-title_slide(now:0,end:0, color:"",tcolor:"", outline:"", title:"", title_notes:"", date:"", authors:"", notes:(),  institutions:"",  header-slide:BB-header_slide) = {
  let a =  {if outline == true{1} else {0}}
  v((1-a)*5em)
  align(center+horizon)[
    #set text(weight: 700, 2em)
//    #line(length:100%, stroke:3pt+default_color)
    #box(stroke: (bottom: 4pt+ color, top:0pt, left:0pt, right:0pt),outset:(bottom:.5em))[#text(fill:color)[#title]]
 //   #line(length:100%, stroke:3pt+default_color)
    #if title_notes !=none {footnote[#title_notes]}
    #v(1em, weak: true)
    #set text(weight: 500, 0.1em)
    
  ]
  
  let author_note = authors.zip(notes)
  pad(
    top: 0.1em,
    bottom: 0.1em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, 
       text(weight: 700, .8em, author)
      )),
      ..institutions.map(institutions => align(center, text(weight: 700, .8em, institutions)))
    ),
  ) 
  [#align(center)[#text(size:0.6em)[#date]]]
}


//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let BB-page-setter(footer:"",body) = {
  set page(fill: rgb("2f4f4f"),footer: [#set text(10pt);#footer])
  set text(fill: rgb("f5f5f5"))
  body
}

//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let BlackBoard = (slide_theme:BB-header_slide, title_theme:BB-title_slide, page_theme: BB-page-setter,default-color: yellow.lighten(50%),emph-color:eastern.darken(40%))


//------


//--------Simpleのテーマ

//Headerスライドのデザイン

#let Simple-header_slide(title,now:0, end:0,color:"", tcolor:"", current-headings: "", outline: false) = {
  set text(size: 23pt, weight:700)
  let a =  {if outline == true{1} else {0}}
  if outline == true {pad(top:30pt,bottom:-30pt)[ 
      #heading-outline(color:color, current-headings: current-headings)] 
      v(-13pt)
      }
  pad(left: -20pt, top:30pt)[
   #if title == [] { v(20pt) }else { h(20pt);text(size:1.2em)[#title]; h(1fr); text(size:0.7em)[#now/#end]; v(-15pt) }
#line(
  length: 30cm,
  stroke: 4pt + tcolor.lighten(80%),
)  #v(a*2.5em)
        
  ]
}

//タイトルスライドのデザイン


#let Simple-title_slide(now:"",end:"", color:"",tcolor:"", outline:"", title:"", title_notes:"", date:"", authors:"", notes:(),  institutions:"",  header-slide:BB-header_slide) = {
 align(center+horizon)[
    #set text(weight: 700, 2em)
//    #line(length:100%, stroke:3pt+default_color)
    #box(stroke: (bottom: 8pt+ color, top:0pt, left:0pt, right:0pt),outset:(bottom:.5em))[#text(fill:color)[#title]]
 //   #line(length:100%, stroke:3pt+default_color)
    #if title_notes !=none {footnote[#title_notes]}
    #v(1em, weak: true)
    #set text(weight: 500, 0.1em)
    
  ]
  
  let author_note = authors.zip(notes)
  pad(
    top: 0.1em,
    bottom: 0.1em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, 
       text(weight: 700, .8em, author)
      )),
      ..institutions.map(institutions => align(center, text(weight: 700, .8em, institutions)))
    ),
  ) 
  [#align(center)[#text(size:0.6em)[#date]]]
}

//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let Simple-page-setter(footer:"",body) = {
  set page(fill: white,footer:  [#set text(10pt);#footer])
  set text(fill: black)
  body
}

//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let Simple = (slide_theme:Simple-header_slide, title_theme:Simple-title_slide, page_theme: Simple-page-setter, default-color: gray.darken(30%),emph-color:white)


//------



//--------Tropicalのテーマ

//Headerスライドのデザイン

#let Tropical-header_slide(title,now:0, end:0,color:"", tcolor:"", current-headings: "", outline: false) = {
  set text(size: 23pt, weight:700)
  let a =  {if outline == true{1} else {0}}
  if outline == true {pad(top:30pt,bottom:-30pt)[ 
      #heading-outline(color:gradient.linear(yellow, red, angle: 0deg), current-headings: current-headings)] 
      v(-13pt)
      }
  pad(left: -20pt, top:30pt)[
   #h(20pt);#box(fill:gradient.linear(red, red.darken(10%), angle: 90deg),outset:(bottom:10pt, left:20pt,top:5pt), radius: (
    left: 5pt,
    top-right: 20pt,
  ))[#text(size:1.2em,fill:white)[#title] #hide[あ]]; #h(1fr); #text(size:0.7em,fill:white)[#now/#end]; #v(-17pt) 
#line(
  length: 30cm,
  stroke: 4pt +red.darken(10%),
)  #v(a*2.5em)
        
  ]
}

//タイトルスライドのデザイン


#let Tropical-title_slide(now:0,end:0, color:"",tcolor:"", outline:"", title:"", title_notes:"", date:"", authors:"", notes:(),  institutions:"",  header-slide:BB-header_slide) = {
  let a =  {if outline == true{1} else {0}}
  v((1-a)*5em)
  align(center+horizon)[
    #set text(weight: 700, 2em, fill:white)
//    #line(length:100%, stroke:3pt+default_color)
    #box(stroke: (bottom: 0pt, top:0pt, left:0pt, right:0pt),outset:(bottom:.5em))[#text(fill:blue.lighten(70%))[#title]]
 //   #line(length:100%, stroke:3pt+default_color)
    #if title_notes !=none {footnote[#title_notes]}
    #v(1em, weak: true)
    #set text(weight: 500, 0.1em)
    
  ]
  
  let author_note = authors.zip(notes)
  pad(
    top: 0.1em,
    bottom: 0.1em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, 
       text(weight: 700, .8em, author)
      )),
      ..institutions.map(institutions => align(center, text(weight: 700, .8em, institutions)))
    ),
  ) 
  [#align(center)[#text(size:0.6em)[#date]]]
}


//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let Tropical-page-setter(footer:"",body) = {
  set page(fill: red.darken(30%),footer: [#set text(10pt);#footer])
  set text(fill: yellow.lighten(70%))
  body
}

//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let Tropical = (slide_theme:Tropical-header_slide, title_theme:Tropical-title_slide, page_theme: Tropical-page-setter,default-color: red.darken(50%),emph-color:yellow.lighten(50%))


//------
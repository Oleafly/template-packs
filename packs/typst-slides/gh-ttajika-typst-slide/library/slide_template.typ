//fontawesomeの読み込み
#import "@preview/fontawesome:0.5.0": *
//CeTZの読み込み
#import "@preview/cetz:0.3.4"
//


#import "functions.typ": *
#import "theme.typ": *


#let project(
  title: "",
  title_notes: none,
  authors: (),
  institutions: (),
  notes: (),
  date: "",
  body,
  default_color_p: none,
  emph_color_p: none,
  strong_color: rgb("3cb371"),
  textcolor: black,
  size:18pt,
  body-font:body-font,
  sans-font:sans-font,
  math-font: "TeX Gyre Bonum Math",
  header-outline: false,
  header-number: false,
  header-numbering_inf:3,
  theme: default-theme,
  footer: none
) = {
  // Set the document's basic properties.
  set document()
  set page("presentation-16-9",
  margin: (right:15pt,top:2pt, left:20pt, bottom:30pt),)

  // Save heading and body font families in variables.


let default_color = {if default_color_p == none {theme.at("default-color")} else {default_color_p}}
let emph_color = {if emph_color_p == none {theme.at("emph-color")} else {emph_color_p}}
  
// slideの作成. headingをスライドの区切りにする
  set text(bottom-edge: "bounds")

  show heading: it => {
  set block(spacing: 27pt)
// slide_numberの更新
  pagebreak(weak:true)
   counter("slide_counter").step() 

  context{
  let now = counter("slide_counter").get().at(0)
  let end = counter("slide_counter").final().at(0)
  context[
    #let current-headings = counter(heading).get().at(0);
    #theme.at("slide_theme")(now:now,end:end,color:default_color,tcolor:emph_color, current-headings:current-headings,outline:header-outline)[#if header-number == true and it.level< header-numbering_inf {counter(heading).display()} #it.body]
  ]
  let a = {if header-outline == true {1} else {0} } 
  
  v(-a * 2.05cm -.5em)
}
}
 



 // Set body font family.
set text(font: body-font, lang: "jp", fill:textcolor)

// fontの設定
  set text(font: sans-font, size:size, weight:400)
  show emph: set text(fill: default_color)
  show strong: set text(font: sans-font, fill: default_color, weight:700)

//テーマに基づくページ設定
show: theme.at("page_theme").with(footer:footer)



set heading(numbering: "1.1.")


 

set footnote(numbering: "\*")

  context[#set heading(outlined: false)
    #slide(title:none,level:2)[
    #theme.at("title_theme")(now:"",end:"", color:default_color,tcolor:emph_color, outline:header-outline, title:title, title_notes:title_notes, date:date, authors:authors, institutions:institutions)
  ]]
  counter(heading).update(0)


  // Main body. 基本設定.

//listのマーカーの設定
 set list(marker: ([#text(fill:default_color)[#fa-angle-right()]], text(fill:default_color, size:0.8em)[#fa-angles-right()],[#text(fill:default_color, size:0.8em)[#fa-caret-right()]]))

// footnoteの設定
  set footnote(numbering: "1")
  counter(footnote).update(0)
// paragraphの設定． indent 1em, 行送り.5em
  set par(justify: false, first-line-indent: 1em, leading: .5em)

//数式フォントの設定
  show math.equation: set text(font: math-font,weight:400, size:size * 1.05)
//set math.equation(numbering: "(1)")
//items with numberingの設定
  set enum(numbering: "1.a.")
  show figure: it => {
  let frame_color = default_color
    if it.kind != "TheoremKinds" {it}
  else {tbox(emph_color, frame_color, [#it.caption] ,it.body)}
    
  }
//参照の編集
show ref: it => {
  if it.element.func() == figure{
    [#it.element.supplement ]
  }
  
}
  
//引用形式の設定
 body
}

//その他ショートカット
#let ya = {text(fill:default_color)[#fa-arrow-right()]}







#import "libs/template.typ": key,address,information
/*typstの場合，改行の有無で組み方が変わることがあるため注意*/

/*setting*********************************************************************/
//page setting
#set page(paper: "a4", margin: (x: 25mm, y: 25mm), number-align: center + bottom, numbering: "- 1 -")
#set text(font: ("Times New Roman", "MS Mincho",), size: 9.5pt, weight: "regular", lang: "ja")
//indent setting
#let indent = 1em
#set par(first-line-indent: indent, justify: true, leading: 0.8em, linebreaks: auto, spacing: 0.6em)
//math setting
#set math.equation(numbering: numbering.with("(1)"))
#set enum(numbering: "(1)")
#set math.mat(delim: "[")
#set math.vec(delim: "[")
// #let dif(val) = $d / (d val)$
// #let diff(val,val2) = $(d val)/ (d val2)$
// #let part(val) = $partial/ (partial val)$
// #let parti(val,val2) = $(partial val)/ (partial val2)$
//bibliography setting
#let std-bibliography = bibliography
#let bib(bibliography: none) = {
  if bibliography != none {
    show std-bibliography: set text(9pt)
    show regex("[0-9a-zA-Z]"): set text(font: "Times New Roman")
    set std-bibliography(title:  align(right, text(13.5pt)[参考文献]), style: "libs/sice.csl")
    bibliography
  }
}
// figure/table figures.
#show figure.where(kind: table): set figure(placement: top, supplement: [Table])
#show figure.where(kind: table): set figure.caption(position: top, separator: [: ])
#show figure.where(kind: image): set figure(placement: top, supplement: [Fig.])
#show figure.where(kind: image): set figure.caption(position: bottom, separator: [: ])


/*title**********************************************************************/
//title font setting
#set text(font: ("Times New Roman", "MS Gothic",), weight: "regular", lang: "ja")
//alignment setting
#set align(center)

//event title
#smallcaps[
  計測自動制御学会○○支部 第○○回研究集会(20○○.○○.○○)
  
  資料番号 ○○
]

#linebreak()
//paper title
#text(16pt, weight: "bold")[
  計測自動制御学会研究集会typstテンプレート //main title
]

//paper title in English
#text(14pt, weight: "regular")[
  The Society of Instrument and Control Engineers typst Template
]

#linebreak()
//author
#text(11.5pt, weight: "regular")[
  $○"山田太郎"^*$，$"山田次郎"^*$
]

//author in English
#text(12pt, weight: "regular")[
  $○"Taroh Yamada"^*$, $"Jiroh Yamada"^*$
]

#linebreak()
//author affiliation
#text(11.5pt, weight: "regular")[
  $#h(1pt)^*"○○大学"$
]

//author affiliation in English
#text(12pt, weight: "regular")[
  $#h(1pt)^*"○○ University"$
]

#linebreak()
//keywords
#text(11.5pt, weight: "bold")[
  キーワード:
]
#key()[ハミルトン系][Hamilton system]
#key()[多様体][manifold]
#key()[シンプレクティック幾何学][symplectic geometry]
#key()[微分形式][differential form]

#linebreak()
//address
#address[○○○-○○○○][○○県○○市○○\ ○○大学大学院○○研究科○○ ○○○○]
#information[(○○○○)○○-○○○○][][○○○○○○○○ $at$ ○○○○.○○.jp]

#linebreak()
//separator line setting
#line(length: 40%)
#linebreak()


/*main text**********************************************************************/
//numbering
#set heading(numbering: "1.", hanging-indent: indent)
#show heading.where(level: 1): set text(13.5pt)
#show heading.where(level: 2): set text(11.5pt)
//heading font setting
#let heading_font(body) = {
  set text(font: ("Times New Roman", "MS Gothic")) // weightの指定は反映されないらしい
  // font: (日本語文字を含まないフォント, 日本語文字を含むフォント)
  body
}
#show heading: heading_font // heading_fontを適用する
//spacing setting
#show math.equation: it => h(0.25em, weak: true) + it + h(0.25em, weak: true)
#set text(cjk-latin-spacing: auto)
//font setting
#set text(font: ("Times New Roman", "MS Mincho",), size: 10.5pt, weight: "regular", lang: "ja")
//indent
#set align(left)
#show heading: it => {
  it
  par(text(size: 0pt, ""))
}

//columns
#linebreak()
#show: columns.with(2)

//main text
#import "@preview/roremu:0.1.0": roremu

= 緒言
#roremu(120)
@courant1990dirac
#roremu(200)
@fujioka2017manifold
#figure(
      placement: auto, 
      image("figs/fig1.svg",width:60%),
      caption: [グラフの例],
    )<fig1>
#roremu(300)
= 研究の目的
#roremu(100)
@vanDerSchaft1998implicit
#roremu(200)
= 研究の背景
#roremu(200)
@shima1997nonlinear
#roremu(200)
= 研究の方法
#roremu(200)
= 研究の結果・考察
#roremu(100)
= 結言
#roremu(100)

#bib(bibliography: bibliography("libs/refs.yml", full: false))




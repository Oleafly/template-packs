#import "@preview/physica:0.9.2": *
#import "@preview/showybox:2.0.1":*
#import "@preview/codelst:2.0.2": sourcefile
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

#let conf(
  title: none,
  doc,
) = {
  set text(lang: "ja")
  set page(margin: (top: 25mm, bottom: 25mm, left: 25mm, right: 25mm), paper: "a4", numbering: "1", number-align: center)

  let en_font = "New Computer Modern"
  let ja_font = "Noto Serif CJK JP"
  set text(font: (en_font, ja_font), size: 11pt)

  show "、": "，"
  show "。": "．"

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set block(breakable: true)

  show figure: it => [
    #it
    #par(text(size: 0em, ""))
  ]

  show heading: it => [
    #set text(size: 11pt)
    #it
    #par(text(size:0em, ""))
  ]
  set heading(numbering: "1.1.1. ")

  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
      (top: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 { center }
      else { left }
    )
  )
  set par(justify: true, leading: 1em, first-line-indent: 1em)

  set align(center)
  text(15pt, title)

  set align(right)
  text(11pt, "電子情報工学科3年 03-250406 太田智也")
  set align(right)
  text(11pt, datetime.today().display())

  set align(left)
  doc
}

#let cfile(filename, name) = figure(sourcefile(read(filename), file: name, lang: "C"), caption: name, supplement: [#text("code")])
// #let srcfile(filename, name) = figure(sourcefile(frame: block.with(fill: green.lighten(90%)),read(filename), file: name, lang: "verilog"), caption: name, supplement: [#text("code")])
#let logfile(filename, name) = figure(sourcefile(read(filename), file: name, lang: "plain"), caption: name, supplement: [#text("output")])

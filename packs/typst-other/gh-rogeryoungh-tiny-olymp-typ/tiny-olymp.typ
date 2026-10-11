#let serif-font  = ("Latin Modern Roman", "Noto Serif CJK SC")
#let sans-font  = ("Latin Modern Sans", "Noto Sans CJK SC")
#let mono-font = ("Latin Modern Mono")

#let fakepar=context{let b=par(box());b;v(-measure(b+b).height)}



#let problem(input_file, output_file, time_limit, memory_limit,) = {
  pad(x: 1.7em, table(
    stroke: none,
    columns: (auto, auto),
    [Input File:], input_file,
    [Output File:], output_file,
    [Time Limit:], time_limit,
    [Memory Limit:], memory_limit,
  ))
  fakepar
}

#let examples(..body) = {
  pad(x: 2em, table(
    columns: (46%, 50%),
    stroke: 0.5pt,
    inset: 0.6em,
    table.cell(align: center, strong(`standard input`)),
    table.cell(align: center, strong(`standard output`)),
    ..body
  ))
}

#let url-color = rgb(128, 0, 0)

#let project(title: "", author: "", second-header: none, date: datetime.today(), titlepage: true, body) = {
  // 字体
  // "Palatino Linotype", "Linux Libertine", "Noto Serif CJK SC"
  set text(font: serif-font, lang: "zh", region: "cn", size: 12pt)
	show raw: set text(font: mono-font, size: 12pt)


  if titlepage {
    include "titlepage.typ"
  }

  // 设置文档基本属性
  set document(author: author, title: title)
  set page(paper: "a4", margin: (x: 13mm, y: 21mm), numbering: "1", header: [
    #set align(center)
    #set par(spacing: .8em)
    #set text(font: sans-font, size: 0.9em)
    
    #title

    #if second-header != none {
      second-header
      v(-0.4em)
      line(length: 100%,stroke: 0.5pt)
      v(-0.8em)
    } else {
      line(length: 100%,stroke: 0.5pt)
      v(-0.8em)
    }

  ])


  // 段落设置
  // https://typst-doc-cn.github.io/docs/reference/model/par/
  set par(first-line-indent: 2em, justify: true, leading: 1em)

  // 链接颜色
  show link: set text(fill: url-color)

  // 标题
  set heading(numbering: "A. ")

  show heading.where(level: 1): it => box(width: 100%)[
    #set text(1.1em, font: sans-font)
    #if it.numbering != none {
      "Problem " + counter(heading).display()
    }
    #it.body
  ]

  show heading.where(level: 2): it => box(width: 100%)[
    #set text(1.1em, font: sans-font)
    #v(-0.5em)
    #it.body
  ]

  set list(indent: 2em)
  set enum(indent: 2em)

  body
}

#import "@preview/numbly:0.1.0": numbly


#let font = (main: "IBM Plex Serif", mono: "IBM Plex Mono", cjk: "Noto Serif CJK SC")
#let cjk-markers = regex("[“”‘’．，。、？！：；（）｛｝［］〔〕〖〗《》〈〉「」【】『』─—＿·…\u{30FC}]+")
#let fakepar = context {
  box()
  v(-measure(block() + block()).height)
}
// 标题，(小组成员), (结对小组成员), 日期
#let assign_cover(title, subTitles ,members, pairMembers, date) = {
  align(
    center,
    text(size: 48pt, weight: "bold")[
      #v(3em)
      编译原理实验报告
    ],
  )
  v(2em)
  align(
    left,
    grid(
      columns: 2,
      align(center, text(size: 14pt)[#box()]),
      align(
        left,
        (
          for sub in subTitles {
            text(size: 20pt)[
              #sub.name: #sub.content

            ]
          }
        ),
      ),
    ),
  )
  v(1fr)
  align(
    right,
    grid(
      columns: 2,
      align(center, text(size: 14pt)[小组成员: #box()]),
      align(
        right,
        (
          for member in members {
            text(size: 14pt)[
              #member.name（学号：#member.id）

            ]
          }
        ),
      ),
    ),
  )
  linebreak()
  if pairMembers == none { } else {
    align(
      right,
      grid(
        columns: 2,
        align(right, text(size: 14pt)[小组成员：#box()]),
        align(
          left,
          (
            for member in pairMembers {
              text(size: 14pt)[
                #member.name（学号：#member.id）

              ]
            }
          ),
        ),
      ),
    )
  }
  linebreak()
  align(
    right,
    text(size: 14pt)[
      完成日期：#date.display("[year]年[month padding:none]月[day padding:none]日")
    ],
  )

  pagebreak(weak: true)
}

#let assign_outline() = {
  set page(paper: "a4")

  show outline.entry.where(level: 1): it => {
    v(14pt, weak: true)
    text(size: 14pt)[#it]
  }

  align(center, text(28pt, weight: "bold")[实验目录])
  v(15pt)
  
  outline(title: none, depth:2, indent: auto)
}

#let assign_class(title, subTitle ,author, members, pairMembers, date, body) = {
  set page(paper: "a4", margin: auto)
  set text(font: (font.main, font.cjk), lang: "zh", region: "cn")
  show cjk-markers: set text(font: font.cjk)

  set heading(
    numbering: numbly(
      "{1:一}、", // use {level:format} to specify the format
      "{2:1}.", // if format is not specified, arabic numbers will be used
      "({3:1})", // here, we only want the 3rd level
    ),
  )

  set document(title: title, author: author)
  set par(justify: true)
  show math.equation.where(block: true): it => block(width: 100%, align(center, it))

  set raw(tab-size: 4)
  show raw: set text(font: (font.mono, font.cjk))
  // Display inline code in a small box
  // that retains the correct baseline.
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 4pt, y: 0pt), outset: (y: 4pt), radius: 4pt)
  show raw.where(block: true): it => {
    set par(justify: false)
    block(
      fill: luma(240),
      inset: 8pt,
      radius: 8pt,
    )[
      #place(top + right, dy: -4pt, dx: 4pt)[#text(fill: gray, style: "italic", size: 8pt, it.lang)]
      #grid(
        columns: (auto, 1fr),
        align: (x, y) => if x == 0 {right} else {left},
        column-gutter: 0.5em,
        // stroke: (x,y) => if x==0 {( right: (paint:gray, dash:"densely-dotted") )},
        inset: 0.25em,
        ..it.lines.map((line) => (text(fill:gray, str(line.number)), line.body)).flatten()
      )
    ]
  }


  show link: it => {
    set text(fill: blue)
    underline(it)
  }

  set list(indent: 2em)
  set enum(indent: 2em)
  set enum(
    numbering: numbly(
      "{1:1}.",
      "{2:a})",
    ),
    full: true,
  )
  show list: it => {
    set list(indent: 0.5em)
    set enum(indent: 0.5em)
    it
  }
  show enum: it => {
    set enum(indent: 0.5em)
    set list(indent: 0.5em)
    it
  }

  assign_cover(title, subTitle, members, pairMembers, date)
  assign_outline()

  set page(
    paper: "a4",
    margin: auto,
    footer: [
      #set align(center)
      #set text(9pt)
      #context {
        counter(page).display("1")
      }
    ],
  )
  counter(page).update(1)
  // align(center, text(size: 21pt, weight: "bold", title))
  // [
  //   #show heading: it => {
  //     set align(center)
  //     set text(size: 21pt, weight: "bold")
  //     it
  //   }
    
  //   #heading(numbering: none, depth: 1, title)
  // ]
  show heading: set block(spacing: 1.2em)
  show heading.where(depth: 1): it => {
    show h.where(amount: 0.2em): none
    it
  }
  set text(size: 12pt)
  set par(first-line-indent: 2em)

  show math.equation.where(block: true): it => it + fakepar // 公式后缩进
  show heading: it => it + fakepar // 标题后缩进
  show figure: it => it + fakepar // 图表后缩进
  show enum: it => it + fakepar
  show list: it => it + fakepar // 列表后缩进
  show grid: it => it + fakepar // 列表后缩进
  show raw.where(block: true): it => it + fakepar
  body
}
#let problem_counter = counter("problem")
#let prob_solution_counter = counter("prob-solution")
#let my_heading(title) = {
  pagebreak()
  counter(heading).update(0)
  prob_solution_counter.update(0)
  problem_counter.update(0)
  show heading: it => {
    set align(center)
    set text(size: 21pt, weight: "bold")
    it
  }  
  heading(numbering: none, depth: 1, title)
}


#let list(body) = {
  let fakepar = context {
    box()
    v(-measure(block() + block()).height)
  }
  grid(columns: (2em, 1fr))[][
    #body
  ]
  fakepar
}


#let prob_block(body) = {
  v(-0.5em)
  block(fill: rgb(230, 255, 255), width: 100%, inset: 8pt, radius: 4pt, stroke: rgb(0, 191, 255), body)
}

#let cprob(text, body) = {
  [
    #set heading(numbering: none)
    #problem_counter.step()
    === *问题 #context problem_counter.display("1")*: #text
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    prob_block(body)
  }
}

#let information = counter("information")
#let info_block(body) = {
  v(-0.5em)
  block(fill: rgb("#ffffff"), width: 100%, inset: 8pt, radius: 4pt, stroke: rgb("#004979"), body)
}
#let info(text, body) = {
  [
    #set heading(numbering: none)
    #information.step()
    === *重点 #context information.display("1")*: #text
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    info_block(body)
  }
}
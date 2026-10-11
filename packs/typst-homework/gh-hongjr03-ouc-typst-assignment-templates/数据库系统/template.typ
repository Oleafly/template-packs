#import "@preview/numbly:0.1.0": numbly


#let font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif CJK SC",
)
#let cjk-markers = regex("[“”‘’．，。、？！：；（）｛｝［］〔〕〖〗《》〈〉「」【】『』─—＿·…\u{30FC}]+")
#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let pagebreak(fill-rest: false) = {
  if fill-rest {
    v(1fr, weak: true)
  } 
  colbreak()

}

#let assign_class(
  student_id: none,
  student_name: none,
  student_class: none,
  student_no: none,
  course_name: none,
  semester: none,
  teacher_name: none,
  finish_date: none,
  lab_date: none,
  lab_title: none,
  fill-page: false,
  body,
) = {
  set page(
    paper: "a4",
    margin: (top: 2.6cm, bottom: 2.3cm, inside: 2cm, outside: 2cm),
    footer: [
      #set align(center)
      #set text(9pt)
      #context {
        counter(page).display("1")
      }
    ],
  )
  set document(title: lab_title, author: student_name)
  set text(font: (font.main, font.cjk), lang: "zh", region: "cn")
  show cjk-markers: set text(font: font.cjk)
  set heading(
    numbering: numbly(
  "{1:一}、", // use {level:format} to specify the format
  "{2:1}.", // if format is not specified, arabic numbers will be used
  "({3:1})", // here, we only want the 3rd level
),
  )
  set par(justify: true)
  show math.equation.where(block: true): it => block(width: 100%, align(center, it))

  set raw(tab-size: 4)
  show raw: set text(font: (font.mono, font.cjk))
  // Display inline code in a small box
  // that retains the correct baseline.
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)
  show raw: it => {
    show ".": "." + sym.zws
    show "=": "=" + sym.zws
    show ";": ";" + sym.zws
    it
  }

  // Display block code in a larger block
  // with more padding.
  // and with line numbers.
  let style-number(number) = text(gray)[#number]
  show raw.where(block: true): it => {
    align(center)[
      #block(
        fill: luma(240),
        inset: 10pt,
        radius: 4pt,
        width: 100%,
      )[
        #place(top + right, dy: -15pt)[
          #set text(size: 9pt, fill: white, style: "italic")
          #block(
            fill: gray,
            outset: 4pt,
            radius: 4pt,
            // width: 100%,
            context {
                  it.lang
            }
          )
        ]
        #set par(justify: false, linebreaks: "simple")
        #grid(
          columns: (1em, 1fr),
          align: (right, left),
          column-gutter: 0.7em,
          row-gutter: 0.6em,
          // stroke: 1pt,
          ..it.lines.enumerate().map(((i, line)) => (style-number(i + 1), line)).flatten(),
        )

      ]]
  }

  show link: it => {
    set text(fill: blue)
    underline(it)
  }

  set list(indent: 6pt)
  set enum(indent: 6pt)
  set enum(
    numbering: numbly(
      "{1:1})",
      "{2:a}.",
    ),
    full: true,
  )

  counter(page).update(1)
  [
    #show heading: it => {
      set align(center)
      set text(size: 字号.小二, weight: "bold")
      it
    }
    #set text(tracking: 2em)
    #heading(numbering: none, depth: 1)[实验报告]
  ]
  show heading: set block(spacing: 1.5em)
  // show heading: set block(above: 1.4em, below: 1em)

  show heading.where(depth: 1): it => {
    show h.where(amount: 0.3em): none
    set text(size: 字号.小四)
    it
  }

  show heading: it => {
    set text(size: 字号.小四)
    it
  }

  set text(size: 字号.小四)
  set par(first-line-indent: 2em)
  let fakepar = context {
    box()
    v(-measure(block() + block()).height)
  }
  show math.equation.where(block: true): it => it + fakepar // 公式后缩进
  show heading: it => it + fakepar // 标题后缩进
  show figure: it => it + fakepar // 图表后缩进
  show enum: it => {
    // it.numbering + fakepar
    it
    // for item in it.children {
    //   context {
    //     counter(it.numbering).display()
    //   }
    //   [
    //     #item.body
    //   ]
    // }

    fakepar
  }
  // show enum.item: it => {
  //   repr(it)
  //   it
  // }
  show list: it => {
    it
    fakepar
  }
  show grid: it => it + fakepar // 列表后缩进
  show table: it => it + fakepar // 表格后缩进
  show raw.where(block: true): it => it + fakepar

  [
    #set par(justify: true)
    #set text(size: 字号.五号)
    #table(
      align: center + horizon,
      inset: 0.5em,
      columns: (1.2fr, 1.5fr, 1.2fr, 1.9fr, 1.2fr, 2fr),
      [学号], student_id, [姓名], student_name, [专业班级], student_class,
      [上课序号], student_no, [课程名称], course_name, [学期], semester,
      [任课教师],
      teacher_name,
      [完成日期],
      finish_date.display("[year]年[month padding:none]月[day]日"),
      [上机课时间],
      lab_date,
    )
    #v(0em, weak: true)
    #table(
      inset: 0.5em,
      align: center + horizon,
      columns: (1fr, 3fr),
      [实验名称], lab_title,
    )
  ]
  v(0em, weak: true)
  block(
    // align: left + top,
    inset: 1em,
    stroke: 1pt,
    breakable: true,
    body + v(1fr)
  )

}
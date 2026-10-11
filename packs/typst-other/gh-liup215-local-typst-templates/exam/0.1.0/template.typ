#import "@preview/based:0.2.0": base64
#let question-number = counter("question-number")
#let showSolution = state("show-solution", false)
#let question-points = state("question-points", 0)
#let total-points = state("total-points", 0)

#let question(source: "", points: 0, show-points: false,body) = {
  context(question-points.update(points))
  context(total-points.update(x=>
    x + points
  ))
  question-number.step()
  
  context[
    #enum(
      numbering: (n) => {
          [*#n*]
      },
      body-indent: 2em,
      start: question-number.get().at(0)
    )[
      #if source != "" {
        [*(#source)*]
      } 

      // #box(
        // width: 100%,
        // [
          #body
        // ]
      // )
    ]
  ]

  if show-points {
    context {
      align(right)[
        *Total Mark for Question #question-number.get().at(0) = #question-points.get()*
      ]
    }
  }
}

#let subquestion(points: 0,body) = {
  question-number.step(level: 2)
  if points > 0 {
    context(question-points.update(x=>
      x + points
    ))
  }
  context[
    #enum(
      numbering: (n) => {
          [*(#"abcdefghijklmnopqrstuvwxyz".at(n - 1))*]
      },
      body-indent: 2em,
      start: question-number.get().at(1)
    )[#body]
  ]
}

#let subsubquestion(points: 0,body) = {
  question-number.step(level: 3)
  if points > 0 {
    context(question-points.update(x=>
      x + points
    ))
  }
  context[
    #enum(
      numbering: (n) => {
          [*(#("i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x").at(n - 1))*]
      },
      body-indent: 2em,
      start: question-number.get().at(2)
    )[#body]
  ]
}

#let choices(
  options: ()
) = {
  set enum(
    numbering: (n) => {
        [*#"ABCDEFGHIJKLMNOP".at(n - 1)*]
    },
    spacing: 1em,
    body-indent: 2em,
  )
  for value in options {
    enum.item(value)
  }
}

#let oneparchoices(options: ()) = {
  set enum(
    numbering: (n) => {
      [*#"ABCDEFGHIJKLMNOP".at(n - 1)*]
    },
    spacing: 1em,
    body-indent: 2em,
  )

  let onum = 0

  for value in options {
    onum = onum + 1
    box(
      width: 1fr,
      enum.item(onum, value)
    )
  }
}

#let solution(body) = {
  context{ 
    let show-solution = showSolution.final()
    if show-solution {
      block(
        width: 100%,
        inset: 8pt,
        radius: 4pt,
        stroke: 1pt,
        [
          *Solution*
          
          #body
        ], 
      )
      // body
    }
  }
}

// 后缀 英文  suffix

#let answerLines(number: 1, prefix: [], suffix: []) = {
  prefix
  for i in range(1, number + 1) {
    box(
      width: 1fr,
      line(length: 100%, start: (0pt, 25pt), stroke: (dash: "dotted"))
    )
    if i == number {
      suffix
    }
    linebreak()
  }
}

#let cover(class: "AP", year: "2025", month: "Final", exam: "Final Exam", subject: "Subject", duration: "1 hour 30 min") = [

  #box()[
    #par(leading: 2em)[
      #text(size: 28pt, weight: "bold", fill: red)[
        #subject
        #linebreak()
        #class
      ]
    ]
  ]
  #box(width: 1fr)[]
  #box()[
    #par(leading: 2em)[
      #text(size: 28pt, weight: "bold")[
        #month
        #linebreak()
        #year
      ]
    ]
  ]

  #v(1em)

  #text(fill: red, size: 14pt)[#exam]

  #text(size: 14pt)[
    Center No.: #text("_______________")
    #box(width: 1fr)[]
    Class: #text("_______________")

    Candidate No.: #text("____________")
    #box(width: 1fr)[]
    Name: #text("_______________")
  ]

  #v(1em)

  Exam Duration: #text(red)[
    #duration
  ]

  #v(1em)

  Addition Materials: #text(red)[None]

  #line(length: 100%)

  #text(size: 14pt, weight: "bold")[READ THESE INSTRUCTIONS FIRST]

  #text(red)[
    // set the line spacing in the paragraph

    #par(spacing: 0.5em, leading: 0.5em)[
      If you have been given an Answer Booklet, follow the instructions on the front cover of the Booklet.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      Write your Centre number, Candidate number and name on all the work you hand in.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      Write in dark blue or black pen.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      You may use an HB pencil for any diagrams or graphs.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      Do not use staples, paper clips, glue or correction fluid.
    ]

    #v(1em)

    #par(spacing: 0.5em, leading: 0.5em)[
      Answer all questions.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      Give non-exact numerical answers correct to 3 significant figures, or 1 decimal place in the case of angles in degrees, unless a different level of accuracy is specified in the question.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      The use of an electronic calculator is expected, where appropriate.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      You are reminded of the need for clear presentation in your answers.
    ]

    #v(1em)

    #par(spacing: 0.5em, leading: 0.5em)[
      At the end of the examination, fasten all your work securely together.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      The number of marks is given in brackets [ ] at the end of each question or part question.
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      The total number of marks for this paper is #context(total-points.final()).
    ]

    #par(spacing: 0.5em, leading: 0.5em)[
      Questions carrying smaller numbers of marks are printed earlier in the paper, and questions carrying larger numbers of marks later in the paper.
    ]
  ]
]

#let exam_paper(
  font: "Arial",
  header: [],
  class: "",
  year: "2025",
  month: "June",
  exam: "Final Exam",
  duration: "1 hour 30 min",
  subject: "Subject",
  show-solution: false,
  show-cover: true,
  paper-size: "a4",
  student-info: ("姓名", "班级", "年级", "学校"),
  body
) = {
  showSolution.update(show-solution)

  set figure.caption(separator: "")

  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  set text(font: font)

  set list(
    indent: 2em,
    body-indent: 2em
  )

  set par(
    spacing: 1.5em,
    // leading: 1em
  )

  let is-a3-2col = paper-size == "a3-2col"

  // A3 左侧装订边参数
  let a3-inside = 4cm
  let a3-outside = 3cm
  let a3-top = 2.5cm
  let a3-bottom = 2cm

  let common-header = [
    #align(center)[
      #image("header.png", width: 100%)
      #text(size: 18pt, fill: gray)[
        DEPU International Senior Department
      ]
    ]
  ]

  // A3 双栏页眉：两页头部图片
  let dual-header-content = [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1cm,
      align(center)[#image("header.png", width: 100%)],
      align(center)[#image("header.png", width: 100%)],
    )
  ]

  // A3 第一页左侧信息栏与密封线（严格按 examora 方式放在 page.header 中）
  // examora 原式：place(dy: page.height, dx: -margin.inside + 0.5em, rotate(-90deg, ...))
  // 这里仅改参数：让起始点向内偏移少一点，并缩小旋转后 box 的横向宽度，
  // 使 4 个字段全部落在页面可用高度内。
  let a3-seal-content = context {
    if counter(page).get().first() == 1 {
      let n = student-info.len()
      let usable-h = page.height - a3-top - a3-bottom
      let column-width = 7cm
      place(
        dy: usable-h - 15em,
        dx: -1cm,
        rotate(
          -90deg,
          origin: left + bottom,
          place(
            left + bottom,
            box(stroke: none, height: 1em, width: usable-h)[
              #align(center + bottom)[
                #grid(
                  columns: (column-width,) * n,
                  ..student-info.map(field =>
                    text(font: "Kaiti")[#field]
                     + ": " + box(stroke: (bottom: 0.5pt), width: 70%)
                  )
                )

                #v(0.5cm)

                #box(stroke: none, width: 100%)[
                  #place(dy: -0.3em, line(start: (5%, 0%), end: (95%, 0%), stroke: (dash: "dash-dotted")))
                  #place(dx: 17cm, dy: -0.6em, box(fill: white)[#text(size: 10pt, weight: "bold", font: "KaiTi")[密 封 线]])
                ]
              ]
            ],
          ),
        ),
      )
    }
  }

  let a3-header = [
    #dual-header-content
    #a3-seal-content
  ]

  set page(
    paper: if is-a3-2col { "a3" } else { "a4" },
    flipped: is-a3-2col,
    columns: if is-a3-2col { 2 } else { 1 },
    header: if is-a3-2col { a3-header } else { [
      #place(dx: -2.5cm, box(width: 100% + 5cm, height: 100%)[
        #common-header
      ])
    ] },
    background: none,
    margin: if is-a3-2col {
      (top: a3-top, bottom: a3-bottom, inside: a3-inside, outside: a3-outside)
    } else {
      (top: 4cm, left: auto, right: auto, rest: auto)
    },
    numbering: (..nums) => {
      [*#nums.at(0) / #nums.at(1)*]
    },
  )

  if not is-a3-2col and show-cover {
    cover(
      class: class,
      year: year,
      month: month,
      exam: exam,
      duration: duration,
      subject: subject,
    )

    pagebreak()
  }

  body

  // align(center)[
  //   #text(size: 14pt)[
  //     This is the end of this paper
  //   ]
  // ]
}
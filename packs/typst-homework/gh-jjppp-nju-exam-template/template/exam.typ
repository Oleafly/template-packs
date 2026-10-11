#import "common.typ": *

#let exam(
  course_name: "课程名称",
  course_year: 2024,
  semester: 1, // 1 | 2
  department: "计算机学院",
  exam_form: "开卷", // "开卷" | "半开卷" | "闭卷"
  exam_type: "期末", // "期中" | "期末"
  paper_type: "A", // "A" | "B"
  instructors: ("Mable", "Dipper"),
  exam_time: 120,
  show_answer: false,
  mock: false,
  body,
) = [
  #set page(
    numbering: if mock { "1" } else { "第1页，共1页" },
    margin: (
      top: 2cm,
      left: 2cm,
      right: 2cm,
    ),
  )
  #set table(stroke: 0.5pt)
  #set text(
    lang: "zh",
    font: "Times New Roman",
    size: 11pt,
  )
  #set raw(theme: "default.tmTheme")
  #set pagebreak(weak: true)

  #set heading(numbering: "1")
  #show heading: it => {
    context {
      score_states.update(it => {
        it + (state("wjp" + str(it.len()), 0),)
      })
    }
    v(-15pt)
    context {
      table(
        columns: (auto, 1fr),
        align: (left, right),
        stroke: 0pt,
        [#v(10pt) #box(it) #pts(current_problem_score())],
        if mock { } else {
          box[
            #set text(size: 9pt)
            #table(
              columns: (auto, 4em),
              align: (center, center),
              table.header([得分], " "),
              [评分人], " ",
            )
          ]
        },
      )
    }
  }

  #display_answer.update(_ => show_answer)
  #display_score.update(_ => not mock)

  #if mock {
    align(
      center,
      text(17pt)[ Mock Exam Problems #datetime.today().display("([month repr:short] [day])")],
    )
  } else {
    align(
      center,
      text(17pt)[
        南京大学本科#(exam_type)考试试卷（#paper_type 卷）#if show_answer {
        text(red)[标准答案]
      }
      ],
    )
    columns(2)[
      #set text(weight: "bold")
      课程名称： 《#course_name》

      学年学期： #(course_year)-#(course_year + 1) 学年 第 #semester 学期

      开课单位： #department

      考试方式： #exam_form

      #colbreak()
      #align(right)[
        #set text(weight: "regular")

        姓 名：#blank_space(width:60)

        学 号：#blank_space(width:60)

        年 级：#blank_space(width:60)

        专 业：#blank_space(width:60)
      ]
    ]

    align(center)[考试时长：#exam_time 分钟；总分：#context total_problem_score() 分]

    context {
      table(
        columns: (auto,) + (number_of_problems() + 1) * (1fr,),
        align: (center,) * (number_of_problems() + 2),
        table.header([题目], ..(range(1, number_of_problems() + 1).map(id => [#id])), [总分]),
        [得分], ..(range(number_of_problems()).map(_ => " ")), " ",
      )
    }

    let python_builtins = (
      `all`,
      `any`,
      `bool`,
      `dict`,
      `enumerate`,
      `filter`,
      `float`,
      `int`,
      `iter`,
      `len`,
      `list`,
      `map`,
      `max`,
      `min`,
      `pow`,
      `print`,
      `range`,
      `reversed`,
      `round`,
      `sorted`,
      `sum`,
      `zip`,
    )

    [
      注意事项：
      + 试题的难度不是线性递增的，#emphasize[注意时间分配]。在这项测验中，可能有些题目较难，因此你不要在一道题上思考太久，遇到不会答的题目可先跳过，如果有时间再去思考。否则，你可能没有时间完成后面的题目。
      + 代码填空题的#emphasize[正确答案不止一种]。代码填空题答案正确即可得分，错误也不会倒扣分。每空#emphasize[最多只能填一个] Python 语句或表达式，可以直接使用的 Python 内置函数（Python Built-in Functions）包括 #python_builtins.join("，", last: " 和 ")。
    ]
  }

  #set par(spacing: 10pt)
  #set par(leading: 6pt)

  #body
]

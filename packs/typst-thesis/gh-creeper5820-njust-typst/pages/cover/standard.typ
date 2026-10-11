#import "../../common.typ": content-width, fonts, page-margin, size
#import "@preview/cuti:0.4.0": cn-fakebold, fakebold

// ── 封面专用常量 ──

// 信息栏横线
#let line-start = 50mm
#let line-len = content-width - 18.5mm - line-start
#let line-stroke = 0.5pt
#let line-offset = 5.7mm
#let info-start = 158.81mm
#let info-row-gap = 10.82mm
#let major-prefix-gap = 23.74mm

// 标题区
#let title-box-width = 141.57mm
#let title-step = 12.91mm
#let title-line-gap = 9mm

// ── 封面专用函数 ──

// 信息栏通用行（head 左对齐，横线，内容居中；指导教师不用此函数）
#let render-info-head(head) = {
  if type(head) == str {
    [
      #set text(font: fonts.song, size: size.四号)
      #cn-fakebold(text(head))
    ]
  } else {
    head
  }
}

#let info-row(head, value, dy) = {
  place(top + left, dx: 18.51mm, dy: dy)[
    #render-info-head(head)
  ]

  place(top + left, dx: line-start, dy: dy + line-offset)[
    #line(length: line-len, stroke: line-stroke)
  ]

  place(top + left, dx: line-start, dy: dy)[
    #box(width: line-len, align(center)[
      #set text(font: fonts.song, size: size.四号)
      #cn-fakebold(value)
    ])
  ]
}

#let major-prefix = box(width: 34mm, height: 7mm)[
  #set text(font: fonts.song, size: size.四号)
  #place(top + left, dx: 0mm, dy: 0mm)[#cn-fakebold(text[专])]
  #place(top + left, dx: major-prefix-gap, dy: 0mm)[#cn-fakebold(text[业])]
]

// 大标题：按测量宽度自动折行，每行下方画横线
#let cover-title(title) = context {
  let max-width = title-box-width
  let line-width = content-width

  if type(title) != str {
    box(width: title-box-width)[title]
  } else {
    let t = title.trim()
    let lines = ()
    let current = ()
    let measure-line = line => {
      measure(
        text(font: (fonts.times, fonts.hei), size: size.小一)[#line],
      ).width
    }

    if t.contains("\n") {
      for part in t.split("\n") {
        let part = part.trim()
        if part != "" {
          lines = lines + (part,)
        }
      }
    } else {
      for ch in t.clusters() {
        let trial = current + (ch,)
        let trial-line = trial.join()
        if current.len() == 0 or measure-line(trial-line) <= max-width {
          current.push(ch)
        } else {
          let line = current.join().trim()
          if line != "" {
            lines = lines + (line,)
          }
          current = (ch,)
        }
      }

      let line = current.join().trim()
      if line != "" {
        lines = lines + (line,)
      }
    }

    let title-height = if lines.len() == 0 { 0mm } else { title-step * (lines.len() - 1) + 12mm }

    box(width: title-box-width, height: title-height)[
      #for (i, title-line) in lines.enumerate() [
        #place(top + left, dx: 0mm, dy: title-step * i)[
          #box(width: title-box-width)[
            #align(center)[
              #set text(font: (fonts.times, fonts.hei), size: size.小一)
              #fakebold(title-line)
            ]
          ]
        ]

        #place(top + left, dx: 0mm, dy: title-step * i + title-line-gap)[
          #align(center)[#line(length: line-width, stroke: line-stroke)]
        ]
      ]
    ]
  }
}

// ── 封面主函数 ──

#let standard(
  title: "",
  student-name: "",
  student-number: "",
  supervisor-1: (),
  supervisor-2: (),
  department: "",
  major: "",
  research-direction: "",
  date: "",
  heading: "毕业设计（论文）报告",
) = {
  set page(
    paper: "a4",
    margin: page-margin,
    header: none,
    footer: none,
  )

  let short-line-len = content-width / 3
  let short-line-x = (content-width - short-line-len) / 2

  box(width: 100%, height: 243mm)[
    // 校徽
    #place(top + left, dx: 17.56mm, dy: 20.09mm)[
      #image("../../assets/njust.png", width: 125.1mm)
    ]

    // 主标题
    #place(top + left, dx: 19.33mm, dy: 56.53mm)[
      #box(width: 116.17mm, align(center)[
        #cn-fakebold(text(font: fonts.kai, size: 32pt)[#heading])
      ])
    ]

    // 论文标题（自动折行 + 横线）
    #place(top + left, dx: 8.16mm, dy: 85.46mm)[#cover-title(title)]

    // 学生姓名
    #place(top + left, dx: 0mm, dy: 122.13mm)[
      #box(width: content-width, align(center)[
        #cn-fakebold(text(font: fonts.kai, size: size.小二)[#student-name])
      ])
    ]

    #place(top + left, dx: short-line-x, dy: 128.4mm)[
      #line(length: short-line-len, stroke: line-stroke)
    ]

    #place(top + left, dx: 67.42mm, dy: 130.33mm)[
      #box(width: 25.4mm, align(center)[
        #text(font: fonts.song, size: size.小四)[（学生姓名）]
      ])
    ]

    // 学号
    #place(top + left, dx: 70.01mm, dy: 135.53mm)[
      #box(width: 19.52mm, align(center)[
        #cn-fakebold(text(font: fonts.kai, size: size.小二)[#student-number])
      ])
    ]

    #place(top + left, dx: short-line-x, dy: 141.3mm)[
      #line(length: short-line-len, stroke: line-stroke)
    ]

    #place(top + left, dx: 71.65mm, dy: 143.53mm)[
      #box(width: 16.93mm, align(center)[
        #text(font: fonts.song, size: size.小四)[（学号）]
      ])
    ]

    #place(top + left, dx: 18.51mm, dy: info-start + info-row-gap * 0)[
      #set text(font: fonts.song, size: size.四号)
      #cn-fakebold(text[指 导 教 师])
    ]

    #place(top + left, dx: line-start, dy: info-start + info-row-gap * 0 + line-offset)[
      #line(length: line-len, stroke: line-stroke)
    ]

    #if supervisor-2.len() > 0 {
      place(top + left, dx: line-start, dy: info-start + info-row-gap * 1 + line-offset)[
        #line(length: line-len, stroke: line-stroke)
      ]
    }

    #let render-supervisor(items, y) = {
      let n = items.len()
      let area-len = line-len / n
      for (i, item) in items.enumerate() {
        place(top + left, dx: line-start + area-len * i, dy: y)[
          #box(width: area-len, align(center)[
            #set text(font: fonts.kai, size: size.四号)
            #fakebold(item)
          ])
        ]
      }
    }

    #render-supervisor(supervisor-1, info-start + info-row-gap * 0)
    #if supervisor-2.len() > 0 {
      render-supervisor(supervisor-2, info-start + info-row-gap * 1)
    }

    // 信息栏正文起始位置（根据指导教师行数调整）
    #let info-body-start = if supervisor-2.len() > 0 {
      info-start + info-row-gap * 2
    } else {
      info-start + info-row-gap * 1
    }

    // 信息栏
    #info-row("学 生 学 院", department, info-body-start + info-row-gap * 0)
    #info-row(major-prefix, major, info-body-start + info-row-gap * 1)
    #info-row("研 究 方 向", research-direction, info-body-start + info-row-gap * 2)

    // 提交时间
    #let submit-dy = info-body-start + info-row-gap * 3
    #place(top + left, dx: 18.51mm, dy: submit-dy)[
      #set text(font: fonts.song, size: size.四号)
      #cn-fakebold(text[提 交 时 间])
    ]

    #place(top + left, dx: line-start, dy: submit-dy + line-offset)[
      #line(length: line-len, stroke: line-stroke)
    ]

    #place(top + left, dx: line-start, dy: submit-dy)[
      #box(width: line-len, align(center)[
        #for ch in date.clusters() {
          if ch.match(regex("[0-9]")) != none {
            fakebold(text(font: fonts.times, size: size.四号)[#ch])
          } else {
            fakebold(text(font: fonts.song, size: size.四号)[#ch])
          }
        }
      ])
    ]
  ]
}

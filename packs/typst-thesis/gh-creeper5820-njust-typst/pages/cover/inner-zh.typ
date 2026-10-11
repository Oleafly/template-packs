#import "../../common.typ": content-width, fonts, page-margin, size
#import "@preview/cuti:0.4.0": fakebold

#let break-title-zh(title, max-width) = context {
  let t = title.trim()
  if t == "" { return box(width: 0mm, height: 0mm)[] }

  let lines = ()
  let full-w = measure(text(font: fonts.hei, size: 24pt)[#t]).width
  let n-lines = calc.max(1, calc.ceil(full-w / max-width))
  let chars = t.clusters()
  if t.contains("\n") {
    for part in t.split("\n") {
      let part = part.trim()
      if part != "" { lines = lines + (part,) }
    }
  } else if n-lines <= 1 {
    lines = (t,)
  } else {
    let per-line = calc.ceil(chars.len() / n-lines)
    for i in range(0, chars.len(), step: per-line) {
      let end = calc.min(i + per-line, chars.len())
      lines = lines + (chars.slice(i, end).join(),)
    }
  }

  let step = 11.1mm
  let line-h = 9.5mm
  let title-height = if lines.len() == 0 { 0mm } else { step * (lines.len() - 1) + line-h }

  box(width: max-width, height: title-height)[
    #for (i, title-line) in lines.enumerate() [
      #place(top + left, dx: 0mm, dy: step * i)[
        #box(width: max-width)[
          #align(center)[
            #fakebold(text(font: fonts.hei, size: 24pt)[#title-line])
          ]
        ]
      ]
    ]
  ]
}

#let inner-zh(
  title: "",
  student-name: "",
  supervisor-1: (),
  date: "",
) = {
  set page(
    paper: "a4",
    margin: page-margin,
    header: none,
    footer: none,
  )

  box(width: 100%, height: 243mm)[
    // 论文题目（36pt 黑体，自动折行，无下划线）
    #let title-w = content-width + 10mm
    #place(top + left, dx: (content-width - title-w) / 2, dy: 41.3mm)[#break-title-zh(title, title-w)]

    // 作者（小二 楷体，加粗）
    #place(top + left, dx: 38.1mm, dy: 98.5mm)[
      #fakebold(text(font: fonts.kai, size: size.小二)[作\u{3000}\u{3000}者：#student-name])
    ]

    // 指导教师（小二 楷体，加粗）
    #let sup1-name = if supervisor-1.len() >= 1 { supervisor-1.at(0) } else { "" }
    #let sup1-title = if supervisor-1.len() >= 2 { supervisor-1.at(1) } else { "" }
    #place(top + left, dx: 38.1mm, dy: 120.7mm)[
      #fakebold(text(font: fonts.kai, size: size.小二)[指导教师：#sup1-name #sup1-title])
    ]

    // 校名（18pt 宋体）
    #place(top + left, dx: 0mm, dy: 219mm)[
      #box(width: content-width, align(center)[
        #fakebold(text(font: fonts.song, size: size.小二)[南 京 理 工 大 学])
      ])
    ]

    // 日期（18pt TNR bold + 宋体）
    #let date-parts = date.split(regex("[年月]")).filter(s => s.trim() != "")
    #let year = if date-parts.len() >= 1 { date-parts.at(0).trim() } else { "" }
    #let month = if date-parts.len() >= 2 { date-parts.at(1).trim() } else { "" }

    #place(top + left, dx: 0mm, dy: 228.6mm)[
      #box(width: content-width, align(center)[
        #fakebold(text(font: fonts.times, size: size.小二)[#year])
        #fakebold(text(font: fonts.song, size: size.小二)[年])
        #fakebold(text(font: fonts.times, size: size.小二)[#month])
        #fakebold(text(font: fonts.song, size: size.小二)[月])
      ])
    ]
  ]
}

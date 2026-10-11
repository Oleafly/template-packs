// 封面共享组件
// 由 0-thesis-cover.typ 和 0-course-report.typ 调用

#import "../fonts.typ": fonts

// 信息栏表格：label 右对齐加粗、value 居中、仅 value 下加底线
// 用 Typst 原生 table.cell(stroke:) 实现下划线填空，
// 替代手写的 box + v(4pt)/v(-4pt) + line() 技巧
#let cover-info-table(rows) = {
  table(
    columns: (6.5em, 20em),
    align: (right + horizon, center + horizon),
    inset: (x: 0.5em, y: 6pt),
    stroke: none,
    ..rows
      .map(((l, v)) => (
        text(font: fonts.heiti, size: 16pt, weight: "bold")[#l],
        table.cell(stroke: (bottom: 0.7pt))[
          #text(font: fonts.songti, size: 16pt)[#v]
        ],
      ))
      .flatten(),
  )
}

// 封面顶部公共块：校徽 + 校名横幅 + 大标题
// logo-width/banner-width 可覆盖，默认值为课程设计封面所用尺寸
#let cover-header(logo, banner, title, logo-width: 25%, banner-width: 70%) = align(center)[
  #image(logo, width: logo-width)
  #v(0.5cm)
  #image(banner, width: banner-width)
  #v(2cm)
  #text(font: (fonts.arial, fonts.heiti), size: 24pt, weight: "bold")[#title]
  #v(2.5em)
]

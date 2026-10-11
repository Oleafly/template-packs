// 图 / 表 / 公式章节式编号模块
// 依赖 i-figured 包实现带章节前缀（如 图 1-1、公式 (1-1)）的自动编号系统

#import "@preview/i-figured:0.2.4"
// 正文部分编号
#let _set_numbering(body) = {
    show heading: i-figured.reset-counters
    show figure: i-figured.show-figure.with(numbering: "1-1")
    show math.equation: i-figured.show-equation.with(numbering: "(1-1)")
    body
}

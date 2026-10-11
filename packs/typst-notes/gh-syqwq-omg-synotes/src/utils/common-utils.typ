#import "@preview/itemize:0.2.0" as _itemize
#import "@preview/zebraw:0.5.5": zebraw
#import emoji: drops, eyes

#let cn-font-serif = "Source Han Serif SC"  // 思源宋体
#let en-font-serif = "New Computer Modern"
#let cn-font-sans = "Source Han Sans SC"  // 思源黑体
#let en-font-sans = "New Computer Modern Sans"
#let en-font-mono = "Consolas Nerd Font"
#let cn-kaiti = "LXGW WenKai" // 霞鹜文楷
#let cn-kaiti-mono = "LXGW WenKai Mono"
#let qwq = eyes + drops + drops + drops

// 颜色字典
#let colors = (
  "1": rgb("b6710a"),
  "2": rgb("FBACBE"),
  "3": rgb("FFBA49"),
  "purple": rgb("#4f078d"),
  "definition": rgb("#255C99"), // 3 definition
  "problem": rgb("7B0828"), // 4 problem
  "theorem": rgb("4956cf"), // 5 theorem
  "example": rgb("FFD166"), // 6 example
  "remark": rgb("A997DF"), // 7 remark
)

#let dvdcolors = (
  rgb("#9E9E9E"),
  rgb("#F44336"),
  rgb("#E91E63"),
  rgb("#9C27B0"),
  rgb("#673AB7"),
  rgb("#3F51B5"),
  rgb("#2196F3"),
  rgb("#03A9F4"),
  rgb("#00BCD4"),
  rgb("#009688"),
  rgb("#4CAF50"),
  rgb("#8BC34A"),
  rgb("#CDDC39"),
  rgb("#FFEB3B"),
  rgb("#FFC107"),
  rgb("#FF9800"),
  rgb("#FF5722"),
  rgb("#795548"),
  rgb("#9E9E9E"),
)

#let show-common-format(body) = {
  // 字体
  set text(
    font: (
      en-font-serif,
      cn-font-serif,
    ),
    // weight: "light",
  )
  // 代码字体
  show raw: set text(font: (en-font-mono, cn-font-sans), weight: 400)
  // 汉语标点
  show "。": ". "
  // 段落首行缩进
  set par(first-line-indent: 2em)

  // 更好的列表（列表项公式居中）
  show ref: _itemize.ref-enum
  show: _itemize.default-enum-list
  set enum(numbering: "(1)", full: true)

  show: zebraw.with(background-color: luma(249), indentation: 4, hanging-indent: true)

  body
}

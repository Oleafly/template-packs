// 缩进控制与段落间距修复模块
// 提供图 / 行间公式后的首行缩进复位功能，确保每段首行缩进一致性

#let indent() = {
  box(width: 2em)
}
#let indent_par(body) = {
  [
    #box(width: 1.8em)
    #body
  ]
}
#let no_indent(body) = {
  set par(
    first-line-indent: 0em
  )
  body
}
#let empty_par() = {
  [
    #v(-1em)
    #box()
  ]
}
#let _fix_indent(body) = {
  show figure: it => {
    it + empty_par()
  }
  show math.equation.where(block: true): it => {
    it + empty_par()
  }
  body
}
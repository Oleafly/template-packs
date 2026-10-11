#import "../utils.typ": font-size, font-family

// 致谢页
#let acknowledgement-page(body) = {
  // 标题：小2号黑体，居中，段前后各1行，行距22磅，段前分页
  pagebreak()
  v(22pt)
  align(center, text(font: font-family.heiti, size: font-size.xiaoerhao)[
    致#h(2em)谢
  ])
  v(22pt)

  // 内容：小4号宋体，首行缩进2字符，固定行距22磅
  set text(font: font-family.songti, size: font-size.xiaosihao)
  set par(first-line-indent: 2em, leading: 22pt - 1em, justify: true)
  body
}

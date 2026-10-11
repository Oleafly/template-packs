#import "../utils.typ": font-size, font-family

// 学术成果页
#let achievements-page(body) = {
  // 标题：小2号黑体，居中，段前后各1行，行距22磅，段前分页
  pagebreak()
  v(22pt)
  align(center, text(font: font-family.heiti, size: font-size.xiaoerhao)[
    攻读学士学位期间发表的论文和取得的科研成果
  ])
  v(22pt)

  // 内容：小4号宋体，顶格，段首悬进，段前后各0.1行，1.3倍行距
  // 格式与参考文献保持一致
  set text(font: font-family.songti, size: font-size.xiaosihao)
  set par(
    first-line-indent: 0pt,
    leading: 0.55em,
    spacing: 0.55em + font-size.xiaosihao * 0.1 * 2,
    hanging-indent: 2em,
    justify: true,
  )
  body
}

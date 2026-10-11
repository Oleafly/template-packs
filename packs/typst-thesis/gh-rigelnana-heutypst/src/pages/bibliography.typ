#import "../utils.typ": font-size, font-family

// 参考文献页
#let bibliography-page(bib-file) = {
  // 标题：小2号黑体，居中，段前后各1行，行距22磅，段前分页
  pagebreak()
  v(22pt)
  align(center, text(font: font-family.heiti, size: font-size.xiaoerhao)[
    参#h(1em)考#h(1em)文#h(1em)献
  ])
  v(22pt)

  // 内容：小4号宋体，顶格，内容与序号间空半格，段首悬进，段前后各0.1行，1.3倍行距
  // 1.3倍行距(Word标准)：leading = 1.3em - 0.75em = 0.55em
  // 悬挂缩进：序号[1]约1.5em + 半格0.5em = 2em
  set text(font: font-family.songti, size: font-size.xiaosihao)
  set par(
    first-line-indent: 0pt,
    leading: 0.55em,
    spacing: 0.55em + font-size.xiaosihao * 0.1 * 2,  // leading + 段前后各0.1行
    hanging-indent: 2em,
    justify: true,
  )

  bibliography(bib-file, title: none, style: "gb-7714-2015-numeric")
}

#import "../utils.typ": font-size, font-family

// 目录页
#let outline-page() = {
  // 标题：小2号黑体，居中，"目录"间空两字符，段前后各1行，行距22磅，段前分页
  pagebreak()
  v(22pt)  // 段前1行
  align(center, text(font: font-family.heiti, size: font-size.xiaoerhao)[
    目#h(2em)录
  ])
  v(22pt)  // 段后1行

  // 目录内容：固定行距22磅
  set text(font: font-family.songti, size: font-size.xiaosihao)
  set par(leading: 22pt - 1em)

  // 章标题：小4号黑体，顶格
  show outline.entry.where(level: 1): it => {
    set text(font: font-family.heiti, size: font-size.xiaosihao)
    v(22pt - 1em, weak: true)
    it
  }
  // 节标题：小4号宋体，空两字符
  show outline.entry.where(level: 2): it => {
    set text(font: font-family.songti, size: font-size.xiaosihao)
    v(22pt - 1em, weak: true)
    pad(left: 2em, it)
  }
  // 条标题：小4号宋体，空四字符
  show outline.entry.where(level: 3): it => {
    set text(font: font-family.songti, size: font-size.xiaosihao)
    v(22pt - 1em, weak: true)
    pad(left: 4em, it)
  }

  outline(title: none, indent: 0pt, depth: 3)
}

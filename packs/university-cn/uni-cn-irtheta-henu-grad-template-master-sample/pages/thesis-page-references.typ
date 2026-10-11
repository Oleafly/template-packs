// 参考文献生成及排版模块
// 采用国标 gb-7714-2015 样式，自动生成带适当缩进和格式的文献列表

#let _set_references(csl_style: "china-national-standard-gb-t-7714-2015-numeric.csl", body) = {
    set bibliography(style: csl_style, title: "参考文献")
    show bibliography: it => {
      // 将参考文献标题强制设为一级标题、无编号，并应用标准文献段落缩进
      set heading(level: 1, numbering: none)
      set par(justify: false, leading: 1.24em, first-line-indent: 0em, hanging-indent: 2em)
      it
    }
    body
}
// 致谢页排版与落款模块
// 包含作者姓名的自动字间距处理及精确的右对齐落款日期

#import "../fonts/font-def.typ": * 
#import "../utilities/indent-funcs.typ": * 

#let page_acknowledgement(author: "", date: (), body) = {
  // 字符串处理：将输入的姓名逐字拆分，加入全角空格实现自动字间距
  let spaced = {
      let result = ""
      for c in author {
        result += c + "　"  // 用全角空格，若需半角空格改为 " "
      }
      result.trim()  // 去掉末尾多余的空格
    }
  
  // 禁用一级标题编号，并将“致谢”居中渲染
  set heading(level: 1, numbering: none) 
  show <_acknowledgement>: {
          align(center)[
          #text(font: heiti, 14pt, weight: "regular")[致　谢]
      ]
  } + empty_par() // 修复标题后第一行不缩进
  
  // 顶部精确间距与标题插入
  [
    #v(13.2mm)
    = 致谢 <_acknowledgement>
    #v(10.2mm)
  ]
  body
  // 落款区：作者姓名和日期统一右对齐，并采用特定水平间距补偿
  v(4mm)
  align(right)[
    #text(font: songti, 12pt)[#spaced#h(6em)]
  ]
  v(4mm)
  align(right)[
    #text(font: songti, 12pt)[#date.at(0)#h(0.7em)年#h(0.7em)#date.at(1)#h(0.7em)月#h(5em)]
  ]
}
// 附录页排版模块
// 提供“附录”主标题的居中样式，并统一二级附录（如附录 A、附录 B）的不编号层级

#import "../fonts/font-def.typ": * 
#import "../utilities/indent-funcs.typ": * 

#let page_appendix(body) = {
  set heading(level: 1, numbering: none) 
  show <_appendix>: {
          align(center)[
          #text(font: heiti, 14pt, weight: "regular")[附　录]
      ]
  } + empty_par()
  
  // 控制主标题“附录”及其上方下方与正文的精确物理间距
  [
    #v(13.2mm)
    = 附录 <_appendix>
    #v(10.2mm)
  ]
  
  // 后续内容切换至对齐排版，且强制二级标题（附录A、B）无编号
  set par(justify: false)
  set heading(level: 2, numbering: none)
  
  body
}
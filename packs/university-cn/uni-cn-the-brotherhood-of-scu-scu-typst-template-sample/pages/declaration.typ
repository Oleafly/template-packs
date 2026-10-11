#import "../fonts/font-def.typ": *

// 原创性声明和授权书
#let declaration(anonymous: false) = {
  // 取消目录里的 number
  set heading(level: 1, numbering: none)
  show <_thx>: {
    // 这个取消展示时的 numbering
    set heading(level: 1, numbering: none)
    set align(center)
    set text(font: songti, size: 14pt, weight: "regular")
    "声　　明"
  }

  [= 声明 <_thx>]
  text(font: songti, size: 10.5pt, tracking: -0.5pt)[
    #set par(justify: false, leading: 1.24em, first-line-indent: 2em, spacing: 10pt)
    本人声明所呈交的学位论文是本人在导师指导下进行的研究工作及取得的研究成果。据我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得四川大学或其他教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示谢意。
    
    本学位论文成果是本人在四川大学读书期间在导师指导下取得的，论文成果归四川大学所有，特此声明。

    #linebreak()
    #align(left)[
      作者签名：　　　　　　　 导师签名：　　　　　　　
    ]
    #linebreak() 

    #h(75pt)　　　　　　　年　　月　　日
  ]
  
  v(6em)
  // 取消目录里的 number  
  set heading(level: 1, numbering: none)
  show <_thx>: {
    // 这个取消展示时的 numbering
    set heading(level: 1, numbering: none)
    set align(center)
    set text(font: songti, size: 14pt, weight: "regular")
    "学位论文版权使用授权书"
  }

  // 手动覆盖原先标题的设定
  [= 学位论文版权使用授权书 <_thx>]
  text(font: songti, size: 10.5pt, tracking: -0.5pt)[
    #set par(justify: false, leading: 1.24em, first-line-indent: 2em, spacing: 10pt)
    #if not anonymous [
      本学位论文作者完全了解四川大学有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或相关机构送交论文的原件、复印件和电子版，允许论文被查阅和借阅。本人授权四川大学将本学位论文的全部或部分内容编入有关数据库进行信息技术服务，可以采用影印、缩印或扫描等复制手段保存、汇编学位论文，并用于学术活动。
      
      （涉密学位论文在解密后适用于本授权书）
    ] else [
      本学位论文作者完全了解学校有关保障、使用学位论文的规定，同意学校保留并向有关学位论文管理部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权█████████████将本学位论文的全部或部分内容编入有关数据进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。
    ]

    #linebreak() 
    #align(left)[
      作者签名：　　　　　　　 导师签名：　　　　　　　
    ]
    #linebreak() 

    #h(75pt)　　　　　　　年　　月　　日
  ]
}

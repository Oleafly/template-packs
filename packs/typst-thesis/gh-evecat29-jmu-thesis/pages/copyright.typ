#import "@preview/pointless-size:0.1.2": zh

#let copyright(cjk, info) = {
  let (song, hei, kai, fang) = cjk

  // 独立页面配置
  set page(
    header: none, 
    footer: none, 
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm)
  )
  set align(center)
  
  // 正文宋体
  song[
    #set text(size: zh("小四"))
    
    // 大标题
    #v(1em)
    #align(center)[
      #hei[#text(size: zh("三号"), weight: "bold")[集美大学本科毕业论文（设计）版权使用授权书]]
    ]
    #v(1.5em)
    
    #table(
      columns: (70pt, 70pt, 45pt, 100pt, 65pt, 1fr),
      stroke: 0.5pt,
      align: center + horizon, // 全局文本居中
      inset: 0.8em,

      // 第一行
      table.cell(colspan: 2)[毕业论文（设计）题目], 
      table.cell(colspan: 4, align: left + horizon)[#pad(left: 0.2em, info.title)],

      // 第二行
      [学生姓名], info.name, 
      [学号], info.id, 
      [专业], info.class,

      // 第三行
      [所在学院], 
      table.cell(colspan: 2)[#info.school],       // 占第 2、3 列
      [指导教师], 
      table.cell(colspan: 2)[#info.supervisor],   // 占第 5、6 列

      // 授权书
      table.cell(colspan: 6, align: left + top)[
        #block(height: 480pt, width: 100%)[
          #v(1em)
          #align(center)[
            #hei[#text(size: zh("四号"), weight: "bold")[版权使用授权书]]
          ]
          #v(1.5em)

          #set par(first-line-indent: 2em, leading: 1.5em, justify: true)
          本毕业论文（设计）作者同意集美大学保留和使用本毕业论文（设计），并向国家有关部门或机构送交毕业论文（设计）的复印件和电子版，允许毕业论文（设计）被查阅和借阅。本人授权，集美大学可以将本毕业论文（设计）的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本毕业论文（设计）。

          本毕业论文（设计）属于：

          □ 1. 不保密，适用上述授权。

          □ 2. 保密，在 #box(width: 30pt, stroke: (bottom: 0.5pt)) 年 #box(width: 30pt, stroke: (bottom: 0.5pt)) 月解密后适用本授权。

          #v(1em)
          #par(first-line-indent: 0pt)[
            (请在以上方框内打“√”，不填写的默认为公开毕业论文（设计），适用上述授权。)
          ]

          #v(1fr) 

          // 签名与日期
          #grid(
            columns: (1fr, 1fr),
            align(center)[
              #box(width: 14em, align(left)[
                作者签名： \
                #v(2.5em)
                #align(right)[年 #h(1.5em) 月 #h(1.5em) 日]
              ])
            ],
            align(center)[
              #box(width: 14em, align(left)[
                指导教师签名： \
                #v(2.5em)
                #align(right)[年 #h(1.5em) 月 #h(1.5em) 日]
              ])
            ]
          )
          #v(1em)
        ]
      ]
    )
  ]
  pagebreak()
}
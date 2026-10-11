#import "@preview/pointless-size:0.1.2": zh

#let integrity(cjk, info) = {
  let (song, hei, kai, fang) = cjk

  // 独立页面配置
  set page(
    header: none, 
    footer: none, 
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm)
  )
  set align(center)
  
  song[
    #set text(size: zh("小四"))
    
    // 大标题
    #v(1em)
    #align(center)[
      #hei[#text(size: zh("三号"), weight: "bold")[集美大学本科毕业论文（设计）诚信书]]
    ]
    #v(1.5em)
    
    #table(
      columns: (70pt, 70pt, 45pt, 110pt, 45pt, 1fr),
      stroke: 0.5pt,
      align: center + horizon,
      inset: 0.8em,

      // 第一行
      table.cell(colspan: 2)[毕业论文（设计）题 目], 
      table.cell(colspan: 4)[#info.title],

      // 第二行
      [学生姓名], info.name, 
      [专业], info.major, 
      [学号], info.id,

      // 第三行
      [指导老师], 
      table.cell(colspan: 2)[#info.supervisor],
      [职称], 
      table.cell(colspan: 2)[#info.rank],

      // 第四行
      [所在学院], table.cell(colspan: 5)[#info.school],

      // 诚信书正文
      table.cell(colspan: 6, align: left + top)[
        #block(height: 420pt, width: 100%)[
          #v(1em)
          #align(center)[
            #hei[#text(size: zh("四号"), weight: "bold")[诚信书]]
          ]
          #v(1.5em)

          #set par(first-line-indent: 0pt, leading: 1.5em, justify: true)
          本人郑重承诺和声明：
          
          #h(2em)我承诺在毕业论文（设计）活动中遵守学校有关规定，恪守学术规范，在本人的毕业论文（设计）中未剽窃、抄袭他人的学术观点、思想和成果，未篡改研究数据，如有违规行为发生，我愿承担一切责任，接受学校的处理。

          #v(1fr) 
          
          #align(right)[
            #box(width: 16em)[
              #set par(first-line-indent: 0pt)
              #grid(
                columns: 1,
                row-gutter: 1.5em,
                align: left,
                [学生（签名）： #box(width: 100pt, stroke: (bottom: 0.5pt))],
                align(right)[
                  #info.date.year 年 #h(1.5em) 月 #h(1.5em) 日
                ]
              )
            ]
            #h(1em)
          ]
          #v(1em)
        ]
      ]
    )
    
    // 底部备注
    #set par(first-line-indent: 0pt)
    #align(left)[
      #set text(size: zh("四号"))
      备注：本表存入学生毕业论文（设计）资料袋。
    ]
  ]
  pagebreak()
}
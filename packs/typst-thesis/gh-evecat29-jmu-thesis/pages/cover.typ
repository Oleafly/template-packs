#import "@preview/pointless-size:0.1.2": zh
#import "@preview/zh-format:0.1.0": u
#import "@preview/cuti:0.4.0": cn-fakebold
#let cover(cjk, info) = {
  let (song, hei, kai, fang) = cjk
  
  let justify-text(txt) = txt.clusters().join(h(1fr))
  let label-box(txt) = box(width: 4em, justify-text(txt))

  // 个人信息
  let field(label, value) = grid(
    columns: (auto, 1fr),
    column-gutter: 0.5em,
    align: (left + horizon, center + bottom),
    kai(text(size: zh("小二"), label-box(label))),
    box(
      width: 100%,
      stroke: (bottom: 1pt),
      pad(bottom: 0.2em, hei(text(size: zh("三号"), value)))
    )
  )

  let date-item(val, width: 3em) = box(
    width: width, 
    stroke: (bottom: 0pt),
    align(center, val)
  )

  // 独立页面配置
  set page(
    header: none, 
    footer: none, 
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm)
  )
  set align(center)
  
  v(2cm)

  // Logo
  grid(
    columns: (auto, auto), 
    gutter: 1em, 
    align: horizon,
    image("jmulogo.svg", height: 7em),
    grid(
      rows: (auto, auto), 
      row-gutter: 0.5em, 
      align: center,
      image("jmuword.svg", height: 4em),
      text(size: zh("三号"), fill: rgb("#e60012"), tracking: 0.08em, weight: "bold")[JIMEI UNIVERSITY]
    )
  )
  
  v(1cm)
  cn-fakebold(kai(text(size: zh("小初"), info.type)))
  
  v(2cm)
  set par(first-line-indent: 0pt)
  grid(
    columns: (auto, 1fr),
    align: (left + horizon, left + bottom),
    
    pad(top: -2.6em, cn-fakebold(kai(text(size: zh("二号"), "题目  ")))),
    {
      let row-h = 2.5em 
      let lines = 2
      let font-size = zh("二号")
      
      box(width: 100%, height: row-h * lines)[
        // 底层横线
        #place(top, stack(
          spacing: 3pt, 
          ..(box(width: 100%, height: row-h, stroke: (bottom: 1pt)),) * lines
        ))
        #place(top, pad(
          top: 0.5em, // 微调对齐
          par(leading: row-h - 1em, justify: true, hei(text(size: font-size, info.title)))
        ))
      ]
    }
  )
  
  v(4cm)
  
  // 元数据
  cn-fakebold(grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    row-gutter: 1.8em,
    
    field("学院", info.school),
    field("专业", info.major),
    field("年级", info.grade),
    field("班级", info.class),
    field("姓名", info.name),
    field("学号", info.id),
    field("指导老师", info.supervisor),
    field("职称", info.rank),
  ))
  
  v(3cm)
  
  // 日期
  cn-fakebold(song(text(size: zh("小四"))[
    #date-item(info.date.year, width: 2em) 年 
    #date-item(info.date.month, width: 1em) 月 
    #date-item(info.date.day, width: 1em) 日
  ]))

  pagebreak()
}
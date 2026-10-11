// 改进的GOODLAB周报模板 (兼容Typst 0.13+)
// 添加了自动日期更新功能


#let project(title: "", authors: (), date: none, body) = {
  // 设置页面属性
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    numbering: "1",
  )
    // 设置字体
  set text(
    font: (
      "Times New Roman",
      "SimSun"
    ),
    fallback: true,
    size: 11pt,
    lang: "zh",
  )
  
  // 获取当前日期 - 自动更新为最新日期（英文格式）
  let current_date = if date == none {
    datetime.today().display("[month repr:long] [day], [year]")
  } else {
    date
  }
  
  // 段落缩进和对齐
  set par(
    first-line-indent: 2em,
    justify: true,
    leading: 1.4em,
  )
    // 标题样式
  set heading(
    numbering: "1.1.",
  )
  
  // 自定义标题样式
  show heading: it => {
    set text(weight: "bold")
    if it.level == 1 {
      set text(font: ("Times New Roman", "SimSun"), size: 16pt)
      v(1em)
      block[#it.body]
      v(0.8em)
    } else if it.level == 2 {
      set text(font: ("Times New Roman", "SimSun"), size: 14pt)
      v(0.8em)
      block[#it.body]
      v(0.5em)
    } else {
      block[#it.body]
      v(0.2em)
    }
  }
    // 标题页
  align(center)[
    #v(3cm)
    
    // 上方淡横线
    #line(length: 70%, stroke: (thickness: 0.5pt, paint: rgb(180, 180, 180)))
    
    #v(1cm)
    
    // 标题
    #text(
      size: 24pt,
      weight: "bold",
      upper(title)
    )
    
    #v(1cm)
    
    // 下方粗横线
    #line(length: 70%, stroke: (thickness: 1.2pt, paint: rgb(50, 50, 50)))
    
    #v(0.8cm)
    
    // 日期
    #text(
      style: "italic",
      size: 14pt
    )[#current_date]
    
    #v(3cm)
    
    // 作者信息 - 增加行间距并使用粗体
    #stack(
      spacing: 1em,
      ..authors.map(author => text(
        weight: "semibold",
        size: 13pt, 
        author
      )),
    )
  ]
  
  // 目录和正文之间的分隔
  pagebreak()
    // 正文
  body
}

// 列表样式
set list(
  indent: 2em,
  spacing: 0.65em,
)

set enum(
  indent: 2em,
  spacing: 0.65em,
)

// 表格样式
set table(
  inset: 8pt,
  stroke: 0.7pt,
)

// 图形样式
set figure(
  placement: auto,
)

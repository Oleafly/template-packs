// 上海交通大学课程报告模板样式文件
// Typst 版本
// 原LaTeX模板: https://github.com/Jiazhen-Lei/SJTU_Course_Template_Latex

// 文本框函数

#let MAIN = ("New Computer Modern", "SimSun")
#let TITLE = ("New Computer Modern", "Noto Sans SC")
#let KAI = ("New Computer Modern", "KaiTi")

#let tbox(content) = {
  align(center)[
    #box(
      fill: gray.lighten(90%),
      stroke: 0.5pt + black,
      radius: 2pt,
      inset: 8pt,
      width: 8cm,
      content
    )
  ]
}

// 主模板函数
#let sjtu-report(
  title: "课程报告",
  lang: "zh",
  subtitle: "",
  school: "学院名称",
  class: "班级",
  student-id: "学号", 
  author: "姓名",
  date: datetime.today(),
  header: "上海交通大学",
  logo: "figures/sjtu_logo_notitle_page-0001.jpg", // 可选，校徽路径
  body
) = {
  
  // 文档基本设置
  set document(
    title: title,
    author: author,
    date: date,
  )
  
  // 页面设置
  set page(
    paper: "a4",
    margin: 2.5cm,
    header: if header != "" {
      align(center)[
        #set text(font: MAIN, size: 10pt)
        #header
      ]
    } else { none },
    header-ascent: 1cm,
    numbering: "1",
  )
  
  // 字体设置
  set text(
    font: MAIN,
    size: 10.5pt,
    lang: "zh",
    region: "cn",
  )

  set par(first-line-indent: 2em, justify: true, leading: 1em)
  
  set heading(numbering: "1.1")

  
// 标题设置
show heading.where(level: 1): it => {
    v(0.5em)
    set text(font: TITLE, size: 18pt, weight: "bold")
    set par(
      first-line-indent: 0em,
      leading: 1em,
    )
    align(center)[
      #if it.body != [参考文献] and it.body != [目录] {
          counter(heading).display("一、")
          it.body
        }else {
        it.body
      }
    ]
    v(0.5em)
}

show heading.where(level: 2): it => {
  // v(0.5em)
  set text(font: TITLE, size: 16pt, weight: "bold") 
  set par(
    first-line-indent: 0em,
    leading: 1em,
  ) 
  counter(heading).display()
  it.body
  // v(0.5em)
}
  
  // 数学公式设置
  set math.equation(numbering: "(1)")
  
  // 图表编号设置
  set figure.caption(separator: [ ])
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  
  // 参考文献设置
  set bibliography(style:"gb-7714-2015-numeric")
  
  // 链接设置
  show link: set text(fill: blue)
  
  // 封面页
  page(
    margin: 2.5cm,
    header: none,
    footer: none,
    numbering: none,
  )[
    #set align(center)
    
    // 校徽/校名logo
    #if logo != none {
      v(2cm)
      image(logo, width: 40%)
    } else {
      v(5cm)
    }
    
    // 标题
    #v(if logo != none { 1cm } else { 3cm })
    #set text(font: TITLE, size: 24pt, weight: "bold")
    #title
    
    #v(1cm)
    #set text(font: KAI, size: 18pt, weight: "bold")
    #if subtitle != "" {
      subtitle
    }
    
    #v(if logo != none { 2cm } else { 3cm })
    
    // 个人信息
    #set text(font: KAI, size: 16pt, weight: "regular")
    #grid(
      columns: 2,
      column-gutter: 0cm,
      row-gutter: 0.8cm,
      align: center,
      [学院], [#underline(
        pad(
          left: 1em,
        )[#school]
      )],
      [班级], [#underline(
        pad(
          left: 1em,
        )[#class]
      )],
      [学号], [#underline(
        pad(
          left: 1em,
        )[#student-id]
      )],
      [姓名], [#underline(
        pad(
          left: 1em,
        )[#author]
      )],
    )
    
    #v(2cm)
    #set text(font: MAIN, size: 14pt)
    #date.display("[year]年[month]月[day]日")
  ]
  
  // 目录页
  page(
    header: none,
    footer: none,
    numbering: none,
  )[
    #show outline: it => {
      show heading: title => {
        set align(center)
          set text(
            font: TITLE,
            size: 18pt,
          )
          title
          v(1em)
      }
      it
  }
    #show outline.entry: it => {

      v(0.5em, weak: false)
      set text(
        font: MAIN,
        size: 10.5pt,
      )
      if(it.level == 1){
        set text(
          font: TITLE,
          size: 16pt,
          weight: "bold",
        )
        it
      }
      if(it.level == 2){
        set text(
          font: MAIN,
          size: 14pt,
        )
        it
      }
  }

    #outline(
      indent: 2em,
      depth: 3,
    )
  ]

  // 正文页码从1开始
  counter(page).update(1)
  
  // 正文内容
  body
  
  // 参考文献
  bibliography("reference.bib", title: auto)
}

#let three-line-table(column_num, cells) = {
  let toprule = table.hline(stroke: 0.08em)
  let bottomrule = toprule
  let midrule = table.hline(stroke: 0.05em)
  set align(center)
  table(
    columns: column_num,
    stroke: none,
    toprule,
    table.header(..cells.slice(0, count: column_num)),
    midrule,
    ..cells.slice(column_num),
    bottomrule
  )
}
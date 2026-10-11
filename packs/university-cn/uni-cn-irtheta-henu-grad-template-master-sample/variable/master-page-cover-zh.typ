// 中文封面页样式模块

#import "../fonts/font-def.typ": *

#let page_cover_zh(
  anonymous: false, 
  unit_code: "", 
  id: "", 
  category_code: "", 
  title_zh: "", 
  college_name: "", 
  discipline_major: "", 
  research_area: "", 
  applied_degree_zh: "", 
  applicant_zh: "", 
  supervisor_zh: "", 
  date_zh: (), 
) = {
  // 盲审逻辑：根据参数无缝切换 Logo 和隐藏个人信息
  let logo_path = if not anonymous {"/assets/Henu-Logo.png"} else {"/assets/Henu-Logo-black.png"}
  
  set page(paper: "a4", margin: (left: 2.1cm, right: 2.1cm, top: 2.4cm, bottom: 2.4cm))
  
  let info_l(body) = {
    set align(center)
    text(font: fangsong, 10pt)[#body]
  }
  let info_r(anonymous, body) = {
    set align(center)
    body = if not anonymous {body} else {[███████]}
    text(font: fangsong, 10pt)[#body]
  }
  let info_value(anonymous, body) = {
    let body = if not anonymous {body} else {[███████]}
    [
      #set align(left)
      #set text(font: heiti, 14pt, tracking: 2pt)
      #h(4.5mm)#body
    ]
  }
  set page(
    foreground:  {
      // 下方信息栏：用 place 强制固定绝对物理坐标，确保排版不受上方元素影响
      place(
        dx: 6cm,
        dy: 17.5cm,   
        align(center)[
          // 下方信息网格：用精确的 #h(...) 手拆字间距，强行把不同字数的标签在物理长度上拉平
          #grid(
            columns: (auto, auto), 
            rows: (5mm, 5mm),
            row-gutter: 6.3mm, 
            stroke: none,  
            align: center + horizon, 
            [
              #set text(font: heiti, 14pt)
              #align(center)[培#h(6.67mm)养#h(6.67mm)方#h(6.67mm)向#h(5mm)：]
            ], 
            info_value(anonymous, college_name), 
            [
              #set text(font: heiti, 14pt)
              #align(center)[学#h(3.75mm)科#h(3.75mm)、#h(3.75mm)专#h(3.75mm)业#h(5mm)：]
            ], 
            info_value(anonymous, discipline_major),
            [
              #set text(font: heiti, 14pt)
              #align(center)[研#h(6.67mm)究#h(6.67mm)方#h(6.67mm)向#h(5mm)：]
            ], 
            info_value(anonymous, research_area), 
            [
              #set text(font: heiti, 14pt)
              #align(center)[申#h(2mm)请#h(2mm)学#h(2mm)位#h(2mm)类#h(2mm)别#h(5mm)：]
            ], 
            info_value(anonymous, applied_degree_zh), 
            [
              #set text(font: heiti, 14pt)
              #align(center)[申#h(12.5mm)请#h(12.5mm)人#h(5mm)：]
            ], 
            info_value(anonymous, applicant_zh), 
            [
              #set text(font: heiti, 14pt)
              #align(center)[指#h(6.67mm)导#h(6.67mm)教#h(6.67mm)师#h(5mm)：]
            ], 
            info_value(anonymous, supervisor_zh)
          )
        ]
      )
      place(
        center,
        dy: 25.68cm,
        text(font: heiti, 14pt)[#date_zh.at(0)#h(4mm)年#h(4mm)#date_zh.at(1)#h(4mm)月]
      )
    }
  )
  [
    #set align(left)
    // 顶部信息栏表格，严格复刻 A4 物理尺寸
    #grid(
      columns: (68.89pt, 88.44pt), 
      rows: (25.23pt, 25.23pt, 25.23pt), 
      stroke: 0.5pt, 
      align: center + horizon, 
      info_l("单 位 代 码"), 
      info_r(anonymous, unit_code), 
      info_l("学 　 　 号"), 
      info_r(anonymous, id), 
      [
        #set align(center)
        #text(font: fangsong, 10pt)[
          分#h(9pt)类#h(9pt)号
        ]
      ], 
      info_r(anonymous, category_code)
    )
    #set align(center)
    #v(51pt)
    // 核心展示区：用 stack 硬控垂直距离，防止排版引擎的段落间距问题
    #stack(
      dir: ttb, spacing: 0pt, 
      image(logo_path, width: 66mm, height: 15.5mm), 
      v(22pt), 
      text(font: songti, 42pt, weight: "bold")[
        硕#h(20.3pt)士#h(20.3pt)学#h(20.3pt)位#h(20.3pt)论#h(20.3pt)文
      ], 
      v(70pt), 
      rect(
        width: 12.9cm, 
        stroke: none, 
        [
          #set par(leading: 1em)
          #set text(font: heiti, 17pt, weight: "bold")
          #title_zh
        ]
      )
    )
  ]
  set page(foreground: none)
  pagebreak()
}

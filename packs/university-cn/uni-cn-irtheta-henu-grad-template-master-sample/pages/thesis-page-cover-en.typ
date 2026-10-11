// 英文封面页样式模块

#import "../fonts/font-def.typ": *

#let page_cover_en(
  anonymous: false, 
  title_en: "", 
  applied_degree_en: "", 
  applicant_en: "", 
  supervisor_en: "", 
  date_en: ()
) = {
  // 盲审模式：隐匿申请人及导师姓名
  if anonymous {
    applicant_en = {"███████"}
    supervisor_en = {"███████"}
  }

  set page(
    foreground:  {
      // 英文声明块：用 place 强制固定绝对物理坐标，确保排版不受上方元素影响
      place(
        center,
        dy: 11.6cm,   
        align(center)[
          #set par(leading: 6.5mm)
          #text(font: songti, 15pt)[A Dissertation Submitted to \
          the Graduate School of Henan University \
          in Partial Fulfillment of the Requirements \
          for the Degree of \
          #applied_degree_en]
          #v(45mm)
          #set text(font:songti, 15pt)
          #set par(leading: 7mm)
          #set align(center)
          By

          #text(font: songti, 15pt, style: "italic")[#applicant_en]

          Supervisor: #supervisor_en

          Date: #date_en.at(1). #date_en.at(0)

        ]
      )
    }
  )
  set align(center)
  // 英文封面正文流：对齐并堆叠主标题、作者、导师与日期
  stack(
    v(20mm), 
    rect(
      width: 12cm,
      stroke: none, 
      [
        #set align(center)
        #set par(leading: 6.5mm)
        #text(font: songti, 15pt, weight: "bold")[#title_en]
      ]
    )
  )
  // 清理刚才使用的 foreground 定位
  set page(foreground: none)
  pagebreak()
}
#import "utils.typ" : *

// --- 封面 ---
#set page(header: none, footer: none, numbering: none)
#place(
  top + left,
  rect(
    width: 100%,
    height: 100%,
    stroke: (paint: rgb(52, 113, 176), thickness: 2pt),
    fill: none,
  ),
)
#align(center, [
  #cover-image("images/电子科技大学-logo-512px.png", width: 18%)
  #v(25pt)
  #rect(
    stroke: (dash: "dashed", thickness: 1pt),
    inset: (top: 20pt, right: 20pt, bottom: 20pt, left: 20pt),
    text(font: font-cn, size: 26pt, weight: "bold")[信息与软件工程学院],
  )
  #block(
    spacing: 15pt,
    text(font: font-title, size: 28pt, weight: "bold")[企业实习总结报告],
  )
  #v(50pt)
  #block(
    width: 100%,
    inset: (left: 11%, right: 11%),
    [
      #set text(
        font: font-cn,
        size: 16pt,
      )
      #let underlined-text(content) = {
        block(
          width: 100%,
          [
            #content
            #place(
              bottom,
              dy: 2pt,
              line(length: 100%, stroke: 1pt + black),
            )
          ],
        )
      }
      #grid(
        columns: (4fr, 7fr),
        align: (left, center),
        row-gutter: 40pt,
        [学　　号：], underlined-text([在此填写学号]),
        [姓　　名：], underlined-text([在此填写姓名]),
        [专业方向：], underlined-text([在此填写专业方向]),
        [企业名称：], underlined-text([在此填写企业名称]),
        [实习岗位：], underlined-text([在此填写实习岗位]),
        [企业指导教师：], underlined-text([在此填写企业指导教师]),
        [院内指导教师：], underlined-text([在此填写院内指导教师]),
      )
    ],
  )
])

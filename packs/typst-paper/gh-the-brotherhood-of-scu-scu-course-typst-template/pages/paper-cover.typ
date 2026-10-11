// 默认本科生毕业论文的封面 (CS 格式)
#import "../fonts/font-def.typ": *

#let paper_cover(cover_logo_path: "../assets/scu_black.png", anonymous, report_name, title, school, author, id, date, grade, major) = {
  align(center)[
    // hust logo
    #v(20pt)

    // 匿名化处理需要去掉个人、机构信息
    #let logo_path = cover_logo_path

    // 学校名称 png
    #image(logo_path)

    #text(
      size: 22pt,
      font: songti,
      weight: "bold",
      tracking: 5pt,
    )[#report_name]
    #v(20pt)

    // scu logo
    #image("../assets/scu_logo_black.png", width: 25%)

    #v(20pt)

    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 1pt,
        stroke: (
          bottom: 1pt + black,
        ),
        text(
          font: fangsong,
          size: 16pt,
          bottom-edge: "descender",
          weight: "bold",
        )[
          #body
        ]
      ) 
    }
    
    #let info_key(body) = {
      text(
        font: fangsong,
        size: 16pt,
        weight: "bold",
      )[
        #body
      ]
    }

    #v(20pt)

    #grid(
      columns: (70pt, 300pt),
      rows: (25pt),
      gutter: 3pt,
      info_key("题　　目"),
      info_value(title),
      info_key("学　　院"),
      info_value(if not anonymous { school } else { "██████████" }),
      info_key("专　　业"),
      info_value(if not anonymous { major } else { "██████████" }),
      info_key("学生姓名"),
      info_value(if not anonymous { author } else { "██████████" }),
      info_key("学　　号"),
      grid(
        columns: (8fr, 2fr, 5fr),
        info_value(if not anonymous { id } else { "██████████" }),
        info_key("年级"),
        info_value(if not anonymous { grade } else { "███████" }),
      ),
    )
    #v(130pt)



    #text(
      font: fangsong,
      size: 16pt,
      weight: "bold",
    )[
      #date.at(0) 年 #date.at(1) 月 #date.at(2) 日
    ]
    #pagebreak()
  ]
}
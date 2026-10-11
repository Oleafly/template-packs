// template.typ
#let ueh-project(
  config-file: "config.json", 
  body
) = {
  let default-settings = (
    department: "KHOA QUẢN TRỊ",
    title: "TIỂU LUẬN",
    topic-title: "Chủ Đề...",
    city: "TP. Hồ Chí Minh",
    date: "ngày... tháng... năm...",
    cover_info: ()
  )

  let info = default-settings + json(config-file)

  set page(margin: 1.5cm)
    
  // --- Header ---
  place(top + left, dy: 1cm)[
    #set text(size: 13pt, weight: "bold")
    #text(fill: black)[ĐẠI HỌC KINH TẾ TP. HỒ CHÍ MINH] \
    #text(fill: black)[TRƯỜNG KINH DOANH] | #text(fill: gray)[#info.department]
    #v(0.8cm)
    #image("logo.png", width: 6cm)
  ]

  // --- Titles ---
  place(bottom + left, dy: -33.33%)[
    #block(width: 100%)[
      #text(size: 46pt, weight: "bold", fill: rgb("#105F68"))[#info.title] \
      #v(0.1mm)
      #block(width: 80%)[
        #text(size: 22pt, weight: "bold", fill: rgb("#105F68"))[#info.topic-title]
      ]
    ]
  ]

  // --- Teal Block (Dynamic Grid) ---
  place(bottom + left, dx: -1.5cm, dy: 1.5cm)[
    #rect(fill: rgb("#105F68"), width: 100% + 3cm, height: 25% + 3cm)[
    #place(top + left, dx: 1.5cm, dy:0.5cm)[
        #block(stroke: (left: 3pt + rgb("#F47C2A")), inset: (left: 1em), width: 100%)[
          #set text(size: 16pt, fill: white)
          
          #let grid-data = info.at("cover_info", default: ())
          
          #let grid-data = info.at("cover_info", default: ())
          
          #let grid-cells = grid-data.map(item => {
             let val-content = if type(item.value) == array {
                table(
                  columns: (auto, auto),
                  inset: (y: 5pt, x: 0pt),
                  column-gutter: 2em,
                  stroke: none, 
                  align: left,
                  ..item.value.map(student => (
                    student.at("name", default: ""), 
                    student.at("id", default: "")
                  )).flatten()
                )
             } else {
                [#item.value]
             }

             return ([*#item.key:*], val-content)
          }).flatten()

          #grid(
            columns: (auto, auto), 
            column-gutter: 2em, 
            row-gutter: 0.8em,
            ..grid-cells
          )
        ]
      ]
    ]
  ]

  // --- Orange Circle ---
  place(bottom + right, dx: -0.5cm, dy: -25%)[
    #circle(fill: rgb("#F47C2A"), radius: 1.5cm)
  ]

  // --- Footer ---
  place(bottom + center, dy: 0.5cm)[
    #set text(size: 16pt, fill: white, weight: "bold")
    #info.city, #info.date
  ]

  pagebreak()
  body
}
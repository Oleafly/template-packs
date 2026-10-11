#let cover(
  course: "J5　情報システム実験実習Ⅲ　実験報告書",
  title: "",
  exp_dates: (), 
  submit_date: "",
  serial_no: "",
  student_id: "",
  author_name: "",
) = {
  set page(
    margin: (top: 3cm, bottom: 3cm, left: 3cm, right: 3cm),
    footer: none,
  )
  set text(font: ("Arial", "YuGothic"))
  set underline(offset: 3pt)
  set align(center)
  // 中央のコンテンツ
  v(6.0em)
  text(course, size: 18pt)
  v(5.0em)
  grid(
    columns: (auto, 1fr),
    column-gutter: 20pt,
    text("題目", size: 20pt),
    box(
      width: 100%,
      stroke: (bottom: 1pt),
      inset: (bottom: 5pt),
      text(title, size: 20pt)
    )
  )
  v(5.5em)
  set text(font: "YuGothic")
  for i in range(3) [
    #if i == 0 [
      #text("実施年月日", size: 14pt)
      #h(14pt)
    ] else [
      #h(14*6pt)
    ]
    #underline(
      text(if i < exp_dates.len() { exp_dates.at(i) } else { "" }, size: 14pt),
    )
    #if i < 2 [
      #v(1.0em)
    ]
  ]
  v(2.0em)
  text("提出年月日", size: 14pt)
  h(14pt)
  underline(
    text(submit_date, size: 14pt),
  )
  v(10.0em)


  set align(left)
  block(inset: (left: 2em))[
    #text("提出者", size: 14pt)
    #v(1.0em)
    #block(inset: (left: 18pt))[
      #text("通し番号", size: 14pt)
      #h(14pt)
      #underline(
        text(serial_no, size: 14pt),
      )
      #h(14pt)
      #text("学籍番号", size: 14pt)
      #h(14pt)
      #underline(
        text(student_id, size: 14pt),
      )
      #h(14pt)
      #text("氏名", size: 14pt)
      #underline(
        text(author_name, size: 14pt),
      )
      #h(14pt)

    ]
  ]
  
  pagebreak()
}

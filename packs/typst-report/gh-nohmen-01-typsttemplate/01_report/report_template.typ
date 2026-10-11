// 2026/04/02

// -------------------------------表紙-------------------------------
#let cover(
  Snumber:none, //シリーズ番号
  day:    none, //作成日
  title:  none, //タイトル
  sub:    none, //サブタイトル
  overview:none,//概要
  aff:    none, //所属（学年・学部）
  grade:  none, //学年
  id:     none, //学生番号
  name:   none, //名前
  cutoff: none, //提出期限
  class:  none, //授業名
  period: none, //授業時間
  teacher:none, //教員名
  body,
) = {
  
  set page(
    paper: "a4",
    margin: (x: 20mm, y: 20mm),
  )

  set text(
    font: "Noto Sans Mono",
  )

// -------------------------------Header-------------------------------

  grid(
    columns: (30mm, 110mm, 30mm),
    [#Snumber], none, [#day],
  )

  line(length: 100%, stroke: (paint: black, thickness: 4pt, cap: "round"))

// -------------------------------Title-------------------------------
  grid(
    columns: (150mm, 30mm),
    inset: (left: 0mm, right: 10mm, top: 5mm, bottom: 5mm),
    [#text(size: 25pt, weight: "regular",)[#title]],
    align(horizon+ right)[#text(size:9pt)[build with Typst]],
    [#text(size: 20pt, weight: "regular",)[#sub]],
    none,
  )
// -------------------------------Overview-------------------------------
  grid(
    columns: 1,
    inset: (left: 0mm, right: 0mm, top: 5mm, bottom: 0mm),
    text(size: 12pt, weight: "bold")[OVERVIEW],
    text[#overview]
  )

// -------------------------------footer-------------------------------
  align(bottom)[
    #align(center)[#text(size: 15pt, weight: "bold")[INFORMATION]]
    #grid(
      columns: (85mm, 85mm),
      inset: (left: 0mm, right: 0mm, top: 0mm, bottom: 5mm),
      line(length: 5%, stroke: (paint: black, thickness: 3pt, cap: "round")), align(right)[#line(length: 5%, stroke: (paint: black, thickness: 3pt, cap: "round"))],
      text(weight: "bold", size: 12pt)[Cut off],  text(weight: "bold", size: 12pt)[AFF],
      text()[#cutoff],                text()[#aff],
      text(weight: "bold", size: 12pt)[Class],  text(weight: "bold",  size: 12pt)[grade],
      text()[#class],                text()[#grade],
      text(weight: "bold", size: 12pt)[Period],  text(weight: "bold", size: 12pt)[ID],
      text()[#period],                text()[#id],
      text(weight: "bold", size: 12pt)[teacher],    text(weight: "bold", size: 12pt)[name],
      text()[#teacher],                text()[#name],
      line(length: 5%, stroke: (paint: black, thickness: 3pt, cap: "round")), align(right)[#line(length: 5%, stroke: (paint: black, thickness: 3pt, cap: "round"))],
      )
  ]
  pagebreak()
  body
}


// -------------------------------遊び紙-------------------------------
#let flyleaf = {
  set text(
    font: "Noto Sans Mono",
  )
  align(center)[
    #block(
      height: 257mm,
      width: 150mm
    )[
      #align(horizon)[
        #text(size: 15pt)[PAPER DETAIL]
        #align(center)[
          #text(size: 8pt)[
            #v(-2mm)
            #grid(
              columns: (16mm,35mm),
              inset: (left: 0mm, right: 0mm, top: 0mm, bottom: 1mm),
              [FONT ---------],       [Noto Sans Mono],
              [ID ---------------],   [report_template],
              [SIZE ---------],       [A4],
              [DATE ---------],       [2026.04.02],
              [TYPE ---------],       [report type],
              [LICENSE---],           [MIT License]
            )
          ]
        ]
        #v(0mm)
        #text(size: 8pt)[Copyright (c) nohmen]
        #v(-2mm)
        #text(size: 8pt)[2026]
      ]
    ]
  ]
}
// -------------------------------ボディー-------------------------------



// -------------------------------ヘッダー レベル１-------------------------------
#let number-counter-01 = counter("h1")
#{number-counter-01.update(1)}
#let h1 = (it) => context{
  grid(
    columns: (15mm, 111mm),
    text(size: 12pt, font: "Noto Sans Mono")[
      #number-counter-01.update(n => n + 1)
      #number-counter-01.display("1")
    ],
    align(horizon, heading(level:1, text(size: 12pt, it)))
  )
}



// -------------------------------ヘッダー レベル２-------------------------------
#let number-counter-02 = counter("h2")
#{number-counter-02.update(1)}
#let h2 = (it) => context{
  grid(
    columns: (15mm, 111mm),
    text(size: 11pt, font: "Noto Sans Mono")[
      #number-counter-02.update(n => n + 1)
      #number-counter-02.display("1")
    ],
    align(horizon, heading(level:1, text(size: 11pt, it)))
  )
}



// -------------------------------ヘッダー レベル３-------------------------------
#let number-counter-03 = counter("h3")
#{number-counter-03.update(1)}
#let h3 = (it) => context{
  grid(
    columns: (15mm, 111mm),
    text(size: 30pt, font: "Noto Sans Mono")[
      #number-counter-03.update(n => n + 1)
      #number-counter-03.display("1")
    ],
    align(horizon, heading(level:1, text(size: 10pt, it)))
  )
}
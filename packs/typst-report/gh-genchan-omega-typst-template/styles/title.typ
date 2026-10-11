#let title(
  title: "",
  name: "",
  submit-date: "",
  subject: "",
  teacher: "",
  student-number: "",
  department: "",
  grade: "",
  submit-size: 11pt * calc.pow(1.2, 2),
  title-size: 13pt * calc.pow(1.2, 5),
  info-size: 11pt * calc.pow(1.2, 1),
) = [
  // 提出日
  #set text(weight: 200)
  #set align(right)
  #let dates = submit-date.split("-")
  #text(size: submit-size)[提出日 : #dates.at(0)年#dates.at(1)月#dates.at(2)日]
  #v(150pt)
  
  // タイトル
  #set text(weight: 1000)
  #set align(center)
  #text(size: title-size)[
    [#title]
  ]
  #v(1fr)

  // 各種情報
  #set text(weight: 200)
  #set align(right)
  #text(size: info-size)[
    #table(
      columns:(auto, auto),
      align: (right, left),
      stroke: none,
      [講義名 : ],[#subject],
      [担当教員 : ],[#teacher 先生],
      [],[],
      [学籍番号 : ],[#student-number],
      [所属 : ],[#department],
      [学年 : ],[#grade 年],
      [氏名 : ],[#name]
    )  
  ]

  // ページの切り替え
  #pagebreak()
]

#let sep(length: 100%) = {
  line(stroke: red + 0.03cm, length: length)
  v(-0.42cm)
  line(stroke: red + 0.03cm, length: length)
  v(-0.42cm)
  line(stroke: red + 0.03cm, length: length)
}

#let make-cover(
  name: "姓名",
  class: "软件 24XX 班",
  student-id: "2240000000",
  phone-number: "18800000000",
  email: "2240000000@stu.xjtu.edu.cn",
  date: datetime.today(),
  count: 1
) = {
  import "@preview/cuti:0.3.0": show-cn-fakebold
  show: show-cn-fakebold

  let kvtext(key, value, keyfont: "KaiTi") = {
    grid(
      columns: (17%, 83%),
      text(font: keyfont, size: 20pt)[#{
        set align(center)
        strong(key)
      }],
      text(font: "KaiTi", size: 20pt)[#{
        set align(left)
        h(0.2cm)
        str(value)
      }],
      [], v(9pt) + sep(), [],
    )
  }

  set page(paper: "a4", margin: (
      top: 1.75cm,
      bottom: 2.54cm,
      left: 3.17cm,
      right: 3.17cm,
    ),
  )
  set align(center)

  text(font: "KaiTi", size: 48pt)[
    *面向对象程序设计 #linebreak() 实验报告*
  ]
  v(-1.1cm)
  sep()
  v(0.2cm)
  text(font: "DengXian", size: 24pt)[
    第 #count 次
  ]
  v(0.3cm)
  image("xjtu-logo.png", width: 5.7cm, height: 5.72cm)
  v(1.7cm)

  kvtext("姓名", name)
  v(0.14cm)
  kvtext("班级", class)
  v(0.14cm)
  kvtext("学号", student-id)
  v(0.14cm)
  kvtext("电话", phone-number)
  v(0.14cm)
  kvtext("Email", email, keyfont: "Malgun Gothic")
  v(0.14cm)
  kvtext("日期", date.display("[year]-[month]-[day]"))

  pagebreak(weak: true)
}

#let make-table-of-contents(
  contents,
) = {
  set page(paper: "a4", margin: (
      top: 1.75cm,
      bottom: 2.54cm,
      left: 3.17cm,
      right: 3.17cm,
    ),
  )
  set align(center)

  heading[#{
    align(left, image("xjtu-name.png", width: 2.96cm, height: 0.61cm))
    v(-0.62cm)
    align(right, text(font: "DengXian", size: 12pt)[
        面向对象程序设计实验报告
    ])
    v(-0.42cm)
    line(stroke: 0.2pt + color.linear-rgb(25.82%, 25.82%, 25.82%), length: 100%)
  }]
  v(0.56cm)
  text(font: "DengXian", size: 26pt)[
    目录
  ]
  v(-0.2cm)
  
  set align(left)
  
  text(font: "DengXian", size: 14pt, contents)

  pagebreak(weak: true)
}

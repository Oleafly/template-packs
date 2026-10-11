#import "../style.typ": zihao

#let declare-page(
  doctype: "midterm",
  sign: none,
  info: (:),
  ziti: (:),
) = {
  set text(font: ziti.fangsong, size: zihao.xiaosi, weight: "bold", top-edge: 3pt)
  set par(leading: 1em, hanging-indent: 0em, first-line-indent: (amount: 2em, all: true))

  v(5em)

  block(breakable: false)[
    本人承诺：报告中的内容真实无误，若有不实，愿承担相应的责任和后果。 I hereby declare and confirm that the details provided in this Form are valid and accurate. If anything untruthful found, I will bear the corresponding liabilities and consequences.

    #v(1.5em)

    #grid(
      align: left,
      columns: (65%, 1fr),
      stroke: none,
      inset: 0em,
      [
        #grid(
          columns: (60%, 1fr),
          align: left,
          [学生签字/Signature of Student：], sign,
        )
      ],
      [日期/Date：#info.sign-date.display()],
    )
  ]
}

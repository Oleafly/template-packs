/// ZCST 课程设计报告模板
///
/// - department (string): 院系
/// - major (string): 专业
/// - course (string): 课程
/// - students (array): 学生（名字，学号）
/// - teacher (string): 教师
/// - finish_time (datetime): 完成时间
/// - body (content): 正文
/// -> content
#let report(
  department: "院系",
  major: "专业",
  course: "课程",
  students: (("姓名", "学号"),),
  teacher: "教师",
  finish_time: datetime(year: 1970, month: 1, day: 1),
  body,
) = {
  import "@preview/cuti:0.3.0": show-cn-fakebold, show-fakebold
  show: show-fakebold

  set page(paper: "a4")
  let s = "\u{3000}"

  text(size: 12pt, font: "KaiTi")[
    #align(center + horizon)[
      #text(size: 32pt)[珠海科技学院]
      #v(2cm)
      #text(size: 48pt, weight: "bold")[课程设计报告]
      #v(2cm)
      #pad(x: 2cm)[
        #table(
          columns: (1fr, 3fr),
          stroke: 0.1pt,
          inset: (x: 12pt, y: 12pt),
          [院　　系], [#department],
          [专　　业], [#major],
          [科　　目], [#course],
          [学　　生],
          [
            #(
              students
                .map(((name, id)) => (
                  if (name.clusters().len() == 2) {
                    name.clusters().at(0) + "　" + name.clusters().at(1)
                  } else {
                    name
                  }
                    + "　"
                    + id
                ))
                .join(linebreak())
            )
          ],

          [指导教师], [#teacher],
          [完成时间], [#finish_time.display("[year]年[month]月[day]日")],
        )]
    ]]

  pagebreak()

  set text(size: 12pt, font: "SimSun")
  set par(leading: 2em)

  outline(title: block(width: 100%)[#align(center)[#text(size: 24pt, weight: "bold")[目录]]])

  pagebreak()

  set heading(numbering: "1.1.1")
  show heading: set block(below: 1.5em)

  set par(spacing: 1em)

  show strong: it => {
    let content = it.body
    let text_value = if content != none { content.text } else { "" }

    if (
      text_value
        .matches(
          regex("[\u{4E00}-\u{9FFF}\u{3400}-\u{4DBF}\u{F900}-\u{FAFF}\u{2E80}-\u{2EFF}\u{3000}-\u{303F}\u{FF00}-\u{FFEF}]"),
        )
        .len()
        > 0
    ) {
      text(
        font: "SimHei",
        weight: "regular",
        content,
      )
    } else {
      text(weight: "bold", content)
    }
  }

  set raw(theme: none)
  show raw: set text(size: 12pt, font: "Courier Prime")
  show raw.where(block: true): it => {
    set text(size: 10pt)
    set par(justify: false, linebreaks: "optimized", leading: 1em)

    box(width: 100%, inset: 8pt, fill: color.rgb(222, 222, 222))[
      #align(right)[#underline[#it.lang]]

      #let lines = it.text.split("\n")

      #set par(justify: false, linebreaks: "optimized", leading: 1em)

      #table(
        columns: (auto, auto),
        stroke: none,

        ..lines
          .enumerate()
          .map(((i, line)) => (
            ([#align(right)[#(i + 1)]], [#line.split("").join(sym.zws)])
          ))
          .flatten()
      )
    ]
  }

  set figure(numbering: "1.1.1", supplement: "图")

  body
}

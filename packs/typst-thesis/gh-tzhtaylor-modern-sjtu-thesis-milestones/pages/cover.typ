#import "../style.typ": zihao
#import "../utils.typ": *

#let cover-page(
  doctype: "midterm",
  ziti: (:),
  info: (:),
) = {
  let title = if doctype == "proposal" {
    "研究生学位论文开题报告"
  } else if doctype == "midterm" {
    "硕士研究生学位论文中期检查报告"
  } else if doctype == "annual-progress" {
    "博士研究生学位论文年度进展报告"
  }

  let title-en = if doctype == "proposal" {
    "Graduate Thesis/Dissertation Proposal"
  } else if doctype == "midterm" {
    "Mid-term Examination Report for SJTU Master Student"
  } else if doctype == "annual-progress" {
    "Annual Progress Report for SJTU Doctoral Student"
  }

  align(center, image(
    "../assets/sjtu-logo.png",
    width: 10cm,
  ))

  align(center, text(
    title,
    font: ziti.songti,
    size: zihao.yihao,
    weight: "bold",
  ))

  align(center, text(
    title-en,
    size: zihao.xiaosan,
    weight: "bold",
  ))

  v(1fr)

  set table(stroke: (x, y) => if x == 1 {
    (bottom: 0.5pt + black)
  })

  let info-key(zh, en) = (
    text(
      zh,
      font: ziti.kaiti,
      size: zihao.sihao,
      weight: "black",
    )
      + h(0.5em)
      + text(
        en,
        size: zihao.xiaosi,
        weight: "bold",
      )
  )

  let info-value(v) = (
    text(
      v,
      font: ziti.fangsong,
      size: zihao.xiaosi,
    )
  )

  align(center, [
    #if doctype == "proposal" {
      table(
        align: left + horizon,
        columns: (38%, 1fr),
        row-gutter: 1em,
        [#info-key("学号", "Student ID")], [#info-value(info.student-id)],
        [#info-key("姓名", "Name")], [#info-value(info.name)],
        [#info-key("学生类别", "Degree Program")], [#info-value(info.degree)],
        [#info-key("学习形式", "Study Mode")], [#info-value(info.study-mode)],
        [#info-key("导师", "Supervisor(s)")], [#info-value(info.supervisor)],
        [#info-key("论文题目", "Thesis Title")], [#info-value(info.title)],
        [#info-key("学院", "School")], [#info-value(info.school)],
        [#info-key("专业", "Major")], [#info-value(info.major)],
        [#info-key("开题日期", "Date")], [#info-value(info.proposal-date.display("[year]年[month]月[day]日"))],
        [#info-key("开题地点", "Venue")], [#info-value(info.venue)],
      )
    } else if doctype == "midterm" {
      block(width: 85%)[
        #table(
          align: left + horizon,
          columns: (38%, 1fr),
          row-gutter: 1em,
          column-gutter: -2em,
          [#info-key("学号", "Student ID")], [#info-value(info.student-id)],
          [#info-key("姓名", "Name")], [#info-value(info.name)],
          [#info-key("学生类别", "\nDegree Program")], [#info-value(info.degree)],
          [#info-key("学习形式", "\nStudy Mode")], [#info-value(info.study-mode)],
          [#info-key("导师", "Supervisor(s)")], [#info-value(info.supervisor)],
          [#info-key("专业", "Major")], [#info-value(info.major)],
          [#info-key("学院", "School")], [#info-value(info.school)],
          [#info-key("考核日期", "Date")], [#info-value(info.exam-date.display("[year]年[month]月[day]日"))],
        )
      ]
    } else if doctype == "annual-progress" {
      table(
        align: left,
        columns: (38%, 1fr),
        row-gutter: 1em,
        [#info-key("学号", "Student ID:")], [#info-value(info.student-id)],
        [#info-key("姓名", "Name:")], [#info-value(info.name)],
        [#info-key("导师", "Supervisor(s):")], [#info-value(info.supervisor)],
        [#info-key("专业", "Major:")], [#info-value(info.major)],
        [#info-key("学院", "School:")], [#info-value(info.school)],
        [#info-key("入学方式", "Enrollment:")], [#info-value(info.study-mode)],
        [#info-key("学生类别", "Degree Program:")], [#info-value(info.degree)],
        [#info-key("考核日期", "Date:")], [#info-value(info.exam-date.display("[year]年[month]月[day]日"))],
      )
    }
  ])

  v(1fr)

  pagebreak(weak: true)
}

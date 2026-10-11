#import "../utils.typ": font-size, font-family, cjk-fill, show-cn-fakebold

// 扉页
#let title-page(
  title: "",
  title-en: "",
  student-id: "",
  classification: "公开",
  author: "",
  department: "",
  major: "",
  supervisor: "",
  supervisor-title: "",
  supervisor-dept: "",
  submit-date: "",
  defense-date: "",
  degree-unit: "哈尔滨工程大学",
) = {
  set page(header: none, footer: none, numbering: none)
  set text(font: font-family.songti, size: font-size.xiaosihao)
  // Word 1.5倍行距 → Typst: leading = 0.75em
  set par(leading: 0.75em)
  set block(spacing: 0.75em)
  set par(spacing: 0.75em)

  // 空行高度 = 小4号 baselineskip = 小4号 × 1.75
  let empty-line = font-size.xiaosihao * 1.75

  // 空一行
  v(empty-line)

  // 空三行（原学号密级位置）
  v(empty-line * 3)

  // 论文题目（2号黑体居中）
  align(center, text(font: font-family.heiti, size: font-size.erhao)[
    #title
  ])

  // 空一行
  v(empty-line)

  // 英文标题（2号Times New Roman）
  align(center, text(font: "Times New Roman", size: font-size.erhao)[
    #title-en
  ])

  // 空四行
  v(empty-line * 4)

  // 信息表（4号宋体加粗，固定行距26磅，标签撑满6字符，冒号对齐，值左对齐）
  {
    show: show-cn-fakebold
    set text(font: font-family.songti, size: font-size.sihao, weight: "bold")
    let label-width = 6em
    let info-label(body) = cjk-fill(label-width, body)
    align(center, grid(
      columns: (label-width, auto, auto),
      rows: (26pt,) * 9,
      align: (right, center, left),
      info-label[学生姓名], [：], text(weight: "regular")[#author],
      info-label[所在学院], [：], text(weight: "regular")[#department],
      info-label[所在专业], [：], text(weight: "regular")[#major],
      info-label[指导教师], [：], text(weight: "regular")[#supervisor],
      info-label[职称], [：], text(weight: "regular")[#supervisor-title],
      info-label[所在单位], [：], text(weight: "regular")[#supervisor-dept],
      info-label[论文提交日期], [：], text(weight: "regular")[#submit-date],
      info-label[论文答辩日期], [：], text(weight: "regular")[#defense-date],
      info-label[学位授予单位], [：], text(weight: "regular")[#degree-unit],
    ))
  }
}

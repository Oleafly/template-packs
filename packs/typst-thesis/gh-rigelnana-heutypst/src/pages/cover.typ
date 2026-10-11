#import "../utils.typ": font-size, font-family, cjk-fill

// 封面页
#let cover-page(
  title: "",
  student-id: "",
  classification: "公开",
  department: "",
  major: "",
  author: "",
  supervisor: "",
  date: datetime.today(),
) = {
  set page(header: none, footer: none, numbering: none)
  set text(font: font-family.songti, size: font-size.xiaosihao)
  // Word 1.5倍行距 → Typst: leading = 1.5em - 0.75em = 0.75em
  set par(leading: 0.75em)
  set block(spacing: 0.75em)
  set par(spacing: 0.75em)

  // 空行高度 = 小4号 baselineskip = 小4号 × 1.75（1.5倍行距）
  let empty-line = font-size.xiaosihao * 1.75

  // 学号和密级（小4号宋体居右，标签分散对齐，冒号对齐）
  v(empty-line)  // 空一行
  {
    let id-label-width = 2em
    let value-width = 6em
    align(right, grid(
      columns: (id-label-width, auto, value-width),
      rows: (empty-line,) * 2,
      align: (right, center, center),
      cjk-fill(id-label-width, [学号]), [：], student-id,
      cjk-fill(id-label-width, [密级]), [：], classification,
    ))
  }

  // 空三行
  v(empty-line * 3)

  // 校名（小2号宋体居中）
  align(center, text(font: font-family.songti, size: font-size.xiaoerhao)[
    哈尔滨工程大学本科生毕业论文
  ])

  // 空两行
  v(empty-line * 2)

  // 论文题目（2号黑体居中）
  align(center, text(font: font-family.heiti, size: font-size.erhao)[
    #title
  ])

  // 空七行
  v(empty-line * 7)

  // 信息表（小3号宋体，标签分散对齐，冒号对齐，值左对齐）
  // Word 1.5倍行距：baselineskip = font-size + font-size*0.75 = font-size*1.75
  {
    set text(font: font-family.songti, size: font-size.xiaosanhao)
    let label-width = 7em
    let info-label(body) = cjk-fill(label-width, body)
    align(center, grid(
      columns: (label-width, auto, auto),
      rows: (font-size.xiaosanhao * 1.75,) * 4,
      align: (right, center, left),
      info-label[学院（系）名称], [：], department,
      info-label[专业名称], [：], major,
      info-label[学生姓名], [：], author,
      info-label[指导教师], [：], supervisor,
    ))
  }

  // 空三行
  v(empty-line * 3)

  // 校名（小2号楷体居中）
  align(center, text(font: font-family.kaiti, size: font-size.xiaoerhao)[
    哈尔滨工程大学
  ])

  // 日期（小3号宋体居中）
  align(center, text(font: font-family.songti, size: font-size.xiaosanhao)[
    #date.display("[year]年[month]月")
  ])
}

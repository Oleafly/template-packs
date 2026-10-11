#let lec-report(doc, stu-id: [], stu-name: [], time: [], loc: [], speaker: [], subject: []) = {
  set page(margin: (top: 1in, bottom: 1in, left: 1.25in, right: 1.25in))

  set text(font: "FangSong", size: 16pt)
  set par(leading: 1em)

  let title = text(font: "SimSun", size: 20pt, stroke: 0.5pt)[人文讲座听课报告]

  let body = {
    set text(font: ("Times New Roman", "SimSun"), size: 10.5pt)
    set par(justify: true, first-line-indent: 2em, leading: 18pt - 1em)
    set block(spacing: 18pt - 1em)

    v(-0.5em)

    doc
  }

  let remark = [
    #set text(font: "Microsoft YaHei", size: 9pt, fill: rgb(192, 0, 0))
    #set par(justify: true)

    该报告请提交电子版。在吴健雄学院开设的“高端人文讲座系列”（讲座预告中会标注）中选听，每场完成 1 篇《听课报告》，通过网上系统完成报名、签到、提交报告，第3学年结束前进行审核。
  ]

  table(
    columns: (2.8cm, 1fr, 2.75cm, 1fr),
    rows: (auto, auto, auto, 1fr, auto),
    align: center + horizon,
    inset: (x: 0em, y: 0.7em),
    table.cell(colspan: 4, stroke: none, inset: (y: 1em), title),
    [学号+姓名],
    [#stu-id#stu-name],
    [时间地点],
    block[#time \ #loc],
    [主讲人],
    speaker,
    [讲座题目],
    subject,
    [讲座摘要及听讲心得（参考字数:500字左右）],
    table.cell(colspan: 3, align: top + start, body),
    [说明],
    table.cell(colspan: 3, align: left, inset: (y: 0.7em), remark),
  )
}

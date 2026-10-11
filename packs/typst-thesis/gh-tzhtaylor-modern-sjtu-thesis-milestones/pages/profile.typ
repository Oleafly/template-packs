#import "../style.typ": zihao
#import "../utils.typ": *

#let proposal-table(info) = table(
  align: left + horizon,
  columns: (22%, 1fr),
  stroke: 0.5pt + black,
  inset: (y: 10pt),
  [论文题目 #linebreak() Proposed Title], [#info.title],
  [研究课题来源 #linebreak() Source of Research Project],
  [
    请在合适选项前画 $checkmark$ Please select proper options by $checkmark$.

    #if info.project-source == 1 { checkbox } else { $square$ } 国家自然科学基金课题 NSFC Research Grants

    #if info.project-source == 2 { checkbox } else { $square$ } 国家社会科学基金 National Social Science Fund of China

    #if info.project-source == 3 { checkbox } else { $square$ } 国家重大科研专项 National Key Research project-source

    #if info.project-source == 4 { checkbox } else { $square$ } 其它纵向科研课题 Other Governmental Research Grants

    #if info.project-source == 5 { checkbox } else { $square$ } 企业横向课题 R&D Projects from Industry

    #if info.project-source == 6 { checkbox } else { $square$ } 自拟课题 Self-proposed Project

    $square$ 其它 Other $med$ #uline(17em)[$med$ 在此处填写内容]
  ],
)

#let profile-page(
  doctype: "midterm",
  info: (:),
  ziti: (:),
) = {
  let title = if doctype == "midterm" {
    "中期检查报告 Mid-term Examination Report"
  } else if doctype == "annual-progress" {
    "博士生年度进展报告 Annual Progress Report"
  }

  align(center, text(
    font: ziti.fangsong,
    size: zihao.sihao,
    weight: "bold",
    title,
  ))

  v(0.5em)

  set text(font: ziti.fangsong, size: zihao.xiaosi)
  set par(
    leading: 1em,
    first-line-indent: 0em,
    hanging-indent: 0em,
    justify: false,
  )
  align(center, if doctype == "proposal" { proposal-table(info) } else {
    table(
      align: left + horizon,
      columns: (28%, 1fr),
      stroke: 0.5pt + black,
      inset: (y: 10pt),
      [论文题目 #linebreak() Proposed Title], [#info.title],
      [研究课题来源 #linebreak() Source of Research Project],
      [
        请在合适选项前画 $checkmark$ Please select proper options by $checkmark$.

        #if info.project-source == 1 { checkbox } else { $square$ } 国家自然科学基金课题 NSFC Research Grants

        #if info.project-source == 2 { checkbox } else { $square$ } 国家社会科学基金 National Social Science Fund of China

        #if info.project-source == 3 { checkbox } else { $square$ } 国家重大科研专项 National Key Research project-source

        #if info.project-source == 4 { checkbox } else { $square$ } 其它纵向科研课题 Other Governmental Research Grants

        #if info.project-source == 5 { checkbox } else { $square$ } 企业横向课题 R&D Projects from Industry

        #if info.project-source == 6 { checkbox } else { $square$ } 自拟课题 Self-proposed Project
      ],

      [论文开题日期 #linebreak() Thesis Proposal Date],
      [#info.proposal-date.display("[year]年[month padding:none]月[day padding:none]日")],
    )
  })
}

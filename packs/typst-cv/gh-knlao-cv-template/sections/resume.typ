#import "../template/resume.template.typ": *
#import "../template/scripts/maybe-image.typ": maybe-image

#move(dx: -5%, dy: 0cm)[#grid(
  columns: (30%, 75%),
  rows: (96%),
  gutter: 4%,
  [
    #align(center)[#maybe-image("/media/you.jpg", width: 80%) ]
    #item-box(
      title: "个人资料",
      font-size: 11pt,
    )[
      #table(
        columns: (24%, 16%, 60%),
        align: (left, left, left),
        stroke: none,
        [姓名], table.cell(colspan: 2)[陈大文],
        [性别], table.cell(colspan: 2)[男],
        table.cell(colspan: 2)[出生日期], [1999/02/29],
        [电话], table.cell(colspan: 2)[(+853)12345678],
        [], table.cell(colspan: 2)[(+86)1234567654321],
        [电邮], table.cell(colspan: 2)[?????\@?????.???]
      )
    ]
    #v(0.5em)
    #item-box(
      title: "教育经历",
      font-size: 11pt
    )[
      #box(
        inset: 0.5em
      )[
        #edu(
          level: "高中",
          school: "XX中学",
          date: "开始年份-结束年份"
        )
        #v(0.5em)
        #edu(
          level: "初中",
          school: "XX中学",
          date: "开始年份-结束年份"
        )
      ]
    ]
    #v(0.5em)
    #item-box(
      title: "技能专长",
      font-size: 11pt
    )[
      #table(
        columns: (24%, 76%),
        align: (left, left),
        stroke: none,
        [语言], [普通话|英语],
        [学术], [中文|数学],
        [科技], [Python|C++],
        [艺术], [钢琴]
      )
    ]
  ],
  [
    #v(2em)
    #h(2em)
    #box[
      #text(36pt)[*陈大文*]
      #v(-2em)
      #text(30pt)[CHAN Tai Man]
    ]
    #v(2em)
    #item-box(
      title: "重要奖项",
      font-size: 12pt
    )[
      #box(inset: 0.5em)[
        *分类一*
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        *分类二*
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        *分类三*
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
        - 比赛名称(简称)[地区] - 奖项
      ]
    ]
    // #v(2em)
    #item-box(
      title: "社团活动",
      font-size: 12pt
    )[
      #box(inset: 0.5em)[
        #table(
          columns: (65%, 35%),
          align: (left, right),
          stroke: none,
          [社团名称], [开始年份-结束年份],
          [社团名称], [开始年份-结束年份],
          [社团名称], [开始年份-结束年份],
          [社团名称], [开始年份-结束年份],
          [社团名称], [开始年份-结束年份]
        )
      ]
    ]
  ]
)]

#pagebreak()
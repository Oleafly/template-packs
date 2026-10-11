#import "util.typ": TODO

#let template(
  it,
  是否设计: true,
  是否草稿: false,
  题目: TODO[基于Typst的学位论文排版技术研究],
  姓名: TODO[熊耀华],
  年级: TODO[2016级],
  学号: TODO[123456],
  院系: TODO[交通运输与物流],
  专业: TODO[摸鱼工程],
  指导老师: TODO[张#h(1em)三],
) = [
  #import "@preview/cuti:0.3.0": show-cn-fakebold

  #let 二号 = 22pt
  #let 小二 = 18pt
  #let 小三 = 15pt
  #let 四号 = 14pt
  #let 小四 = 12pt

  #let 黑体 = ("Times New Roman", "SimHei")
  #let 宋体 = ("Times New Roman", "SimSun")
  //#let 黑体 = ("Times New Roman", "Source Han Sans SC")
  //#let 宋体 = ("Times New Roman", "Source Han Serif SC")
  #let 黑体 = "Source Han Sans SC"
  #let 宋体 = "Source Han Serif SC"
  //#let 宋体 = "Songti SC"
  //#let 黑体 = "Hiragino Sans GB"


  #let 文档类型 = if 是否设计 {
    [设计]
  } else {
    [论文]
  }

  #set page(
    paper: "a4",
    margin: (y: 2.6cm, x: 2.7cm),
    header-ascent: 1em,
    header: [
      #set align(center)
      #set text(font: 宋体, size: 小四)
      #set par(spacing: 5pt)
      西南交通大学本科毕业#{ 文档类型 }
      #line(length: 100%, stroke: 0.3mm)
    ],
    background: if 是否草稿 {
      let draft_color = red.transparentize(0%)
      let draft = text(fill: draft_color, size: 220pt)[DRAFT\ ]
      place(horizon, rotate(60deg, draft))
      place(bottom + left, dx: 1em, dy: -1em)[
        #set text(fill: draft_color, size: 30pt)
        草稿，创建日期#datetime.today().display()
      ]
      place(box(height: 100%, width: 100%, fill: white.transparentize(10%)))
    } else {
      none
    },
  )

  #set text(
    font: 宋体,
    size: 小四,
    lang: "zh",
  )

  #set par(
    first-line-indent: (amount: 2em, all: true),
    justify: true,
    linebreaks: "optimized",
    leading: 0.5em,
  )

  //#rect(fill: blue, height: 100%, width: 100%)[#lorem(100)]

  #let 扉页(title: 题目) = {
    page(
      header: none,
    )[
      #grid(
        //stroke: 1pt,
        columns: 1fr,
        rows: (0.5fr, 0.5fr, 1fr, 0.5fr),
        [
          #set text(font: 黑体, size: 小二)
          #set par(leading: 1em)
          #set align(center + horizon)
          西 南 交 通 大 学\
          本科毕业#文档类型
        ],
        [
          #set text(font: 黑体, size: 二号)
          #set par(leading: 1em)
          #set align(center + horizon)
          #title
        ],
        [
          #align(
            center + horizon,
            {
              set text(font: 黑体, size: 小四)
              set par(leading: 1em)
              grid(
                //stroke: 1pt,
                columns: 2,
                column-gutter: 1em,
                rows: 4,
                row-gutter: 0.5em,
                align: left,
                [年#h(2em)级：], 年级,
                [学#h(2em)号：], 学号,
                [姓#h(2em)名：], 姓名,
                [专#h(2em)业：], 专业,
                [指导老师：], 指导老师,
              )
            },
          )
        ],
        [
          #set text(font: 宋体, size: 小四)
          #set par(leading: 1em)
          #set align(center + horizon)
          2026年12月
        ],
      )
    ]
  }

  #let 诚信申明() = {
    page(
      header: none,
    )[
      #grid(
        //stroke: 1pt,
        rows: (0.5fr, 1fr, 1fr),
        columns: 1fr,
        //show-cn-fakebold()[
        [
          #set text(font: 黑体, size: 小二)
          #set par(leading: 1em)
          #set align(center + horizon)
          *西南交通大学\
          本科毕业#{ 文档类型 }学术诚信声明*
        ],
        [
          #set text(font: 宋体, size: 四号)
          #set par(leading: 1em)
          #h(2em)本人郑重声明：所呈交的毕业#{ 文档类型 }，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。
        ],
        [
          #set text(font: 宋体, size: 四号)
          #set par(leading: 1em, first-line-indent: 0em)
          #grid(
            //stroke: 1pt,
            rows: 2,
            row-gutter: 3em,
            columns: (1fr, 1fr),
            column-gutter: 2em,
            [], [作者签名：],
            [], [日期：#h(4em)年#h(2em)月#h(2em)日],
          )
        ],
      )
    ]
  }

  #let 授权书() = {
    page(
      header: none,
    )[
      #grid(
        //stroke: 1pt,
        columns: 1fr,
        rows: (0.5fr, 1fr, 1fr),
        //show-cn-fakebold()[
        [
          #set text(font: 黑体, size: 小二)
          #set par(leading: 1em)
          #set align(center + horizon)
          *西南交通大学\
          本科毕业设计（论文）版权使用授权书*
        ],
        [
          #set text(font: 宋体, size: 四号)
          #set par(leading: 1em)
          本毕业#{ 文档类型 }作者同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权西南交通大学可以将本毕业#{ 文档类型 }的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本毕业#{ 文档类型 }。
          #grid(
            //stroke: 1pt,
            rows: 3,
            row-gutter: 1em,
            columns: 2,
            column-gutter: 1em,
            [], [保密□，在#box(width: 2em, inset: (x: 2pt), line()) 年解密后适用本授权书。],
            [#h(2em)本论文属于], [],
            [], [不保密□。],
          )
          （请在以上方框内打“√”）
        ],
        [
          #set text(font: 宋体, size: 四号)
          #set par(leading: 1em)
          #grid(
            //stroke: 1pt,
            rows: 2,
            row-gutter: 3em,
            columns: 2,
            column-gutter: 4em,
            [作者签名：], [指导教师签名：],
            [日期：#h(4em)年#h(2em)月#h(2em)日], [日期：#h(4em)年#h(2em)月#h(2em)日],
          )
        ]
      )
    ]
  }

  #let 评阅意见() = {
    page()[
      #set text(font: 宋体, size: 小四)
      #set par(first-line-indent: 0em)
      #let underline = box(width: 1fr, baseline: 2pt, line(length: 100%, stroke: 0.8pt))
      #v(1em)
      #grid(
        //stroke: 1pt,
        columns: (1fr, 1fr),
        column-gutter: 1em,
        row-gutter: 1em,
        [
          院 系 #underline #place(top + center)[#院系]
        ],
        [
          专 业 #underline #place(top + center)[#专业]
        ],
        [
          年 级 #underline #place(top + center)[#年级]
        ],
        [
          姓 名 #underline #place(top + center)[#姓名]
        ],
        grid.cell(colspan: 2)[题 目 #underline #underline #place(top + center)[#题目]],
      )

      #grid(
        //stroke: 1pt,
        columns: (auto, 1fr),
        column-gutter: 1em,
        box[指导教师\ 评#h(2em)语], [],
        [],
        grid(
          row-gutter: 1.5em,
          ..{ (underline,) * 8 },
          [
            #h(3fr) 指导教师 #underline （签章）
          ]
        ),
      )
      #v(2em)
      #grid(
        //stroke: 1pt,
        columns: (auto, 1fr),
        column-gutter: 1em,
        box[评#h(0.5em)阅#h(0.5em)人\ 评#h(2em)语], [],
        [],
        grid(
          row-gutter: 1.5em,
          ..{ (underline,) * 8 },
          [
            #h(3fr) 评阅人 #underline （签章）
          ]
        ),
      )
      #v(1em)
      #grid(
        row-gutter: 1.5em,
        [成#h(2em)绩 #underline#h(2fr)],
        [答辩委员会主任 #underline（签章）#h(2fr)],
        [#h(1fr)年#h(2em)月#h(2em)日#h(2em)],
      )
    ]
  }

  #let 任务书() = {
    import "../parts/任务书.typ"

    page()[
      #let underline = box(width: 1fr, baseline: 2pt, line(length: 100%, stroke: 0.8pt))
      #set text(font: 宋体, size: 小四)
      #set par(first-line-indent: 0em)
      #grid(
        columns: 1fr,
        rows: (3cm, auto),
        row-gutter: 1em,
        [
          #set text(font: 黑体, size: 小二)
          #set align(center + horizon)
          //#show-cn-fakebold[
          #box()[
            *毕业#{ 文档类型 }任务书*
          ]
        ],
        grid(
          columns: (1fr, 1fr, 1fr),
          [
            班#h(2em)级 #underline #place(top + center, dx: 1em)[#专业]
          ],
          [
            学生姓名 #underline #place(top + center, dx: 1em)[#姓名]
          ],
          [
            学#h(2em)号 #underline #place(top + center, dx: 1em)[#学号]
          ],
        ),
        [
          发题日期：#h(4em)年#h(2em)月#h(2em)日 #h(1fr) 完成日期：#h(4em)年#h(2em)月#h(2em)日
        ],
        [
          题#h(2em)目 #underline
        ]
      )

      #set grid(row-gutter: 1.5em)

      #block[
        #grid(
          [1、本设计（论文）的目的、意义 #underline],
          ..{ (underline,) * 7 },
        )
        #set par(leading: 0.8em)
        #place(top + left, h(16em) + 任务书.达成度)
      ]

      #block[
        #grid(
          [2、学生应完成的任务 #underline],
          ..{ (underline,) * 7 },
        )
        #set par(leading: 0.8em)
        #place(top + left, h(11em) + 任务书.达成度)
      ]

      #block[
        #grid(
          [3、本设计（论文）与本专业的毕业要求达成度如何？（如在知识结构、能力结构、
            素质结构等方面有哪些有效的训练。）],
          ..{ (underline,) * 7 },
        )
        #set par(leading: 0.8em)
        #place(top + left, dy: 2.8em, 任务书.达成度)
      ]

      #let final_week = 2
      #let total_week = 任务书.任务时间分配.map(task => { task.at(1) }).sum() + final_week

      #grid(
        row-gutter: 0.5em,
        [4、本设计（论文）各部分内容及时间分配：（共 #box(width: 1fr)[#align(center)[#total_week] #place(underline)] 周）#h(3fr) ],
        ..任务书
          .任务时间分配
          .enumerate(start: 1)
          .map(task => [
            #let (idx, (task, time)) = task
            #h(2em) #numbering("第一部分", idx) #box(width: 1fr)[#align(center)[#task] #place(underline)] (#time 周)
          ]),
        [#h(2em) 评阅及答辩 #underline (#final_week 周)]
      )

      #block[
        #grid(
          [备#h(2em)注 #underline],
          ..{ (underline,) * 2 },
        )
        #place(top + left, h(5em) + 任务书.备注)
      ]
      #v(2em)
      #grid(
        [指导教师： #underline #h(4em)年#h(2em)月#h(2em)日 #h(2fr)],
        [审#h(0.5em)批#h(0.5em)人： #underline #h(4em)年#h(2em)月#h(2em)日 #h(2fr)],
      )
    ]
  }

  #let 摘要(content: [正文略], keywords: ([论文], [排版], [Typst])) = {
    page()[
      #block(width: 100%)[
        #set text(font: 黑体, size: 小二)
        #set align(center + horizon)
        #v(1em)
        *摘#h(3em)要*
      ]

      #v(1em)
      #set par(leading: 1em)
      #content

      #{
        set text(font: 黑体, size: 小四)
        set par(first-line-indent: 0em)
        [关键字：] + keywords.join([，])
      }

    ]
  }

  #let abstract() = {
    page()[
      #block(width: 100%)[
        #set text(font: 黑体, size: 小二)
        #set align(center + horizon)
        #v(1em)
        *Abstract*
      ]
      #v(1em)
      #set par(leading: 1em)
      正文略
    ]
  }

  #let 目录() = {
    page()[
      #v(1em)

      #block(width: 100%)[
        #set text(font: 黑体, size: 小四)
        #set align(center + horizon)
        *目#h(3em)录*
      ]

      #v(1em)
      #show outline.entry: it => {
        let is_first_level = it.level == 1
        let font = if is_first_level {
          黑体
        } else {
          宋体
        }
        let weight = if is_first_level {
          "bold"
        } else {
          "regular"
        }
        set text(font: font, size: 小四, weight: weight)

        link(
          it.element.location(),
          it.indented(it.prefix(), it.inner()),
        )
      }

      #show outline: set block(below: 1em)
      #set outline.entry(fill: box(width: 1fr)[#repeat[#text(font: "SimSun")[...]]])

      #align(center, block(width: 80%, outline(
        title: none,
        target: heading,
        indent: n => {
          calc.max(n - 1, 0) * 2em
        },
        depth: 3,
      )))
    ]
  }


  #let front-matter() = {
    扉页()
    诚信申明()
    授权书()

    set page(
      footer: context [
        #set align(center)
        #set text(font: 黑体, size: 小四)
        #let (num,) = counter(page).get()
        #numbering("第I页", num)
      ],
    )
    counter(page).update(1)

    评阅意见()
    任务书()

    let content = include "../parts/摘要.typ"
    摘要(content: content)
    abstract()
    目录()
  }

  #front-matter()

  #set list(
    marker: box(baseline: 9pt)[#box(baseline: -3pt, width: 0.5em)[
        #let c = circle(fill: black, radius: 2pt)
        #c
      ]
    ],
    indent: 1em,
  )
  #set enum(
    body-indent: 0.5em,
    indent: 0em,
    numbering: n => {
      box(
        baseline: 10pt,
        width: 1.5em,
        numbering("1.", n),
      )
    },
  )
  #show heading.where(level: 1): set align(center)
  #show heading.where(level: 1): set text(size: 小三, font: 黑体)
  #show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    pagebreak(weak: true) + v(2em) + it + v(2em)
  }
  #show heading.where(level: 2): set text(size: 四号, font: 黑体)
  #show heading.where(level: 2): set block(below: 1em, above: 2em)
  #show heading.where(level: 3): set text(size: 小四, font: 黑体)
  #show figure.caption: set text(size: 小四, font: 黑体)
  #show figure.where(kind: table): set figure.caption(position: top)
  #set figure(numbering: (..num) => {
    let chapter = counter(heading).get().first()
    let fig-num = num.pos().first()
    numbering("1-1", chapter, fig-num)
  })
  #set page(numbering: "1")
  #set heading(numbering: (..n) => context {
    let is_main = query(selector(<结论>).before(here())).len() == 0
    //if not is_main {
    //  []
    //} else if n.pos().len() == 1 {
    if n.pos().len() == 1 {
      numbering("第1章", n.pos().at(0))
    } else {
      numbering("1. 1", ..n)
    }
  })
  #set table(stroke: 0pt)

  #show raw: set text(font: "Source Han Mono SC", weight: "regular")
  #show raw: set strong(delta: 0)
  #show raw: set underline(stroke: 0pt)
  #show raw.where(block: true): set block(width: 100%, fill: color.luma(220), inset: 0em)
  #show raw.where(block: true): it => {
    show raw.line: line => {
      let c = if calc.odd(line.number) { color.luma(220) } else { color.luma(240) }
      box(width: 100%, fill: c, outset: 2.5pt)[
        #line.body
        #place(top + left, dx: -5em, box(width: 4em)[
          #set text(size: 6pt)
          #h(1fr)
          #line.number
        ])
      ]
    }
    align(center, it)
  }

  #set math.equation(numbering: n => {
    let chapter = counter(heading).get().first()
    numbering("(1-1)", chapter, n)
  })

  #it
]

#let main-body(it) = {
  counter(page).update(1)

  it
}

#let after-matter(it) = {
  set heading(numbering: none)
  it
}

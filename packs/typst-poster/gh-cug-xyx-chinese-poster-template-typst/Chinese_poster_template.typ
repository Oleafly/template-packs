#import "@preview/peace-of-posters:0.5.6" as pop
#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/showybox:2.0.3": showybox
#show: show-cn-fakebold

// 自定义主题
#let my_theme = (
    "body-box-args": (
        inset: 0.6em,
        width: 100%,
    ),
    "body-text-args": (:),
    "heading-box-args": (
        inset: 0.6em,
        width: 100%,
        fill: rgb("#7a1410"),
        stroke: rgb("#7a1410"),
    ),
    "heading-text-args": (
        fill: white,
    ),
)


#let box-grey(it, col: white) = {
  showybox(it, frame: (
    border-color: rgb(col),
    body-color: rgb(col),
  ))
}

#set page("a0", margin: 1cm, width: 90cm, height: 120cm) // panel
#pop.set-poster-layout(pop.layout-a0)
#pop.set-theme(my_theme)
#set text(
  // font: "Microsoft YaHei",
  size: pop.layout-a0.at("body-size"), // 33pt
)
#let box-spacing =0.86em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(
  spacing: box-spacing,
)


// =============================================
#pop.title-box(
  [*论文题目论文题目论文题目论文题目论文题目*],
  authors: [*$"谢宇轩"^(1,2)，"李四"^(1,2)，"王五"^(1,2)$*],
  institutes: [*¹xx大学xx学院xx系，²xxxxxxx*],
  keywords: [*关键词：关键词1；关键词2；关键词3；关键词4*],
  text-relative-width: 85%,
  logo: circle(image("./Figures/CUG_logo.png"), fill: white, inset: -45pt),
  spacing: 2%
)


#pop.column-box(
    heading: [
      #set align(center)
      *引言*
    ],
  )[
    #text(size: 45pt)[
      #set align(horizon)
      - 引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言。#text(fill: rgb("#0070c0"))[*然而，引言引言引言引言引言引言引言引言引言引言引言引言。*]
      - 本研究引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言引言。
    ]
  ]

// 正文，参数3表示分为3栏
#columns(3,[

  #pop.column-box(
    heading: [
      #set align(center)
      *内容1*
    ],
    stretch-to-next: true // 到底
  )[
    #figure(
      box(width: 100%)[#image("./Figures/Figure_02.jpg", width: 100%)],
      gap: 0em,
			caption: [
        内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1。
    ])

    #box-grey(col: "#f2f2f2")[
      #text(size: 30pt)[
        #set align(horizon)
        - 内容1内容1内容1，#text(fill: rgb("#0070c0"))[*内容1内容1内容1内容1内容1内容1内容1内容1内容1*]，内容1内容1内容1内容1内容1内容1内容1内容1内容1内容。
        - #text(fill: rgb("#0070c0"))[*内容1内容1内容1内容1内容1内容1内容1内容1*]，内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1。
      ]
    ]

    #figure(
      box(width: 100%)[#image("./Figures/Figure_06.jpg", width: 100%)],
      gap: 0em,
			caption: [
      内容1内容1内容1内容1内容1内容1。
    ])

    #box-grey(col: "#f2f2f2")[
      #text(size: 30pt)[
        #set align(horizon)
        - #text(fill: rgb("#0070c0"))[*内容1内容1内容1内容1内容1内容1内容1*]，内容1内容1内容1内容1内容1内容1内容1。
        - #text(fill: rgb("#0070c0"))[*内容1内容1内容1内容1内容1内容1内容1内容1内容1内容1内容内容1内容1内容1内容1。*]
        - 内容1内容1内容1内容1内容1内容1内容1。
        - 内容1内容1内容1内容1内容1内容1内容1。
        - 内容1内容1内容1内容1内容1内容1内容1。
        - 内容1内容1内容1内容1内容1内容1内容1。
      ]
    ]
  ]

  #colbreak() // 换行

  #pop.column-box(
    heading: [
      #set align(center)
      *内容2*
    ]
  )[
    #figure(
      box(width: 100%)[#image("./Figures/Figure_03.jpg", width: 100%)],
      gap: 0em,
			caption: [
      内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2
    ])

    #box-grey(col: "#f2f2f2")[
      #text(size: 30pt)[
        #set align(horizon)
        - 内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2。
        - 内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2。
        - 内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2。
        - 内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2。
        - #text(fill: rgb("#0070c0"))[*内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2内容2。*]
      ]
    ]
  ]

  #pop.column-box(
    heading: [
      #set align(center)
      *内容3*
    ],
    stretch-to-next: true // 到底
  )[
    #figure(
      box(width: 100%)[#image("./Figures/Figure_04.jpg", width: 100%)],
      gap: 0em,
			caption: [
      内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3。
    ])

    #box-grey(col: "#f2f2f2")[
      #text(size: 30pt)[
        #set align(horizon)
        - #text(fill: rgb("#0070c0"))[*内容3*]内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3。
        - 内容3#text(fill: rgb("#0070c0"))[*内容3*]内容3内容3内容3内容3内容3内容3内容3内容3内容3。
        - #text(fill: rgb("#0070c0"))[*内容3内容3*]内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3。
        - #text(fill: rgb("#0070c0"))[*内容3内容3*]内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3内容3。
      ]
    ]
  ]

  #colbreak() // 换行

    #pop.column-box(
    heading: [
      #set align(center)
      *内容4*
    ],
  )[
    #figure(
      box(width: 100%)[#image("./Figures/Figure_06.jpg", width: 100%)],
      gap: 0em,
			caption: [
      内容4内容4内容4内容4内容4内容4。
    ])

    #box-grey(col: "#f2f2f2")[
      #text(size: 30pt)[
        #set align(horizon)
        - 内容4*内容4*内容4*内容4*内容4内容4内容4内容4内容4内容4内容4内容4内容4内容4。
        - 内容4内容4内容4，#text(fill: rgb("#0070c0"))[*内容4内容4内容4内容4内容4内容4内容4*]。
      ]
    ]
  ]

  #pop.column-box(
    heading: [
      #set align(center)
      *内容5*
    ],
    // stretch-to-next: true // 到底
  )[
    #figure(
      box(width: 100%)[#image("./Figures/Figure_05.jpg", width: 100%)],
      gap: 0em,
			caption: [
      内容5内容5内容5内容5内容5内容5。内容5内容5内容5内容5内容5内容5。内容5内容5内容5内容5内容5内容5。内容5内容5内容5内容5内容5内容5。内容5内容5内容5内容5。
    ])

    #box-grey(col: "#f2f2f2")[
      #text(size: 30pt)[
        #set align(horizon)
        - 内容5内容5内容5内容5内容5内容5内容5#text(fill: rgb("#0070c0"))[*内容5内容5内容5内容5*]内容5内容5内容5。
        - 内容5内容5内容5内容5内容5#text(fill: rgb("#0070c0"))[*内容5内容5内容5内容5*]内容5内容5内容5内容5内容5。
        - 内容5内容5内容5，#text(fill: rgb("#0070c0"))[*内容5内容5内容5内容5内容5内容5*]内容5内容5内容5。
        - 内容5内容5内容5内容5#text(fill: rgb("#0070c0"))[*内容5内容5内容5*]。
      ]
    ]
  ]
])


#pop.column-box(
    heading: [
      #set align(center)
      *结论*
    ],
  )[
    #text(size: 45pt)[
      #set align(horizon)
      - 内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5。
      - 内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5，#text(fill: rgb("#0070c0"))[*内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5内容5*]。
    ]
  ]

/**
 * https://jonaspleyer.github.io/peace-of-posters/
 * 还有很多box的案例
**/

#pop.bottom-box()[
  #text(size: 37pt)[
    Lu, J., Kong, D., Zhang, Y., Xie, Y., et al. (2025). Hotspots of global water resource changes and their causes. *Earth's Future*.
  ]
]

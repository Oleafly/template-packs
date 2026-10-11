#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2.5cm),
)

#let regular = 350
#let bold = 500

#set text(font: "MiSans", weight: regular, lang: "zh", region: "cn", size: 10pt)
#set par(justify: true, spacing: 0.5em, leading: 0.5em)

#let normal-link(dest, body) = text(fill: rgb("#255595"), underline(offset: 1.5pt, link(dest, body)))
#let silent-link(dest, body) = underline(offset: 1.5pt, link(dest, body))

#show heading.where(level: 1): it => [
  #set text(12pt, weight: bold)
  #block(it, above: 0.8em)
  #v(-1em)
  #line(length: 100%, stroke: 0.75pt)
]

#set document(title: "Cirno 的简历", author: "Cirno")

#let contact-item(body, icon: image) = [
  #set text(size: 10pt)
  #box(icon, height: 10pt)
  #h(2pt)
  #box(body, height: 10pt)
]

#let space-between(l, r) = grid(
  columns: (auto, 1fr),
  align: horizon,
  l, align(right, r),
)

#let list-section(body) = [
  #set par(leading: 0.5em, spacing: 0.75em)
  #set list(marker: "•")
  #body
]

#let dot = box(scale(75%)[•])
#let endash = [–]


#grid(
  columns: (2fr, 1fr, 1fr),
  [
    #text(weight: bold, size: 20pt)[Cirno] \
    #set text(size: 9pt)
    2099/09 毕业 \
    青蛙冷冻工程师
  ],
  [
    #set align(horizon)
    #contact-item(icon: image("assets/device-mobile.svg"))[199 9999 9999] \
    #contact-item(icon: image("assets/mail.svg"))[
      #normal-link("mailto:cirno@example.com")[cirno\@example.com]
    ]
  ],
  [
    #set align(horizon)
    #contact-item(icon: image("assets/brand-github.svg"))[
      #normal-link("https://example.com")[example.com]
    ] \
    #contact-item(icon: image("assets/home.svg"))[
      #normal-link("https://example.com")[example.com]
    ]
  ],
)


#h(10pt)


= 教育经历

#space-between(
  [本科#dot\琪露诺的完美算术教室#dot\青蛙冷冻学],
  text(9pt)[2099/09 #endash 2099/09],
)


= 工作经历

#box[
  #space-between(
    text(weight: bold, "这里是公司") + dot + "这里是部门",
    text(9pt)[2099/09 #endash 现在],
  )
]
#box[
  #text(size: 9pt)[
    这里是介绍
  ]
]

#list-section[
  - 啥也没做
  - 还是啥也没做
]


= 个人项目

#box[
  #text(weight: bold)[个人项目名字]#dot\一些技术栈
] \
#box[
  #text(size: 9pt)[
    // underline 补正
    #box(
      move(dy: -1.5pt)[
        #normal-link("https://example.com")[example.com]
      ],
    ) \
    这里放一些描述
  ]
]

#list-section[
  - 这是啥？

  - 这又是啥？
]


= 专业技能

#list-section[
  - 啥也不会

  - 还是啥也不会

  - 会啥

  - 不会
]


= 证书与奖项

没有

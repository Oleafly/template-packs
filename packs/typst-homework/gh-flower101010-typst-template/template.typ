#import "@preview/ctheorems:1.1.3": *
#let conf(
  title: [],
  institute: [],
  name: [],
  course: [],
  professor: [],
  date: "auto",
  doc,
) = [
  #show: thmrules.with(qed-symbol: $square$)
  #set heading(numbering: "A.1.")
  #set text(font: ("New Computer Modern", "Noto Serif SC"), lang: "zh", region: "cn")

  #set page(
    header: context {
      if counter(page).get().first() > 1 [
        #text(font: "New Computer Modern", style: "italic", course) - #text(font: "New Computer Modern", title)
        #h(1fr)
        #counter(page).display()
        #line(
          length: 100%,
          start: (0pt, -10.5pt),
          stroke: 0.4pt,
        )
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 [
        #h(1fr)
        #text(
          font: "New Computer Modern",
          style: "italic",
          name,
        )
        #line(
          length: 100%,
          start: (0pt, -25pt),
          stroke: 0.4pt,
        )
      ] else [
        #align(center)[#counter(page).display()]
      ]
    },
  )

  #align(center)[
    #if institute != [] [
      #text(
        11pt,
        weight: "thin",
        font: "New Computer Modern",
        style: "normal",
        smallcaps(institute),
      )
      #line(
        length: 100%,
        start: (0pt, -5pt),
        stroke: 0.4pt,
      )
    ]
    #if title != [] [
      #move(
        dx: 0pt,
        dy: -9pt,
        text(
          17pt,
          weight: "black",
          font: "New Computer Modern",
          style: "normal",
          title,
        ),
      )
    ]
    #if name != [] [
      #move(
        dx: 0pt,
        dy: -9pt,
        [
          #text(
            11pt,
            weight: "light",
            font: "New Computer Modern",
            style: "italic",
            name,
          )
        ],
      )
      #line(
        length: 100%,
        start: (0pt, -13pt),
        stroke: 0.4pt,
      )
    ]
    #if course != [] or professor != [] [
      #move(
        dx: 0pt,
        dy: -19pt,
        [
          #if course != [] [
            #text(
              11pt,
              weight: "regular",
              font: "New Computer Modern",
              style: "normal",
              "Course: ",
            )#text(
              11pt,
              weight: "light",
              font: "New Computer Modern",
              style: "italic",
              course,
            )
          ]
          #if course != [] and professor != [] [
            #text(
              11pt,
              weight: "regular",
              font: "New Computer Modern",
              style: "normal",
              " – Professor: ",
            )
          ] else if professor != [] [
            #text(
              11pt,
              weight: "regular",
              font: "New Computer Modern",
              style: "normal",
              "Professor: ",
            )
          ]
          #if professor != [] [
            #text(
              11pt,
              weight: "light",
              font: "New Computer Modern",
              style: "italic",
              professor,
            )
          ]
        ],
      )
    ]
    #if date != none [
      #move(
        dx: 0pt,
        dy: -20pt,
        [
          #text(
            10pt,
            weight: "light",
            font: "New Computer Modern",
            style: "normal",
            if date == "auto" {
              datetime.today().display("[month repr:long] [day], [year]")
            } else {
              date
            },
          )
        ],
      )
    ]
  ]
  #doc
]

#let proof = thmproof("proof", "Proof")
#let answer = thmproof("answer", "Answer")

#let problem(content, index: "#") = {
  // 创建标签块
  let label-block = block(
    fill: orange.lighten(95%),
    stroke: 1pt + orange,
    radius: 4pt,
    inset: (x: 6pt, y: 4pt),
    [*Problem #index*],
  )

  // 主要内容块，带上边距为标签留空间
  block(
    fill: orange.lighten(90%),
    stroke: 1.5pt + rgb("#ff851ba6"),
    radius: 4pt,
    inset: (left: 12pt, right: 12pt, top: 14pt, bottom: 12pt),
    width: 100%,
    above: 1.5em,
    below: 1em,
    breakable: true,
    [
      // 将标签定位到左上角边框上
      #place(
        top + left,
        dx: 4pt,
        dy: -21.8pt, // 精确计算：标签高度/2 + 边框调整 + 微调
        label-block,
      )
      #content
    ],
  )
}

#let theorem = thmbox(
  "theorem", // identifier
  "Theorem", // head
)
#let lemma = thmbox(
  "theorem", // identifier - same as that of theorem
  "Lemma", // head
  fill: rgb("#efe6ff"),
)
#let example = thmplain(
  "example",
  "Example",
).with(numbering: none)

#let solution = thmplain(
  "theorem",
  "Solution",
).with(numbering: none)

#let remark = thmplain(
  "remark",
  "Remark",
  fill: rgb("#f0f8ff"),
  stroke: rgb("#87ceeb") + 1pt,
  inset: (left: 12pt, right: 12pt, top: 12pt, bottom: 12pt),
  above: 1.5em,
  below: 1.5em,
).with(numbering: none)

#import "utils.typ": *
#import "@preview/chic-hdr:0.5.0": *

#let font_serif = ("Noto Serif CJK SC", "Noto Serif SC")
#let font_sans = ("Noto Sans CJK SC","Noto Sans SC")

#let indent() = {
  box(width: 2em)
}


#let info_key(body) = {
  rect(inset: (right:1em+2pt,left: 2pt,bottom: 2pt,top: 2pt), stroke: none, text(font: font_serif, size: 16pt, body))
}

#let info_value(body) = {
  rect(
    //width: 100%,
    inset: 2pt,
    stroke: none,
    text(font: font_serif, size: 16pt, bottom-edge: "descender")[ #body ],
  )
}

#let project(
  lab_name: "单摆测量重力加速度实验",
  stu_name: "你的名字",
  stu_id: "PB24114514",
  department: "排版与Typst开发学院",
  date: datetime.today(),

  with_outline: false,
  watermark: "",

  abstract: [abstract 是摘要],
  keywords: ([keywords],"是",[关键词]),
  body,
) = {
  show: init
  set page("a4")
  set par(    // 段落设置
    justify: false,
    leading: 1.04em,
    first-line-indent:(amount: 2em, all: true),
  )

  set text(   // 字体设置
      //size: 26pt,
      font: font_serif,
      lang: "zh",
      region: "ch",
  )

  show figure.where(
    kind: table
  ): set figure.caption(position: top)


  show: chic.with(  // 页眉设置
    chic-header(
      left-side: smallcaps(
        text(size: 12pt, font: font_sans)[
          #lab_name
        ],
      ),
      right-side: text(size: 12pt, font: font_sans)[
        #chic-page-number()
      ],
      side-width: (60%, 0%, 35%),
    ),
    chic-separator(on: "header", stroke()),
    chic-offset(20%),
    chic-height(3.2cm),
  )

  // 封面
  align(center)[
    //#image("./USTC-name.png", width: 100%)
    #set text(weight: "bold",)
    #v(1em)

    // 报告名
    #text(size: 24pt, font: font_serif)[
      #lab_name
    ]
    // #image("./USTC-logo.png", width: 60%)

    #v(-0.2cm)

    // 个人信息
    #grid(
      columns: 2,
      rows: (28pt, 28pt),
      gutter: 0pt,
      info_key("学院"),
      info_value(department),
      info_key("姓名"),
      info_value(stu_name),
      info_key("学号"),
      info_value(stu_id),
    )
    // 日期
    #v(-0.5cm)
    #text(font: font_serif, size: 14pt)[
      #date.year() 年 #date.month() 月 #date.day() 日
    ]
  ]
  [
    == 摘要：
    #abstract
   
    #if keywords != none [
      / 关键词：: #if type(keywords) == array {
        keywords.at(0)
        for kw in keywords.slice(1) {
          "；"+kw
        }
      } else {
        keywords
      }
    ]
    #if with_outline {
      show outline.entry.where(level: 1): it => {
        v(22pt, weak: true)
        strong(it)
      }
      show outline.entry: it => {
        v(10pt, weak: true)
        set text(
          font: "Noto Sans CJK SC",
          size: 14pt,
        )
        it
      }
    }
  ]

  body
}

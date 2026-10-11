#set text(font: "SimSun", size: 10.5pt)
#set par(justify: true,first-line-indent: 2em) // 两端对齐，段前缩进2字符
#set par(leading: 1em)
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show :show-cn-fakebold
#import "@preview/tablem:0.1.0": tablem
#import "../config.typ": config,configEn

#{
  set align(right)
  set text(font:"SimSun", size: 12pt)
  table(
    columns: (4em,4em),
    rows: (3em),
    align: (center,center),
    [#v(0.7em)*成绩*],[]
  )
}

#v(60pt)

#{
  set align(center)
  image("../../img/logo.jpg")
}

#v(3em)

#{
  set align(center)
  set text(font: "Microsoft YaHei", size: 24pt, weight: "black")

  [#config.course\ 结课论文]

  v(2em)

}

#let fixed_underline(total_width,body) = context {
  let size = measure(body)
  let left_width = (total_width - size.width)/2

  box(width: total_width)[#underline(body, extent: left_width)]
  
}


#let underline_width = 18em

#{
  set align(center)
  set text(font: "Microsoft YaHei", size: 15pt, weight: "black")

  [题#h(2em)目：#fixed_underline(underline_width)[#config.title]\ ]
  [学#h(2em)院：#fixed_underline(underline_width)[#config.school]\ ]
  [专业名称：#fixed_underline(underline_width)[#config.major]\ ]
  [学#h(2em)号：#fixed_underline(underline_width)[#config.sid]\ ]
  [姓#h(2em)名：#fixed_underline(underline_width)[#config.author]\ ]
  [任课教师：#fixed_underline(underline_width)[#config.teachers.join("，")]\ ]
  [评#h(0.5em)阅#h(0.5em)人：#fixed_underline(underline_width)[\u{0}]\ ]
  
  v(2em)

}


#pagebreak()




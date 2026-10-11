#let bachelor-thesis-style(
  title: "Title",
  author: "○○○",
  supervisor: "○○○",
  pubdate: (
    year: [20OO],
    month: [O]
  ),
  body,
) = {
  set page(
    paper: "a4",
    margin: (
      left: 30mm,
      right: 30mm,
      top: 35mm,
      bottom: 40mm,
    ),
    footer-descent: 25mm
  )

  let myeonjo = (
    "Noto Serif CJK KR",
    "KoreanMJM", "ShinMyeongJo"  // 신명조 required originally
  )
  let gothic = (
    "Noto Sans CJK KR",
    "HYGoThic",  // 견고딕 required originally
  )
  
  // 바탕글
  set text(
    font: myeonjo,
    size: 10pt,
    lang: "ko",
  )
  
  set par(
    leading: 1.6em,
    first-line-indent: 0em,
    justify: true,
  )
  
  // 본문
  show par: it => {
    set par(
      leading: 1.65em,
      first-line-indent: 0em,
      justify: true,
    )
    pad(
      left: 18pt,
      right: 18pt,
      it,
    )
  }
  
  // 개요1
  let outline1(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 0pt, right: 0pt, content)
  }
  
  // 개요2
  let outline2(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 10pt, right: 0pt, content)
  }
  
  // 개요3
  let outline3(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 20pt, right: 0pt, content)
  }
  
  // 개요4
  let outline4(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 30pt, right: 0pt, content)
  }
  
  // 개요5
  let outline5(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 40pt, right: 0pt, content)
  }
  
  // 개요6
  let outline6(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 50pt, right: 0pt, content)
  }
  
  // 개요7
  let outline7(content) = {
    set par(
      leading: 1.6em,
      first-line-indent: -0em,
      justify: true,
    )
    pad(left: 60pt, right: 0pt, content)
  }
  
  // 각주
  show footnote.entry: set text(font: myeonjo, size: 9.5pt)
  show footnote.entry: set par(
    leading: 1.3em,
    first-line-indent: -0em,
    justify: true,
  )
  
  // 캡션
  show figure.caption: set text(font: gothic, size: 9pt)
  show figure.caption: set par(
    leading: 1.6em,
    first-line-indent: 0em,
    justify: true,
  )
  
  // 제목 1단계
  show heading.where(level: 1): set text(size: 12pt, weight: "bold", font: myeonjo)
  show heading.where(level: 1): set par(
    leading: 1.6em,
    first-line-indent: 0em,
    justify: true,
  )
  
  // 제목 2단계
  show heading.where(level: 2): set text(size: 10pt, font: myeonjo)
  show heading.where(level: 2): set par(
    leading: 1.6em,
    first-line-indent: 0em,
    justify: true,
  )

  let format-name(name, spacing: 3.5em) = {
    let chars = name.split("")
    chars.join(h(spacing))
  }

  let vspan-using-line(basesize, row, lineheight) = {
    v(basesize * row + basesize * (lineheight - 1) * (row - 1))
  }
  
  // 표지
  align(center)[
    #v(12mm)
    #text(size: 14pt)[학사학위논문]
    #vspan-using-line(14pt, 2, 1.6)
    #text(size: 26pt)[#title]
    #vspan-using-line(14pt, 3, 1.6)
    #text(size: 16pt)[전 남 대 학 교]
    #v(7pt)
    #par(leading: 1.1em)[
      #text(size: 16pt)[
        전자컴퓨터공학부\
        컴퓨터정보통신공학전공
      ]
    ]
    #vspan-using-line(14pt, 4, 1.6)
    #text(size: 16pt)[#format-name(author)]
    #vspan-using-line(14pt, 8, 1.6)
    #text(size: 16pt)[#pubdate.year\년 #h(.8em) #pubdate.month\월]
  ]

  pagebreak()
  counter(page).update(0)
  
  // 내지
  align(center)[
    #v(12mm)
    #text(size: 14pt)[학사학위논문]
    #vspan-using-line(14pt, 2, 1.6)
    #text(size: 26pt)[#title]
    #vspan-using-line(14pt, 3, 1.6)
    #text(size: 16pt)[전 남 대 학 교]
    #v(7pt)
    #par(leading: 1.1em)[
      #text(size: 16pt)[
        전자컴퓨터공학부\
        컴퓨터정보통신공학전공
      ]
    ]
    #vspan-using-line(14pt, 3, 1.6)
    #text(size: 16pt)[#format-name(author)]
    #vspan-using-line(14pt, 2, 1.6)
    #text(size: 16pt)[
      지도교수#h(.2em) #format-name(supervisor, spacing: 1.2em) #h(.8em) (인)
    ]
      #vspan-using-line(14pt, 6, 1.6)
    #text(size: 16pt)[#pubdate.year\년 #h(.8em) #pubdate.month\월]
  ]

  // 쪽번호
  set page(
    footer: context [
      #set align(center)
      #set text(font: gothic, size: 10pt)
      #set par(leading: 1.6em, first-line-indent: 0em, justify: true)
      #counter(page).display()
    ]
  )
  pagebreak()

  body
}

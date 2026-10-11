#let bachelor-thesis-style(
  title: "논문 주제목",
  subtitle: none,
  author: "이름",
  supervisor: "△△△",
  pubdate: (
    year: [○○○○],
    month: [○]
  ),
  coach-date: (
    first: (year: [#h(1em)], month: [#h(1em)], day: [#h(1em)]),
    second: (year: [#h(1em)], month: [#h(1em)], day: [#h(1em)]),
    third: (year: [#h(1em)], month: [#h(1em)], day: [#h(1em)]),
  ),
  disable-bibliography: false,
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
    footer-descent: 25mm,
  )

  let myeonjo = (
    "Noto Serif CJK KR",
    "KoreanMJM", "ShinMyeongJo"  // 신명조 required originally
  )
  let gothic = (
    "Noto Sans CJK KR",
    "HYGoThic",  // 견고딕 required originally
  )

  let text-size-default = 11pt
  // 바탕글
  set text(
    font: myeonjo,
    size: text-size-default,
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
  show footnote.entry: set text(font: myeonjo, size: 10pt)
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

  // 인용문
  show quote: it => {
    set text(size: 10pt)
    set par(leading: 2em)
    block(
      spacing: 1em,
      inset: (top: 1em, bottom: 1em, left: 10pt, right: 0pt),
      it.body
    )
  }

  // 제목 1단계
  show heading.where(level: 1): it => {
    set text(size: 14pt, weight: "bold")
    set align(center)
    set block(spacing: 1em)
    [
      #it.numbering #it.body\
      #v(text-size-default)
    ]
  }
  
  // 제목 2단계
  show heading.where(level: 2): it => {
    set text(size: 11pt, weight: "bold")
    set align(left)
    pad(left: 1em, [
      #it.numbering #it.body #v(.7em)
    ])
  }

  // 유틸
  let format-name(name, spacing: 3.5em) = {
    let chars = name.split("")
    chars.join(h(spacing))
  }

  let vspan-using-line(basesize, row, lineheight) = {
    v(basesize * row + basesize * (lineheight - 1) * (row - 1))
  }
  
  // 표지
  align(center)[
    #v(0.5cm)  // 4cm
    #text(size: 14pt)[문학사학위논문]
    #v(1.5cm)
    #text(size: 26pt)[
      #title\
    ]
    #if (subtitle != none) [
      #text(size: 18pt)[#subtitle]
    ]
    #v(2.5cm)
    #text(size: 16pt)[전남대학교 인문대학]
    #v(0.5cm)
    #text(size: 16pt)[일어일문학과]
    #v(1.5cm)
    #text(size: 16pt)[#author]
    #v(7cm)
    #text(size: 16pt)[#pubdate.year\년 #h(.8em) #pubdate.month\월]
  ]

  pagebreak()
  
  // 내지
  align(center)[
    #set par(leading: 1em)
    #v(0.5cm)  // 4cm
    #text(size: 26pt)[
      #title\
    ]
    #if (subtitle != none) [
      #text(size: 18pt)[#subtitle]
    ]
    #v(2.5cm)
    #text(size: 16pt)[전남대학교 인문대학]
    #v(0.5cm)
    #text(size: 16pt)[일어일문학과]
    #v(1.5cm)
    #text(size: 16pt)[#author]
    #v(3cm)
    #text(size: 14.5pt)[
      #if (coach-date.first != none) [
        1차 지도 일지: #coach-date.first.year\년 #coach-date.first.month\월 #coach-date.first.day\일
      ]
      #v(0.5cm)
      #if (coach-date.second != none) [
        2차 지도 일지: #coach-date.second.year\년 #coach-date.second.month\월 #coach-date.second.day\일
      ]
      #v(0.5cm)
      #if (coach-date.third != none) [
        3차 지도 일지: #coach-date.third.year\년 #coach-date.third.month\월 #coach-date.third.day\일
      ]
    ]
    #v(1cm)
    #text(size: 16pt)[지도교수 #h(.3em) #supervisor #h(.3em) (인)]
    #v(2cm)
    #text(size: 16pt)[#pubdate.year\년 #h(.5em) #pubdate.month\월]
  ]

  pagebreak()

  // 목차
  show outline: align.with(center)
  show outline.entry: it => {
    let level = it.level
    
    let indent = if level == 1 {
      10pt - 10pt
    } else if level == 2 {
      25pt - 10pt
    } else if level == 3 {
      32pt - 10pt
    }
    
    let font-size = if level == 1 {
      12pt
    } else {
      11pt
    }

    let weight = if level == 1 {
      "bold"
    } else {
      "regular"
    }

    set par(
      leading: 1.8em,
      first-line-indent: 0em
    )

    // 번호 자리 콘텐츠: 크기를 콘텐츠 안에 직접 적용
    let prefix-content = if it.prefix() != none {
      text(size: font-size, weight: weight)[#it.prefix() ]
    } else {
      // 번호가 없으면 "1. " 폭만큼 빈 자리 (context 안에서 measure)
      context box(width: measure(text(size: font-size, weight: weight)[1. ]).width)
    }
  
    box(
      width: 100%,
      inset: (left: indent),
      [
        #prefix-content#text(size: font-size, weight: weight)[#it.body()]
        #box(width: 1fr, repeat[·])
        #text(size: font-size, weight: weight)[#it.page()]
      ]
    )
  }
  show outline.entry.where(level: 1): set text(size: 12pt, weight: "bold")

  
  outline(
    title: text(size: 17pt, weight: "bold")[목차]
  )

  set figure.caption(separator: " ")
  
  show figure.where(kind: table): set figure(
    supplement: "",
    numbering: (..nums) => {
      let num = nums.pos().map(str).join(".")
      [\<표-#num\>]
    }
  )
  
  show figure.where(kind: image): set figure(
    supplement: [],
    numbering: (..nums) => {
      let num = nums.pos().map(str).join(".")
      [\<그림-#num\>]
    }
  )
  
  // 수집기: 표/그림 목차 (supplement 포함)
  let table-list = state("table-list", ())
  let figure-list = state("figure-list", ())
  
  show figure.where(kind: table): fig => {
    table-list.update(lst => {
      lst.push((
        caption: fig.caption.body,
        number: numbering(fig.numbering, ..counter(figure.where(kind: table)).at(fig.location())),
      ))
      lst
    })
    fig
  }
  
  show figure.where(kind: image): fig => {
    figure-list.update(lst => {
      lst.push((
        caption: fig.caption.body,
        number: numbering(fig.numbering, ..counter(figure.where(kind: image)).at(fig.location())),
      ))
      lst
    })
    fig
  }
  
  let list-entry(supplement, title, page) = {
    set par(
      leading: 1.8em,
      first-line-indent: 0em
    )
    
    box(
      width: 100%,
      inset: (left: 10pt),
      [
        #text(
          size: 11pt,
          weight: "regular",
        )[#supplement #title]
        #box(width: 1fr, repeat[·])
        #text(
          size: 11pt,
          weight: "regular",
        )[#page]
      ]
    )
  }

  v(1em)

  // 표 목차
  context {
    let tables = table-list.final()
    if tables.len() > 0 {
      align(center)[
        #text(size: 17pt, weight: "bold")[표 목차]
      ]
      
      let table-queries = query(figure.where(kind: table))
      
      for (i, tbl) in tables.enumerate() {
        if i < table-queries.len() {
          let page-num = table-queries.at(i).location().page()
          list-entry(tbl.number, tbl.caption, page-num)
        }
      }
    }
  }

  v(1em)
  
  // 그림 목차
  context {
    let figures = figure-list.final()
    if figures.len() > 0 {
      align(center)[
        #text(size: 17pt, weight: "bold")[그림 목차]
      ]
      let figure-queries = query(figure.where(kind: image))
      
      for (i, fig) in figures.enumerate() {
        if i < figure-queries.len() {
          let page-num = figure-queries.at(i).location().page()
          list-entry(fig.number, fig.caption, page-num)
        }
      }
    }
  }
  
  v(12pt)
  
  set heading(numbering: "1.")
  
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
  
  counter(page).update(1)

  body

  // bibliography
  show bibliography: set heading(numbering: none)
  show bibliography: set text(size: 11pt)
  show bibliography: it => {
    set text(size: 11pt)
    set par(first-line-indent: -2em, hanging-indent: 2em, leading: .8em)
    it
  }
  
  if (disable-bibliography != true) {
    pagebreak()
    bibliography("refs.bib", full: true, title: [참고문헌], style: "cite-style.csl")
  }
}

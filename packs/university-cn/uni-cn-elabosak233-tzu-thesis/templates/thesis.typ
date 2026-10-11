#import "@preview/cuti:0.4.0": show-cn-fakebold

#import "fonts.typ": fonts, sizes
#import "patches.typ": patch-enum-item, patch-list-item
#import "pages/cover.typ": cover
#import "pages/authorization.typ": authorization, authorization-page
#import "pages/abstract.typ": abstract, abstract-page
#import "pages/abstract-en.typ": abstract-en, abstract-en-page
#import "pages/toc.typ": toc
#import "pages/bibliography.typ": bibliography-page
#import "pages/acknowledgement.typ": acknowledgement, acknowledgement-page
#import "pages/commitment.typ": commitment, commitment-page

#let thesis(
  title: "基于 Typst 的台州学院学位论文模板",
  title-en: "A Thesis Template Based on Typst",
  school: "人工智能学院",
  major: "计算机科学与技术（奇安信）",
  class: "23 计算机奇安信班",
  uid: "2362120000",
  student: "张三",
  advisor: "李四",
  second-advisor: none,
  date: datetime.today(),
  bibliography: none,
  body,
) = {
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 2.5cm, bottom: 2.5cm, top: 2.5cm),
  )

  cover(title, school, major, class, uid, student, advisor, second-advisor, date)

  pagebreak()

  authorization-page(date)
  abstract-page()
  abstract-en-page()

  toc

  set page(numbering: "1")

  counter(page).update(1)

  show: show-cn-fakebold

  align(center)[
    #set par(spacing: 1em, leading: 1em)
    #v(2em)
    #text(font: (fonts.main, fonts.黑体), size: sizes.三号)[
      #title
    ]
    #v(1em)
    #text(font: fonts.main, size: sizes.三号, weight: "bold")[
      #title-en
    ]
    #v(1em)

    #text(font: fonts.楷体, size: sizes.小五)[
      #school#h(1em)#major

      #student

      指导教师：#advisor
    ]
  ]

  set heading(
    numbering: (..nums) => {
      let level = nums.pos().len()
      let n = nums.pos()

      if level == 1 {
        numbering("1.", ..n)
      } else if level == 2 {
        numbering("1.1", ..n)
      } else if level == 3 {
        numbering("1.1.1", ..n)
      }
    },
  )

  show heading: it => {
    let size = if it.level == 1 { sizes.四号 } else if it.level == 2 { sizes.小四 } else {
      sizes.五号
    }

    let top = if it.level == 1 { 1.0em } else { 0.5em }

    let bottom = if it.level == 1 { 1em } else { 0.5em }

    v(top)
    set text(font: (fonts.main, fonts.黑体), size: size, weight: "regular")
    it
    v(bottom)
  }

  set text(
    font: ((name: fonts.main, covers: "latin-in-cjk"), fonts.宋体),
    size: sizes.五号,
    lang: "zh",
    top-edge: "ascender",
    bottom-edge: "descender",
  )

  set par(first-line-indent: (amount: 2em, all: true), leading: 1.25em, spacing: 1.25em)

  show figure.where(
    kind: table,
  ): set figure.caption(position: top)

  // 图表共享编号
  show figure.where(kind: table): set figure(kind: image, supplement: [表])

  show figure.where(kind: image): set figure(supplement: [图])

  set figure(
    numbering: n => {
      let ch = counter(heading).get().first()

      numbering("1-1", ch, n)
    },
  )

  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    it
  }

  show figure.caption: it => {
    v(0.5em)
    set text(
      font: (fonts.main, fonts.宋体),
      size: sizes.五号,
    )

    it

    v(0.5em)
  }

  show cite: it => {
    set text(font: fonts.宋体, size: sizes.五号, baseline: -0.1em)
    super(it)
  }

  body

  pagebreak()
  bibliography-page(bib: bibliography)

  pagebreak()
  acknowledgement-page()

  pagebreak()
  commitment-page(date)
}

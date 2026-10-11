#import "pages/abstract-page.typ": abstract-page-cn, abstract-page-en
#import "pages/cover-page.typ": cover-page
#import "pages/decl-page.typ": decl-page
#import "pages/outline-page.typ": outline-page
#import "layouts/basic-layout.typ": basic-layout
#import "layouts/page-layout.typ": page-header, page-footer

#import "@preview/i-figured:0.2.4"

#let thesis-init(
  graduate-year: 2025,
  topic: "基于Typst的杭电论文模板",
  institute: "计算机学院",
  major: "计算机科学与技术",
  class: "21xxxxxx",
  student-id: "21xxxxxx",
  name: "张三",
  supervisor: "李四",
  complete-time: datetime(year: 2025, month: 4, day: 1),
  abstract-cn: lorem(100),
  abstract-en: lorem(100),
  keywords-cn: ("Typst", "论文模板"),
  keywords-en: ("Typst", "Thesis Template"),
  doc,
) = {
  set document(title: topic, author: name)

  let s = state("pager-state", false)

  cover-page(
    graduate-year: graduate-year,
    topic: topic,
    institute: institute,
    major: major,
    class: class,
    student-id: student-id,
    name: name,
    supervisor: supervisor,
    complete-time: complete-time,
  )

  decl-page(topic: topic)

  abstract-page-cn(keywords: keywords-cn, abstract-cn)

  abstract-page-en(keywords: keywords-en, abstract-en)

  outline-page(pager-state: s)


  show: page-header.with()
  show: page-footer.with(pager-state: s)
  show: basic-layout.with()

  show <acknowledgement>: set heading(numbering: none)

  counter(page).update(1)
  doc
}

#let appendix(doc) = {
  counter(heading).update(0)
  set heading(numbering: "附录A", supplement: [附录])

  show figure: i-figured.show-figure.with(numbering: "A-1")

  doc
}

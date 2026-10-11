#import "../utils/mod.typ": *

#let elegant-cover(
  author: "author",
  mail: "123456789",
  course: "course",
  course-alt: "sub-course",
  footer-text: "生如夏花之绚烂，死如秋叶之静美",
  cover-pic: "../pic/dawn.png",
  cover-rec-color: rgb("#f1a258"),
) = {
  set page(
    margin: (top: 0em),
    footer: align(center, text(font: cn-kaiti, footer-text)),
    background: none,
  )
  let rect-h = 28pt
  let banner = box[
    #let w = 132%
    // #image("../pic/dawn.png", width: w)
    #image(cover-pic, width: w)
    #place(center, rect(width: w, height: rect-h, stroke: none, fill: cover-rec-color))
  ]
  align(center, banner) 
  v(rect-h)
  v(40pt)
  v(1fr)
  pad(left: 0em, text(size: 28pt, weight: 450, font: (en-font-sans, cn-font-sans), course))
  pad(left: 0em, top: 1em, text(size: 18pt, weight: 450, font: (en-font-serif, cn-font-sans), course-alt))
  [
    #set text(fill: luma(130), size: 15pt, font: (en-font-serif, cn-font-serif))
    作者：#author \
    时间：#datetime.today().display("[year].[month].[day]") \
    邮箱：#mail
  ]
  place(right, dy: -10em, image("../pic/mascot.png", height: 15%))
  v(1fr)
}

#let svg-cover(course: "course", author: "author") = {
  let fill-color = rgb("#D8CFC6")

  set page(footer: none, background: image("../pic/bg-4.svg", width: 101%, fit: "cover"))

  set text(fill: white)
  set par(first-line-indent: 0pt)


  place(
    image("../pic/ecnu-logo-white.svg", height: 30%),
    dy: -80pt,
  )

  v(5fr)
  [
    #align(left)[#underline(
      (underline(text(size: 45pt, weight: 800)[#course], offset: 7pt, stroke: red)),
      stroke: red,
      offset: 11pt,
    )]
    #align(left)[
      #text(size: 45pt, weight: 800)[笔记]
    ]
  ]
  v(1em)
  text(
    font: (en-font-sans, cn-font-sans),
    size: 16pt,
    weight: 800,
  )[#math.copyright #author \ East China Normal University]
  v(10fr)
}

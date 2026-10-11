#import "./default_set.typ": *
#import "@preview/cap-able:0.0.1": *


#let fmt-num(n) = {
  let s = str(n)
  let len = s.clusters().len()
  if len == 1 { "00" + s } else if len == 2 { "0" + s } else { s }
}
#let paperTypeShow(paperType: "review", trueContent, falseContent) = {
  if paperType == "review" {
    trueContent
  } else {
    falseContent
  }
}

#let cvpr(paperType: "review", paperId: "", title: "", author_info: "", rebuttal: false, content) = {
  set page(
    // paper: "us-letter",
    width: 8.5in,
    height: 11in,
    columns: 2,
    margin: (top: 1in, bottom: 1.1in, left: 0.75in, right: 0.75in),
    header: [
      #paperTypeShow(paperType: paperType)[
        #textphvb()[
          #grid(
            columns: (5em, 1fr, 5em),
          )[
            CVPR\
            \# #paperId
          ][
            #set align(center)
            #confName #confYear Submission \##paperId.  CONFIDENTIAL REVIEW COPY. DO NOT DISTRIBUTE.
          ][
            CVPR\
            \# #paperId
          ]
        ]
      ][]
    ],
    header-ascent: 3em,
    numbering: (cur, total) => paperTypeShow(paperType: paperType)[#cur][],
  )
  set columns(gutter: 0.33in)
  set par(justify: true, spacing: 0.65em, first-line-indent: (amount: 1.5em, all: true))
  set align(left)
  set text(
    font: confFontfamily.default,
    size: confFontSize.normal,
  )
  set heading(numbering: "1.1")
  show heading.where(): it=>{
    if rebuttal {
      set block(above: confFontSize.small, below: confFontSize.small)
      it
    } else {
      set block(above: confFontSize.large, below: confFontSize.normal)
      it
    }
  }
  show heading.where(level: 1): set text(size: confFontSize.large, weight: "bold")
  show heading.where(level: 2): set text(size: confFontSize.large, weight: "bold")
  show <abstract>: set heading(numbering: none)
  show <abstract>: set block(below: confFontSize.large)
  show: it => {
    paperTypeShow(paperType: paperType)[
      #set par.line(
        numbering: n => textphvb()[#fmt-num(n)],
      )
      #it
    ][#it]
  }

  set math.equation(numbering: "(1)")
  show link: it => text(fill: confColor.link, font: confFontfamily.link, it)

  set bibliography(style: "ieee")

  // set cite(style: read("../csl/ieee.csl",encoding: none))
  set cite(style: "american-physics-society")
  show cite: it => text(fill: confColor.link, it)

  set figure(numbering: "1")
  show figure.caption: set text(size: confFontSize.small)
  show figure.caption: set align(left)
  show: capfig-style.with(
    caption-size: confFontSize.small,
  )
  show: captab-style.with(
    caption-below: 1em,
  )
  // title and author info
  place(
    top + center,
    scope: "parent",
    float: true,
  )[
    #set align(center)
    #if rebuttal == false {
      v(1em)
    }
    #text(confFontSize.Large, weight: "bold", title)
    #if rebuttal == false {
      v(2em)
      text(confFontSize.large)[
        #show: it => if paperType == "review" {
          [
            Anonymous CVPR submission
            #v(1em)
            Paper ID #paperId
          ]
        } else {
          it
        }
        #author_info
      ]
      v(2em)
    }
  ]
  content
}

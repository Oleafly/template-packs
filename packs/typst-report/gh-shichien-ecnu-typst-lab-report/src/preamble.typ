#import "colorbox.typ": *
#import "@preview/mitex:0.2.6": *
#import "@preview/subpar:0.2.2": *
#import "@preview/subpar:0.2.2": grid as subfigure
#import "@preview/numbly:0.1.0": numbly
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/codly:1.3.0": * // 代码高亮包
#import "@preview/codly-languages:0.1.6": *
#import "@preview/cjk-unbreak:0.2.3": remove-cjk-break-space // 解决 CJK 换行问题
#import "@preview/citegeist:0.2.0": load-bibliography // 解决引用缺失问题

#let all-bib-entries() = {
  let bib-file = {
    let all-bib = query(bibliography)
    if all-bib.len() > 0 {
      all-bib.at(0).sources.at(0)
    } else {
      none
    }
  }
  if bib-file == none {
    (:)
  } else {
    load-bibliography(read(bib-file))
  }
}

#let possible-missing-ref(it) = {
  if str(it.target) in all-bib-entries() or it.element != none {
    it
  } else {
    text(fill: red, "<未找到引用" + str(it.target) + ">")
  }
}

#let template(header: "", author: "", title: "", body) = {
  set document(author: author, title: title, date: auto)
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: 1em,
    spacing: 1.2em,
    hanging-indent: 0em,
  )
  
  set list(
    tight: true,
    marker: ([•], [--], [>]),
    indent: 1em,
    body-indent: 0.8em,
  )
  
  set enum(
    tight: true,
    numbering: "1.1.",
    indent: 1em,
    body-indent: 0.5em,
    full: true,
  )
  
  show: show-cn-fakebold
  show: remove-cjk-break-space
  set text(
    size: 10pt,
    font: ("Times New Roman", "SimSun"),
    lang: "zh",
    region: "cn",
  )
  
  set heading(numbering: "1.1.1  ")
  show heading: it => box(width: 100%)[
    #set text(font: ("Times New Roman", "Source Han Serif SC", "SimSun"))
    #if it.numbering != none {
      text(size: 1.1em)[
        #counter(heading).display("1.1.1")
      ]
    }
    #h(0.5em) #text(weight: "extrabold")[#it.body]
  ]
  
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }
  
  set footnote.entry(indent: 0em)
  
  set math.equation(
    numbering: n => {
      numbering("(1.1)", counter(heading).get().first(), n)
    },
  )
  
  show outline: set heading(numbering: none)
  show outline.entry.where(level: 1): it => {
    set block(above: 1.1em)
    text(
      font: ("Times New Roman", "Source Han Serif SC", "SimSun"),
    )[
      #text(weight: "extrabold", size: 1.1em)[#it]
    ]
  }
  show outline.entry.where(level: 2): it => {
    set block(above: 1.1em)
    it
  }
  
  show: codly-init
  codly(languages: codly-languages)
  show raw: it => {
    set text(font: ("JetBrains Mono NL", "SimSun"))
    it
  }
  
  show link: {
    underline.with(stroke: rgb("#0074d9"), offset: 2pt)
  }
  show link: set text(blue)
  
  show ref: possible-missing-ref
  
  set page(
    margin: (
      left: 15mm,
      right: 15mm,
      top: 15mm,
      bottom: 20mm,
    ),
    fill: white, // 解决源代码跳转问题
    header: [#align(center)[#header] #v(-0.2cm)] + line(length: 100%),
    footer: line(length: 100%)
      + context {
        if counter(page).at(here()).first() == 0 { return }
        let page-number = counter(page).at(here()).first()
        [
          #if calc.odd(page-number) {
            align(
              left,
            )[ #h(-2em) _In Typst By_ #link("github.com/Shichien", scr("Deralive"))]
            v(-2em)
            align(right)[#counter(page).display("第 1 页，共 1 页", both: true)] // 奇数页靠右
          } else {
            align(left)[ #h(-2em) #counter(page).display("第 1 页，共 1 页", both: true)] // 偶数页靠左
            v(-2em)
            align(right)[_In Typst By_ #link("github.com/Shichien", scr("Deralive"))]
          }
        ]
      },
  )
  body
}

#import "fonts.typ": *

#let toc-entry-style() = {
  show outline.entry: it => {
    let fill-dots = box(width: 1fr, repeat[.])

    if it.level == 1 {
      text(size: 14pt, font: fonts.song)[
        #it.body
        #fill-dots
        #it.page
      ]
    } else if it.level == 2 {
      text(size: 14pt, font: fonts.song)[
        #h(2em)#it.body
        #fill-dots
        #it.page
      ]
    } else if it.level == 3 {
      text(size: 14pt, font: fonts.song)[
        #h(4em)#it.body
        #fill-dots
        #it.page
      ]
    } else {
      it
    }
  }
}

#let make-toc() = {
  // 从右页（奇数页）起
  pagebreak(to: "odd")

  set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
    header: none,
    footer: context [#align(center)[#text(size: 9pt)[#counter(page).display("I")]]],
  )

  [
    #v(2em)

    // 目录标题（三号黑体，居中）
    #align(center)[
      #text(size: 16pt, weight: "bold", font: fonts.hei)[目录]
    ]

    #v(1.5em)

    // 目录内容行距18磅
    #set par(leading: 18pt)

    #toc-entry-style()
    #outline(
      title: none,
      indent: auto
    )

  ]
}

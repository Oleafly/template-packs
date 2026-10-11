#import table: cell, header

#let letter_font = ("New Computer Modern Math", "Noto Serif CJK JP")
#let heading_font = ("Noto Sans CJK JP", "Noto Sans CJK JP")
#let pagenum_font = "Noto Serif CJK JP"

#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let toc() = {
  set text(
    lang: "ja",
    font: heading_font,
  )

  align(center)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)
  context {
    let elements = query(selector(heading))
    for el in elements {
      let page_num = counter(page).at(el.location()).first()

      let chapt_num = if el.numbering != none {
        // numberingの第一引数はnumberingのフォーマット，第二引数に実際の数値が入る．
        numbering(
          el.numbering,
          ..counter(heading).at(el.location()),
        )
      } else { none }

      if el.level == 1 {
        set text(weight: "black")
        if chapt_num == none { } else {
          chapt_num
          "  "
        }
        let rebody = to-string(el.body)
        rebody
      } else if el.level == 2 {
        h(2em)
        chapt_num
        " "
        let rebody = to-string(el.body)
        rebody
      } else {
        h(5em)
        chapt_num
        " "
        let rebody = to-string(el.body)
        rebody
      }

      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      text(
        [#page_num],
        font: pagenum_font,
      )
      linebreak()
    }
  }
}


#let image_num(_) = {
  context {
    let chapt = counter(heading).at(here()).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(here()).at(0)
    str(chapt) + "." + str(n + 1)
  }
}

#let table_num(_) = {
  context {
    let chapt = counter(heading).at(here()).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(here()).at(0)
    str(chapt) + "." + str(n + 1)
  }
}

#let img(image, caption: "") = {
  figure(
    image,
    caption: caption,
    supplement: "図",
    numbering: image_num,
    kind: "image",
  )
}

#let tbl(table, caption: "") = {
  figure(
    table,
    caption: caption,
    supplement: "リスト",
    numbering: table_num,
    kind: "table",
  )
}

#let report(
  title: "タイトル",
  author: "著者",
  school: "学校",
  department: "科",
  id: "ID",
  date: (datetime.today().year(), datetime.today().month(), datetime.today().day()),
  paper-size: "a4",
  bibliography-file: none,
  body,
) = {
  // 各種スタイルの設定
  set text(
    lang: "ja",
    font: letter_font,
    size: 10.5pt,
  )
  let heading_text(body) = {
    set text(
      size: 12pt,
      weight: "semibold",
      font: heading_font,
    )
    body
  }
  show heading: it => {
    heading_text(it)
    par(text(size: 0.8em, ""))
  }
  set heading(numbering: "1.1. ")
  set par(first-line-indent: 1em, leading: 0.8em)
  set page(
    paper: paper-size,
    margin: (top: 25mm, left: 25mm, right: 20mm, bottom: 20mm),
  )

  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption.body
      context {
        let chapt = counter(heading).at(here()).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      }
    } else if it.kind == "table" {
      set text(size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption.body
      set text(size: 10.5pt)
      it.body
      context {
        let chapt = counter(heading).at(here()).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      }
    } else {
      it
    }
  }

  set document(title: title, author: author) // ドキュメントのメタデータ設定

  align(center)[
    #v(80pt)
    #text(size: 16pt)[
      #school#h(1em)#department
    ]

    #v(50pt)
    #text(size: 23pt)[
      #title
    ]
    #v(80pt)
    #text(size: 16pt)[
      #id #author
    ]

    #v(40pt)
    #text(size: 16pt)[
      #date.at(0) 年 #date.at(1) 月 #date.at(2) 日 提出
    ]
    #pagebreak()
  ]

  // 目次から1ページ目とする
  counter(page).update(1)
  set page(
    footer: [
      #align(
        center,
        text(
          context {
            counter(page).display("1")
          },
          font: pagenum_font,
        ),
      )
    ],
  )
  
  show raw: it => {
    h(0.5em)
    box(
    radius: 0.3em,
    outset: 3pt,
    fill: luma(230),
    it.text,
    )
    h(0.5em)
  }
  toc()
  pagebreak()
  body
}

#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let techbook(
  ebook: false,
  title: "Book Title",
  author: "Author",
  date: none,
  paper-size: "jis-b5",
  body,
) = {
  let sans = ("Source Han Sans", "Noto Sans CJK JP");
  let mono = ("Source Han Mono", "Noto Sans Mono CJK JP");

  set document(title: title, author: author, date: date)

  set text(
    lang: "ja",
    font: sans,
    size: 10pt,
  )
  //
  show raw: set text(
    font: mono,
    size: 10pt,
  )
  show raw.line: it => it.text // コードブロックの書式を無効に

  show raw.where(block: true): it => {
    v(1em)
    let lang = it.lang
    stack(
      spacing: none,
      if lang != none {
        block(
          width: 100%,
          fill: luma(224),
          inset: 5pt,
          text(weight: "bold", size: 0.8em, lang)
        )
      },
      block(
        width: 100%,
        fill: luma(240),
        inset: 12pt,
        it
      )
    )
    v(1em)
  }

  // インラインコードに背景色をつける
  show raw.where(block: false): it => {
    highlight(
      fill: luma(240),
      top-edge: 12pt,
      bottom-edge: -5pt,
      it
    )
  }

  show raw.where(block: true): par.with(
    leading: 0.8em
  )

  set table(
    inset: (y: 10pt, x: 1em)
  )

  set page(
    paper: paper-size,
    margin: (bottom: 1.5cm, top: 2cm),
  )

  page(align(center + horizon)[
    #text(2em)[*#title*]
    #v(2em, weak: true)
    #text(1.6em, author)
  ])

  pagebreak(to: "odd")

  // 目次
  show outline.entry.where(
    level: 1
  ): it => {
    v(2em, weak: true)
    strong(it)
  }
  outline(indent: auto, title: [目次 #v(2em)], depth: 2)

  // ページ指定
  set page(
    numbering: "1",

    header: context {
      let loc = here()
      let chapter = query(selector(heading.where(level: 1)).before(loc)).last()
      let i = counter(page).get().first()

      // 章開始ページかどうかを判定
      let chapters = query(selector(heading.where(level: 1)))
      let ch = chapters.find(it => it.location().page() == i)
      if ch != none {
        // 章開始ページは特別扱いしないと前記事のタイトルが出てしまう
        return
      }

      if calc.odd(i) {
        // 奇数ページには記事タイトルを表示（あれば）

        // 記事の開始ページかどうかを判定
        let sections = query(selector(heading.where(level: 2)))
        let section = sections.find(it => it.location().page() == i)
        if section != none {
          // 記事が始まるページは特別扱いしないと前記事のタイトルが出てしまう
          return align(right, section.body)
        }

        let sections = query(selector(heading.where(level: 2)).before(loc).after(chapter.location()))
        if sections != () {
          align(right, sections.last().body)
        }
      } else {
        // 偶数ページには章見出しを表示
        if chapter != none {
          chapter.body
        }
      }
    },

    // 偶数ページのページ番号は左に、奇数ページのページ番号は右に
    footer: context [
      #align(
        counter(page).display("1"),
        if calc.odd(counter(page).get().first()) { right } else { left }
      )
    ]
  )

  // 章見出し
  show heading.where(level: 1): it => {
    text(2em, weight: 700, it.body)
  }

  // 記事タイトル
  show heading.where(level: 2): it => {
    for fig-kind in (image, table, raw) {
      counter(figure.where(kind: fig-kind)).update(0)
    }
    counter(footnote).update(0)
    pagebreak()

    // 直前の <author> metadata から著者名を取得して埋め込む
    let before = query(selector(<author>).before(here()))
    let author = if before != none {
      before.last().value
    }

    block(
      fill: luma(224),
      inset: (x: 12pt, y: 6pt),
      pad(
        bottom: 6pt,
        top: 6pt,
        [
          #text(weight: 500, 1em, author)
          #v(-0.5em)
          #line(length: 100%, stroke: 0.05pt)
          #v(-0.5em)
          #block(text(weight: 900, 2em, it.body))
        ]
      )
    )
    v(1em)
  }

  // 記事内見出し1
  show heading.where(level: 3): it => {
    v(0.5em)
    text(1.5em, weight: 700, block(it.body))
    v(-1em)
    line(length: 100%, stroke: .5pt)
    v(1em)
  }

  // 記事内見出し2
  show heading.where(level: 4): it => {
    v(0.5em)
    block(
      fill: luma(224),
      inset: (x: 12pt, y: 6pt),
      radius: 10em,
      text(1.2em, weight: 500, block(it.body))
    )
  }

  // 記事内見出し3
  show heading.where(level: 5): it => {
    v(0.2em)
    text(1em, weight: 600, block(it.body))
  }

  show heading: set text(11pt, weight: 400)

  // 段落頭の字下げ
  set par(first-line-indent: 1em)
  show heading: it => {
      it
      par(text(size: 0pt, ""))
  }
  show list: it => {
      set text(1em, weight: 700)
      set list(marker: [•])
      pad(left: 1.2em, it)
      par(text(size: 0pt, ""))
  }
  show enum: it => {
      set text(1em, weight: 700)
      pad(left: 1.2em, it)
      par(text(size: 0pt, ""))
  }
  show raw.where(block: true): it => {
      it
      par(text(size: 0pt, ""))
  }
  show raw.where(text: true): it => {
      it
      v(100em)
  }
  show figure: it => {
    // captionが未指定(none)の場合は図表番号をインクリメントしない
    counter(figure.where(kind: it.kind)).update(n => if it.caption == none { n - 1 } else { n })

    it.body
    align(center)[
      #it.caption
    ]
    v(1.5em)
  }
  show figure.where(kind: raw): it => {
    box(
      align(left, it.body),
      inset: (bottom: -1.5em),
    )
    align(center)[
      #it.caption
    ]
    v(1.5em)
  }

  show figure.caption: set text(size: 0.9em)
  
  // 行間
  set par(leading: 1em)

  // リンクはfootnoteに置く、リンクテキストを下線付きにする
  show link: it => {
    underline(it)
    if type(it.dest) == "string" and it.dest != content-to-string(it.body) { // リンクテキストとリンク先が異なる場合のみfootnoteを追加する
      footnote(link(it.dest, underline(it.dest)))
    }
  }

  // 本文
  body

  // 奥付
  pagebreak(to: "even")
}

#let chapter-number-counter = counter("chapter")
#let chapter-title-page(title, image_path) = context {
  chapter-number-counter.step()
  let content = heading(title)
  pagebreak()
  block(
    height: 100%,
    width: 100%
  )[
    #h(-20cm)
    #content
    #v(0pt)
    #align(left)[
      #text(6.5em, weight: 200, "Chapter\n")
      #text(20em, weight: 900, chapter-number-counter.display("01"), fill: luma(192))
    ]
    #align(center + horizon)[
      #v(5em)
      #image(image_path, height: 60%)
    ]
    #align(right + bottom)[
      #set par(leading: 0.1em)
      #text(8.4em, weight: 700, content.body)
    ]
  ]
}

#let illust(image_path, author, alignment, img_size) = {
  align(alignment)[
    #box(
      align(center)[
        #image(image_path, height: img_size)
        #text(0.8em, weight: 200, [Illustration by *#author*])
      ]
    )
  ]
}

#let article(body) = {
  set heading(offset: 1) // 記事内の見出しは1段下げる
  body
  [#metadata(none)<author>]
}

#let horizontalrule = [
  #v(1.5em)
  #align(center, box(width: 15%, repeat[#text(size: 2em, "*") #h(1em)]))
]
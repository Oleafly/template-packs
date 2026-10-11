#let init(body) = {
  set page(paper: "a5", margin: (top: 20mm, bottom: 25mm, inside: 20mm, outside: 18mm))
  set text(lang: "ja", font: ("Noto Sans CJK JP", "IPAexGothic", "Yu Gothic", "Hiragino Sans"), size: 10pt)
  set par(leading: 0.8em, first-line-indent: 1em)

  body
}

#let contents-style(body) = {
  // init page number
  counter(page).update(1)
  set page(numbering: "1", number-align: center)
  
  // default heading...
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    text(size: 18pt, weight: "bold", it)
    v(1em)
  }
  
  show raw.where(block: true): it => {
    block(fill: luma(245), inset: 10pt, radius: 4pt, width: 100%, it)
  }

  body
}

#let chapter-style(body) = {
  // main chapter style

  // outline style
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      [第#n.first()章]
    } else {
      numbering("1.1", ..n)
    }
  })
  
  show outline.entry: it => {
    if it.level == 1 {
      // 章（レベル1）は太字
      v(0.8em, weak: true)
      strong(it)
    } else {
      it
    }
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    text(size: 18pt, weight: "bold", it)
    v(1em)
  }

  body
}

#let print-chap-header(body) = {
  set page(
    numbering: "1",
    number-align: center,
    header: context {
      let headings = query(selector(heading.where(level: 1)))
      let current = headings.filter(h => h.location().page() <= here().page()).last(default: none)
    
      if current != none {
        set text(size: 9pt)
        let nums = counter(heading).at(current.location())
        let num = nums.first()
        [第#{num}章 #current.body]
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt)
      }
    }
  )
  body
}

#let insert-cover(imgpath) = {
  page(margin: 0pt)[
    #image(imgpath, width: 100%, height: 100%)
  ]
}

#let insert-title-page(
  title: "苦行同人誌",
  author: "苦行同人誌倶楽部",
  date: none) = {
    
  let display-date = if date == none {
    datetime.today()
  } else {
    date
  }

  page[
    #set par(first-line-indent: 0em)
    #v(1fr)
    #align(center)[
      #text(size: 24pt, weight: "bold")[#title]
    ]
    #v(2fr)
    #align(center)[
      #text(size: 14pt)[#author　著]
    ]
    #v(1fr)
    #align(center)[
      #text(size: 12pt)[#display-date.display("[year]-[month]-[day]")　　発行]
    ]
    #v(1fr)
    ]
}

#let colophon(
  title: "苦行同人誌",
  edition: "初版",
  printing: "第一刷",
  author: "苦行同人誌倶楽部",
  date: none,
  contact: "author1: hoge@example.com, author2: piyo@example.com",
  publisher: "tom") = {
  
  let display-date = if date == none {
    datetime.today()
  } else {
    date
  }
  
  set par(first-line-indent: 0em)
  align(bottom)[
    #line(length: 100%, stroke: 0.5pt)
    #v(1em)

    #text(size: 14pt, weight: "bold")[#title]
    #v(1em)
    #box[#display-date.display("[year]年[month]月[day]日") #edition#printing　発行]
    #v(0.8em)

    #table(
        columns: (5em, 1fr),
        stroke: none,
        inset: (x: 0pt, y: 0.4em),
        align: (left + top, left + top),

        [著　者], [#author],
        [連絡先], [#contact],
        [印刷所], [#publisher],
    )

    #v(1em)
    #line(length: 100%, stroke: 0.5pt)
  ]
}
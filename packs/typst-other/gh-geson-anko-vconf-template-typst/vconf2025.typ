// vconf2025.typ

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

#let conf(
  title: "",
  authors: (),
  affiliations: none,
  abstract: [],
  bibliography-file: none,
  bibliography-margin: 40pt, // 本文と参考文献の行間調整
  body,
) = {
  // Document setup
  // set document(author: authors.map(a => to-string(a.name)), title: title) // 著者情報のメタデータを埋め込みたい場合はコメントアウト
  set page(
    paper: "a4",
    margin: (top: 12.7mm, bottom: 12.7mm, left: 12.7mm, right: 12.7mm),
    numbering: none,
  )
  // ドキュメント全体のデフォルトフォント
  set text(font: "Harano Aji Mincho", lang: "ja")

  set heading(numbering: "1.1.")

  // Title block
  align(center)[
    #text(weight: 700, size: 18pt, title)
    #v(12pt, weak: true)
    #text(size: 10pt)[
      #(
        authors
          .map(author => [
            #box(width: 30%, [
              #author.name\
              #text(size: 9pt, author.contact)
            ])
          ])
          .join([ ])
      )
    ]
    #v(10pt, weak: true)
    #if affiliations != none {
      text(size: 10pt)[
        #affiliations.join([,#h(1em)])
      ]
    }
    #v(6pt, weak: true)
  ]

  show par: set block(spacing: 0.65em) // 行間設定
  set par(justify: true, first-line-indent: 1em) // 字下げ
  // ヘッダー設定
  show heading: it => {
    set text(weight: "bold", size: 10pt) // 見出しサイズを変更
    it
    v(0em, weak: true) // 見出し下のスペース調整
    par(text(size: 0pt, "")) // typstのバグで2段落目移行しか字下げされないので強制的に1段落目を追加
  }

  // 図表設定
  show figure: it => {
    set align(center)
    set par(justify: true)
    set text(size: 8pt)
    it
  }
  show figure.caption: set align(left) // キャプションを左寄せ
  show figure.where(
    // 表のキャプションは上に表示
    kind: table,
  ): set figure.caption(position: top)

  // Abstract
  block(width: 100%, inset: 10pt, breakable: false, [
    *概要：* #abstract
  ])
  v(12pt, weak: true)

  // Main body
  show: rest => columns(2, rest) // ダブルカラム

  body

  if bibliography-file != none {
    set text(lang: "en")
    v(bibliography-margin, weak: true) // 参考文献とメイン文書の間調整
    bibliography(bibliography-file, title: "参考文献", style: "ieee")
  }
}

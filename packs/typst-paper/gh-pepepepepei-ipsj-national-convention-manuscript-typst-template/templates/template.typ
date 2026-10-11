#let init(
  title: (),
  authors: (),
  affiliations: (),
  body,
) = {
  // メタデータの設定
  set document(
    title: title.ja,
    author: authors.map(name => name.ja),
  )

  // ページ全体に関わる設定
  let mincho = ("Times New Roman", "Yu Mincho")
  set text(
    font: mincho,
    size: 10.5pt,
    lang: "ja",
  )
  set page(
    paper: "a4",
    margin: (
      bottom: 25mm,
      top: 30mm,
      left: 20mm,
      right: 20mm,
    ),
  )
  set par(
    leading: 0.73em,
    first-line-indent: (amount: 1em, all: true),
    justify: true,
    spacing: 0.73em,
  )
  show "。": "．"
  show "、": "，"

  // 見出しについて
  set heading(numbering: "1.1.1")
  show heading: it => {
    set text(
      weight: "bold",
      size: 10.5pt,
    )
    block(
      below: 0.73em,
    )[
      #if it.numbering != none {
        counter(heading).display(it.numbering)
        h(1em)
      }#it.body
    ]
  }

  // 図表について
  show figure: it => {
    block(
      above: 2.73em,
      below: 2.73em,
    )[#it]
  }
  set figure.caption(
    separator: [　],
  )

  // 表について
  set table(
    inset: 7pt,
    align: horizon,
  )
  show figure.where(kind: table): set figure.caption(position: top)

  // 参考文献について
  set bibliography(style: "ipsj.csl")

  // 以下出力内容
  // タイトル
  align(center)[
    #text(
      size: 16pt,
      weight: "bold",
    )[#title.ja]
    // 著者名
    #grid(
      align: center,
      gutter: 2em,
      columns: calc.min(authors.len(), 5),
      ..authors.map(author => {
        [#author.ja#super(numbering("*", author.affiliation + 1))]
      }),
    )
    // 所属機関名
    #grid(
      align: center,
      gutter: 2em,
      columns: calc.min(affiliations.len(), 5),
      ..affiliations
        .enumerate(start: 1)
        .map(affiliation => {
          [#affiliation.at(1).ja#super(numbering("*", affiliation.at(0) + 1))]
        }),
    )
  ]
  v(2em)

  // 本文
  columns(2, gutter: 7mm)[
    // 1ページ目左下のやつ
    #place(
      bottom + left,
      float: true,
    )[
      #block(
        stroke: (top: 0.5pt),
        inset: (top: 6pt),
        width: 100%,
      )[
        #set text(size: 9pt)
        // 英語タイトル
        #title.en\
        // 講演者・所属
        #for affiliation in affiliations.enumerate(start: 1) {
          // 講演者
          numbering("*", affiliation.at(0) + 1)
          authors.filter(author => author.affiliation == affiliation.at(0)).map(author => author.en).join(", ")
          linebreak()
          // 所属
          h(0.5em)
          affiliation.at(1).en
          linebreak()
        }
      ]
    ]
    #body
  ]
}

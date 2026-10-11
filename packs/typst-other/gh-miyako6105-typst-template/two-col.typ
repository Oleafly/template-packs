// ===== two-col.typ =====
// 学会予稿用テンプレート(Typst 0.11+ 想定)

#let two_col(
  title: "Title",
  // 各著者は (name, affiliation) の辞書。affiliation は所属番号(1始まり)
  authors: (),
  // 所属機関名を番号順に並べた配列
  affiliations: (),
  bibliography-file: none,
  body,
) = {
  // --- ページ・フォント ---
  set page(paper: "a4", margin: (x: 20mm, y: 20mm))
  set text(
    font: "Noto Sans JP", // 環境に合わせて変更すること
    size: 10.5pt,
    lang: "ja",
  )
  set par(
    justify: true,
    first-line-indent: 1em,
    leading: 0.65em
  )

  // --- 見出しのナンバリング ---
  set heading(numbering: "1.1.")

  // 見出しの見た目:レベルごとに分岐
  show heading: it => {
    // it.level == 1 が章(1. はじめに)、== 2 が節(1.1 ...)
    let s = if it.level == 1 { 14pt } else { 11pt }
    set text(weight: "bold", size: s)
    block(above: 1.2em, below: 0em, it
    )
    par(text(size: 0pt, ""))
  }

  // --- タイトルブロック(1段組・中央揃え) ---
  place(
    top + center,
    scope: "parent",
    float: true,
    {
      text(size: 18pt, weight: "bold")[#title]
      v(1.2em)

      // 著者名 + 所属マーク(上付き)
      set text(size: 11pt)
      let marks = ("†", "‡", "§", "¶", "‖")
      authors.map(a => {
        [#a.name#super(marks.at(a.affiliation - 1))]
      }).join(h(1.5em))
      v(0.8em)

      // 所属機関(マーク付き・中央)
      set text(size: 9pt)
      affiliations.enumerate().map(((i, aff)) => {
        [#super(marks.at(i))#aff]
      }).join(h(1em))
      v(1.5em)
    },
  )

  // --- 本文を2段組にする ---
  columns(2, gutter: 6mm, {
    // 本文
    body

    // 参考文献(bib ファイル指定時のみ)
    if bibliography-file != none {
      bibliography(
        bibliography-file,
        title: "参考文献",
        style: "ieee", // 分野に合わせて変更すること
      )
    }
  })
}
// setting.typ
// --------------------
// ドキュメント全体の設定ファイル(ページ、フォント、数式、表、図の設定)
// --------------------

// プロジェクト全体の設定
#let project(
  title: "",
  theme-number: "",
  ja-project-theme: "",
  en-project-theme: "",
  supervisor: (),
  abstract: [],
  authors: (),
  keywords: (),
  body,
) = {
  // ドキュメントの設定
  set page(paper: "a4", margin: 2cm, numbering: "1", number-align: center, header: context {
    // 1ページ目以降ヘッダを表示する
    if here().page() > 1 {
      // 右寄せ
      set align(right)
      table(
        columns: 2,
        stroke: none,
        align: (center + horizon, center + horizon),
        table.hline(start: 0, end: 2, stroke: (thickness: 0.5pt)),
        table.vline(start: 0, stroke: (thickness: 0.5pt)),
        table.cell(inset: (x: 6pt, y: 5pt), [テーマ番号]),
        table.hline(start: 0, end: 5, stroke: (thickness: 0.5pt)),
        table.vline(start: 0, end: 1, stroke: (thickness: 0.5pt, dash: "dotted")),
        table.cell(inset: (x: 6pt, y: 5pt), [#theme-number], colspan: 1),
        table.vline(start: 0, end: 1, stroke: (thickness: 0.5pt)),
      )
    } else {
      none
    }
  })
  set heading(numbering: "1.")
  set document(author: authors.map(a => a.name), title: title)

  // 数式周りの処理
  set math.equation(numbering: "(1)")
  show math.equation: set text(font: ("New Computer Modern Math"))

  // 表の設定
  set table(inset: 8pt, align: horizon)
  set figure.caption(position: top)

  // タイトル・著者情報の設定
  set text(font: "Libertinus Serif", lang: "ja", size: 8pt)
  table(
    columns: 5,
    stroke: none,
    align: (center + horizon, center + horizon, left + horizon, center + horizon, center + horizon),
    // 内部要素
    table.hline(start: 0, end: 2, stroke: (thickness: 0.5pt)),
    table.vline(start: 0, stroke: (thickness: 0.5pt)),
    table.cell(inset: (x: 2pt, y: 1pt), [テーマ番号]),
    table.hline(start: 0, end: 5, stroke: (thickness: 0.5pt)),
    table.vline(start: 0, end: 1, stroke: (thickness: 0.5pt, dash: "dotted")),
    table.cell(inset: (x: 6pt, y: 3pt), [#theme-number], colspan: 1),
    table.vline(start: 0, end: 1, stroke: (thickness: 0.5pt)),
    table.cell([], colspan: 3),
    table.cell([プロジェクト\ テーマ], rowspan: 2),
    table.vline(end: 3, stroke: (thickness: 0.5pt, dash: "dotted")),
    table.cell(inset: (x: 2pt, y: 1pt), [和文]),
    table.vline(start: 1, end: 4, stroke: (thickness: 0.5pt, dash: "dotted")),
    table.cell(text(size: 8.5pt)[#ja-project-theme]),
    table.vline(start: 1, end: 3, stroke: (thickness: 0.5pt)),
    table.cell([指導教員], rowspan: 2),
    table.vline(start: 1, end: 3, stroke: (thickness: 0.5pt, dash: "dotted")),
    table.cell(
      align: center + horizon,
      grid(rows: (1 * calc.min(1, supervisor.len() / 2)), gutter: 1em, ..supervisor.map(sup => align(center)[
        #sup
      ])),
      rowspan: 2,
    ),
    table.vline(start: 1, end: 5, stroke: (thickness: 0.5pt)),
    table.hline(start: 1, end: 4, stroke: (thickness: 0.5pt, dash: "dotted")),
    table.cell(inset: (x: 2pt, y: 1pt), [英文]),
    table.cell(text(size: 8.5pt)[#en-project-theme]),
    table.hline(start: 0, end: 5, stroke: (thickness: 0.5pt)),
    table.cell(inset: 5pt, [プロジェクト\ メンバー], colspan: 2),
    table.cell(
      inset: 5pt,
      align: center + horizon,
      grid(rows: (1 * calc.min(1, authors.len() / 2)), columns: 2, gutter: 0.8em, ..authors.map(author => align(left)[
        #str("\t")
        #author.class
        #str("\t")
        #author.name
        (#author.ruby)
      ])),
      colspan: 3,
    ),
    table.hline(start: 0, end: 5, stroke: (thickness: 0.5pt)),
  )

  // Abstract, Keywords, MainBodyのフォントサイズは10pt
  set text(font: "Libertinus Serif", lang: "ja", size: 10pt)
  // 段落の設定
  set par(justify: true, first-line-indent: 1em, leading: 0.5em, spacing: 1em)

  // Abstract.
  pad(top: 0.5em, [
    #strong([Abstract])
    #text("    ")
    #abstract
  ])

  // Keywords
  pad(bottom: 1.1em, [
    #strong([Keywords])
    #text("    ")
    #keywords.map(k => text([#k])).join(", ")
  ])

  // Main body.
  show: columns.with(2, gutter: 1.6em)

  body
}

#show figure.caption: it => [
  #let cap-font = "Noto Serif CJK JP"
  #set text(font: cap-font, size: 10pt)
  #grid(
    rows: 2,
    columns: 2,
    gutter: 0.5em,
    align: (left, right),
    [#text(font: cap-font, size: 10pt)[#it.supplement #context it.counter.display(it.numbering)]],
    [#text(font: cap-font, size: 10pt)[#ja-caption]],
    [#text(font: cap-font, size: 10pt)[#it.supplement #context it.counter.display(it.numbering)]],
    [#text(font: cap-font, size: 10pt)[#en-caption]],
  ),
]

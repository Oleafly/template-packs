#let setting(doc) = {
  // カラムの設定
  set columns(2, gutter: 7mm)
  set page(columns: 2, paper: "a4", margin: (top: 30mm, bottom: 25mm, left: 20mm, right: 20mm))

  // 文字の設定
  set text(lang: "ja", font: ("Times New Roman", "YuMincho"), size: 10.5pt, spacing: 0.5em)
  // 段落の設定
  set par(first-line-indent: (all: true, amount: 1em), justify: true, leading: 1em)
  // 脚注の設定
  set footnote(numbering: "*")

  // 見出しの表記設定
  set heading(
    numbering: "1 ",
    supplement: none,
  )
  // 最上階層の設定
  show heading.where(level: 1): it => {
    let cvs = 5.25mm
    block(
      height: 1.3 * cvs,
      fill: none,
      align(horizon, text(size: 13pt, font: "Hiragino Kaku Gothic ProN", it)),
    )
  }

  // 表のcaptionは上に
  show figure.where(kind: table): set figure.caption(position: top)

  set table(
    stroke: (x, y) => if y == 0 {
      (top: 1.0pt + black, bottom: 1.0pt + black)
    } else if y == (table.columns) {
      (bottom: 1.0pt + black)
    },
    align: (x, y) => (
      if x > 0 { center } else { left }
    ),
  )

  // 式の設定
  set math.equation(
    numbering: (..args) => {
      return [(#{ counter(heading).get().at(0) }.#args.at(0)) ]
    },
    supplement: [式#h(-0.1em)],
  )

  // 句読点の置き換え
  show "。": ". "
  show "、": ", "

  doc
}

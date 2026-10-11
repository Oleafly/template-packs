// ===========================
//  Global Style Settings
// ===========================

#let conf(doc) = {

  // ページ番号のスタイル
  set page(numbering: "1")

  // デフォルトのフォント設定
  set text(
    font: "Hiragino Kaku Gothic ProN",
    lang: "ja",
    weight: "bold"
  )
  set par(leading: 0.9em)

  // 図のキャプション位置
  set figure.caption(position: top)

  // キャプションの文字色
  show figure.caption: set text(fill: rgb("#d9796a"), weight: "bold")

  // 1. 自動番号付けを有効化
  set heading(numbering: "1.1")

  // 2. 各レベルのフォントサイズを設定
  show heading.where(level: 1): set text(size: 20pt, weight: "bold")
  
  show heading.where(level: 2): set text(size: 16pt, weight: "bold")
  
  show heading.where(level: 3): set text(size: 14pt, weight: "bold")

  // 見出しの上下に少し余白を入れる設定（お好みで）
  show heading: it => {
    v(0.5em)
    it
    v(0.3em)
  }

  // 数式の設定
  show math.equation: set text(weight: "bold")
  set math.equation(numbering: "(1)")

  // 最後にドキュメントの中身を出力
  doc
}
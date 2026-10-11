// --- template.typ ---

// 1. インポートは一番上に書きます
#import "@preview/theorion:0.4.1": *
#import cosmos.fancy: *

// 2. ドキュメント全体の設定を行う関数を定義します
//    引数に title, author, そしてドキュメント本体(doc)を取ります
#let project(title: "", author: "", doc) = {
  // 3. show-theorion をここで適用します
  show: show-theorion

  // 4. 各種設定を関数内で行います
  set heading(numbering: "1.")
  set-theorion-numbering("1.") // 関数呼び出しもここで行います

  set text(
    lang: "en",
    size: 10.5pt,
  )

  set math.equation(numbering: "(1)")

  // 引用のカスタマイズ
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el == none or el.func() != eq { return it }
    link(el.location(), numbering(
      el.numbering,
      ..counter(eq).at(el.location()),
    ))
  }

  set page(
    header: [
      #datetime.today().display("[year]/[month]/[day]")
    ],
    numbering: "1",
    margin: (
      top: 2cm,
      bottom: 2cm,
      x: 2cm,
    ),
  )

  set cite(style: "alphanumeric")

  // 5. タイトルの描画 (maketitleの中身をここに移動)
  //    もしタイトルが空でない場合のみ表示する制御などを入れても良いです
  if title != "" {
    align(center)[
      #text(weight: "black", size: 1.8em, title)
      #v(0.5em)
      #text(size: 1.2em, author)
    ]
  }

  // 6. 最後にドキュメントの中身を出力します
  doc
}

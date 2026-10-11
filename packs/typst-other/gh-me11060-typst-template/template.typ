#import "@preview/zebraw:0.6.3": zebraw            // コードブロック
#import "@preview/physica:0.9.8": *                // 微分などの記号
#import "@preview/cetz:0.5.0" as cetz: canvas      // 図
#import "@preview/algo:0.3.6": algo, comment, d, i // 疑似コード
#import "@preview/curryst:0.6.0": prooftree, rule  // 証明木
#import "@preview/pinit:0.2.2" as pt: pin          // 矢印・マーカー
#import "@preview/unify:0.8.0": *                  // 単位系
#import "@preview/fletcher:0.5.8" as fl            // 図式
#import "@preview/equate:0.3.2": equate            // 数式のサブ番号
#import "@preview/lilaq:0.6.0" as lq               // グラフ

#let main(
  main-font: ("New Computer Modern", "Harano Aji Mincho"),
  heading-font: "Harano Aji Gothic",
  math-font: ("New Computer Modern Math", "Harano Aji Mincho"),
  code-font: "Google Sans Code",
  cjk-indent: false,
  heading-numbering: true,
  equation-numbering: false,
  biblio: none,
  body,
) = {
  set page(numbering: "1")
  set par(first-line-indent: (amount: 1em, all: true)) if cjk-indent
  set text(lang: "ja", font: main-font, size: 10pt)

  set heading(numbering: "1.") if heading-numbering
  show heading: set text(font: heading-font, weight: "regular", size: 10pt)
  show heading.where(level: 1): set text(weight: "medium")
  show heading: it => {
    if (it.level == 1) { v(2em) } else { v(1em) }
    it
    v(1em)
  }

  set math.equation(block: true, supplement: "式")
  set math.equation(numbering: numbering.with("(1.1)")) if equation-numbering
  show math.equation: set text(font: math-font)
  show math.equation: set block(breakable: true)
  show math.equation.where(block: false): it => {
    h(0.25em)
    it
    h(0.25em)
  }
  set math.mat(delim: "[", column-gap: 1em)
  show: equate.with(sub-numbering: equation-numbering)

  show figure.where(kind: image): set figure(supplement: "図")
  show figure.where(kind: table): set figure(supplement: "表")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: "コード")

  set table(stroke: none, align: center)

  show raw: set text(font: code-font, size: 8pt, weight: "regular")

  show: lq.set-grid(stroke: none)

  body

  if biblio != none { bibliography(title: "参考文献", biblio) }
}

#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "付録A.1.", supplement: "付録")

  body
}

#let title(
  title,
  authors: none,
  date: none,
  title-font: "Harano Aji Gothic",
) = {
  set text(font: title-font, weight: "medium")

  align(center, {
    block(text(size: 14.4pt, title))
    block(authors)
    block(date)
  })
}

#let s = h(1em)

// 使い方

#show: main.with()

#title([テンプレートの使い方])

#let excode(body) = {
  zebraw(
    numbering: false,
    lang: false,
    body,
  )
}

#let exdisp(code, view) = {
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    code, view,
  )
}

= 準備

#s ファイルの先頭に次を追加する。

#excode(
  ```typ
  #import "template.typ": *
  #show: main.with()
  ```,
)

#s `main`は次のように定義されている。

#excode(
  ```typ
  #let main(
    main-font,
    heading-font,
    math-font,
    code-font,
    cjk-indent,
    heading-numbering,
    equation-numbering,
    biblio,
    body
  )
  ```,
)

#table(
  columns: 2,
  align: left,
  [- `main-font`], [本文に使用されるフォント],
  [- `heading-font`], [見出しに使用されるフォント],
  [- `math-font`], [数式に使用されるフォント],
  [- `code-font`], [コードに使用されるフォント],
  [- `cjk-indent`], [段落の最初を1文字字下げするか],
  [- `heading-numbering`], [見出しを番号付けするか],
  [- `equation-numbering`], [数式を番号付けするか],
  [- `biblio`], [参考文献ファイル],
)

= タイトル

#s `title`は次のように定義されている。

#excode(
  ```typ
  #let title(title, authors, date, title-font)
  ```,
)

#table(
  columns: 2,
  align: left,
  [- `title`], [タイトル名(必須)],
  [- `authors`], [著者名],
  [- `date`], [作成日時など],
  [- `title-font`], [タイトルに使用されるフォント],
)

#s 以下は`title`の使用例とその表示結果。

#exdisp(
  excode(
    ```typ
    #title(
      [タイトル],
      authors: [著者名],
      date: [2020年4月1日],
    )
    ```,
  ),
  title(
    [タイトル],
    authors: [著者名],
    date: [2020年4月1日],
  ),
)

= 付録

#s `appendix`は次のように定義されている。

#excode(
  ```typ
  #let appendix(body)
  ```,
)

#s 以下のようにして使用する。以降の見出しの番号付けがアルファベットになる。

#exdisp(
  excode(
    ```typ
    #show: appendix
    = 見出し
    ```,
  ),
  [
    #show: appendix
    = 見出し
  ],
)

= コードブロック

#s コードブロックを使いたい場合は`zebraw`を使う。

#table(
  columns: 2,
  align: left,
  [- `numbering`], [行数を非表示にしたいときは`false`にする。],
  [- `numbering-offset`], [表示する行数がどこから始まるかを指定する。],
  [- `lang`], [言語を表すラベルを変えられる。非表示にしたいときは`false`にする。],
)

#s 以下は使用例とその表示結果。

#exdisp(
  ````typ
  #zebraw(
    numbering-offset: 5,
    ```rs
    fn main() {
      println!("Hello World");
    }
    ```
  )
  ````,
  zebraw(
    numbering-offset: 5,
    ```rs
    fn main() {
      println!("Hello World");
    }
    ```,
  ),
)

= 手動字下げ

#s 手動で字下げするときは`s`を使う。

#exdisp(
  ````typ
  #s 一文字分の空白が挿入される。
  ````,
  [
    □一文字分の空白が挿入される。
  ],
)

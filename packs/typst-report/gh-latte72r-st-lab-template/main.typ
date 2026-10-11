
// --------------------
// 文書全体の見た目
// --------------------
#let body = "Noto Serif CJK JP"
#let head = "Noto Sans CJK JP"

#set text(lang: "ja", font: body, size: 11pt)
#show strong: it => {
  set text(font: head, weight: "bold")
  it
}
#show heading: it => {
  set text(font: head)
  block(below: 1.1em, it)
}
#show heading.where(level: 1): it => {
  set text(size: 16pt, weight: "bold")
  it
}
#show heading.where(level: 2): it => {
  set text(size: 13pt, weight: "bold")
  it
}
#show heading.where(level: 3): it => {
  set text(size: 11pt, weight: "semibold")
  it
}

// コード表示（raw）のフォントは等幅寄りを指定
#show raw: set text(font: "Bizin Gothic Discord", size: 10.5pt)

// 数式番号（例：式 (1.1)）
#set math.equation(
  numbering: numbering.with("(1.1)"),
  supplement: "式",
)

// 表の罫線と余白（説明文書側でのデフォルト）
#set table(inset: (x: 0.8em, y: 0.6em), stroke: none)
#set table.hline(stroke: 0.6pt)
#set table.vline(stroke: 0.6pt)

// --------------------
// 説明用の小物
// --------------------
#let demo(title, code, body) = {
  title

  grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,

    // 左セル
    [
      *Typstコード*
      #code
    ],

    // 右セル
    [
      *出力*
      #body
    ],
  )
}

// --------------------
// 本文
// --------------------
#outline(
  depth: 1,
)

= Typst レポートテンプレートの使い方

== 何ができるか

このテンプレートは，表紙つきのレポート本文をTypstで組むためのものです．説明文書では，表紙の指定方法と，図・表・数式・参照の書き方を最小例で示します．

== 最小構成

`report` 関数を呼び出し，`report.with(..)` に表紙情報をまとめて渡します．
未使用項目は `[]` で空欄にできます．

```typst
#import "../template.typ": report, pill, slash_cell

#show: doc => report.with(
  exp_y: 1859,
  exp_m: 12,
  exp_d: 14,
  subject: [アナログ演算回路],
  submit: (1880, 12, 27, 14, 30),
  temp: [24.484 °C],
  humid: [28 %],
  pressure: [908 hPa],
  coexp: ([フロップ・オコーネル],),
)(doc)

= 実験目的
本文をここに記入します．
```

== 共同実験者

共同実験者は配列で渡し，いない場合は `()` にします．

#demo(
  [共同実験者の指定],
  [
    ```typst
    #show: doc => report.with(
      coexp: ([共同実験者A], [共同実験者B]),
    )(doc)

    #show: doc => report.with(
      coexp: (),
    )(doc)
    ```
  ],
)[
  ここでは出力省略．
]

= 図・表・数式の入れ方

== 図

`#figure(..)` で画像にキャプションを付け，ラベルを付けて参照します．

#demo(
  [図の挿入と参照],
  [
    ```typst
    #figure(
      image("../assets/sample.png", width: 80%),
      caption: [実験1で用いた回路図],
    ) <fig:kairo1>

    本文中では @fig:kairo1 を参照できます．
    ```
  ],
)[
  #figure(
    image("./assets/sample.png", width: 80%),
    caption: [実験1で用いた回路図],
  ) <fig:kairo1>
  本文中では @fig:kairo1 を参照できます．
]

== 表

表は `#table(..)` を `#figure(..)` に入れると，表番号とキャプションが付き，参照もしやすくなります．

#demo(
  [表の挿入と参照],
  [
    ```typst
    #figure(
      table(
        columns: 2,
        table.hline(),
        table.header([傾き (実験値) \[V/s\]], [傾き (理論値) \[V/s\]]),
        table.hline(),
        [$-9.6 times 10^3$], [$-1/(R C) times E_0$],
        table.hline(),
      ),
      caption: [傾きの実験値と理論値],
    ) <tbl:slope>

    本文中では @tbl:slope を参照できます．
    ```
  ],
)[
  #figure(
    table(
      columns: 2,
      table.hline(),
      table.header([傾き (実験値) \[V/s\]], [傾き (理論値) \[V/s\]]),
      table.hline(),
      [$-9.6 times 10^3$], [$-1/(R C) times E_0$],
      table.hline(),
    ),
    caption: [傾きの実験値と理論値],
  ) <tbl:slope>
  本文中では @tbl:slope を参照できます．
]

== 数式

文中はインライン数式，独立行はブロック数式になります．ラベルを付けると参照できます．式の体裁は，分数を `1/(R C)` のままにするより，`(1)/(R C)` などにして見た目を安定させるのがおすすめです（必要なら `frac` で明示します）．

#demo(
  [数式と式番号・参照],
  [
    ```typst
    文中は $E = m c^2$ のように書きます．

    $ (dif y(t)) / (dif t) = - (1)/(R C) times u(t) $ <eq:diff>

    式 @eq:diff より，入力が定数 $u(t)=E_0$ のとき，
    $ (dif y(t)) / (dif t) = - (1)/(R C) times E_0 $
    ```
  ],
)[
  文中は $E = m c^2$ のように書きます．

  $ (dif y(t)) / (dif t) = - (1)/(R C) times u(t) $ <eq:diff>

  式 @eq:diff より，入力が定数 $u(t)=E_0$ のとき，
  $ (dif y(t)) / (dif t) = - (1)/(R C) times E_0 $
]

= サンプル構成例

説明ファイルには，レポート本文の長いサンプルを丸ごと入れず，短い断片を置くのが読みやすいです．本文サンプルは `sample_report.typ` に分け，説明ファイルからは該当箇所だけ引用する形にすると管理しやすくなります．

= コンパイル

VS Codeの Tinymist Typst 拡張機能を使うと自動でコンパイルされてプレビューできるので便利です．

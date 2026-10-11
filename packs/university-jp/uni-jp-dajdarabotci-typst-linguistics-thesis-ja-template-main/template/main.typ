#import "../lib.typ": *

#show: ling-thesis.with(
  lang: "ja",
  title: "学位論文用Typstテンプレート（言語学）",
  subtitle: [日本におけるTypstのさらなる普及を期待して],
  author: "八軒花子",
  id: "123456789",
  class: "平成X年度修士論文",
  school: "文学研究科",
  lab: "言語文学専攻　言語情報学研究室",
  mentor: "琴似太郎",
  description: "テンプレートの使用方法についての説明", // pdf description
  keywords: ("Typst", "学位論文"),
  date: datetime(year: 2001, month: 1, day: 8),
  seriffont: "Times New Roman",
  seriffont-cjk: "Yu Mincho",
  sansfont: "Arial",
  sansfont-cjk: "Yu Gothic",
  paper: "a4", // "a*", "b*", or (paperwidth, paperheight) e.g. (210mm, 297mm)
  baselineskip: auto,
  textwidth: auto,
  lines-per-page: auto,
  cover: true, // or true
  cols: 1, // 1, 2, 3, ...
  non-cjk: regex("[\u0000-\u2023]"), // or "latin-in-cjk" or any regex
  cjkheight: 0.88, // height of CJK in em
)

#abstract(
  (
    "要旨",
    [
      吾輩は猫である。名前はまだ無い。// 下に1行開けると改段落

      #ruby[珍野][ちんの]#ruby[苦沙弥][くしゃみ]の家で飼われていたが、なんだかんだあってビールを飲んだら酔っ払って水甕のなかに落ちてしまい溺れ死んだ。南無阿弥陀仏南無阿弥陀仏。ありがたいありがたい。
    ],
  ),
  ("Abstract", lorem(8)),
  ("Аннотация", "Далеко-далеко за словесными горами в стране гласных и согласных живут рыбные тексты."),
)

#set page(numbering: "i") // 前付は i, ii, iii, ... で番号付け
#counter(page).update(1)

#toc()
#toc-fig() // 図目次. 不要なら削除してください
#list-abbr()

#set page(numbering: "1")
#counter(page).update(1)

= はじめに

言語学徒のためのTypst学位論文用テンプレートです。#TeX 界の第一人者、奥村晴彦さんが作成した日本語用テンプレートjs
#footnote[
  (u)p#LaTeX のjsarticle/jsbook相当のテンプレート。GitHubリポジトリ: https://github.com/okumuralab/typst-js
]
を基に、言語学の学位論文に適した形に改変しました。表紙レイアウトは北海道大学文学部および文学院が例年例示しているもの（厳密に指定されている訳ではない）を参考にしました。

このテンプレートは以下のTypstパッケージを使用しています。

- *`leipzig-glossing`* Copyright © 2023 Gregory Shuflin（MITライセンス）\ グロスを生成するパッケージ。\ リポジトリ：https://code.everydayimshuflin.com/greg/typst-lepizig-glossing
- *`cjk-unbreak`*\ `.typ` ファイルの和文中で改行をおこなった際に生成される半角スペースを削除する。

= グロスの生成

詳細は上記 `leipzig-glossing` リポジトリの README ファイルをご確認ください。本テンプレートは `example.with(numbering: true, label-supplement: none)` をラップした関数 `ex()` を含んでいます。この関数が不要な場合は、`lib.typ` の `let ex = ...` の行を削除してください。

```typc
#ex(
  header: "ブルガリア語",
  label: "bg",
  (
    source: ([Az], [sǎm], [ot], [Universitet-a], [Hokajdo.]),
    morphemes: ([#p1#sg.#nom], [be.#prs.#p1#sg], [from], [University-#def.#M.#sg.#obl], [Hokkaido]),
    translation: [「わたしは北海道大学から来た。」],
    label: "bg-pos",
  ),
  (
    source: ([Ne], [sǎm], [ot], [Universitet-a], [Hokajdo.]),
    /* header, source, transliteration, morphemes, translation に -style をつけた
    パラメータを使うと文字の書式を変えられる*/
    source-style: text.with(style: "italic", weight: "bold"),
    morphemes: ([#neg], [be.#prs.#p1#sg], [from], [University-#def.#M.#sg.#obl], [Hokkaido]),
    translation: [「わたしは北海道大学の者ではない。」],
    label: "bg-neg",
  ),
)

@bg は例全体への参照。
@bg-pos は一つ目の例文への参照。
@bg-neg は二つ目の例文への参照。
```

#ex(
  header: "ブルガリア語",
  label: "bg",
  (
    source: ([Az], [sǎm], [ot], [Universitet-a], [Hokajdo.]),
    morphemes: ([#p1#sg.#nom], [be.#prs.#p1#sg], [from], [University-#def.#M.#sg.#obl], [Hokkaido]),
    translation: [「わたしは北海道大学から来た。」],
    label: "bg-pos",
  ),
  (
    source: ([Ne], [sǎm], [ot], [Universitet-a], [Hokajdo.]),
    source-style: text.with(style: "italic", weight: "bold"),
    morphemes: ([#neg], [be.#prs.#p1#sg], [from], [University-#def.#M.#sg.#obl], [Hokkaido]),
    translation: [「わたしは北海道大学の者ではない。」],
    label: "bg-neg",
  ),
)

@bg は例全体への参照。
@bg-pos は一つ目の例文への参照。
@bg-neg は二つ目の例文への参照。

= 目次や略語一覧の生成

```typc
#toc() // 目次
#toc-fig() // 図目次と表目次
#list-abbr() // 略語一覧
```

このファイルの冒頭で、上記の関数が使用されています。略語一覧は、グロスで使用した略号をアルファベット順に並び替えたものになっています。

= 図表

== 表の挿入

```typc
#figure(
  table(
    columns: 3,
    rows: 2,
    table.header(
      [], [*A*], [*B*]
    ),
    [1], [あ], [い],
  ),
  caption: "簡単な表"
)
```

#figure(
  table(
    columns: 3,
    rows: 2,
    table.header([], [*A*], [*B*]),
    [1], [あ], [い],
  ),
  caption: "簡単な表",
)

```typc
#let wareki = csv("table/wareki.tsv", delimiter: "\t")
#figure(
  table(
    columns: 2,
    align: left,
    ..wareki.flatten()
  ),
  caption: "TSVファイルから読み込んだ表"
)
```

#let wareki = csv("table/wareki.tsv", delimiter: "\t")
#figure(
  table(
    columns: 2,
    align: left,
    ..wareki.flatten()
  ),
  caption: "TSVファイルから読み込んだ表",
)

= 数式

言語学の論文でどれだけ使うかはわかりませんが、こんな風に数式を美しく描画することができます。

```typc
$ (integral_0^oo (sin x) / sqrt(x) d x)^2
  &= sum_(k = 0)^oo ((2 k)!) / (2^(2 k) (k!)^2) 1 / (2 k + 1) \
  &= product_(k = 1)^oo (4 k^2) / (4 k^2 - 1) = pi / 2 $
```

$
  (integral_0^oo (sin x) / sqrt(x) d x)^2 & = sum_(k = 0)^oo ((2 k)!) / (2^(2 k) (k!)^2) 1 / (2 k + 1) \
                                          & = product_(k = 1)^oo (4 k^2) / (4 k^2 - 1) = pi / 2
$

= おまけ

奥村晴彦さんが作成したマクロです。このテンプレートにもそのまま含めています。

```typc
#kintou(8em)[北光一閃]
```

#quote[
  #kintou(8em)[北光一閃]
]

```typc
/ #ruby[恵迪][けいてき]の森: 札幌キャンパスの中にある原生林
```

/ #ruby[恵迪][けいてき]の森: 札幌キャンパスの中にある原生林

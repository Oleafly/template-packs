#import "../theme/template.typ": *

== dictionary
これが生きるタイプの修論だったというのもあるだろうが、筆者はこのdictionaryの存在がとっっても役に立ったので、紹介する。

以下のような形式で、key-valueのマップを定義することが可能。以下の例を見れば大体使い方がわかるだろう。
#grid(
  column-gutter: 10pt,
  columns: 2,
  [
    ```typst
    #let dict = (
      name: "Typst",
      born: 2019,
    )
    #dict.name \
    #(dict.launch = 20)
    #dict.len() \
    #dict.keys() \
    #dict.values() \
    #dict.at("born") \
    #dict.insert("city", "Berlin")
    #("name" in dict)
    ```
  ],
  [
    #let dict = (
      name: "Typst",
      born: 2019,
    )
    #dict.name \
    #(dict.launch = 20)
    #dict.len() \
    #dict.keys() \
    #dict.values() \
    #dict.at("born") \
    #dict.insert("city", "Berlin")
    #("name" in dict)
  ],
)


さて、コレがどう役に立つのか。筆者の修論では、tableに結果をまとめる際に大変役に立ちました。

chapter/data.typに以下のようにarray, dictionaryを定義する。実験・解析において考えられるカテゴリーやその結果の数字などをまとめたものである#footnote[
  geminiにいい感じの例となる適当なデータ群作ってって指示してできたデータです
]。

```typst
#let classes = (
  "Apple",
  "Banana",
  "Cherry",
  "Grape",
  "Orange",
)

#let model_A = (
  scores: (0.85, 0.92, 0.78, 0.88, 0.90),
  average: 0.866,
  total_accuracy: "87.1%"
)

#let model_B = (
  scores: (0.88, 0.90, 0.82, 0.85, 0.93),
  average: 0.876,
  total_accuracy: "88.5%"
)
```

そしてこれを用いて、次のようにtableを書くことができる。

```typst
#import "data.typ": *
#figure(
  table(
    columns: 3,
    stroke: none,
    ..(
      table.hline(y: 0),
      table.hline(y: 2, stroke: .5pt),
      table.hline(y: 8, stroke: (dash: "dashed")),
      table.hline(y: 9),
    ),
    align: (x, y) => if x == 0 { left } else { center },
    fill: (x, y) => {
      if y == 0 or y == 1 { gray.lighten(60%) } else if x == 0 { gray.lighten(80%) }
    },

    table.cell(rowspan: 2, align: horizon)[*Target Class*],
    table.cell(colspan: 2)[*Model Comparison (Precision)*],
    [*Model A (SVM)*], [*Model B (CNN)*],

    ..for (i, name) in classes.enumerate() {
      let row = (
        name,
        [#model_A.scores.at(i)],
        [#model_B.scores.at(i)],
      )

      if i == 2 {
        let subtotal = (
          [*Top-3 Average*],
          [*#model_A.average*],
          [*#model_B.average*],
        )
        row + subtotal
      } else {
        row
      }
    },

    [*Overall Accuracy*], model_A.total_accuracy, model_B.total_accuracy,
  ),
)
```

#import "data.typ": *
#figure(
  table(
    columns: 3,
    stroke: none,
    ..(
      table.hline(y: 0),
      table.hline(y: 2, stroke: .5pt),
      table.hline(y: 8, stroke: (dash: "dashed")),
      table.hline(y: 9),
    ),
    align: (x, y) => if x == 0 { left } else { center },
    fill: (x, y) => {
      if y == 0 or y == 1 { gray.lighten(60%) } else if x == 0 { gray.lighten(80%) }
    },

    table.cell(rowspan: 2, align: horizon)[*Target Class*],
    table.cell(colspan: 2)[*Model Comparison (Precision)*],
    [*Model A (SVM)*], [*Model B (CNN)*],

    ..for (i, name) in classes.enumerate() {
      let row = (
        name,
        [#model_A.scores.at(i)],
        [#model_B.scores.at(i)],
      )

      if i == 2 {
        let subtotal = (
          [*Top-3 Average*],
          [*#model_A.average*],
          [*#model_B.average*],
        )
        row + subtotal
      } else {
        row
      }
    },

    [*Overall Accuracy*], model_A.total_accuracy, model_B.total_accuracy,
  ),
)


ヘッダ書いてるところまでは普通のtableである。本題はここから。
```typst
..for (i, name) in classes.enumerate() {
  let row = (
    name,
    [#model_A.scores.at(i)],
    [#model_B.scores.at(i)],
  )
```
classesという配列を順番に見ていき、i番目をnameに入れて{}内の処理をループする。
そのループ内では一つの行に表示するものを定義している。
1列目にnameそのもの、2,3列目にはdictionary model_A, model_Bのscoresの対応する場所を拾ってくるように、ということ。
```typst
if i == 2 {
  let subtotal = (
    [*Top-3 Average*],
    [*#model_A.average*],
    [*#model_B.average*],
  )
  row + subtotal
} else {
  row
}
```
そしてここで表示する際に特殊なルールを設けている。
i==2のとき、つまりデータ部分3行目を出力する際に追加でsubtotalという別な配列を作って表示するということをしている。
筆者は背景事象数の合計値の出力とかに使っていたな。



比較のため、ベタ書きした時のrawコードも見ておこう。
```typst
#table(
  columns: 3,
  stroke: none,
  .. (
    table.hline(y: 0),
    table.hline(y: 2, stroke: .5pt),
    table.hline(y: 8, stroke: dash: "dashed"),
    table.hline(y: 9),
  ),
  align: (x, y) => if x == 0 { left } else { center },
  fill: (x, y) => {
    if y == 0 or y == 1 { gray.lighten(60%) }
    else if x == 0 { gray.lighten(80%) }
  },

  table.cell(rowspan: 2, align: horizon)[*Target Class*],
  table.cell(colspan: 2)[*Model Comparison (Precision)*],
  [*Model A (SVM)*], [*Model B (CNN)*],

  [Apple], [0.85], [0.88],
  [Banana], [0.92], [0.90],
  [Cherry], [0.78], [0.82],

  [*Top-3 Average*], [*0.850*], [*0.866*],

  [Grape], [0.88], [0.85],
  [Orange], [0.90], [0.93],

  [*Overall Accuracy*], [87.1%], [88.5%]
)
```
まーそもそもtypstだとtableが書きやすいのでこれを修正する必要が出てきた、となったとていうほど面倒ではないが、これがもっと行・列が増える場合や、似たような表をたくさん書く必要がある場合にはその限りではないと思う。

ちなみに、わざわざ自前でdictionaryを定義せずとも、もとより結果をjsonとかyamlとかにまとめておけば同様のことができる。実験なんかで処理したデータをそのまま使えるという意味ではこちらで統一した方が楽だろう。

```typst
  #let data = json(path("../chapter/data.json"))

  #table(
    columns: 3,
    stroke: none,
    ..(
      table.hline(y: 0),
      table.hline(y: 2, stroke: .5pt),
      table.hline(y: 8, stroke: (dash: "dashed")),
      table.hline(y: 9),
    ),
    align: (x, y) => if x == 0 { left } else { center },
    fill: (x, y) => {
      if y == 0 or y == 1 { gray.lighten(60%) } else if x == 0 { gray.lighten(80%) }
    },
    table.cell(rowspan: 2, align: horizon)[*Target Class*],
    table.cell(colspan: 2)[*Model Comparison (Precision)*],
    [*Model A (SVM)*], [*Model B (CNN)*],

    ..for (i, name) in data.classes.enumerate() {
      let row = (
        name,
        [#data.model_A.scores.at(i)],
        [#data.model_B.scores.at(i)],
      )

      if i == 2 {
        let subtotal = (
          [*Top-3 Average*],
          [*#data.model_A.average*],
          [*#data.model_B.average*],
        )
        row + subtotal
      } else {
        row
      }
    },

    [*Overall Accuracy*], data.model_A.total_accuracy, data.model_B.total_accuracy,
  )
```

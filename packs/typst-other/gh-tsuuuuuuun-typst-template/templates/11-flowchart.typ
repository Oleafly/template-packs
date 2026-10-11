#import "@preview/autograph:0.1.0": diagram, node, edge
#import "../lib.typ": code

= フローチャート

`autograph` は Graphviz のレイアウトエンジンでノードの位置と辺の経路を決め、
描画は `fletcher` に任せます。座標を指定する必要がありません。

#figure(
  diagram(
    node(<start>, [開始]),
    node(<input>, [原稿を読む]),
    node(<check>, [誤りあり？]),
    node(<fix>, [修正する]),
    node(<out>, [PDF を出力]),
    node(<end>, [終了]),
    edge(<start>, <input>),
    edge(<input>, <check>),
    edge(<check>, <fix>, label: [はい]),
    edge(<fix>, <check>),
    edge(<check>, <out>, label: [いいえ]),
    edge(<out>, <end>),
  ),
  caption: [原稿から PDF までの手順],
) <fig-flowchart>

#ref(<fig-flowchart>) の配置はすべて自動です。
「修正する」から「誤りあり？」へ戻る辺も、重ならないよう回り込んでいます。

== 書き方

ノードをラベルで宣言し、辺でつなぐだけです。

#code(file: "chapters/11-flowchart.typ")[
```typst
#diagram(
  node(<start>, [開始]),
  node(<check>, [誤りあり？]),
  edge(<start>, <check>),
  edge(<check>, <fix>, label: [はい]),
)
```
]

ノードが増えても座標を考え直す必要がないので、下書きの段階で構造だけ書けます。

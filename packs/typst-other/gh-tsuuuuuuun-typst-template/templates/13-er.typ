#import "@preview/dati-basati:0.1.0" as db

= ER 図

`dati-basati` は Chen 記法の ER 図を描きます。
実体は矩形、関連は菱形、属性は丸で表され、主キーは黒丸になります。

#figure(
  db.er-diagram({
    db.entity(
      (0, 0),
      label: "顧客",
      name: "customer",
      attributes: (west: ("顧客 ID", "氏名", "住所")),
      primary-key: "顧客 ID",
    )
    db.entity(
      (8, 0),
      label: "注文",
      name: "order",
      attributes: (east: ("注文 ID", "数量")),
      primary-key: "注文 ID",
    )
    db.relation(
      entities: ("customer", "order"),
      label: "発注",
      name: "places",
      cardinality: ("(1,1)", "(0,n)"),
    )
  }),
  caption: [顧客と注文の関連],
) <fig-er>

#ref(<fig-er>) では、一人の顧客が零件以上の注文を持つ関係を表しています。
多重度は `cardinality` に `(最小, 最大)` の組で与えます。

実体の位置は座標で指定します。属性は `west` や `east` などの方位ごとに
まとめて渡し、`primary-key` に挙げた名前が主キーとして描かれます。

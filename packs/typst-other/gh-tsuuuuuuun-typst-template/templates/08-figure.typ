= 図

== 画像を貼る

#figure(
  image("../images/flow.svg", width: 70%),
  caption: [原稿から PDF までの流れ],
) <fig-flow>

画像のパスは、この章ファイルから見た相対位置で解決されます。

== 図を参照する

#ref(<fig-flow>) に示したとおり、三つの工程に分かれます。

== 大きさを変える

#figure(
  image("../images/flow.svg", width: 40%),
  caption: [幅を 40% にした場合],
)

== 図を横に並べる

#figure(
  grid(
    columns: 2,
    column-gutter: 1em,
    image("../images/flow.svg"),
    image("../images/flow.svg"),
  ),
  caption: [二つの図を並べる],
)

== 図形を直接描く

#figure(
  rect(width: 7cm, height: 1.4cm, radius: 3pt, fill: luma(245), stroke: 0.8pt)[
    #align(center + horizon)[外部の画像を使わない図]
  ],
  caption: [Typst の描画機能で作った図],
)

#pagebreak()

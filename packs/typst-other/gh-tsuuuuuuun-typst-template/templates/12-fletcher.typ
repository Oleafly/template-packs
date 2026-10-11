#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= 汎用の作図

`fletcher` は配置を自分で決めるかわりに、形・色・辺の曲げ方まで細かく指定できます。
自動レイアウトはありませんが、図の見た目を意図どおりに作り込めます。
以下は公式ギャラリーの例です。

== 可換図式

数式モードでそのまま図を書けます。

#figure(
  diagram(cell-size: 15mm, $
    G edge(f, ->) edge("d", pi, ->>) & im(f) \
    G slash ker(f) edge("ur", tilde(f), "hook-->")
  $),
  caption: [群準同型定理],
)

== 形・色・辺の制御

#figure(
  {
    set text(white, font: "New Computer Modern")
    diagram(
      edge-stroke: 1pt,
      node-corner-radius: 5pt,
      edge-corner-radius: 8pt,
      mark-scale: 80%,

      node((0, 0), [input], fill: maroon),
      node((2, +1), [memory unit (MU)], fill: olive),
      node((2, 0), align(center)[arithmetic & logic \ unit (ALU)], fill: olive),
      node((2, -1), [control unit (CU)], fill: olive),
      node((4, 0), [output], fill: eastern, shape: fletcher.shapes.hexagon),

      edge((0, 0), "r,u,r", "-}>"),
      edge((2, -1), "r,d,r", "-}>"),
      edge((2, -1), "r,dd,l", "--}>"),
      edge((2, 1), "l", (1, -.5), marks: ((inherit: "}>", pos: 0.65, rev: false),)),

      for i in range(-1, 2) {
        edge((2, 0), (2, 1), "<{-}>", shift: i * 5mm, bend: i * 20deg)
      },

      edge((2, -1), (2, 0), "<{-}>"),
    )
  },
  caption: [計算機の構成],
)

角の丸み、六角形のノード、破線、曲げた辺、矢じりの位置がすべて指定されています。
これだけの制御をするかわりに、ノードの位置は格子座標で自分が決めます。

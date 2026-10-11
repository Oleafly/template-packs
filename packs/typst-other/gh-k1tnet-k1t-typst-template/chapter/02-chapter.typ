#import "../macros.typ": *

== In this paper

一行だと $y = a x ^ 2 + b x + c$ みたいになる

複数行は
$
  a x ^ 2 + b x + c &= 0\
  x                 &= (- b plus.minus sqrt(b ^ 2 - 4 a c)) / (2 a)
$

図表用のテーブル(マクロ利用)

#ffigure(ja-caption: [表のタイトル], table-data: table(
  columns: 4,
  table.cell([], colspan: 2, rowspan: 2),
  table.cell([上下方向の位置], colspan: 2),
  [下],
  [上],
  table.cell([左右方向の位置], rowspan: 2),
  [左],
  [1600 ms],
  [800 ms],
  [右],
  [400 ms],
  [200 ms],
))<表の説明>

同じマクロで図も挿入可能
#ffigure(ja-caption: "サンプル画像", image-path: "sample_image.png")<画像の説明>

#ffigure(ja-caption: [表番号は自動設定], table-data: table(
  stroke: none,
  columns: 3,
  table.hline(),
  [名前],
  [味],
  [産地],
  table.hline(),
  [リンゴ],
  [92.1],
  [青森],
  [みかん],
  [92.6],
  [愛媛],
  [いちご],
  [90.3],
  [金沢],
  table.hline(),
))<表の説明>

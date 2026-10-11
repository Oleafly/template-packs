#metadata("darashi")<author>

== 図表と画像の活用

技術書において、図表や画像は内容を視覚的に伝える重要な要素です。この章では、Typstを使って図表や画像を効果的に活用する方法について解説します。

=== 基本的な画像の挿入

Typstでは、`image`関数を使って画像を挿入できます。基本的な使い方は以下の通りです：

```typ
#image("path/to/image.jpg")
```

画像のサイズを指定する場合は、`width`や`height`パラメータを使用します：

```typ
// 幅を指定（高さは自動的に調整される）
#image("path/to/image.jpg", width: 80%)

// 高さを指定（幅は自動的に調整される）
#image("path/to/image.jpg", height: 5cm)

// 幅と高さの両方を指定
#image("path/to/image.jpg", width: 10cm, height: 5cm)
```

幅や高さは、絶対値（cm, mm, pt など）や相対値（%）で指定できます。相対値は、親要素の幅に対する割合です。

=== キャプション付きの図

技術書では、画像にキャプションを付けることが一般的です。Typstでは、`figure`関数を使ってキャプション付きの図を作成できます：

```typ
#figure(
  image("path/to/image.jpg", width: 80%),
  caption: [図1: サンプル画像]
)
```

`figure`関数を使うと、自動的に図番号が付与され、参照も可能になります：

```typ
#let fig = figure(
  image("path/to/image.jpg", width: 80%),
  caption: [サンプル画像]
)

@fig を参照してください。 // 「図1: サンプル画像」のように表示される
```

=== 画像の配置

画像の配置を制御するには、`align`関数を使用します：

```typ
// 中央揃え
#align(center)[
  #image("path/to/image.jpg", width: 80%)
]

// 右揃え
#align(right)[
  #image("path/to/image.jpg", width: 60%)
]

// 左揃え
#align(left)[
  #image("path/to/image.jpg", width: 60%)
]
```

複数の画像を横に並べるには、`grid`関数を使用します：

```typ
#grid(
  columns: (1fr, 1fr),  // 2列のグリッド
  gutter: 1em,          // 列間の余白
  image("path/to/image1.jpg", width: 100%),
  image("path/to/image2.jpg", width: 100%)
)
```

=== 画像の装飾

画像に枠線や背景色を付けるには、`box`関数を使用します：

```typ
// 枠線付きの画像
#box(
  stroke: 1pt,
  image("path/to/image.jpg", width: 80%)
)

// 角丸の枠線と背景色
#box(
  stroke: 1pt,
  fill: rgb("#f5f5f5"),
  radius: 5pt,
  inset: 10pt,
  image("path/to/image.jpg", width: 80%)
)
```

=== サポートされる画像形式

Typstは、以下の画像形式をサポートしています：

- JPEG (.jpg, .jpeg)
- PNG (.png)
- GIF (.gif)
- SVG (.svg)
- WebP (.webp)

特に、SVGはベクター形式のため、拡大しても画質が劣化しません。図やダイアグラムには、SVG形式を使用することをお勧めします。

=== 表の作成

Typstでは、`table`関数を使って表を作成できます：

```typ
#table(
  columns: (auto, auto, auto),  // 列の幅を指定
  [*列1*], [*列2*], [*列3*],    // ヘッダー行
  [データ1], [データ2], [データ3],  // データ行
  [データ4], [データ5], [データ6]   // データ行
)
```

列の幅は、`auto`（内容に合わせて自動調整）、絶対値（1cm など）、相対値（1fr など）で指定できます。`fr`（フラクション）は、利用可能なスペースを比率で分割します。

表のスタイルをカスタマイズするには、`set table`を使用します：

```typ
#set table(
  stroke: 0.5pt,        // 罫線の太さ
  inset: 5pt,           // セル内の余白
  align: center,        // セル内のテキスト配置
  fill: (_, row) => if row == 0 { rgb("#f0f0f0") } else { none }  // ヘッダー行の背景色
)
```

キャプション付きの表を作成するには、`figure`関数を使用します：

```typ
#figure(
  table(
    columns: (auto, auto, auto),
    [*列1*], [*列2*], [*列3*],
    [データ1], [データ2], [データ3],
    [データ4], [データ5], [データ6]
  ),
  caption: [表1: サンプルデータ]
)
```

=== セルの結合

表のセルを結合するには、`table.cell`関数を使用します：

```typ
#table(
  columns: (auto, auto, auto),
  [*列1*], [*列2*], [*列3*],
  table.cell(colspan: 2)[結合セル], [データ3],
  [データ4], table.cell(rowspan: 2)[結合セル], [データ6],
  [データ7], [データ9]
)
```

`colspan`は水平方向のセル結合、`rowspan`は垂直方向のセル結合を指定します。

=== 複雑な表のデザイン

より複雑な表のデザインには、`table.cell`、`table.row`、`table.column`関数を組み合わせて使用します：

```typ
#table(
  columns: (auto, auto, auto),
  fill: rgb("#f5f5f5"),  // 表全体の背景色
  align: center,         // 表全体のテキスト配置
  
  table.header(
    fill: rgb("#333333"),  // ヘッダー行の背景色
    text(fill: white)[*列1*], text(fill: white)[*列2*], text(fill: white)[*列3*]
  ),
  
  table.cell(fill: rgb("#e0e0e0"))[データ1], [データ2], [データ3],
  [データ4], table.cell(fill: rgb("#e0e0e0"))[データ5], [データ6]
)
```

=== 図表番号のカスタマイズ

Typstでは、図表番号の形式をカスタマイズできます：

```typ
// 図番号を「図1-1」のような形式に変更
#set figure(
  numbering: (..nums) => {
    let chapter = nums.at(0)
    let fig = nums.at(1)
    [図#chapter-#fig]
  }
)
```

章ごとに図表番号をリセットするには、以下のようにします：

```typ
= 新しい章
#counter(figure.where(kind: image)).update(0)
```

=== 図表一覧の作成

論文や技術書では、図表一覧を作成することがあります。Typstでは、以下のようにして図表一覧を作成できます：

```typ
= 図表一覧

== 図一覧
#locate(loc => {
  let figures = query(figure.where(kind: image), loc)
  for fig in figures [
    #link(fig.location())[図 #fig.counter.display(): #fig.caption]\
  ]
})

== 表一覧
#locate(loc => {
  let tables = query(figure.where(kind: table), loc)
  for tab in tables [
    #link(tab.location())[表 #tab.counter.display(): #tab.caption]\
  ]
})
```

=== ダイアグラムの作成

技術書では、フローチャートや構造図などのダイアグラムが必要になることがあります。Typstには直接ダイアグラムを作成する機能はありませんが、以下の方法でダイアグラムを挿入できます：

1. 外部ツール（Draw.io, Mermaid, PlantUML など）でダイアグラムを作成し、SVG形式で保存
2. SVGファイルをTypstドキュメントに挿入

```typ
#figure(
  image("diagrams/flowchart.svg", width: 80%),
  caption: [システムのフローチャート]
)
```

=== 画像の最適化

印刷用の技術書では、画像の解像度が重要です。一般的に、印刷用の画像は300 DPI以上の解像度が必要です。また、ファイルサイズを小さくするために、以下の点に注意してください：

1. 写真はJPEG形式（高品質設定）で保存
2. 図やスクリーンショットはPNG形式で保存
3. ダイアグラムやロゴはSVG形式で保存
4. 不要な部分はトリミング
5. 適切なサイズにリサイズ

=== 実践的なテクニック

==== 画像の枠線と影

プロフェッショナルな印象を与えるために、画像に枠線と影を付けることができます：

```typ
#let shadowed_image(path, width: 80%) = {
  box(
    shadow: (
      offset: 3pt,
      color: rgb("#00000044")
    ),
    stroke: 1pt,
    radius: 2pt,
    inset: 0pt,
    image(path, width: width)
  )
}

#shadowed_image("path/to/image.jpg")
```

==== 画像のグループ化

関連する複数の画像をグループ化して表示することができます：

```typ
#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #image("path/to/image1.jpg", width: 100%)
      #align(center)[*（a）サンプル1*]
    ],
    [
      #image("path/to/image2.jpg", width: 100%)
      #align(center)[*（b）サンプル2*]
    ]
  ),
  caption: [異なる条件での実験結果]
)
```

==== 画像の注釈

画像に注釈を付けるには、`overlay`関数を使用します：

```typ
#let annotated_image(path, width: 80%) = {
  box(
    width: width,
    overlay(
      image(path, width: 100%),
      align(right + top, text(fill: red)[*重要な部分*]),
      align(left + bottom, text(fill: blue)[*注目ポイント*])
    )
  )
}

#annotated_image("path/to/image.jpg")
```

=== まとめ

この章では、Typstを使って図表や画像を効果的に活用する方法について解説しました。適切な図表や画像を使用することで、技術書の内容をより分かりやすく伝えることができます。

次の章では、Typstを使った索引や参考文献の作成方法について解説します。

//////////////////////////////////////////////////////////////////
////
////                report_template_Typst
////                       main.typ
////
//////////////////////////////////////////////////////////////////

// 設定ファイル
#import "settings.typ": *

#show: setup
#show: bib-init

// 定理環境の設定
// #import cosmos.simple: *
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion
// 定理などの番号を節ごとに振る（例：Theorem 4.1）
#set-inherited-levels(1)

#set document(title: [
  ここに文書のタイトルを入れます
])
#show: doc => author(
  authors: (
    (
      name: "著者名",
      affiliation: "著者の所属・学年",
      email: "author@example.com",
    ),
    // (
    //   name: "第二著者",
    //   affiliation: "第二著者の所属・学年",
    //   email: "second@example.com",
    // ),
  ),
  date: [2026 年 6 月 1 日],
  cover: true, // true なら表紙あり，false なら表紙なし
  doc,
)

// 目次が不要な場合は以下の行（改ページの行も含む）をコメントアウトしてください．
#outline(
  title: "目次",
  indent: auto,
)
#pagebreak()

= これは見出し
<sec:heading>

== これは小見出し
<ssec:subheading>

=== これはさらに小さい見出し
<sssec:subsubheading>

コピペ用に図と表はここにも置いておきます．
その他は `template-manual/` ディレクトリのファイルを参考にしてください．

#pagebreak()

#figure(
  placement: top,
  image("figure/example-image.pdf", width: 65%),
  caption: [Please write the figure caption here.],
)<fig:one_figure>

#figure(
  placement: top,
  grid(
    columns: 2,
    gutter: 2.5mm,
    subfigure(
      image("figure/example-image-a.pdf", width: 100%),
      caption: [Left figure caption.],
      label: <subfig:two_figures-a>,
    ),
    subfigure(
      image("figure/example-image-b.pdf", width: 100%),
      caption: [Right figure caption.],
      label: <subfig:two_figures-b>,
    ),
  ),
  caption: [Two figures placed side by side.],
) <fig:two_figures>

#figure(
  placement: top,
  grid(
    columns: 3,
    gutter: 2.5mm,
    subfigure(
      image("figure/example-image-a.pdf", width: 100%),
      caption: [Left figure caption.],
      label: <subfig:three_figures-a>,
    ),
    subfigure(
      image("figure/example-image-b.pdf", width: 100%),
      caption: [Center figure caption.],
      label: <subfig:three_figures-b>,
    ),
    subfigure(
      image("figure/example-image-c.pdf", width: 100%),
      caption: [Right figure caption.],
      label: <subfig:three_figures-c>,
    ),
  ),
  caption: [Three figures placed side by side.],
) <fig:three_figures>

#figure(
  placement: top,
  grid(
    columns: 2,
    gutter: 2.5mm,
    subfigure(
      image("figure/example-image-a.pdf", width: 100%),
      caption: [Upper-left figure caption.],
      label: <subfig:four_figures-a>,
    ),
    subfigure(
      image("figure/example-image-b.pdf", width: 100%),
      caption: [Upper-right figure caption.],
      label: <subfig:four_figures-b>,
    ),

    subfigure(
      image("figure/example-image-c.pdf", width: 100%),
      caption: [Lower-left figure caption.],
      label: <subfig:four_figures-c>,
    ),
    subfigure(
      image("figure/example-image-d.pdf", width: 100%),
      caption: [Lower-right figure caption.],
      label: <subfig:four_figures-d>,
    ),
  ),
  caption: [Four figures placed in a $2 times 2$ grid.],
) <fig:four_figures>

#figure(
  placement: top,
  table(
    columns: (auto, auto, auto),
    align: (left, center, right),

    stroke: (x, y) => (
      if y == 0 {
        (top: 1.2pt + black, bottom: 1.2pt + black)
      } else {
        (bottom: 0.5pt + black)
      }
    ),

    table.header(
      table.cell(align: center)[学会名],
      table.cell(align: center)[会員種別],
      table.cell(align: center)[年会費],
    ),

    table.cell(colspan: 3, align: center)[実在する学会],

    [日本機械学会], [学生員], [$4,800$ 円],
    [日本流体力学会], [学生会員], [$5,000$ 円],
    [日本伝熱学会], [学生会員], [$4,000$ 円],

    table.cell(colspan: 3, align: center)[実在しない学会],

    table.cell(rowspan: 4, align: left + horizon)[日本架空学会], [小学生会員], [$-8,000$ 円],
    [中高生会員], [$-5,000$ 円],
    [大学生会員], [$-2,000$ 円],
    [名誉学生会員], [$6.02 times 10^23$ 円],
  ),
  caption: [Please write the table caption here.],
) <tb:example_table>

#bibliography-list(
  title: "参考文献",
  ..bib-file(read("bibliography.bib"), ..my-bib-style),
)



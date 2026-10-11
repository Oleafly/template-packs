#import "@preview/cjk-unbreak:0.2.1": remove-cjk-break-space
#show: remove-cjk-break-space

#set document(title: "タイトル")

// フォント設定
#set text(
  font: ("Latin Modern Roman", "Noto Serif CJK JP"),
  size: 12pt,
  lang: "ja",
  cjk-latin-spacing: none
)

// ページ設定（LaTeX jreportに近い余白）
#set page(
  paper: "a4",
  margin: (
    top: 46.45mm,
    bottom: 44.54mm,
    left: 39.44mm,
    right: 39.78mm,
  ),
)

// 段落設定
#set par(
  justify: true,
  first-line-indent: 1em,
  leading: 0.65em,
  spacing: 0.65em,
)

// 見出し設定
#set heading(numbering: "1.1")

// 章の設定
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1.6cm)
  block[
    #set text(
      font: ("Latin Modern Roman", "Noto Sans CJK JP"),
      size: 24pt,
      weight: "bold"
    )
    #if it.numbering != none {
      [第#counter(heading).display()章#h(1em)]
    }
    #it.body
  ]
  v(1.25cm)
}

// 節の設定
#show heading.where(level: 2): it => {
  v(1.2em)
  block[
    #set text(
      font: ("Latin Modern Roman", "Noto Sans CJK JP"),
      size: 16pt,
      weight: "bold"
    )
    #if it.numbering != none {
      counter(heading).display(it.numbering)
      h(1em)
    }
    #it.body
  ]
  v(0.8em)
}

// 見出し直後も字下げを強制
#show heading: it => {
  it
  v(-1em)
  h(1em)
}

// itemize
#show list: it => {
  v(1em)
  it
  v(1em)
}

// enumerize
#show enum: it => {
  v(1em)
  it
  v(1em)
}

// verbatim
#show raw.where(block: true): it => {
  v(1em)
  it
  v(1em)
}

// ========================================================================== //
//     Title                                                                  //
// ========================================================================== //

#align(center + horizon)[
  #text(size: 18pt)[
    タイトル\
    サブタイトル
  ]
  #v(2em)
  #text(size: 14pt)[
    所属\
    学籍番号：0000000\
    名前
  ]
]

#pagebreak()

// ========================================================================== //
//     Index                                                                  //
// ========================================================================== //

#outline(title: "目次", indent: auto)

#pagebreak()

// ========================================================================== //
//     Background                                                             //
// ========================================================================== //

= 背景

Typstの数式はLaTeXとは異なる体系を持っており，それなりにクセがあります．
注意してください．
例えば，$e^(i pi) + 1 = 0$はインライン数式に，$ dif S = (delta q) / T $はブロック数式になります．

以下は文字稼ぎのための特に意味のない数式の連打です．

$
sin(x)
  = sum_(n=0)^oo (-1)^n / ((2n+1)!) x^(2n+1)
$

$
lim_(n -> oo) P((sum_(i=1)^n X_i - n mu) / (sigma sqrt(n)) <= x)
  =
Phi(x)
  =
1/sqrt(2pi) integral_(-oo)^x e^(-t^2/2) dif t
$

$
f(n) = cases(
  n/2 &"if" n equiv 0 space (mod 2),
  3n+1 &"if" n equiv 1 space (mod 2)
)
$

== 節

Markdown記法に似ているところもあります．
章や節は\#ではなく=ですが，まあ似てはいます．
以下はLaTeXでいうitemizeです．

- item1
- item2
- item3

以下はLaTeXでいうenumerizeです．

1. item1
2. item2
3. item3

そして，以下はLaTeXでいうverbatimです．

```
#include <stdio.h>

int main() {
	printf("Hello, world!");
	return 0;
}
```

#h(1em)表や図の書き方もそれなりにクセがあります．
@some-table や @some-image のようにアットマークで参照できます．

#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(),
    [],                 table.vline(), [3D [ms]],   table.vline(), [2D [ms]], table.vline(), [2D / 3D [%]],
    table.hline(),
    [GeForce GTX 1650], table.vline(), [16860.832], table.vline(), [949.113], table.vline(), [5.62910],
    [GeForce RTX 3060], table.vline(), [855.265],   table.vline(), [525.801], table.vline(), [61.4781],
    table.hline(),
  ),
  placement: top,
  caption: [なんらかの表]
) <some-table>

#figure(
  image("image.png", width: 100%),
  placement: top,
  caption: [なんらかの図]
) <some-image>

参考文献はworks.bibのようにBiBTeX形式が使えます．
本文中で @bvh-org や @simple @3d のように参照することで初めてbibliography関数の結果に現れます．
今回は taa を参照していないので，works.bibにあっても参考文献には載りません．

// ========================================================================== //
//     Object                                                                 //
// ========================================================================== //

= 目的

// ========================================================================== //
//     Related Works                                                          //
// ========================================================================== //

= 関連研究

// ========================================================================== //
//     Preparation                                                            //
// ========================================================================== //

= 準備

// ========================================================================== //
//     Theory                                                                 //
// ========================================================================== //

= 理論

// ========================================================================== //
//     Implementation                                                         //
// ========================================================================== //

= 実装

// ========================================================================== //
//     Evaluation                                                             //
// ========================================================================== //

= 評価

// ========================================================================== //
//     Conclusion                                                             //
// ========================================================================== //

= 結論

// ========================================================================== //
//     References                                                             //
// ========================================================================== //

#heading(level: 1, numbering: none)[参考文献]
#set text(lang: "en")
#bibliography("works.bib", title: none)
#set text(lang: "ja")

// ========================================================================== //
//     Acknowledgements                                                       //
// ========================================================================== //

#heading(level: 1, numbering: none)[謝辞]

#import "template.typ": *

#show: project.with(
  title: "タイトル",
  authors: (
    "山田 太郎",
  ),
  date: "2024/01/06"
)

= サンプル

== 文章

#lorem(60) @crazy-rich @quantized-vortex

== 図

サンプル図を @img に示す。

#figure(
  image("assets/graph.png"),
  caption: [グラフ]
) <img>

== 表

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: horizon,
    [], [月曜日], [火曜日],[水曜日],[木曜日],[金曜日],
    "午前", "コンパイラ\n理論", text("オペレーティング\nシステム", 9pt), "コンピュータ\nネットワーク", text("オペレーティング\nシステム", 9pt), "コンピュータ\nネットワーク",
    "午後", "データ\nマイニング", "コンピュータ\nネットワーク", text("オペレーティング\nシステム", 9pt), "コンピュータ\nネットワーク", "分散システム"
  ),
  caption: "サンプル表"
)

== プログラム

#figure(
  ```c
  #include <stdio.h>
  int main() {
    // printf関数の使用例
    printf("Hello, World!");
    return 0;
  }
  ```,
  caption: "C言語でのHelloWorld"
)

#bibliography("bibliography.yml")
#import "./report_template.typ": *
#set text(font: "Yu mincho")
#let list(text, caption: "") = tbl(
 table(
    columns: (1fr),
    inset: 10pt,
    align: left,
    text,
  ),
  caption: caption
)

#show: report.with(
  title: "Typstのテンプレート",
  author: "引田 鴻志 (s2233)",
  school: "大分工業高等専門学校",
  department: "情報工学科3年",
  id: "30番",
)

= 目的
このTypstファイルは，Typstでレポート作成を行う場合のテンプレートである．

= 各種機能の扱い方
== インラインコード
インラインコードは``` `code` ``` `code` で呼び出せる（関数`raw()`の糖衣構文）．

== リスト
リストは`list()`関数を用いる（リスト#table_num(0)）．リスト番号は`#table_num(0)`#table_num(0)で参照できる．
#list(
  raw(read("./files/include.txt")), 
  caption: "リストとread(), list()の例"
)

== 画像
図はこのように,`img()`関数を用いる（図#image_num(0)）．番号を参照するには`#image_num(0)`#image_num(0)を用いる．
#img(
  image("./files/screenshot.png"),
  caption: "画像の読み込み例"
)

== 数式
数式は`$  $`で囲う．数式は独自のTypst記法を用いる．例えば
`$ f'(a) = lim_(h -> 0) ((f(a + h) - f(a)) / h) $`
$ f'(a) = lim_(h -> 0) ((f(a + h) - f(a)) / h) $
`$ integral_(a)^(b) f(x) d x = lim_(n -> infinity) sum_(i=1)^n f(x_i) Delta x $`
$ integral_(a)^(b) f(x) d x = lim_(n -> infinity) sum_(i=1)^n f(x_i) Delta x $
である．インライン数式は単に`$e^(i pi) + 1 = 0$`$e^(i pi) + 1 = 0$のように，`$`の前後に空白を開けなければよい．

#pagebreak()
= まとめ
Typstはコンパイルが高速! Typstは記述量が少ない! パッケージで悩むことがない! 
環境構築は `sudo snap install typst`(※unix系の場合)だけ，楽ちん楽ちん♪

その他，使い方に困ったら，公式ドキュメント（英語）を読みましょう．とても詳細かつわかりやすく書いてあります．
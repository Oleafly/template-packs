= Typstのセットアップ
Typst@typst で論文を書くためのテンプレートを提供します。
== セットアップ
+ このテンプレートをお好みのディレクトリに配置
+ vscodeでmain.typを含むrootで開く
+ `Tinymist Typst`の拡張機能をインストール
+ このテンプレートの`main.typ`を開いた状態で、以下の@fig:buildIcon で示すアイコンをクリックでpdfにビルドできます。
// ↑本来のtypstの参照では@buildIconでいいですが、外部のライブラリを使ってる関係でfig: or tbl: or lst:が必要です。

#figure(
  caption: "ビルドアイコン",
  image("../img/typstBuild.png")
)<buildIcon>

// モジュールのインポート
#import "libs/template.typ": *
#import "contents/fig_tbl.typ": *
#show: thesis

//////////////////////////////////////////////
//// 本文

= テンプレートの使い方

== 概要
必要に応じて、contentsフォルダ内の各.typファイルとthesis.typに追記してください。参考文献はref.bibに記述してください。VSCodeを使用する場合は、拡張機能 Tinymist Typst を利用してPDFを出力すると便利です。執筆時点（2024/11/19）での動作確認は、バージョン0.12.2で実施済みです。\


== 数式
@eq1 は以下の通り。

$ y &= a x^2 + b x + c\ &= a x^2 + b x + c $ <eq1>
$
  mat(1, 2, ..., 10;2, 2, ..., 10;dots.v, dots.v, dots.down, dots.v;10, 10, ..., 10;)
$
$ rho dv(vb(v), t, d: upright(D)) = -grad p + mu grad^2 vb(v) + rho vb(f) $
$ num("-1.32865+-0.50273e-6") $
$ qty("1.3+1.2-0.3e3", "erg/cm^2/s") $
$ numrange("1,1238e-2", "3,0868e5", thousandsep: "'") $


== 図表

=== 図
@img1 は以下の通り。
#img1 <img1>

=== 表
@tbl1 は以下の通り。
#tbl1 <tbl1>

= 緒言
なんてったってTypst

= 手法
描いた 描いた 描いた 描いた\
#i 描いた 描いた 描いた 描いた\
#i 描いた 描いた 描いた 描いた\
#i 描いた 描いた
== 実験手法

== 解析手法

= 結果と考察
多分、Typst。

= 結言
何の成果も！！得られませんでした！！

////////////////////////////////////////////////
//// へッダーの表示をリセット
#counter(heading).update(0)
#set heading(numbering: none)

= 謝辞
Typstに感謝

////////////////////////////////////////////////
//// 参考文献

#bibliography(bib_file_path, style: bib_style)

////////////////////////////////////////////////
//// Appendix
#show: appendix_layout

= 付録
サンプル







// MIT No Attribution
// Copyright 2024, 2025 Shunsuke Kimura
// https://github.com/kimushun1101/rengo-typst-template

#import "lib.typ": rengo, definition, lemma, theorem, corollary, proof
#show: rengo.with(
  title: [自動制御連合講演会サンプル原稿], 
  authors: [◯ 自動太郎　制御花子(連合大学)　自動次郎 (連合会社)],
  title-en: [Sample Manuscript for the Japan Joint Automatic Control Conference],
  authors-en: [$ast$T. Jido, H.~Seigyo (Rengo Univ.) and J. Jido (Rengo Corp.)],
  abstract: [This document describes the information for authors such as paper submission and the style of manuscript. Only PDF manuscripts are acceptable. The PDF manuscripts should be uploaded on the conference homepage. This document is a template file for a paper, although it is not necessary to strictly follow this format.],
  keywords: ([Electrical paper submission], [The style of manuscript]),
)

= はじめに
使用言語は日本語または英語です．原稿はA4版で2 $tilde.op$ 8ページとし，
PDFファイルを電子投稿していただきます．
アップロードするファイルサイズの制限は5MBとします．

= 原稿の体裁

== 全体の体裁
A4用紙の（US Letterは不可），縦250 mm，横170 mmの枠内に収まるようにし
てください．
余白は，上20 mm，下27 mm，左20 mm，右20 mmとします．
活字の大きさは，
日本語16ポイント，
日本語著者名・英語タイトル・英語著者名12ポイント，
章タイトル12ポイント，
節タイトル10ポイント，
本文の活字10ポイントを目安としてください．
原稿は，
- 邦文タイトル（英文原稿の場合は不要）
- 邦文著者名（登壇者に○印）と著者所属（英文原稿の場合は不要）
- 英文タイトル
- 英文著者名（登壇者に$$印）と英文著者所属
- 英文アブストラクト（100ワード程度）
- 英文キーワード
- 本文，参考文献
の順に書いてください．
英文キーワードまでを1段組，本文・参考文献を2段組にしてください．

== 図と表
図と表は，Fig.~1，Table~1のように番号を振り
（@fig:samplefig 参照），図説，図中の説明文は英文で記入してください．
本文で引用する場合も「Fig.~1に示す」などのようにFig.とTableを使用してください．

#figure(
  placement: top,
  // svg, png, jpg, gif に対応しています．
  // eps, pdf などには対応していません．(2024.07.07)
  // https://typst.app/docs/reference/visualize/image/
  image("fig1.svg", width: 80%), 
  caption: [A sample figure.],
) <fig:samplefig>

// #figure(
//   placement: bottom,
//   caption: [A sample table.],
//   table(
//     columns: 3,
//     stroke: none,
//     table.header(
//       [],
//       [Size (pt)],
//       [Font],
//     ),
//     table.hline(),
//     [Title], [16], [Gothic],
//     [Authors], [12], [Gothic],
//     [Section title], [12], [Gothic],
//     [Contents], [10], [Mincho],
//     [Reference], [9], [Mincho],
//   )
// ) <tab:fonts>

図や表中の文字は小さくなりすぎないよう気をつけてください．
PDF原稿を作成する際，図の画質が劣化しないよう，注意してください．
特にMicrosoft Wordなどで原稿を作成する際，JPEG画像を貼り付けると，一度圧縮されている画像が再圧縮され画質が劣化するようです．
貼り付ける画像は，画質の良い（圧縮率の低い）画像を用いるか圧縮しない画像フォーマットを選ぶなど，各自工夫し，最終的なPDFファイルにおいて画質が劣化しないよう注意してください（300 dpi以上の画質を推奨します）．

== 数式関係
数式の使用例です．
$ dot(x) (t) &= A x(t) + B u(t) $ <eq:system>
$ y(t) &= C x(t) + D u(t) $ <eq:output>
// 引用する場合には @eq:system と @eq:output としてください．

== 定理環境
以下は，theorem 環境の使用例です．
// ctheorems パッケージを使用しています．
// https://typst.app/universe/package/ctheorems

#theorem[
  ここに定理の内容を記述して下さい．系や補題の場合も同様です．
]
#proof[
  ここには定理の証明を記述して下さい．証明の最後には□印がつきます．
]
定理などの文章は，もともとイタリック書体を使うようになってい
ますが，和文との整合性を考えて，ローマン書体を使うように変更
しています．

// #definition("用語 A")[
//   用語 A の定義を書きます．
// ]<def:definition1>
// #lemma("補題 B")[
//   補題 B を書きます．タイトルは省略することもできます．
// ]<lem:lemma1>
// #lemma[
//   補題を書きます．番号は定義や補題ごとに 1 からカウントします．
// ]<lem:lemma2>
// #corollary[
//   系を書きます．@def:definition1 のように，ラベルで参照することもできます．
// ]

= 参考文献
文献の引用は本文中に @web @ConferenceJP @Journal のように書き，
本文の最後にまとめて記述します．次のフォーマットを推奨します．

#set enum(numbering: "a)")
+ 雑誌論文の場合\
	$[$番号$]$ 著者：論文題目；雑誌名，Vol.~巻, No.~号, pp.~始ページ--終ページ (発行年)
+ 会議論文の場合\
	$[$番号$]$ 著者：論文題目；会議論文誌名，pp.~始ページ--終ページ (発行年)
+ 単行本の場合 @Book\
	$[$番号$]$ 著者：書名，pp.~始ページ--終ページ, 発行所 (発行年)
+ Websiteの場合\
	$[$番号$]$ URL

#bibliography("refs.yml", full: false)
// refs.yml に記載する． refs.bib に変更することもできますが，日本語論文の著者名がうまく表示分けができないため，日本語論文を含む参考文献リストの場合には yml で記載することを推奨します．(2024.07.07)
// `full` を `true` に変更すると本文引用がされていない文献も出力される．出力確認のために `true` にしてもよいが，提出時には `false` に戻してください．
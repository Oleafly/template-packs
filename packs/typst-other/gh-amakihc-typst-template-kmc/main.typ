#import "template.typ": *

#show: body => jarticle(
	fontsize: 10.5pt, // フォントサイズ
	// ---------- ----------
	// この部分はあまり気にしなくてよい
	title: [],
	authors: (
		"",
	),
	date: datetime.today().display(),
	// ---------- ----------
	body,
)

// ---------- ----------
// 例
= 正規分布
この章は @statistic を参考に記述した。
== 確率密度関数
正規分布の確率密度関数は
$ // 数式の例
  f(x) = 1/(sqrt(2pi)sigma)exp(-(x-mu)^2/(2sigma^2))
$ <gaussian> // labelの例
で表される。
#footnote[ // footnoteの例
	@gaussian /*refの例*/ において、期待値は $mu$ 、分散は $sigma^2$ である。
]
標準正規分布のグラフは @standard の通り。
#figure( // figureの例
	image("img/image.png", width: 100%),
	caption: [標準正規分布]
) <standard>

#bibliography("main.bib") // 参考文献

#heading([謝辞], numbering: none) // 謝辞
なんかマジでありがとう。

#show: appendix // ここからAppendix

= おまけ
== 三平方の定理
たぶん三平方の定理が成り立つ。
$
  a^2 + b^2 = c^2
$

// ---------- ----------

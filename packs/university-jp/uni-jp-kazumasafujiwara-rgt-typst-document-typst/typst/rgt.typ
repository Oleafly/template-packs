// RGT (Ryukoku Graduation Thesis) Typst Package
// 龍谷大学先端理工学部数理・情報科学課程卒業論文用スタイルファイル
//
// 【特別研究論文の内規・設計上の注意】正本はリポジトリ根の README.md
// 1) 内容に必ずしもオリジナリティーは不要（教科書の独自まとめでも可）
// 2) 概要は1ページのみ。本体とは独立に全体をまとめる（図表・数式・文献一覧可）
// 3) 本文（表紙・目次・文献一覧・付録を除く）はA4で6ページ超（7ページ目に入る）が最低条件
//    冗長な詳細は付録へ。thesis() は概要→表紙→目次の後に本文を開始し、そこで page を 1 に戻す
// 4) 共同研究は序文で研究・執筆分担を明記し、各自の執筆量が単著準拠であること
// 5) 引用は明記し、公開しても問題ないよう配慮。Web引用はアクセス日必須
//    （bib の note = {Accessed: YYYY-MM-DD} と rgt.csl を用いる）

// 定理環境
#let definition(title: none, id: none, it) = [
	#figure(
		kind: "prop",
		supplement: "定義",
	)[
		#block(
			radius: 4pt,
			inset: 10pt,
			fill: silver,
			width: 100%,
		)[
			#align(left)[
				*定義 *
				*#context counter(figure.where(kind: "prop")).display()*
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let theorem(title: none, id: none, it) = [
	#figure(
		kind: "prop",
		supplement: "定理",
	)[
		#block(
			radius: 4pt,
			inset: 10pt,
			width: 100%,
			stroke: (2pt + black),
		)[
			#align(left)[
				*定理*
				#context counter(figure.where(kind: "prop")).display()
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let proposition(title: none, id: none, it) = [

	#figure(
		kind: "prop",
		supplement: "命題",
	)[
		#block(
			radius: 4pt,
			inset: 10pt,
			fill: luma(250),
			width: 100%,
			stroke: (2pt + gray),
		)[
			#align(left)[
				*命題 *
				*#context counter(figure.where(kind: "prop")).display()*
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let lemma(title: none, id: none, it) = [
	#figure(
		kind: "prop",
		supplement: "補題",
	)[
		#block(
			radius: 4pt,
			inset: 10pt,
			width: 100%,
			stroke: (4pt + silver),
		)[
			#align(left)[
				*補題 *
				*#context counter(figure.where(kind: "prop")).display()*
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let corollary(title: none, id: none, it) = [
	#figure(
		kind: "prop",
		supplement: "系",
	)[
		#block(
			radius: 4pt,
			inset: 10pt,
			width: 100%,
			stroke: (2pt + silver),
		)[
			#align(left)[
				*系 *
				*#context counter(figure.where(kind: "prop")).display()*
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let remark(title: none, id: none, it) = [
	#figure(
		kind: "prop",
		supplement: "註",
	)[
		#block(
			inset: 10pt,
			width: 100%,
			stroke: (left: 2pt + black),
		)[
			#align(left)[
				*註 *
				*#context counter(figure.where(kind: "prop")).display()*
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let example(title: none, id: none, it) = [
	#figure(
		kind: "prop",
		supplement: "例",
	)[
		#block(
			inset: 10pt,
			width: 100%,
			stroke: (left: 2pt + gray),
		)[
			#align(left)[
				*例 *
				*#context counter(figure.where(kind: "prop")).display()*
				#if title != none [* : #title *]
				#v(-0.3em)
				#it
			]
		]
	]
	#if id != none { label(id)}
]

#let proof(title: none, it) = {
	strong("証明: " + title)
	it
	align(right)[□]
}

// 論文のテンプレート
// 構成順: 概要(1ページ想定) → 表紙 → 目次 → 本文(ここからページ番号1。本文は7ページ目に入ること)
// 文献一覧・付録は本文ページ数に含めない（内規）。共同研究時の分担明記は序文（本文側）で行う。
#let thesis(
	title: none,
	academic-year: none,
	article-type: none,
	author: none,
	supervisor: none,
	affiliation: none,
	abstract: none,
	font: none,
	doc,
) = {
	set page(
		margin: 20mm,
		paper: "a4",
	)
	set text(
		size: 12pt,
	)
	// --- 概要ページ（内規: 1ページのみ・本体と独立） ---
	align(center)[
		#academic-year 年度 #article-type\
		#text(18pt, title)
	]
	align(right)[
		#affiliation.university
		#affiliation.department
		#affiliation.course
		#h(0.15cm)
		#v(-0.3cm)
		#table(
			columns: 2,
			stroke: none,
			align: (right, left),
				[#author.id:],
				[#author.family-name #author.given-name],
				[指導教員:],
				[#supervisor.family-name #supervisor.given-name],
		)
	]
	align(center)[
		*概要*
	]

	abstract

	pagebreak()

	// --- 表紙（本文ページ数に含めない） ---
	v(2.5cm)

	align(center)[
		#academic-year 年度 #article-type \ \
		#text(25pt, strong(title))
		#v(1fr)
		#align(center)[
			#affiliation.university
			#affiliation.department
			#affiliation.course
			#h(0.15cm)
			#v(-0.3cm)
			#table(
				columns: 2,
				stroke: none,
				align: (right, left),
					[#author.id:],
					[#author.family-name #author.given-name],
					[指導教員:],
					[#supervisor.family-name #supervisor.given-name],
			)
		]
	]
	pagebreak()

	set heading(numbering: "1.")

	show outline.entry.where(
		level: 1
	): set block(above: 1.5em)

	// level 1ヘッダーの更新時のみ変更
	show heading.where(level: 1): it => {
		counter(math.equation).update(0)
		counter(figure.where(kind: image)).update(0)
		counter(figure.where(kind: table)).update(0)
		counter(figure.where(kind: raw)).update(0)
		it
	}

	set math.equation(
		numbering: num =>
			numbering("(1.1)", counter(heading).get().first(), num),
			supplement: none,
	)

	set figure(
		numbering: num =>
			numbering("1.1", counter(heading).get().first(), num)
	)

	// 引用文の左に線を引く
	set quote(block: true)
	show quote.where(block: true): block.with(
		stroke: (left: 2pt + blue, rest: none),
	)

	show link: set text(fill: blue)

	// まず「3バッククォート以上なら必ず block 表示」に
	set raw(block: true)

	// GPT ライトテーマ風
	show raw.where(block: true): block.with(
		fill: rgb("#f6f8fa"),
		inset: (x: 12pt, y: 8pt),
		radius: 4pt,
	)

	// インラインコードも色を合わせたい場合
	show raw.where(block: false): box.with(
		fill: rgb("#f6f8fa"),
		inset: (x: 3pt, y: 1pt),
		radius: 3pt,
	)

	// 参照したときだけ数式番号を付与
	show math.equation: it => {
		if it.block and not it.has("label") [
			#counter(math.equation).update(v => v - 1)
			#math.equation(it.body, block: true, numbering: none)#label("_rgt-skip-eq")
		] else {
		it
		}
	}

	// --- 目次（本文ページ数に含めない） ---
	outline(
		title: "目次",
	)

	pagebreak()
	// --- 本文開始: ページ番号を1にリセット。内規の「6ページ超」はこの番号で数える ---
	counter(page).update(1)
	set page(numbering: "1")
	doc
}
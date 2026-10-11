#import "@preview/physica:0.9.6": *
#import "@preview/hydra:0.6.2": hydra

#let jarticle(
	fontsize: none,
	title: none,
	authors: none,
	date: none,
	body,
) = {
	// フォントは各自お好みで設定すること
	let roman = "CMU Serif"
	let mincho = "Harano Aji Mincho"
	let kakugothic = "BIZ UDPGothic"
	
	set document(author: authors, title: title)
	set page(
		paper: "a4",
		margin: (inside: 25mm, outside: 15mm, top: 30mm, bottom: 20mm), // ここで余白を調整できる
		numbering: none,
		header: context {
			if calc.even(here().page()) {
				text([#counter(page).display() #h(1fr) #hydra(1)])
			} else {
				text([#hydra(2) #h(1fr) #counter(page).display()])
			}
			line(length: 100%)
		}
	)

	set text(lang: "ja", font: (roman, mincho), fontsize)
	set par(justify: true, leading: 0.9em, first-line-indent: 1em)
	set block(spacing: 0.9em)
	set heading(numbering: "1.1  ", supplement: [])
	set footnote(numbering: sym.dagger + "1")
	set image(width: 60%)

	show heading: it => {
		set text(font: (roman, kakugothic, mincho), size: 1.1em)
		it
		v(0.3em)
	}

	show footnote.entry: it => {
		grid(
			columns: (auto, 1fr),
			gutter: 1em,
			numbering(sym.dagger + "1", ..counter(footnote).at(it.note.location())),
			it.note.body
		)
	}

	show strong: set text(font: (roman, kakugothic, mincho))
	show emph: set text(font: (roman, mincho))

	set figure(placement: bottom) // ここで図表の位置のアルゴリズムを指定できる
	set figure(numbering: num => {
		let chapter_num = counter(heading).get().first()
		if chapter_num == none { chapter_num = 1 }
		numbering("1.1", chapter_num, num)
	})
	set figure.caption(separator: [ --- ])
	show figure: set block(inset: (bottom: 1em, top: 1em))
	show figure.where(kind: table): set figure.caption(position: top)

	show heading.where(level: 1): it => {
		counter(math.equation).update(0)
		counter(figure.where(kind: image)).update(0)

		let chapter_numbering = it.numbering
		let chapter_title = it.body

		set text(font: (roman, kakugothic, mincho))
		set par(first-line-indent: 0em)

		if chapter_numbering != none {
			let chapter_num = counter(heading).at(it.location())
			let display_number = if type(chapter_numbering) == function {
				chapter_numbering(..chapter_num)
			} else {
				numbering("第 1 章", chapter_num.at(0))
			}
			block([
				#text(
					size: 1.4em,
					weight: "bold",
					fill: black,
					display_number,
				)

				#text(
					size: 2.0em,
					weight: "bold",
					fill: black,
					chapter_title,
				)
				#v(2em)
			])
		} else {
			block([
				#text(
					size: 2.0em,
					weight: "bold",
					fill: black,
					chapter_title,
				)
				#v(2em)
			])
		}
	}
	set math.equation(numbering: num => "(" + str(counter(heading).get().at(0)) + "." + str(num) + ")")

	show outline.entry.where(level: 1): it => {
		v(0.5em)
		strong(it)
	}

	align(left)[
		#show heading: set text(size: 1.2em)
		#outline(indent: 1.5em)
	]

	show heading.where(level: 1): it => {
		pagebreak()
		it
	}
	
	// 句読点を自動的にコンマピリオドに変換
	// 不要な場合は削除すること
	show "、": "，"
	show "。": "．"

	body
}

// Appendixの設定
#let appendix(body) = {
	set heading(
		numbering: (..nums) => {
			let vals = nums.pos()
			let value = "ABCDEFGHIJ".at(vals.at(0) - 1)
			if vals.len() == 1 {
				return "Appendix " + value + "  "
			}
			else {
				return value + "." + nums.pos().slice(1).map(str).join(".") + "  "
			}
		}
	)
	counter(heading).update(0)
	set figure(numbering: num => {
		let vals = counter(heading).get()
		let chapter_num = vals.at(0)
		let letter = "ABCDEFGHIJ".at(chapter_num - 1)
		[#letter.#num]
	})
	set math.equation(numbering: num => {
		let chapter_num = counter(heading).get().at(0)
		let letter = "ABCDEFGHIJ".at(chapter_num - 1)
		"(" + letter + "." + str(num) + ")"
	})
	body

}

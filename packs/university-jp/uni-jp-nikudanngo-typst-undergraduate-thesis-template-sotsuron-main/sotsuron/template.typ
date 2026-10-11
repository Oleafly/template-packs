#let sans = ("Noto Sans JP")
#let serif = ("Noto Serif JP")

// text setting
#set text(font: serif, 12pt)
#set par(justify: true, first-line-indent: 1em, spacing: 0.65em)

// 図表キャプションのカスタマイズ
#let figcaption = (caption) => figure(caption: caption)
#let tblcaption = (caption) => table(caption: caption)

#let hanko = (name) => [
	#let nameLen = name.len()
	#box([
	#text("印", size: 0.8em, font: serif)
		#place(
			center+horizon,
		[
		#circle(
			radius: nameLen * 0.4em,
			inset: 0pt,
			stroke: 1.6pt + red,
			[
				#set par(leading: 0.1em)
				#text(name.join("\n"), fill:red, size: 16pt, font: serif, weight: "bold", spacing: 0.1em)
				]
			)
		])
	])
]

#let titlePage(
	year: "2024",
	title: "タイトル",
	university: "大阪工業大学",
	faculty: "学部",
	department: "学科",
	lab: "研究室",
	name: "名前",
	supervisor: "指導教員",
	hankoName: "先生",
	doc
) = {
	set par(justify: true, first-line-indent: 1em)
	set page(margin: (
		top: 100mm, 
		bottom: 20mm, 
		left: 20mm, 
		right: 20mm
	))

	// フォントサイズの設定
	set text(size: 18pt, weight: "medium", font: serif)
	align(center + horizon)[
		#text(size: 14pt, [#year 年度 卒業論文])
		#v(1em)
		// titleのアルファベットはserif、それ以外はsans
		#set text(size: 28pt, font: sans)
		#show regex("[a-zA-Z]+"): set text(font: serif)
		#title
		#set text(font: serif, size: 18pt)
		#v(4em)
		#university
		#department\
		#faculty\
		#lab\
		
		#text(size: 24pt, [#name])\
		#v(2em)
		指導教員
		#v(0.2em)
		#text([#supervisor])#h(1em)
		#hanko(hankoName)
	]
	pagebreak()
	set page(
		margin: (
			top: 25mm, 
			bottom: 20mm, 
			left: 20mm, 
			right: 20mm
		),
		numbering: "1"
	)
	set text(font: serif, size: 12pt)
	// headingが長いと、二行目以降のインデントが左寄せになり、行間の....の表示がおかしくなる場合がある
	// https://forum.typst.app/t/how-to-fix-the-bug-for-outline-entries-with-long-titles/707/2
	show outline.entry.where(
		level: 1,
	): it => {
		set text(weight: "bold", size: 12pt)
		v(1.5em, weak: true)
		it
	}
	outline(
		title: [#text(size: 1.3em, font: sans,weight: "medium", "目次") #v(2em)], 
		indent: 2em,
	)
	pagebreak()
	doc
}

#let mainPage(doc) = {
	set math.equation(numbering: "(1)")
	set text(lang: "ja", font: serif, size: 12pt, weight: "regular")
	set ref(supplement: none)
	set par(justify: true, first-line-indent: 1em, spacing: 0.65em)
	set heading(numbering: "1.1 ")
	show heading.where(level: 1): set heading(numbering: "第1章 ")
	show heading.where(level: 1): it => [
		#set text(weight: "semibold", size: 1.4em)
		#linebreak()
		#it
	]
	show heading.where(level: 2): it => [
		#set text(weight: "semibold", size: 1.2em)
		#it
	]
	show heading.where(level: 3): it => [
		#set text(weight: "semibold", size: 1.1em)
		#it
	]
	show heading: it => [
		#show regex("a-zA-Z1-9"): set text(font: serif)
		#show regex("[^a-zA-Z1-9]"): set text(font: sans)
		#it
    #par(text(size: 0pt, ""))
  ]
	set list(indent: 2em , spacing: 1.5em,marker: ([#sym.circle.filled.tiny]))
	set enum(indent: 2em, spacing: 1.5em)
	show list.where() : it => [
		#v(0.5em)
		#it
		#v(0.5em)
	]
	show enum.where() : it => [
		#v(0.5em)
		#it
		#v(0.5em)
	]
	show figure.where(
  	kind: table
	): set figure.caption(position: top)
	
	show figure.where() : it => [
		#v(0.5em)
		#it
		#v(0.5em)
	]

	show math.equation.where() : it => [
		#if(it.block){
			v(0.5em)
			it
			v(0.5em)
		}else{
			it
		}
	]
	doc
}

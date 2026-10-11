#import "@preview/mannot:0.3.0": markhl
#import "@preview/showybox:2.0.4": showybox

// Enhanced color palette
#let colors = (
  dark: (
    bg: rgb("#0f1419"),
    fg: rgb("#bfbdb6"),
    primary: rgb("#39bae6"),
    secondary: rgb("#ffb454"),
    accent: rgb("#c678dd"),
    success: rgb("#95e454"),
    warning: rgb("#f29718"),
    error: rgb("#f07178"),
    muted: rgb("#5c6773")
  ),
  light: (
    bg: rgb("#fafafa"),
    fg: rgb("#575279"),
    primary: rgb("#286983"),
    secondary: rgb("#ea9d34"),
    accent: rgb("#907aa9"),
    success: rgb("#56949f"),
    warning: rgb("#b4637a"),
    error: rgb("#d7827e"),
    muted: rgb("#9893a5")
  )
)

// Utility function to get theme colors
#let get-colors(theme: "dark") = {
  if theme == "light" { colors.light } else { colors.dark }
}

#let elegantmath-box(
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#39bae6"),
	inset: 1.5em,
	radius: 8pt,
	thickness: 1.5pt,
	title: [],
	shadow: true,
	body
) = {
	let shadow-offset = if shadow { (x: 2pt, y: 2pt) } else { (x: 0pt, y: 0pt) }
	
	showybox(
		breakable: true,
		frame: (
			border-color: emph-color,
			title-color: bg-color.lighten(5%),
			body-color: bg-color,
			inset: inset,
			radius: radius,
			thickness: thickness
		),
		title-style: (
			color: emph-color,
			weight: "bold",
			sep-thickness: 1pt
		),
		body-style: (color: fg-color),
		title: title,
		shadow: (
			offset: shadow-offset,
			color: rgb("#000000").transparentize(80%)
		)
	)[
		#body
	]
}



#let elegantmath-title(
	title: "Math",
	subtitle: "Notes and Solutions",
	subsubtitle: "Algebra",
	number: "1",
	author: none,
	email: none,
	date: none,
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#39bae6"),
	theme: "dark"
) = {
	let theme-colors = get-colors(theme: theme)
	
	align(horizon)[
		#elegantmath-box(
			bg-color: bg-color,
			fg-color: fg-color,
			emph-color: emph-color,
			inset: 2.5em,
			radius: 12pt,
			shadow: true,
			title: [
				#grid(
					columns: (1fr, auto),
					align: (left, right),
					[
						#text(size: 32pt, weight: "bold")[#title] \
						#text(size: 20pt, fill: theme-colors.secondary)[#subtitle]
					],
					[
						#text(size: 24pt, weight: "bold", fill: emph-color)[#number]
					]
				)
				#line(length: 100%, stroke: (paint: emph-color, thickness: 2pt))
				#text(size: 16pt, fill: theme-colors.muted)[#subsubtitle]
			]
		)[
			#if author != none or email != none or date != none [
				#grid(
					columns: (1fr, auto),
					align: (left, right),
					gutter: 1em,
					[
						#if author != none [
							#text(size: 14pt, weight: "medium")[
								Por: #text(fill: emph-color)[#author]
							]
						]
						#if email != none [
							#text(size: 12pt)[
								#link("mailto:" + email)[#email]
							]
						]
					],
					[
						#if date != none [
							#text(size: 12pt, fill: theme-colors.muted)[#date]
						] else [
							#text(size: 12pt, fill: theme-colors.muted)[
								#datetime.today().display("[day]/[month]/[year]")
							]
						]
					]
				)
			]
		]
	]
}



#let elegantmath-outline(
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#39bae6"),
	theme: "dark"
) = {
	let theme-colors = get-colors(theme: theme)
	
	elegantmath-box(
		bg-color: bg-color,
		fg-color: fg-color,
		emph-color: emph-color,
		title: [
			#text(size: 20pt, weight: "bold")[Índice]
		]
	)[
		#outline(title: none, indent: auto)
	]
}

// New component: Info box
#let elegantmath-info(
	type: "info", // info, warning, error, success
	title: none,
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	theme: "dark",
	body
) = {
	let theme-colors = get-colors(theme: theme)
	
	let (icon, color) = if type == "warning" {
		("⚠", theme-colors.warning)
	} else if type == "error" {
		("✗", theme-colors.error)
	} else if type == "success" {
		("✓", theme-colors.success)
	} else {
		("i", theme-colors.primary)
	}
	
	elegantmath-box(
		bg-color: bg-color,
		fg-color: fg-color,
		emph-color: color,
		radius: 6pt,
		title: if title != none [
			#icon #h(0.5em) #title
		] else [
			#icon #h(0.5em) #upper(type)
		]
	)[
		#body
	]
}

// New component: Definition box
#let elegantmath-definition(
	term: "",
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#c678dd"),
	body
) = {
	elegantmath-box(
		bg-color: bg-color,
		fg-color: fg-color,
		emph-color: emph-color,
		title: [Definição: #text(weight: "bold")[#term]]
	)[
		#body
	]
}

// New component: Theorem box
#let elegantmath-theorem(
	name: "",
	number: none,
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#95e454"),
	body
) = {
	let title-text = if number != none [
		Teorema #number
	] else [
		Teorema
	]
	
	if name != "" {
		title-text += [: #text(weight: "bold")[#name]]
	}
	
	elegantmath-box(
		bg-color: bg-color,
		fg-color: fg-color,
		emph-color: emph-color,
		title: title-text
	)[
		#body
	]
}



#let elegantmath(
	title: "Math",
	subtitle: "Notes and Solutions",
	subsubtitle: "Algebra",
	number: "1",
	author: none,
	email: none,
	date: none,
	font: "New Computer Modern",
	theme: "dark",
	bg-color: none,
	fg-color: none,
	emph-color: none,
	show-outline: true,
	body
) = {
	// Get theme colors or use custom colors
	let theme-colors = get-colors(theme: theme)
	let final-bg = if bg-color != none { bg-color } else { theme-colors.bg }
	let final-fg = if fg-color != none { fg-color } else { theme-colors.fg }
	let final-emph = if emph-color != none { emph-color } else { theme-colors.primary }
	
	set text(
		fill: final-fg,
		font: font,
		size: 11pt
	)

	set page(
		fill: final-bg,
		numbering: "1",
		margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),
		header: context [
			#if counter(page).get().first() > 1 [
				#set text(size: 9pt, fill: theme-colors.muted)
				#grid(
					columns: (1fr, auto, 1fr),
					align: (left, center, right),
					[#title],
					[#line(length: 3cm, stroke: (paint: theme-colors.muted, thickness: 0.5pt))],
					[#subtitle]
				)
			]
		],
		footer: context [
			#set align(center)
			#set text(fill: final-emph, size: 10pt, weight: "medium")
			#counter(page).display("1")
		]
	)

	// Enhanced math settings
	set math.equation(numbering: "(1)")
	show math.equation: set text(size: 12pt)

	set heading(numbering: "1.1")
	show heading: it => {
		set text(fill: final-emph, weight: "bold")
		if it.level == 1 {
			pagebreak(weak: true)
			v(1em)
			block(
				fill: final-emph.transparentize(90%),
				inset: 1em,
				radius: 8pt,
				width: 100%
			)[
				#set text(size: 18pt)
				#it
			]
			v(0.5em)
		} else if it.level == 2 {
			v(1em)
			block(
				stroke: (left: 3pt + final-emph),
				inset: (left: 1em, y: 0.5em)
			)[
				#set text(size: 14pt)
				#it
			]
			v(0.5em)
		} else {
			v(0.5em)
			it
			v(0.3em)
		}
	}

	// Enhanced lists
	set list(marker: [▸])
	set enum(numbering: "1.")

	elegantmath-title(
		title: title,
		subtitle: subtitle,
		subsubtitle: subsubtitle,
		number: number,
		author: author,
		email: email,
		date: date,
		bg-color: final-bg,
		fg-color: final-fg,
		emph-color: final-emph,
		theme: theme
	)

	pagebreak()

	if show-outline {
		set outline.entry(fill: none)
		elegantmath-outline(
			bg-color: final-bg,
			fg-color: final-fg,
			emph-color: final-emph,
			theme: theme
		)
		pagebreak()
	}

	body
}



#let elegantmath-problem(
	title: none,
	level: 3,
	difficulty: none, // easy, medium, hard
	points: none,
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#39bae6"),
	theme: "dark",
	numbering: "a.",
	page-break: true,
	question,
	solution
) = {
	let theme-colors = get-colors(theme: theme)
	
	// Difficulty indicators
	let difficulty-info = if difficulty != none {
		let (symbol, color) = if difficulty == "easy" {
			("●", theme-colors.success)
		} else if difficulty == "medium" {
			("●", theme-colors.warning)
		} else if difficulty == "hard" {
			("●", theme-colors.error)
		} else {
			("○", theme-colors.muted)
		}
		h(0.5em) + text(fill: color)[#symbol #upper(difficulty)]
	} else { none }
	
	let points-info = if points != none {
		h(0.5em) + text(fill: theme-colors.secondary)[★ #points pts]
	} else { none }
	
	elegantmath-box(
		bg-color: bg-color,
		fg-color: fg-color,
		emph-color: emph-color,
		radius: 8pt,
		thickness: 2pt,
		title: [
			#grid(
				columns: (1fr, auto),
				align: (left, right),
				[
					#if title != none [
						#heading(level: level, outlined: false)[Problema: #title]
					] else [
						#heading(level: level, outlined: false)[Problema]
					]
				],
				[
					#difficulty-info
					#points-info
				]
			)
			#v(-0.5em)
			#line(length: 100%, stroke: (paint: emph-color.transparentize(60%), thickness: 1pt))
			#v(0.3em)
			#text(fill: fg-color)[#question]
		]
	)[
		#text(weight: "medium")[Solução:]
		#v(0.3em)
		#set enum(numbering: numbering)
		#solution
	]

	if page-break {
		pagebreak(weak: true)
	}
}

// Enhanced final answer highlighting
#let elegantmath-final(
	body,
	color: none,
	theme: "dark"
) = {
	let theme-colors = get-colors(theme: theme)
	let final-color = if color != none { color } else { theme-colors.accent }
	
	rect(
		fill: final-color.transparentize(85%),
		stroke: (paint: final-color, thickness: 2pt),
		radius: 6pt,
		inset: 0.8em
	)[
		#set text(weight: "bold", fill: final-color)
		#body
	]
}

// New component: Step-by-step solution
#let elegantmath-steps(
	steps,
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#ffb454"),
	theme: "dark"
) = {
	let theme-colors = get-colors(theme: theme)
	
	elegantmath-box(
		bg-color: bg-color,
		fg-color: fg-color,
		emph-color: emph-color,
		title: [Passos da Solução]
	)[
		#for (i, step) in steps.enumerate() [
			#box(
				fill: emph-color.transparentize(90%),
				radius: 50%,
				inset: 0.4em,
				baseline: 0.2em
			)[
				#text(weight: "bold", fill: emph-color)[#(i + 1)]
			]
			#h(0.5em)
			#step
			#if i < steps.len() - 1 [ #v(0.5em) ]
		]
	]
}

// New component: Code highlighting
#let elegantmath-code(
	language: none,
	caption: none,
	bg-color: rgb("#0f1419"),
	fg-color: rgb("#bfbdb6"),
	emph-color: rgb("#39bae6"),
	body
) = {
	elegantmath-box(
		bg-color: bg-color.darken(5%),
		fg-color: fg-color,
		emph-color: emph-color,
		title: if caption != none [
			Código: #caption
		] else [
			Código
		]
	)[
		#set text(font: "Fira Code", size: 10pt)
		#body
	]
}

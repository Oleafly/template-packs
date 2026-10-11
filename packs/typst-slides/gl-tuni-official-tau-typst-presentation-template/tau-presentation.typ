/**
 *
 * Contains a template function the defines the appearance of a typst document.
 *
***/

// Constants.

#let tunipurple = rgb(78,0,148)

#let pagemargin = 0.3cm

// Global state variables.

#let FRAMECOUNTER = counter("FRAMECOUNTER")

/** title-page
 *
 * A function that typesets the title page of this presentation.
 *
***/

#let title-page(
	authors,
	main-title,
	subtitle,
	invert-title-page-colors,
) = page(
	fill: if invert-title-page-colors { tunipurple } else { white },
	numbering: "*",
	number-align: bottom+right,
	footer:[],
	margin: (
		top: 2cm,
		left: 1cm,
		right: 1cm,
		bottom: 1cm,
	),
	background: place(
		image(
			if invert-title-page-colors {
				"images/tau-logo-fin-eng-inv.svg"
			} else {
				"images/tau-logo-fin-eng.svg"
			},
			height: 2cm,
		)
	)
)[

	#set par(justify:false)

	#set align(left+top)

	#set text(
		fill : if invert-title-page-colors { white } else { tunipurple },
		hyphenate:false
	)

	#v(0.5fr)

	#set text(size:12pt)

	#title[
		#main-title

		#context if subtitle != none {
			set text(size:text.size - 3pt)
			subtitle
		}
	]

	#v(1fr)

	#assert( type(authors) == array, message: "Authors must be given as an array of dictionaries." )

	#assert( authors.all( a => type(a) == dictionary ), message: "Author array contained non-dictionary elements." )

	#assert( authors.len() >= 1, message: "There must be at least 1 author." )

	#set text(size: 12pt)

	#grid(
		inset: (
			top: 0.4em,
			left: 0pt,
			right: 0pt,
			bottom: 0pt,
		),
		authors.first().name + if authors.len() > 1 {" et al."} else {""},
		authors.first().organization,
		authors.first().email,
	)
]

/** tau-presentation
 *
 * Defines the layout of a Tampere University presentation.
 *
***/

#let tau-presentation(
	authors : (
		name : "Author",
		email:"author@email.org",
		organization : "Organization"
	),
	main-title: "Title",
	subtitle: none,
	keywords : (),
	presentation-date: datetime.today(),
	enumMarkers:("1.","a."),
	listMarkers: ([‣],[•],[–]),
	invert-title-page-colors: true,
	text-font: "Luciole",
	math-font: "Luciole Math",
	raw-font: "Fira Mono",
	show-code-line-numbers: true,
	global-font-size: 14pt,
	language: "en",
	description: "",
	doc
) = {

	set document(
		author : authors
			.map(a => a.name + " @ " + a.organization + " (" + a.email + ")")
			.join(", "),
		title : main-title,
		keywords : keywords,
		description: description,
	)

	set text(lang:language)

	set page(
		width:16cm,
		height : 9cm,
		numbering:"1/1",
		number-align: bottom + right,
		footer: context [
			#set align(right)
			#set text(fill:tunipurple,size:0.4cm)
			#let pagenum = counter(page).get().last()
			#let finalpagenum = counter(page).final().last()
			#if pagenum == 0 [] else [ #presentation-date.display() | #pagenum / #finalpagenum ]
		],
		margin: (
			top: pagemargin,
			bottom:0.8cm,
			left:pagemargin,
			right: pagemargin,
		)
	)

	let markerN = listMarkers.len()

	set list( marker: it => [#set text(fill:tunipurple);#listMarkers.at(calc.rem(it,markerN))] )

	let enumMarkN = enumMarkers.len()

	set enum( numbering: (..args) => {
		set text(fill:tunipurple)
		let argarray = args.pos()
		let argN = argarray.len()
		let nn = argarray.last()
		let markerI = calc.rem(argN+1,enumMarkN)
		let pattern = enumMarkers.at(markerI)
		numbering(pattern,nn)
	} )


	set par(
		leading: 0.55em,
		justify: true,
	)

	set text(font: text-font, size: global-font-size)

	show link: it => {
		set text( fill: rgb("#0038FF") )
		it
	}

	show cite: it => {
		set text( fill: tunipurple )
		it
	}

	show raw: set text(font: raw-font)

	show heading: set block(above: 1.4em, below: 1em)

	set math.equation(
		numbering : "(1)",
		supplement: none
	)

	show math.equation: set text( font: math-font )

	// Show equation references like they are on equation
	// lines.

	show ref: it => {
		set text(fill:tunipurple)
		let eq = math.equation
		let el = it.element
		if el != none and el.func() == eq {
			let eloc = el.location()
			// Override equation references.
			link(
				eloc,
				{
					set text(fill:tunipurple)
					math.equation(
						numbering(
							el.numbering,
							..counter(eq).at(el.location()),
						)
					)
				}
			)
		} else {
			// Other references as usual.
			it
		}
	}

	set math.vec(delim:"[")

	set math.mat(delim:"[")

	title-page(
		authors,
		main-title,
		subtitle,
		invert-title-page-colors
	)

	show raw.where( block : false ) : it => {
		box(
			inset : (x : 0.2 * 15pt),
			outset : (y : 0.2 * 15pt),
			fill : rgb(250, 251, 249),
			radius : 0.25 * 15pt,
			it
		)
	}

	show raw.where( block : true ): it => {
		let lastLine = it.lines.last()
		let numberColumnWidth = if lastLine.count < 10 {
			0.7em
		} else {
			calc.floor(calc.log(lastLine.count, base:10)) * 1em
		}
		block(width: 100%, inset: 0.5em, fill: luma(252))[
			#set align(left)
			#grid(
				columns: (numberColumnWidth, 1fr),
				align: (right,left),
				row-gutter:0.7em,
				column-gutter: 0.5em,
				.. for line in it.lines {
					if line.number < line.count {
						(text(fill: gray, str(line.number)), line.body)
					} else if line.number == line.count and line.text.trim() != "" {
						(text(fill: gray, str(line.number)), line.body)
					} else {
						none
					}
				}
			)
		]

	}

	show emph: it => {
		set text(fill:tunipurple,style:"italic",weight: "regular")
		it.body
	}

	show math.equation.where(block: false): box

	doc
}

/** frame
 *
 * Typesets a frame that fills an entire page and spans multiple pages, if the
 * content does not fit onto a single page.
 *
***/

#let FRAMECOUNTER = counter("FRAMECOUNTER")

#let frame(
	alignment:left,
	textsize:13pt,
	frame-title,
	content
) = context {
	FRAMECOUNTER.step()
	let current-frame-counter-val = FRAMECOUNTER.get().last()
	let frame-start-str = "frame-" + str(current-frame-counter-val) + "-start"
	let frame-end-str = "frame-" + str(current-frame-counter-val) + "-end"
	[ #pagebreak(weak:true)#label(frame-start-str) ]
	let FRAMEREPEATCOUNTER = counter("FRAMEREPEATCOUNTER")
	FRAMEREPEATCOUNTER.update(0)
	[
		#grid(
			columns: 1,
			stroke: none,
			row-gutter: 0.5cm,
			grid.header[
				#FRAMEREPEATCOUNTER.step()
				#let text-size = 0.6cm
				#set text(
					fill: tunipurple,
					size: text-size - 0.1cm,
				)
				#context [
					#let frc = FRAMEREPEATCOUNTER.get().last()
					#let ffrc = FRAMEREPEATCOUNTER.at(label(frame-end-str)).last()
					#show heading: set text(
						fill: tunipurple,
						weight: "regular",
						size: text-size,
					)
					#let titletext = if ffrc > 2 [
						#grid(
							columns: (auto, 1fr,auto),
							column-gutter: 0.2cm,
							align: (top + left, center + top, top + right),
							heading(level: 1, frame-title),
							[],
							[(#frc/#(ffrc - 1))]
						)
					] else [
						#heading(level: 1, frame-title)
					]
					#titletext
				]
			],
			[
				#set align(alignment)
				#set text(size:textsize)
				#content
			],
		)
		#FRAMEREPEATCOUNTER.step()
		#label(frame-end-str)
	]
}

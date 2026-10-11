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

#let title-page(authors,title,subtitle,invert-title-page-colors) = page(
	fill: if invert-title-page-colors { tunipurple } else { white },
	numbering: "*",
	number-align: bottom+right,
	footer:[]
)[

	#let logofile = if invert-title-page-colors {
		"images/tau-logo-fin-eng-inv.svg"
	} else {
		"images/tau-logo-fin-eng.svg"
	}

	#set par(justify:false)

	#place(top + left, dx:-pagemargin,dy:-pagemargin)[#image(logofile,width:4cm)]

	#place(top + right, dx:2.8*pagemargin,dy:-2.5*pagemargin)[#image("images/FAME-logo.svg",width:4cm)]

	#set align(center)

	#set text(
		fill : if invert-title-page-colors { white } else { tunipurple },
		hyphenate:false
	)

	#set text(size:0.9cm)

	#v(1.5fr,weak:true)

	#title

	#v(1fr,weak:true)

	#set text(size:0.65cm)

	#subtitle

	#v(1fr,weak:true)

	#assert( type(authors) == array, message: "Authors must be given as an array of dictionaries." )

	#assert( authors.all( a => type(a) == dictionary ), message: "Author array contained non-dictionary elements." )

	#assert( authors.len() >= 1, message: "There must be at least 1 author." )

	#if authors.len() > 3 or authors.len() == 1 [
		#set text(size:0.5cm)
		#if authors.len() > 3 [
			#authors.first().name et al.\
		] else [
			#authors.first().name\
		]
		#authors.first().organization\
		#authors.first().email
	] else {
		set text(size:0.45cm)
		for author in authors {
			let name = author.at("name", default:none)
			if name == none { panic("An author must have at least a name.") }
			let email = author.at("email", default:none)
			let organization = author.at("organization", default:none)
			box(inset:0.3em)[
				#name\
				#if not organization == none [#organization\ ]
				#if not email == none [#email\ ]
			]
		}
	}
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
	title: "Title",
	subtitle: "Subtitle",
	keywords : (),
	presentation-date: datetime.today(),
	enumMarkers:("1.","a."),
	listMarkers: ([‣],[•],[–]),
	invert-title-page-colors: true,
	text-font: "New Computer Modern",
	math-font: "New Computer Modern Math",
	raw-font: "Fira Mono",
	show-code-line-numbers: true,
	global-font-size: 14pt,
	language: "en",
	doc
) = {

	set document(
		author : authors.map(a => a.name).join(", "),
		title : title,
		keywords : keywords,
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
			#if pagenum == 0 [] else [ #presentation-date.display() | #pagenum/#finalpagenum ]
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


	set par(leading: 0.55em, justify: true)

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

	show par: set par(spacing: 0.55em)

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
				[
					#set text(fill:tunipurple)
					#math.equation( numbering(
						el.numbering,
						..counter(eq).at(el.location())
					) )
				]
			)
		} else {
			// Other references as usual.
			it
		}
	}

	set math.vec(delim:"[")
	set math.mat(delim:"[")

	counter(page).update(1)

	title-page(authors,title,subtitle,invert-title-page-colors)

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
		show raw.line: it => [
			#if show-code-line-numbers {
				box(width : 6%)[
					#set text(fill:luma(120))
					#align( right )[#it.number]
				]
				h(2%)
			}
			#it.body
		]
		align(
			left,
			block(
				radius : 0.2cm,
				width: 100%,
				fill: rgb(250, 251, 249),
				inset: 0.1em,
				it
			)
		)
	}

	show emph: it => {
		set text(fill:tunipurple,style:"normal",weight:"bold")
		it.body
	}

	doc
}

/** frame
 *
 * Typesets a frame that fills an entire page and spans multiple pages, if the
 * content does not fit onto a single page.
 *
***/

#let FRAMECOUNTER = counter("FRAMECOUNTER")

#let frame(alignment:center,textsize:14pt,title,content) = context {
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
			gutter: 0.3cm,
			grid.header[
				#FRAMEREPEATCOUNTER.step()
				#set align(left)
				#set text(fill:tunipurple,size:0.7cm)
				#context [
					#let frc = FRAMEREPEATCOUNTER.get().last()
					#let ffrc = FRAMEREPEATCOUNTER.at(label(frame-end-str)).last()
					#let titletext = if ffrc > 2 [
						#title#h(1fr)
						#set text(size:0.5cm)
						#[(#frc/#(ffrc - 1))]
					] else [
						#title
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

#let document(body) = {
	set text(
		font: "New Computer Modern"
	)
	set page(
		paper: "a4",
		numbering: none,
		margin: (
			top: 1in,
			bottom: 1in,
			left: 1in,
			right: 1in,
		)
	)
	body
}

#let makebold(x) = {
	set text(weight: "bold")
	x
}

#let scale_large = scale.with(120%)
#let scale_huge  = scale.with(180%)

#let front_default_title(title: []) = {
	let u = 82%
	(
		line(length: u),
		[#scale_huge[#upper(title)\ ]],
		line(length: u),
	)
}

#let front_full(
	faculty: [],
	subtitle: [],
	title: (),
	authors: (),
	x
) = {
	set page()
	set align(center)
	[ #upper[Vietnam National University - Ho Chi Minh City]\
		#upper[Ho Chi Minh City University of Technology]\
		#upper[Faculty of #faculty]\
		#v(1cm)
		#image("bach-khoa-0.typ.logoHCMUT.png", width: 3cm)\
		#v(1cm)
		#makebold[#table(
			columns: (1fr),
			stroke: none,
			align: center,
			[#scale_large[#upper(subtitle)\ ]],
			..title
		)]
	]
	pagebreak()
	set align(left)
	x
}

#let front(
	faculty: [],
	subtitle: [],
	title: [],
	authors: (),
	x
) = {
	front_full(
		faculty: faculty,
		subtitle: subtitle,
		title: front_default_title(title: title),
		authors: authors,
		x
	)
}

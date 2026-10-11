#let bg = rgb("#0000ff")
#let fg = rgb("#ffffff")
#let hi = rgb("#ffff00")
#let er = rgb("#ff0000")

#let board(time, title, content) = [
	#set text(
		font: "ModeSeven",
		size: 18pt,
		hi
	)
	#set page(
		width: 20cm,
		height: 15cm,
		margin: (top: 48pt, bottom: 26pt, left: 0.4cm, right: 0.4cm),
		fill: black,
		header: rect(fill: bg)[
			#set text(hi, 36pt)
			#title
			#h(1fr)
		],
		header-ascent: 0%,
		footer: context rect(fill: bg)[
			#set text(hi, 18pt)
			Page #counter(page).display("1 of 1", both: true)
			#h(1fr)
			Time Now is #time.display("[hour]:[minute]:[second]")
		],
		footer-descent: 0%,
	)
	#set table(
		stroke: (x, y) => if y == 0 {
			(bottom: 2pt + white)
		} else {
			(none)
		},
		gutter: 0pt,
		fill: (x, y) => (
			if y == 0 {
				rgb("#0000ff")
			} else {
				black
			}
		),
		align: (x, y) => (
			if x == 2 {
				center 
			} else {
				left
			}
		)
	)
	#show table.cell: it => {
		if it.y == 0 {
			set text(fg)
			it
		} else if it.x == 1 {
			set text(hi)
			it
		} else {
			set text(fg)
			it
		}
	}

	#show "Cancelled": [
		#set text(er)
		Cancelled
	]

	#show "Delayed": [
		#set text(hi)
		Delayed
	]

	#set table(
		columns: (auto, 1fr, auto, auto),	
	)

	#content
]

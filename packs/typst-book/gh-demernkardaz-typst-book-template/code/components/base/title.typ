#import "../../plugin/lib.typ": *
#let typst-title = title

#let title(
	foretitle: "Foretitle",
	title: "Title",
	author: "Author",
	publisher: ("Publisher", "Origin", v(2em), 2026),
	publisher-spacing: 1em
) = {
	place(
		center + horizon,
		foretitle
	)

	pagebreak()

	place(center, typst-title(author))
	place(center + horizon,
		text(size: 18pt)[#typst-title(title)]
	)
	place(center + bottom, stack(
		dir: ttb,
		spacing: publisher-spacing,
		..publisher.map(item => {
			if type(item) == int or type(item) == float {
				str(item)
			} else {
				item
			}
		})
	))

	pagebreak()
}

#title()

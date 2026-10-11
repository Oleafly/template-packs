#let frontPage(title:[], subtitle:[], author:[], authorFont:"")= context {
	grid(
	  rows: (1fr, auto, 1fr),
	  columns: 1fr,
	  align: center + horizon,

	  [
	    #text(
	      size: 22pt,
	      weight: "bold",
	    )[#title]
	    #v(1pt)
	    #text(size:16pt)[#subtitle]
	  ],

	  [#image("../media/uji-transparent.png", width: 60%)],
	  [
	    #text(font: "Cascadia Mono", style: "italic", fill: text.fill.transparentize(50%))[Author:]\
	    #text(font: "Cascadia Mono", style: "italic", size: 12pt)[#author]
	  ]
	)
	pagebreak()
	counter(page).update(1)

}
// -- Front page --
#let script-size-rel = 0.75;
#let footnote-size-rel = 0.933;
#let small-size-rel = 0.90;

#let apa-paper(
	title: "Paper Title",
	running-head: "RUNNING HEAD",
	subtitle: "subtitle",
	first-page-omits-running-head: true,
	abstract: none,
	keywords: (),
	authors: (),
	affiliation: [],
	bibliography-file: none,
	fontname: "Times New Roman",
	normal-size: 12pt,
	script-size: none,
	footnote-size: none,
	small-size: none,
	paper-size: "us-letter",
	margin-left: none,
	margin-right: none,
	margin-top: none,
	margin-bottom: none,
	body
) = {
	// get font sizes!
	let scr-sz = if small-size == none { normal-size * script-size-rel } else { small-size };
	let fn-sz = if footnote-size == none { normal-size * footnote-size-rel } else { footnote-size };
	let sm-sz = if small-size == none { normal-size * small-size-rel } else { small-size };
	// get margins!
	let mg-l = if margin-left == none { 1in } else { margin-left };
	let mg-r = if margin-right == none { 1in } else { margin-right };
	let mg-t = if margin-top == none { 1in } else { margin-top };
	let mg-b = if margin-bottom == none { 1in } else { margin-bottom };
	// get author names
	let names = authors.map(x => x.name);
	let namestr = if names.len() == 2 { names.join(" and ") } else { names.join(", ", last: ", and ")}
	let keywordstr = keywords.join(", ")
	// set metadata
	set document(title: title, author: names)
	// set text
	set text(size: normal-size, font: fontname)
	// set page settings
	set page(
		paper: paper-size,
		margin: (top: mg-t, bottom: mg-b, left: mg-l, right: mg-r),
		header-ascent: normal-size,
		header: locate(location => {
			let pagenumber = counter(page).at(location).first()
			grid(
				columns: (1fr, 1em),
				align(
					left,
					upper(
						if running-head == none or (pagenumber == 1 and first-page-omits-running-head) { [] } else { running-head }
						),
				),
				align(
					right,
					[#pagenumber]
				)
			)
		})
	)
	// set heading settings
	set heading(outlined: true, bookmarked: true)
	show heading: it => {
		if it.level == 1 {
			set align(center)
			[
				#set par(first-line-indent: 0.0in, justify: true)
				#text(size: normal-size, weight: "bold", it.body)
				#linebreak()
			]
		} else if it.level == 2 {
			[
				#set par(first-line-indent: 0.0in, justify: true)
				#text(size: normal-size, weight: "bold", it.body)
				#linebreak()
			]
		} else if it.level == 3 {
			[
				#set par(first-line-indent: 0.0in, justify: true)
				#text(size: normal-size, weight: "bold", style: "italic", it.body)
				#linebreak()
			]
		} else if it.level == 4 {
			[
				#set par(first-line-indent: 0.0in, justify: true)
				#text(size: normal-size, weight: "bold", style: "italic", underline(it.body))
			]
		} else {
			[
				#set par(first-line-indent: 0.0in, justify: true)
				#text(size: normal-size, weight: "regular", style: "italic", underline(it.body))
			]
		}
	}
	// set list settings
	set list(indent: (normal-size / 12pt) * 0.25in, body-indent: 0.5 * normal-size, spacing: 2em)
  set enum(indent: (normal-size / 12pt) * 0.25in, body-indent: 0.5 * normal-size, spacing: 2em)
	// set equation settings
  show math.equation: set block(below: 0.67 * normal-size, above: 0.75 * normal-size)
  show math.equation: set text(weight: 400)
	// set bibliography style
	set bibliography(style: "american-psychological-association", title: "References")
	// set line spacing
 set par(leading: 2em)
 show heading: set block(above: 2em, below: 2em)
	// title page
	v(15 * normal-size, weak: false)
	align(center,
		{
			text(size: normal-size, weight: "bold", title)
			v(1 * normal-size, weak: false)
			if subtitle == none { [] } else { text(size: normal-size, subtitle) }
			v(3 * normal-size, weak: false)
			text(size: normal-size, namestr) + [ \ ]
			affiliation
		}
	)
	pagebreak()
	if abstract != none {
		[
			= Abstract
			#set par(first-line-indent: 0.5in, justify: true)
			#abstract

			#if keywords.len() > 0 { emph("Keywords: ") + keywordstr}
		]
		pagebreak()
	}
	set par(first-line-indent: 0.5in, justify: true)
	body
}

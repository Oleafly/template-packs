// Imports
#import "components/code.typ": codeblock
#import "const.typ" as globals
#import "pages/outline.typ": toc, list_of
#import "pages/cover.typ": cover
#import "pages/abstract.typ": abstract
#import "dependencies.typ": zebraw, zebraw-themes, make-glossary, print-glossary, register-glossary
#show: make-glossary
#import "abbreviations.typ": abbreviations-entry-list

// Document config
#set text(size: globals.font_size)
#set page(
	margin: (y: globals.margin_y, x: globals.margin_x)
)
#set par(spacing: globals.paragraph_spacing)

#show heading.where(level: 1): set block(above: globals.heading_margin_top, below: globals.heading_margin_bottom)
#show heading.where(level: 1): set text(size: globals.heading_font_size, weight: 600)
#show heading.where(level: 1): it => {
	pagebreak(weak: true)
	v(globals.heading_extra_margin)
	it
}

#show heading.where(level: 2): set block(above: globals.heading_margin_top, below: globals.heading_margin_bottom)

#show link: it => [
	#underline(text(blue, it)) // styling for urls
]

#show: zebraw.with(..zebraw-themes.zebra) // For making code listings work

// Cover
#cover(
	[Benefits of Applying Software Design Patterns to Backend Rust Applications],
	[Leon Heuer],
	[Prof. Dr. Jan Haase],
	[Unknown],
	[B.Sc. Falk Woldmann Lu],
	datetime.today().display()
)
#set page(footer: context [
  #align(right, counter(page).display())
])
#set page(numbering: "I")
#counter(page).update(1)

// Abstract
#abstract(
	[Benefits of Applying Software Design Patterns to Backend Rust Applications],
	lorem(100),
	[Benefits of Applying Software Design Patterns to Backend Rust Applications],
	lorem(100),
)

// Acknowledgements
#heading(outlined: false, [Acknowledgements])
I would like to thank my parents, my cousin, my company advisor and my friends who supported me during this thesis. #lorem(50)

// Table of Contents
#toc("Contents")

// List of Figures
#list_of("List of Figures", image)

// List of Tables
#list_of("List of Tables", table)

// List of Listings
#list_of("List of Listings", raw)

// Abbreviations
#register-glossary(abbreviations-entry-list)
= Abbreviations
#print-glossary(
	abbreviations-entry-list,
	disable-back-references: true,
)

// Main Section
<end-of-roman-numbering>
#set page(numbering: "1")
#counter(page).update(1)
#set heading(numbering: "1.1")
#set par(justify: true)

#set page(header: context {
	// Before
	let selector_before = selector(heading.where(level: 1)).before(here())
	let level_before = int(counter(selector_before).display())
	let headings_before = query(selector_before)

	if headings_before.len() == 0 {
		return
	}

	// After
	let selector_after = selector(heading.where(level: 1)).after(here())
	let level_after = level_before + 1
	let headings_after = query(selector_after)

	if headings_after.len() == 0 {
		return
	}

	// Get headings
	let heading_before = headings_before.last()
	let heading_after = headings_after.first()

	// Decide on heading
	let heading = heading_before
	let level = level_before

	if heading_after.location().page() == here().page() {
		if (
			heading_after.location().position().y == (globals.heading_extra_margin + globals.margin_y)
				or heading_after.location().position().y == globals.margin_y
		) {
			// Next header is first element of page
			return
		} else {
			heading = heading_after
			level = level_after
		}
	}

	set text(size: 11.5pt)
	grid(
		rows: 2,
		gutter: 5pt,
		if heading.numbering != none {
			emph(str(level) + " " + heading.body)
		} else {
			emph(heading.body)
		},
		line(length: 100%, stroke: 0.7pt),
	)
})



// --- Include content here ---
#include "chapters/01_introduction.typ"
#include "chapters/02_state.typ"
#include "chapters/03_concent.typ"
#include "chapters/04_implementation.typ"
#include "chapters/05_results.typ"
#include "chapters/06_conclusion.typ"


// References
#set page(numbering: "I")
#context {
	let old_page_number = counter(page).at(<end-of-roman-numbering>).first()
	counter(page).update(old_page_number + 1)
}
#set heading(numbering: none)
#bibliography("res/literature.bib", title: [References])
#pagebreak()

// Appendix
#set heading(numbering: "A.1 ")
#counter(heading).update(0)

= Appendix

== Code snippet
#figure(
	codeblock("../res/rust_example.rs", "rust"),
	caption: [Dummy Rust code to show the code blocks]
) <code-snippet>

== Text
#lorem(50)

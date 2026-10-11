#let conf(
	fontSize: 12pt,
	title: "Title",
	company: none,
	authors: (),
	frontPagePicture: none,
	language: "en",
	region: none,
	doc
) = {

/*******************************************************************************
* Internal function
*
* Those functions are only for use by the template
*******************************************************************************/

let authorsList = []
if type(authors) == "array"{
	for i in range(authors.len()) {
		if i == 0 {
			authorsList += [#authors.at(i)]
		} else {
			authorsList += [ & #authors.at(i)]
		}
	}
} else {
	authorsList = [#authors]
}

// currently the heading displayed is the previous one. If the page begin with
// a new heading then the header still display the last one. This due to the
// fact that the header is generated before the display of the header
let generateHeaders() = {
	context {
		let previousHeadings = query(selector(heading).before(here()))

		smallcaps[*#title*]
		h(1fr)
		if previousHeadings.len() != 0 {
			emph(previousHeadings.last().body)
		}
	}

	line(length: 100%)
}

let generateFooters() = {
	line(length: 100%)

	context {
		grid(
			columns: (50%, 50%),
			rows: auto,
			{
				[#counter(page).get().at(0)]
			//	if counter(page).at(here()).even(){
			//		[hello]
			//	}
			},
			{
				[hello]
			}
		)
	}
	/*locate(loc =>{
		grid(
			columns: (50%, 50%),
			rows: auto,
			{
				if calc.even(loc.page()) {
					if company != none [
						#company | #authorsList
					] else[
						#authorsList
					]
				 } else {
					set align(left) 
					counter(page).display("1/1", both: true)
				 }
			},
			{
				if not calc.even(loc.page()) {
					if company != none [
						#company | #authorsList
					] else[
						#authorsList
					]
				} else {
					set align(right) 
					counter(page).display("1/1", both: true)
				}
			},
		)
	})*/
}


/*******************************************************************************
* Document settings
*
* This is where the actual configuration of the document is done.
*******************************************************************************/

	set document(
		title: title,
		author: authors
		)

	set text(
		font: "Arial",
		size: fontSize,
		lang: "fr",
		region: "CH",
	)

	set page(
		paper: "a4",
		header: generateHeaders(),
		footer: generateFooters(),
	)

	set par(
		justify: true,

	)

	set heading(
		numbering: "1.1.1.",
	)

	let diplayTitle() = [
		#align(center, text(2em)[
		#smallcaps[*#title*]
		])
	]

	let firstPage(
	) = {
		set page(
			header: none,
			footer: none,
		)
		if frontPagePicture != none {
			align(center + horizon, text(2em)[
				#smallcaps[*#title*]
				#layout(size => {
					let width = size.width
					image(frontPagePicture, width: size.width)
				})
			])
		} else {
			align(center + horizon, text(2em)[
				#smallcaps[*#title*]
			])
		}
		align(bottom, text(1.4em)[
			Auteur#if(type(authors) == "array"){[s]}~: #authorsList

			#if company != none {
				company
			}

			Date~: #datetime.today().display()
		])
	}

	//diplayTitle()
	firstPage()

	outline()

	pagebreak()

	doc
}

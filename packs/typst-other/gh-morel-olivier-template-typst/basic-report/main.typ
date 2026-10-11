#import "conf.typ": conf

#show: doc => conf(
	fontSize: 12pt,
	title: "Mon Document",
	company: "Ma Société",
	authors: ("Olivier Morel", "Jean Dupont"),
	frontPagePicture: none,
	doc
)

 
= Introduction <intro>
#lorem(100)

#lorem(60)

== Sous-section 1
#lorem(50)

@intro is a test

== Sous-section 2
=== Sous-sous-section 1
#lorem(50)
==== Sous-sous-sous-section 1

= Conclusion
#lorem(100)

#context [
		#let previousHeadings = query(selector(heading).before(here()))
		[#previousHeadings]
]
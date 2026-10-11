#import "./code/lib.typ": *

#let document-locale = utils.iso-parse(
	meta.property("locale", fallback: "en-US")
)

#set text(
	lang: document-locale.at("iso639"),
	region: document-locale.at("iso3166")
)

#show: layout.init
#show: style.use-par
#show: style.use-text
#show: nobreak.apply
#show: hyphenation.apply
#show: typography.apply

#set document(
	title: meta.book(
		"title",
		fallback: locale.get("fallback.title")
	),
	author: meta.author(
		"name",
		fallback: locale.get("fallback.author")
	),
	description: meta.book(
		"description",
		fallback: ""
		),
	keywords: meta.property(
		"keywords",
		fallback: []
	)
)

#show: word-count

/// ========= BOOK CONTENT START ========= ///

Всего слов: #total-words

#chapter.pre-title()
#chapter.title()
#chapter.frontmatter()

= #title() <start_count>

#line(length: 100%)

#chapter.read(
	"Chapter Name",
	"Chapter Name",
)

/// ========= BOOK CONTENT END ========= ///

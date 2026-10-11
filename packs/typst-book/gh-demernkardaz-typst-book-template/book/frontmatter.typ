#import "./preamble.typ": *

#component.base.ГОСТ-Р-7-0-4-2020.блок-классификации(
	УДК: meta.property("УДК", fallback: "000.000.0-00"),
	ББК: meta.property("ББК", fallback: "00-000"),
	Авторский-знак: meta.property("Авторский знак", fallback: "? 00")
)

#component.catalog-card.new(name: "", (
	"author":         meta.author("name", fallback: locale.get("fallback.author")),
	"title":          meta.property("Бибилографическое описание").at(0),
	"description":    meta.property("Аннотация").at(0),
	"ISBN":           meta.property("ISBN", fallback: "000-0-0000-0000-0"),
	"Авторский знак": meta.property("Авторский знак", fallback: "? 00"),
	"УДК":            meta.property("УДК", fallback: "000.000.0-00"),
	"ББК":            meta.property("ББК", fallback: "00-000"),
))

#place(
	bottom + center,
  float: true,
	[
		#block(
			width: 100%,
			inset: (x: 6pt, y: 0pt)
		)[
			#table(
				columns: (1fr, 1fr),
				rows: 1,
				align: (left, right),
				stroke: none,

				[
					#meta.property("ISBN", fallback: "000-0-0000-0000-0")
				],
				[
					#sym.copyright
					#meta.author("name", fallback: locale.get("fallback.author")),
					#meta.date("year", fallback: 2026)]
			)
		]
	]
)

#pagebreak()

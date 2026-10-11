// ======== VARIABLES ========

#let address = "0000 Bélafalva, Orbán Viktor utca 69."

// Must be the same as the date on "Hatósági Bizonyítvány"
#let date-of-declaration = "1970-01-01"

#let declarant = (
	name: "Példa Jenő",
	id-number: "000000AA",
	mothers-name: "Mari Néni",
	birth-place: "Bélafalva (Magyarország)",
	birth-date: "1970-01-01",
)

#let household-members = (
	(address-card-number: "000000AA", name: "Példa Jenő"),
	(address-card-number: "000000AA", name: "Mari Néni"),
	(address-card-number: "000000AA", name: "Papné Béla"),
)

// ======== IMPLEMENTATION ========

#set document(
	title: "Nyilatkozat",
	author: declarant.name,
	date: none,
)

#set page(
	margin: 1.5cm,
)

#set text(
	font: "IBM Plex Sans",
	size: 12pt,
	lang: "hu",
)

#set par(justify: true)
#show table: set par(justify: false)

#align(center)[
	#set par(justify: false)

	#text(1.5em, tracking: 0.2em)[*NYILATKOZAT*]

	(egy háztartásban élőkről szóló igazolás részletezésére, abban az esetben,
	ha nincsenek név szerint feltüntetve az ott lakóhellyel rendelkező személyek)
]

#v(1fr)

Alulírott *#box(declarant.name)* (Név) *#declarant.id-number* (szig. szám)
*#box(declarant.mothers-name)* (Anyja neve) *#declarant.birth-place,
#declarant.birth-date* (születési hely, idő) büntetőjogi felelősségem teljes
tudatában kijelentem, hogy a hatósági bizonyítványon feltüntetett adatoknak
megfelelően az alább felsorolt személyek rendelkeznek bejelentett állandó
lakcímmel/tartózkodási hellyel *#address* szám alatti ingatlanban.

#v(1fr)

#align(center, table(
	columns: 5,
	align: center + horizon,
	[*Ssz.*], [*Név*], [*Lakcím*], [*Lakcím\ érvényességi\ ideje*], [*Lakcímkártya\ száma*],
	..for (i, member) in household-members.enumerate() {
		([#(i + 1).], member.name, address, [Állandó], member.address-card-number)
	}
))

#v(1fr)

Dátum: #date-of-declaration

#v(1fr)

#align(
	right,
	block(
		width: 5cm,
	)[
		#repeat[.]
		#align(top + center)[aláírás]
	],
)

#v(1fr)

#let witness(nr) = block[
	#set par(spacing: 2.5em)

	#box(width: 1fr, repeat[*-*]) *Tanú #nr* #box(width: 1fr, repeat[*-*])

	Név: #box(width: 1fr, repeat[.])

	Szig. szám: #box(width: 1fr, repeat[.])

	Lakcím: #box(width: 1fr, repeat[.])

	#box(width: 1fr, repeat[.])

	Aláírás: #box(width: 1fr, repeat[.])
]

#grid(
	columns: 2,
	column-gutter: 3em,
	witness(1), witness(2),
)

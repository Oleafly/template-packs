#import "../../plugin/lib.typ": *

#let блок-классификации(
	УДК: none,
	ББК: none,
	Авторский-знак: none
) = {
	table(
		columns: (auto, auto),
		stroke: none,
		[#text(weight: 700)[УДК]],
		[#text(weight: 700)[#УДК]],

		[#text(weight: 700)[ББК]],
		[#text(weight: 700)[#ББК]],

		[],
		[#text(weight: 700)[#Авторский-знак]]
	)
}

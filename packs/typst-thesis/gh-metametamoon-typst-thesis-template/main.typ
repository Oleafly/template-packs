#import "util.typ"

#set page(
	paper: "a4",
	margin: (left: 3cm, top: 2cm, right: 1.5cm, bottom: 2cm)
)

#set text(
	font: "New Computer Modern",
	size: 14pt,
	lang: "ru",
)

#set par(
	first-line-indent: (amount: 1.25cm, all: true),
	justify: true,
	// leading: 1em,
)

#set heading(numbering: "1.")

#align(center, text(14pt)[
	*Санкт-Петербургский государственный университет* \
	*Факультет математики и компьютерных наук*
])
 
#v(35mm)

#align(center, text()[
	*_Иванов Иван Иванович_*

#v(8mm)
	#text(size: 17pt)[
	*Выпускная квалификационная работа* \
	#v(0.25cm)
	*_Тема работы: Моя огромная тема дипломной работы как итого моего обучения в бакалавриате_*
	]
#v(3mm)


#v(20mm)

Уровень образования: бакалавриат \
Направление 01.03.02 «Прикладная математика и информатика» \
Основная образовательная программа СВ.5156.2021  \
«Современное программирование» \

#v(25mm)

	#grid(
		columns: (1fr, 1.5fr),
		align(center)[],
		align(left)[ 
			#par(first-line-indent: 0pt)[
			Научный руководитель: \
				доцент. к.ф.-м.н. А. А. Выбегалло
			]
			#v(5mm)
			#par(first-line-indent: 0pt)[
			Рецензент: \
				старший академический консультант \
				ООО "Рога и копыта" А. И. Привалов
			]
		],
	)

	#v(5pt)
])

#place(
    bottom + center,
    float: true,
    [Санкт-Петербург \ 2025 г.]
)

#pagebreak()



#show outline.entry: it => link(
  it.element.location(),
	if it.level == 1 {
		let prefix = if type(it.prefix()) == content { strong(it.prefix()) } else { it.prefix() }
		it.indented(prefix, strong(it.body()) + box(width: 1fr, repeat([.], gap: 0.15em)) + str(it.element.location().page()))
	} else {
		it.indented(it.prefix(), it.inner())
	} 
)

#outline()
#pagebreak()

#include "intro.typ"
#pagebreak()

#include "statement.typ"
#pagebreak()

#include "chap1.typ"
#pagebreak()

#include "chap2.typ"
#pagebreak()

#include "chap3.typ"
#pagebreak()

#include "conclusion.typ"
#pagebreak()

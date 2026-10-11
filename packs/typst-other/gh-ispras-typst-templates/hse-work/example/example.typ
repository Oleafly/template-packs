#import "../lib.typ": *

#show: template.with(
  author-name: "Иванов Иван Иванович",
  title: "Тема работы",
  supervisor-name: "И. И. Иванов",
  supervisor-regalia: "д. ф.-м. н., проф.",
  consultant-name: "И. И. Иванов",
  consultant-regalia: "к. ф.-м. н., доц.",
)

= Введение

#lorem(200) @biswas2017venerable

= Теоретическая часть

#lorem(500) @von2011definitive

= Практическая часть

#lorem(500)

= Заключение

#lorem(100) @c11standard

#bibliography(title: "Список литературы", "./references.bib", style: "gost-r-705-2008-numeric")

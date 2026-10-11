#import "lib.typ": *

// Единая точка правки всех повторяющихся реквизитов отчёта — реализация
// "переменных" в духе \author{}/\title{} из LaTeX через словарь и spread (..meta).
#let meta = (
  ministry: "Министерство науки и высшего образования",
  country: "Российской Федерации",
  fulluniversityname: "ФГБОУ ВО «Алтайский государственный университет»",
  institute: "Институт цифровых технологий, электроники и физики",
  department: "Кафедра вычислительной техники и электроники",
  shortdepartment: "ВТиЭ",
  worktype: "Отчёт по практике на тему:",
  title: "Название работы",
  author: "А. А. Никто",
  groupnumber: "565",
  supervisor: "В. В. Электроник",
  supervisordegree: "к.ф.-м.н., доцент",
  date: str(datetime.today().year()),
  keys-ru: "компьютерное моделирование, система управления версиями",
  abstract-ru: "Объём текста не менее 500 символов! Пока счётчики выставляются вручную, при необходимости правьте lib.typ.",
  count-work-page: "22",
  count-work-img: "6",
  count-work-lit: "5",
  count-work-tab: "6",
)

#show: report.with(..meta)

#make-title(..meta)

#set page(numbering: "1", number-align: top + right, header: auto)
#counter(page).update(2)

#make-abstract(..meta)

#outline(title: "Содержание", indent: auto)

#pagebreak(weak: true)
#heading(numbering: none)[ВВЕДЕНИЕ]

*Актуальность*

*Цель*

*Задачи:*
+ Текст много текста.
+ Текст много текста.
+ Текст много текста.

#include "chapter-1.typ"
#include "chapter-2.typ"
#include "chapter-3.typ"

#heading(numbering: none)[ЗАКЛЮЧЕНИЕ]

+ Пример ссылки на электронный источник @wikiRUBitbucket @wikiRUIdSoftware @wikiRUGitHub.
+ Пример ссылки на книгу одного автора @book1author.
+ Пример ссылки на несколько источников @book1author @wikiRUBitbucket.
+ Пример ссылки на книгу 5-ти и более авторов @book5author.

#pagebreak(weak: true)
#heading(numbering: none)[СПИСОК ИСПОЛЬЗОВАННОЙ ЛИТЕРАТУРЫ]
#bibliography(
  "references.yml",
  style: "gost-r-7-0-5-2008-numeric.csl",
  title: none,
  full: true,
)

#pagebreak(weak: true)
#align(right)[ПРИЛОЖЕНИЕ]
#heading(numbering: none)[ПРИЛОЖЕНИЕ] <appendix1>

#align(center)[Текст программы]

#figure(
  kind: "listing",
  supplement: "Листинг",
  raw(read("src/pi-mpi.c"), lang: "c", block: true),
  caption: [Пример программы вычисления числа $pi$ на языке _C_ с использованием _MPI_ (пример из https://ru.wikipedia.org/wiki/Message\_Passing\_Interface)],
) <code:pi-example>

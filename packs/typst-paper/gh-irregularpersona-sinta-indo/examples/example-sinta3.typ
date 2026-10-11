#import "../lib.typ": sinta3, sinta-3-figure

#let author-list = (
  (
    name: "Max Park",
    affiliation: [X Organization],
    city: [Pretoria],
    country: [South Africa],
    email: "test@mail.org",
  ),
  (
    name: "Peter Lee",
    affiliation: [X Organization],
    city: [Kuala Lumpur],
    country: [Malaysia],
    email: "test@mail.org",
  ),
  (
    name: "Peter Liu",
    affiliation: [X Organization],
    city: [Kuala Lumpur],
    country: [Malaysia],
    email: "another_test@mail.org",
  ),
)

#let abstract-content = lorem(55)
#let abstract-keys = ("Test", "Foo", "Bar", "Baz", "FooBar", "FooBaz")
#show: sinta3.with(
  article-title: [Menjelaskan Cara Sesuatu Foo Bar Baz],
  authors: author-list,
  abstract: abstract-content,
  abstract-keywords: abstract-keys,
  abstract-eng: abstract-content,
  bibliography: bibliography("refs.bib")
)

#let foo = table(
  columns: 5,
  ..range(0, 25).map(x => [#x])
)

= Pendahuluan
#lorem(50)

#lorem(50)
= Tinjauan Pustaka
#lorem(50)
= Metode
#lorem(50)
= Temuan
#lorem(50)
#sinta-3-figure(foo, caption: "Test Table", source: "New York University")
#lorem(50) @netwok2020 @netwok2022
#sinta-3-figure(image("sinta-3test.jpg", width: 50%, height: 50%), caption: "This is from the template!", source: "Self-documented")
= Bahasan
#lorem(50)
= Kesimpulan
#lorem(50)



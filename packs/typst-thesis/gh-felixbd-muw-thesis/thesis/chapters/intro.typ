// #import "@preview/bookly:1.0.0": *
#import "@preview/bookly:1.1.2": *

// #show: chapter.with(
//   title: "Introduction",
//   abstract: [#lorem(50)],
//   numbered: false
// )


#import "./../preamble.typ": *
// #show: document => my-config(document)
#show: doc => my-config(
  // is-draft: false,
  doc
)

#show: chapter-nonum

= Introduction

== Goals

#dropcap[
  *Example*
  #lorem(100)
]


#quote(attribution: [Random #smallcaps[Name]])[
  #lorem(15)
]


#lorem(25)

$
y = f(x) \
g = h(x)
$

#v(1.25em)
=== Sub-goals

#figure(
image("../images/typst-logo.svg", width: 75%),
caption: [#ls-caption([#lorem(10)], [#lorem(2)])],
) <fig:intro>

#lorem(50) (cf. Figure @fig:intro)

#pagebreak()
== Methodology

#lorem(1000)
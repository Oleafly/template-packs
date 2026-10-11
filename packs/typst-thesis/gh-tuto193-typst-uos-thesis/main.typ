#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#import "template.typ": cite-et-al, cite-string, fance-table-align, fancy-table-fill, fancy-table-stroke, gls, project
#import "glossaries.typ": GLOSSARIES

// Make a simple separator for term lists
#set terms(separator: [: ], tight: false)

// Set the language of the document here!
// #let language = "de"
// #let language = "es"
#let language = "de"


// Set language for translations
#let lang = yaml("languages/" + language + ".yaml")

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
///// HELPER FUNCTIONS
/// FIGURES

/// Create a figure(kind: image)
#let figimage = figure.with(supplement: [#lang.supplements.figure], kind: image)
/// Create a figure(kind: table)
#let figtable = figure.with(supplement: [#lang.supplements.table], kind: table)
// Create a code block
#let figcode = figure.with(supplement: [#lang.supplements.code], kind: raw)
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

#show: project.with(
  title: "My Very Cool Title",
  lang: language,
  work-type: "seminar", // seminar, bachelor, master
  author: "John Doe",
  registration-number: "123456",
  institute: "Institute of Very Cool People",
  logo: "images/logo.png",
  bibliography-path: "bibliography.bib",
  bibliography-style: "ieee",
  city: "Osnabrück",
  first-supervisor: "Prof. Dr. Max Müstermann",
  second-supervisor: "Prof. Dr. rer. nat. Müs Maxterfrau",
  // abstract: [
  //   I am the abstract text.
  // ],
  glossaries: GLOSSARIES,
  double-sided: false, // affects the placements of page numbers
)
/// Initialize codly: code will now be shown more awesomely
#show: codly-init.with()

= Introduction
<chap-Introduction>
Here we are in @chap-Introduction.


#lorem(90)... see @fig-1

#figimage(
  [A simple test figure],
  caption: [My very cool caption],
) <fig-1>

== Motivation
<sec-Motivation>
We are in @sec-Motivation and here is a fancy table in @table-1, and we can
do some references. Let's quote something with many authors like #cite-et-al("RWS+2023GDAL", form: "prose").

#figtable(
  table(
    columns: 3,
    align: fance-table-align,
    fill: fancy-table-fill,
    stroke: fancy-table-stroke,
    [*Left side*], [*Middle*], [*Right side*],
    [1], [a], [I],
    [2], [b], [II],
    [3], [c], [II],
  ),
  caption: "Not so fancy caption",
) <table-1>

There is also some code in @code-1.
#figure(
  [
    ```py
    def my_random_function() -> None:
        my_list: list = [1, 3, 4, 9]
        print(my_list)
    ```
  ],
  supplement: [Code Block],
  caption: [Some python code, I think...],
) <code-1>

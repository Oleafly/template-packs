#import "template.typ": *

#show: master-thesis-template.with(
  title: "Automated map generation using generative AI",
  author: "John Doe",
  subtitle: "Limitations of generative AI for thematic map generation and challenges concerning copyright",
  date: datetime(year: 2028, month: 10, day: 31), //submission date
  place: "Dresden, Germany",
  duration: "March–October 2028",
  bibliography: "example.bib", // the relative path to the bibliography file (BibTeX format) to be used for the thesis
  bibliography-style: "apa", // one of typst's supported styles:
  abstract: [#lorem(50)], // this can be imported/included from a separate file
  keywords: "polygon schematization, thematic maps, map generalization, map simplification, map abstraction",
  supervisor: "Prof. Dr. John Doe",
  thesis-assessment-board: ("Prof. Dr. John Doe", "Prof. Dr. Jane Smith", "Prof. Dr. Alice Johnson"),
  submitted-at: (
    university: "University of Example",
    faculty: "Faculty of Master Thesis Studies",
  ),
  acknowledgements: [
    I would like to say "Thank you" to

    - _Person A_ — supervisor, for #lorem(20).

    - _Person B_ — reviewer A, for #lorem(10).

    - _Person C_ — reviewer B, for #lorem(30).

    - _Person D_ — friend A, for #lorem(25).
  ], // this can as well be imported/included from a separate file
  line-numbering: true, // this is optional (defaults to: false), might be useful for reviewers
)

#let place-holder = {
  lorem(100)
  lorem(50)
  lorem(100)
}

// You'd probably want to split your file up and include chapters / sections.
// e.g., #include "chapters/introduction.typ"

= Introduction

#place-holder

== Research identification
#lorem(10). @abdallaWebGISTechniquesApplications2019 #lorem(40)

#figure(
  rect(width: 100%, height: 5cm, stroke: none, fill: luma(240), radius: .5em, align(
    horizon,
  )[Just a placeholder #emoji.hand.call]),
  caption: "Just placeholder figure",
  alt: "This is an alt text for the figure placeholder",
)

@agrawalWebGISIts2017 #lorem(80)

=== The prototype

#place-holder

#figure(
  table(
    columns: 2,
    rows: 2,
    table.header([A], [B]),
    [1], [2],
    [3], [4],
  ),
  caption: "Just placeholder table",
)

== Thesis outline

#place-holder

= Background and related work

#place-holder

== Topic A

#place-holder

== Topic B

#place-holder

= Methodology

#place-holder

== Section A

#place-holder

== Section B

#place-holder

= Implementing the prototype

#place-holder

= Results and discussion

#place-holder

= Conclusion

#place-holder

#show: bibliography-here

#show: appendix

= Appendix A
#place-holder

= Appendix B
#place-holder

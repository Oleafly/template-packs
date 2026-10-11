#import "template/cs3.typ": *
#import "@preview/dashy-todo:0.1.3": todo

// if no text is displayed, make sure either the "Noto" or "DejaVu" font is installed on your system
#show: cs3-thesis.with(
  author: "Namus Namerich",
  author-birthday: datetime(year: 1970, month: 1, day: 1),
  author-birthplace: "Erlangen",
  title: [
    Scalable, Fault-Tolerant AI Architectures for Edge-Driven Inference
  ],
  thesis-type: "master",
  program: "Informatik",
  start-date: datetime(year: 2000, month: 1, day: 1),
  submit-date: datetime.today(),
  supervisor: "Dipl.-Inf. Marc Reichenbach",
  professor: "Prof. Dr.-Ing. Dietmar Fey",
  location: "Erlangen",
  abstract: "/abstract.typ", // optional
  // abstract: [
  //   An alternative inline abstract.
  // ],
  bib: "/sources.bib", // optional, but you probably want this
  appendix: "/appendix.typ", // optional
)

= A Section
#lorem(50) @source // citing a source

#lorem(100) #todo[TODO]

= Another Section

== Some Subsection
#lorem(100)

== Subsection Again
#lorem(50)

=== SubSubSub...
#lorem(200)

= Last Section
#figure(
  image("images/MIPS_ASIC.jpg", width: 50%),
  caption: [A MIPS ASIC]
) <asic>

In @asic, you can see a MIPS ASIC.
Below, in @grid, an example table can be seen.

#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Some Data]
) <grid>

And some more text.

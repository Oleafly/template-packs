#import "template/basic-wipro.typ": *

// For a bachelor thesis, use `basic-bachelor` instead of `basic-wipro`.
// It accepts the same arguments and additionally supports:
//
// acknowledgements: [
//   Vielen Dank an ...
// ],

#let abstract = [
  = Abstract
  Here you write the Abstract
]

#show: doc => basic-wipro(
  logo: image("images/logo.svg", width: 80%),
  title: "My title",
  students: (
    "Max Muster",
    "Martina Muster",
  ),
  year: "2025",
  institution: "HSLU",
  study-program: "BSc Informatik",
  supervisor: "Mr Bossman",
  expert: "Dr. Prof",
  client: "Client",
  public: true,
  secret: false,
  abstract,
  doc,
  bib: include("outlines/bibliography.typ"),
  abbr: include("outlines/abbreviations.typ"),
  imgol: include("outlines/image_outline.typ"),
  tabol: include("outlines/tables.typ"),
)
= First
#lorem(50)

== Second
#lorem(50)

=== Third
#lorem(50)

==== Fourth

#lorem(50)
= A
#lorem(50)

== B
#lorem(50)

=== C
#lorem(50)

==== D

#lorem(50)

#pagebreak()
= Table Example
Here is a simple table:
#figure(
  kind: table,
  caption: [Example Table],
  table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Column 1*], [*Column 2*], [*Column 3*],
  ),
  [Row 1], [Data A], [Value 1],
  [Row 2], [Data B], [Value 2],
  [Row 3], [Data C], [Value 3],
)
)

= Image Example
Here is an Example on how to include an image which is also listed in the Imageoutline.
#figure(
  kind: image,
  caption: [Example Image],
  image("/images/logo.svg", width: 50%),
)
= Source Example
This is based on a source @source-1 // This requires a bibliography.yaml file with an entry with the ID "source-1".
Sources will automatically appear if they are cited.
Add them to `bibliography.yaml`

= Code Example
Here is a code block:
// this needs to be imported first
#import "template/code.typ": code
// then you can use it like this:
#code("sudo rm -rf / --no-preserve-root", lang: "sh")


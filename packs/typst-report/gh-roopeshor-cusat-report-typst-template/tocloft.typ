#import "settings.typ": addToPDFBookmark
// Table Of Contents, List Of Figures and Tables

// set listing heading style
#show heading.where(level: 1): it => {
  set align(center + top)
  block[
    #text(size: 21pt, weight: "bold")[#it.body]
    #v(.5cm)
  ]
}

#addToPDFBookmark("Table of contents")
#outline(
  title: [Table of contents],
  target: heading,
)

#pagebreak()

#addToPDFBookmark("List of Figures")
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
#v(1cm)
#pagebreak()
#addToPDFBookmark("List of Tables")
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)
#v(1cm)

#pagebreak()

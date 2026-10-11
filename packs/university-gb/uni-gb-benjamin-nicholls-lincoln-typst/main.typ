#import "template/lincoln.typ" as lincoln

#show: doc => lincoln.init(doc)
#show: doc => lincoln.TitlePage(doc)
#include "chapters/title-page.typ"
#pagebreak()

#show: doc => lincoln.MainBody(doc)
#include "chapters/acknowledgements.typ"
#include "chapters/abstract.typ"


#outline(title: "Table of Contents")

#outline(title: "List of Figures", target: figure.where(kind: image))

#outline(title: "List of Tables", target: figure.where(kind: table))

// TODO: List of listings

// Reset heading counter (so the chapters start from 1).
#counter(heading).update(0)

#show: doc => lincoln.MainBody(doc)
#include "chapters/introduction.typ"

#bibliography("references.bib", title: "References", style: "harvard-cite-them-right")

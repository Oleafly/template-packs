#import "template/article.typ": article

#show: article.with(
  title: [Article Skeleton],
  authors: (
    (name: "Author Name"),
  ),
  date: datetime.today().display("[month repr:long] [day], [year]"),
)

#include "src/abstract.typ"
#include "src/introduction.typ"
#include "src/methods.typ"
#include "src/results.typ"
#include "src/conclusion.typ"

#bibliography("refs.bib")

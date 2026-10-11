#import "settings.typ": *
#show: project

#set page(numbering: "a")
#showFooter("none")
#include "title.typ"
#include "certificate.typ"
#include "declaration.typ"
#include "acknowledgment.typ"
#include "abstract.typ"

#set page(numbering: "i")
#showFooter("number")
#counter(page).update(1)
#include "tocloft.typ"

#counter(page).update(1)
#set page(
  numbering: "1",
  margin: (x: 1in, y: 1.5in),
)
#showFooter("doe+number")
#include "introduction.typ"
#include "literature_review.typ"
#include "System Overview.typ"
#include "results.typ"
#include "conclusion_scope.typ"

#bibliography(
	title: "References",
	"ref.yaml",
	style: "ieee",
	// full: true // if want to include all that are not even used in the report, set this to true
)
#include "appendix.typ"

#import "typst/hust-thesis.typ": *
#import "typst/metadata.typ": thesis
#import "typst/frontmatter.typ": frontmatter, abstracts

// final: false reproduces the original draftformat header/footer.
// Compile with --input format=final to remove the running header/rules.
// Personal information remains editable in typst/metadata.typ.
#show: hust-thesis.with(final: sys.inputs.at("format", default: "draft") == "final")
#set document(author: thesis.author)

#frontmatter(thesis)
#set page(numbering: "I")
#abstracts(thesis)
#hust-outline()

#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)
#include "typst/body/chap01.typ"
#include "typst/body/chap02.typ"
#include "typst/body/chap03.typ"
#include "typst/body/chap04.typ"
#include "typst/body/conclusion.typ"
#include "typst/body/backmatter.typ"

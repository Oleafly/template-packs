// Frontmatter

#include "./preface/firstpage.typ"
#include "./preface/copyright.typ"
#include "./preface/dedication.typ"
#include "./preface/summary.typ"
// #include "./preface/acknowledgements.typ"
#include "./preface/table-of-contents.typ"
#include "./preface/list.typ"

// Mainmatter
#pagebreak(to: "odd")
#set page(numbering: "1")


#include "./chapters/01-introduction.typ"
#include "./chapters/02-background.typ"
#include "./chapters/03-methodology.typ"
#include "./chapters/04-results.typ"
#include "./chapters/05-future-directions.typ"
#include "./chapters/06-conclusion.typ"

// Appendices
#state("appendix-mode", false).update(true)
#include "./appendix/appendix-A.typ"
// Bibliography
#include("./bibliography/bibliography.typ")



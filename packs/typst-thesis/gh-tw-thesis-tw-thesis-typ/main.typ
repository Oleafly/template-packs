#import "helper/mod.typ": *

#show: thesis

// front matter
#include "contents/front/acknowledgement.typ"
#include "contents/front/abstract.typ"

// notation
#include "contents/front/denotation.typ"

// chapters
#set heading(numbering: "1.1")
#include "contents/chapter01.typ"
#include "contents/chapter02.typ"
#include "contents/chapter03.typ"
#include "contents/chapter04.typ"

// references
#references()

// appendices
#include "contents/back/appendix01.typ"

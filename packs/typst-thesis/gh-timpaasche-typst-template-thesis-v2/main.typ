#import "/template/page-setup.typ": *
#import "/template/tp-functions.typ": *
#import "/metadata.typ": *
#import "/src/glossar/glossar.typ": *
#import "@preview/glossarium:0.5.1": make-glossary, register-glossary, print-glossary, gls, glspl

#create-tp-titlepage(
  main-image: "/src/images/logos/HKA_EIT_Logo.jpg",
  authors: authors,
  technicalSupervisors: technicalSupervisors,
  scientificSupervisors: scientificSupervisors,
)

// load page styling
#show: set-up.with()

// register that there is a glossary
#register-glossary(entry-list)

#include "/chapter/preface/abstract.typ"
#pagebreak()
#include "/chapter/preface/abstract-german.typ"
#pagebreak()
#include "/chapter/preface/affidavit.typ"
#pagebreak()
#include "/chapter/preface/ai-diclaimer.typ"
#pagebreak()

#create-outline()
#create-outline-table()

// start counting at 1 again and changed to arabic style numbering
#show: change-style-to-main.with()

#include "/chapter/01-intruduction.typ"
#pagebreak()

#include "/chapter/02-basics.typ"
#pagebreak()

#include "/chapter/03-state-of-the-technology.typ"
#pagebreak()

#include "/chapter/04-concept.typ"
#pagebreak()

#include "/chapter/05-implementation.typ"
#pagebreak()

#include "/chapter/06-result.typ"
#pagebreak()

#include "/chapter/07-possible-usecases.typ"
#pagebreak()

#print-glossar(entry-list: entry-list)
#create-bibliography()
#create-outline-images()
#create-outline-table()
#create-outline-Code(use-pagebreak: false)

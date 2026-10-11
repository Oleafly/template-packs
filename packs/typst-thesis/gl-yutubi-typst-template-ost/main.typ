#import "lib/lib.typ": *
#import "meta.typ": meta

#show: article.with()

#maketitle()

#pagebreak()
#context { counter(page).update(1) }
#set page(
  header: context [
    #text("")
  ],
  footer: context [
    #table(
      columns: (1fr, auto, 1fr),
      stroke: none,
      inset: 0mm,
      [],
      [
        #counter(page).display(
          "i",
          both: false,
        )
      ],
      [],
    )
  ],
)

// #include "sections/_abstract.typ"
// #pagebreak()
// #include "sections/_management-summary.typ"
// #pagebreak()
// #include "sections/_acknowledgments.typ"
// #pagebreak()

#title-without-numbering(title: context languages.at(curlang.get()).toc)
#outline(
  title: none,
  indent: auto,
)

#pagebreak()
#context { counter(page).update(1) }
#set page(
  header: context [
    #text(meta.title + " | " + authors-text)
  ],
  footer: context [
    #table(
      columns: (1fr, auto, 1fr),
      stroke: none,
      inset: 0mm,
      [],
      [
        #counter(page).display(
          "1",
          both: false,
        )
      ],
      [],
    )
  ],
)

#include "sections/_product-documentation.typ"
#pagebreak()
#include "sections/_project-documentation.typ"
#pagebreak()
#include "sections/_glossary.typ"
#pagebreak()
#include "sections/_bibliography.typ"
#pagebreak()
#include "sections/_appendix.typ"

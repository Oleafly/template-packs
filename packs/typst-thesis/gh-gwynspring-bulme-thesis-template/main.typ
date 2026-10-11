#import "metadata.typ": *
#import "globals.typ": lightblue, lighterblue, mainblue, page_author

#let template_header = context {
  let headings = query(heading.where(level: 1))
  let loc = here()
  let before = headings.filter(
    h => h.location().page() <= loc.page() and h.outlined,
  )
  if before.len() > 0 {
    align(left)[#before.last().body]
  }
}

#let template_footer = context {
  stack(
    if here().page-numbering() != "I" {
      stack(
        line(length: 100%, stroke: 0.4pt),
        v(0.3em),
      )
    },
    grid(
      columns: (1fr, 1fr),
      align(left)[#page_author.get()], align(right)[#counter(page).display()],
    ),
  )
}

#set outline(depth: 3)

#set document(
  title: meta.title,
  author: meta.candidates.first().name,
  keywords: "Diplomarbeit",
  date: auto,
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "de",
)

#set page(
  paper: "a4",
  margin: (
    left: 3.5cm,
    right: 2.5cm,
    top: 2cm,
    bottom: 2cm,
  ),
  header-ascent: 0.5cm,
  footer-descent: 0.5cm,
  header: template_header,
  footer: template_footer,
  numbering: "I",
)

#set math.equation(numbering: "(1)")

#set par(
  justify: true,
  leading: 1.5em,
)

#include "chapters/frontmatter/titlepage.typ"
#pagebreak()

#heading(level: 1, outlined: false)[Eidesstattliche Erklärung]
#include "chapters/frontmatter/declaration.typ"
#pagebreak()

#heading(level: 1, outlined: false)[Kurzfassung]
#include "chapters/frontmatter/abstract_de.typ"
#pagebreak()

#heading(level: 1, outlined: false)[Abstract]
#include "chapters/frontmatter/abstract_en.typ"
#pagebreak()

#heading(level: 1, outlined: false)[Vorwort]
#include "chapters/frontmatter/preface.typ"
#pagebreak()

#heading(level: 1, outlined: false)[Danksagung]
#include "chapters/frontmatter/acknowledgements.typ"
#pagebreak()

#heading(level: 1, outlined: false)[Projektteam und Projektbetreuer]
#include "chapters/frontmatter/team.typ"
#pagebreak()

#include "chapters/content/toc.typ"
#pagebreak()

// From here: Arabic page numbers + heading numbering
#counter(page).update(1)
#set page(
  numbering: "1",
  header: template_header,
  footer: template_footer,
)

#set heading(numbering: "1.1", supplement: "Abs.")

#show heading.where(level: 1): it => {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: "codeblock")).update(0)
  it
}

#show figure.where(kind: image): set figure(
  numbering: (..nums) => context {
    let chapter = counter(heading.where(level: 1)).get().first()
    let fig = nums.pos().first()
    str(chapter) + "." + str(fig)
  },
  supplement: [Abbildung],
)

#show figure.where(kind: table): set figure(
  numbering: (..nums) => context {
    let chapter = counter(heading.where(level: 1)).get().first()
    let fig = nums.pos().first()
    str(chapter) + "." + str(fig)
  },
  supplement: [Tabelle],
)

#show figure.where(kind: "codeblock"): set figure(
  numbering: (..nums) => context {
    let chapter = counter(heading.where(level: 1)).get().first()
    let fig = nums.pos().first()
    str(chapter) + "." + str(fig)
  },
  supplement: [Code],
)

#include "chapters/content/introduction.typ"
#pagebreak()
#include "chapters/content/task.typ"
#pagebreak()
#include "chapters/content/body.typ"
#pagebreak()
#include "chapters/content/project_management.typ"
#pagebreak()
#include "chapters/content/conclusion.typ"
#pagebreak()
#include "chapters/content/indices.typ"
#pagebreak()
#include "chapters/content/bibliography.typ"
#pagebreak()
#include "chapters/content/appendix.typ"

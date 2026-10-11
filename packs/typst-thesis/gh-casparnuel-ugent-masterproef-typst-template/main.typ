#import "template.typ": *

// Afkortingen / Abbreviations
#import "@preview/abbr:0.3.0"
#show: abbr.show-rule

#show: ugent-masterproef-template.with(language: "en", highlight-links: false)

#{
  show: ugent-masterproef-frontpage
  image("voorblad.pdf")
}

#{
  show: ugent-masterproef-preliminary-pages

  include "preliminary/acknowledgement.typ"
  {
    show: ugent-masterproef-abstract.with(
      title: "Some title",
      authors: ("Some Author", "Somebody Else", "Another Writer"),
      supervisors: ("Prof. John Doe", "PhD Jane Smith"),
      counsellors: ("Jack Simons", "Dave Daniels", "Jim Joe"),
      academic-years: ("2025", "2026"),
      keywords: ("Keyword", )
    )

    lorem(300)
  }

  outline(depth: 3)
  outline(title: "List of Figures", target: figure.where(kind: image))
  outline(title: "List of Tables", target: figure.where(kind: table))
  abbr.list(title: "List of Acronyms")
  outline(title: "List of Code Fragments", target: figure.where(kind: raw))
}

#{
  show: ugent-masterproef-body

  include "chapters/introduction.typ"
}

#pagebreak(weak: true)
// #bibliography("references.bib")
#pagebreak(weak: true)

#{
  show: ugent-masterproef-appendix.with(title: "Appendices")
  include "appendices/appendix-xyz.typ"
}

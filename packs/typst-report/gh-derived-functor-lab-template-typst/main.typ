#set par(
  first-line-indent: 1.25cm,
  justify: true,
  leading: 0.65em,
)

#set page(
  "a4",
  numbering: "1",
  number-align: center,
  footer: context {
    let page-num = counter(page).get().first()
    if page-num > 1 {
      align(center, counter(page).display("1"))
    }
  }
)
#set text(font: "Times New Roman", lang: "ru", 14pt)

#show heading: set align(center)
#show figure.where(kind: image): set figure(supplement: [Рис.])
#show heading: it => {
  it
  par(first-line-indent: 1.25cm)[#text()[]]
}

#include "pages/title_page.typ"

#pagebreak()

#outline(
  title: [Содержание]
)

#pagebreak()

#include "pages/content.typ"

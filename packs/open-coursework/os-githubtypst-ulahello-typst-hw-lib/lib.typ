#let mkdoc(
  name: "ur cool assignment name",
  authors: ("ur cool author",), class: "ur cool class",
  font: "Libertinus Serif", paper: "us-letter",
) = {
  assert(1 <= authors.len(), message: "want postive number of authors")
  return (body) => [
    #set document(author: authors, title: name + " - " + class)
    #set text(font: font, lang: "en")
    #set page(
      paper: paper,
      header: context {
        set text(12pt)
        grid(
          columns: (1fr, auto),
          align: (left, top + right),
          [#name],
          emph[#document.author.map(text).join([ #sym.dot ]) --- #class]
        )
        line(length: 100%)
      },
      numbering: "1",
    )

    #body
  ]
}

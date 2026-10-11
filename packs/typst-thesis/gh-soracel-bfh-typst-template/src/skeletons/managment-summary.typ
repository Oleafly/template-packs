#let ManagmentSummery(doc, body: content) = {
  page({
    [
      // TODO is there a better solution? This should be a heading but not appear in the table of contents.
      #set text(size: 14pt)
      Managment Summery
      #linebreak()
    ]
    [
      #body
    ]
  })

  doc
}

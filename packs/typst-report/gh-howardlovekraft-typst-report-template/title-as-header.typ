// i18n date names
#import "@preview/icu-datetime:0.2.2": fmt


#let title-head(
  author: "Холкин Николай",
  subject: [],
  doc,
) = {
  set document(title: subject)
  set page(numbering: "1")
  let today = datetime.today()

  align(center)[
    #title()

    #author

    #fmt(today, locale: "ru", length: "long")
  ]
  outline()
  doc
}

#import "../components/font.typ": bold_upper

#let abstract(
  title,
  abstract_text,
  title_de,
  abstract_text_de
) = {
  bold_upper([Title of Thesis])
  par(title)
  bold_upper([Abstract])
  par(abstract_text)
  v(3em)
  bold_upper([Titel der Arbeit])
  par(title_de)
  bold_upper([Kurzzusammenfassung])
  par(abstract_text_de)
}
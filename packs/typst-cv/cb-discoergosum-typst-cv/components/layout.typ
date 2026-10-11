#import "gen-comp.typ": footer, header
#import "cv-comp.typ": cv-header
#import "letter-comp.typ": adress-blog
#let metadata = toml("../meta.toml")

#let base-layout(content) = {
  set page(
    paper: metadata.layout.paper_size,
    margin: (
      left: eval(metadata.layout.margin.left),
      right: eval(metadata.layout.margin.right),
      top: eval(metadata.layout.margin.top),
      bottom: eval(metadata.layout.margin.bottom),
    ),
  )
  set text(
    lang: metadata.layout.language,
    size: eval(metadata.style.base_font_size),
    font: metadata.style.base_font,
  )

  set par(justify: true)


  set document(
    author: metadata.personnal.name,
  )

  content
}

#let cv-layout(content) = {
  show: base-layout
  set document(
    title: metadata.footer.cv + " — " + metadata.personnal.name,
  )
  set page(footer: footer(metadata.footer.cv))
  cv-header
  content
}


#let letter-layout(date: datetime.today().display("[day].[month].[year]"), content) = context {
  show: base-layout
  set document(
    title: metadata.footer.letter + " — " + metadata.personnal.name,
  )
  set page(footer: footer(metadata.footer.letter))
  grid(
    // stroke: 1pt,
    columns: 1fr,
    rows: (63mm - eval(metadata.layout.margin.top), 27.3mm),
    header,
    adress-blog(date)
  )
  v(8.46mm)

  content
}

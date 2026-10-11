
#let metadata = toml("../meta.toml")


#let adress-blog(date) = {
  set text(size: 0.9em)
  let adress = grid(
    gutter: 0.7em,
    text(size: eval(metadata.style.base_font_size), weight: "bold", metadata.recipient.name),
    metadata.recipient.extra,
    metadata.recipient.adress.street,
    metadata.recipient.adress.zipcode + " " + metadata.recipient.adress.city,
  )

  grid(
    columns: (2fr, 1fr),
    inset: 0pt,
    stroke: none,
    align: (left, right + bottom),
    adress, [Datum: #date],
  )
}




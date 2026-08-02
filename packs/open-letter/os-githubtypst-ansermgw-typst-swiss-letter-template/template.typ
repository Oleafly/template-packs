#import "@preview/datify:1.0.1" as datify

#let rightBlock = body => align(right, block(width: 40%, {
  set align(left)
  body
}))

#let letter(
  lang: "fr",
  dateFormat: "le dd MMMM yyyy",
  sender: (
    name: "Prénom Nom",
    street: "Une Rue 1",
    city: "Ville",
    postal_code: 42,
  ),
  recipient: [
    Mr Awesome Recipient \
    Some street 2 \
    42 HomeCity
  ],
  date: datetime.today(),
  object: "Objet de la lettre",
  attachementsTitle: "Annexes",
  attachements: (),
  body,
) = {
  /*
    PAGE SETUP
  */
  set page("a4", margin: 2cm)
  set par(justify: true)
  set text(size: 10pt, lang: lang, font: "Verdana")

  /*
    SENDER
  */
  sender.name
  linebreak()
  sender.street
  linebreak()
  [#sender.postal_code #sender.city]

  /*
    RECIPIENT
  */
  rightBlock({
    recipient

    v(2.5cm)

    /* LOCATION+DATE */
    [#sender.city, #datify.custom-date-format(date, lang: lang, pattern: dateFormat)]
  })

  v(1.5cm)

  /*
    OBJECT
  */
  text(weight: "bold", object)

  v(1.5cm)

  /*
    CONTENT
  */
  body

  /*
    SIGNATURE
  */

  v(1.5cm)

  rightBlock(sender.name)

  /*
    ANNEXES
  */

  if attachements.len() > 0 {
    align(bottom, {
      text(weight: "bold", attachementsTitle)

      for attachement in attachements [
        - #attachement
      ]
    })
  }
}

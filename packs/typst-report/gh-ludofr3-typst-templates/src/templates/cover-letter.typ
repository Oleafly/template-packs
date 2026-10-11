#let cover-letter(
  theme: none,
  sender: (),
  recipient: (),
  city: "",
  date: "",
  subject: "",
  body,
) = {
  
  set document(author: sender.name, title: "Lettre de motivation - " + sender.name)

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    background: context {
      let current-page = counter(page).get().first()

      if current-page == 1 {
        if "cover-bg" in theme.graphics {
          (theme.graphics.cover-bg)()
        }
      } else {
        if "page-bg" in theme.graphics {
          (theme.graphics.page-bg)()
        }
      }
    },
  )

  set text(font: "Poppins", size: 11pt, lang: "fr", fill: theme.colors.text)
  set par(justify: true, leading: 0.7em)

  block(
    text(weight: "bold", size: 13pt)[#sender.name] + "\n" + sender.address + "\n" + sender.email + "\n" + sender.phone,
  )

  v(2em)

  align(right)[
    #block(align(left)[
      #text(weight: "bold")[#recipient.name] \
      #recipient.address

      #v(2em)

      Fait à #city, le #date
    ])

  ]

  v(2em)

  if subject != "" {
    block(
      text(weight: "bold")[Objet : ] + text(weight: "bold")[#subject],
    )
    v(2em)
  }

  body

  v(1em)
  align(right)[#block(width: 50%, align(left)[#text(weight: "bold")[#sender.name]])]
}

#let authors(from: ()) = [
  #set text(size: 8pt)

  #for author in from [
    #show heading: it => block(upper(it.body))

    === #author.name

    #if "address" in author [
      #author.address \
      #{author.zip + sym.space.en + author.city}
    ]

    #if "email" in author [
      *Email*:~#link("mailto:" + author.email) \
    ]
    #if "phone" in author [
      *Tel.*:~#link("tel:" + author.phone) \
    ]

    #if "meta" in author [
      #for (key, value) in author.meta [
        *#key*:~#value
      ]
    ]
  ]
]

#let letter(
  doc,
  from: (),
  to: (),
  date: text(fill: red)[date is not set],
  subject: text(fill: red)[subject is not set],
) = {
  set document(author: from.map(author => author.name))
  set page(
    paper: "a4",
    margin: (top: 45mm),
    footer: [
      #set align(end)
      #set text(8pt)
      #counter(page).display((number, total) => text[Seite #number von #total], both: true)
    ],
    background: locate(loc => {
      place(top + left, line(start: (0mm, 105mm), length: 5mm))
      place(top + left, line(start: (0mm, 210mm), length: 5mm))
      }
    )
  )
  set text(font: "PT Sans", size: 11pt, lang: "de")

  grid(
    columns: (85mm, 100% - 135mm, 50mm),
    rows: 2,
    gutter: 8pt,
    [],
    [],
    authors(from: from),
    [
      *#to.name* \
      #if "department" in to [
        *#to.department* \
      ]

      #to.address \
      #{to.zip + sym.space.en + to.city}
      #parbreak()
    ],
    [],
    [],  
  )


  pad(top: 8.4mm)[
    *#subject*
  ]
  
  box(width: 100% - 50mm)[
    #align(right)[
      #date
    ]
    #pad(top: 2em)[
      Sehr geehrte Damen und Herren,
    ]
    #doc
  ]

  pad(top: 2em)[
    Mit freundlichen Grüßen \

    #for author in from [
      _ #author.name _ \
    ]
  ]
}

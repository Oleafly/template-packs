// HAW Hamburg colours
#let haw-blue = rgb(0, 60, 160)
#let haw-blue2 = rgb(0, 150, 210)
#let haw-blue3 = rgb(160, 190, 220)

#let departments = (
  design: (name: "Design", address: "Finkenau 35\n22081 Hamburg"),
  informatik: (name: "Informatik", address: "Berliner Tor 7\n20099 Hamburg"),
  medientechnik: (name: "Medientechnik", address: "Finkenau 35\n22081 Hamburg"),
)

#let monate = (
  "Januar",
  "Februar",
  "März",
  "April",
  "Mai",
  "Juni",
  "Juli",
  "August",
  "September",
  "Oktober",
  "November",
  "Dezember",
)

#let declaration-page(title: none, location: "Hamburg") = {
  pagebreak()
  heading(level: 1, numbering: none, outlined: false)[Eigenständigkeitserklärung]
  [Hiermit versichere ich, dass ich die vorliegende Arbeit mit dem Titel]
  align(center, strong(title))
  [selbstständig und nur mit den angegebenen Hilfsmitteln verfasst habe. Alle Passagen, die ich
    wörtlich aus der Literatur oder aus anderen Quellen wie z.#sym.space.thin B. Internetseiten übernommen
    habe, habe ich deutlich als Zitat mit Angabe der Quelle kenntlich gemacht.]
  v(3em)
  let today = datetime.today()
  [#location, #today.day(). #monate.at(today.month() - 1) #today.year()]
}

#let thesis(
  title: [TODO: Insert Title],
  author: "TODO: Insert Author",
  kind: "BACHELORARBEIT",
  erstprüfer: "",
  zweitprüfer: "",
  date: auto,
  department: departments.informatik,
  abstract-de: none,
  abstract-en: none,
  body,
) = {
  set document(title: title, author: author)
  set page(paper: "a4", margin: (top: 2cm, right: 3cm, left: 3cm, bottom: 3cm))

  // Font Settings
  set text(font: "Libertinus Serif", lang: "de", size: 12pt)
  set par(justify: true)
  show heading: it => {
    pad(bottom: 1em, text(size: 1.5em, font: "Libertinus Sans", it))
  }
  set heading(numbering: "1.")

  show heading.where(level: 2): set text(size: 12pt)


  show raw: it => {
    show text: text.with(font: "Anonymous Pro")

    show raw: block.with(
      width: 100%,
      fill: luma(245),
      inset: 6pt,
    )

    context {
      let wd = measure(it.lines.last()).width

      show raw.line: ln => {
        box(width: wd, align(right, text(fill: luma(120), str(ln.number))))
        h(0.8em)
        ln.body
      }

      it
    }
  }

  [
    // Titelblatt
    #set text(font: "Open Sans", fill: haw-blue)
    #align(right, block(width: 16em, image("resources/HAW_Marke_RGB_300dpi.jpg")))

    #align(horizon)[
      #text(weight: "bold")[#kind]

      #text(font: "Martel", size: 2em, weight: "black", title)

      #line(stroke: haw-blue + 3pt, length: 2.2em)
      #v(1.5em)

      #let d = if date == auto { datetime.today() } else { date }
      vorgelegt am #d.day(). #monate.at(d.month() - 1) #d.year()\
      *#author*

    ]
    #align(center + bottom, block(width: 50%, align(left)[
      Erstprüfer:  #erstprüfer\
      Zweitprüfer: #zweitprüfer

      #v(1em)
      #line(stroke: haw-blue + 3pt, length: 2.2em)
      #v(1em)

      #text(weight: "bold")[HOCHSCHULE FÜR ANGEWANDTE WISSENSCHAFTEN HAMBURG]\
      Department #department.name\
      #department.address
    ]))
  ]
  pagebreak()

  // Abstract page
  if abstract-de != none or abstract-en != none {
    set page(numbering: none)
    if abstract-de != none {
      heading(level: 1, numbering: none, outlined: false)[Zusammenfassung]
      abstract-de
    }
    if abstract-en != none {
      v(2em)
      set text(lang: "en")
      heading(level: 1, numbering: none, outlined: false)[Abstract]
      abstract-en
    }
    pagebreak()
  }

  heading(level: 1, numbering: none, outlined: false)[Inhaltsverzeichnis]
  outline(title: none, indent: 1.5em)

  pagebreak()

  set page(numbering: "1")
  counter(page).update(1)
  body
}

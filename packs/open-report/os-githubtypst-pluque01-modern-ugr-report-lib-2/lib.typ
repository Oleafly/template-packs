#let traducir_mes = fecha => {
  // Month translation dictionary
  let meses = (
    "January": "enero",
    "February": "febrero",
    "March": "marzo",
    "April": "abril",
    "May": "mayo",
    "June": "junio",
    "July": "julio",
    "August": "agosto",
    "September": "septiembre",
    "October": "octubre",
    "November": "noviembre",
    "December": "diciembre",
  )

  // Replace month in english for its tranlation
  let fecha_traducida = fecha
  for llave in meses.keys() {
    if fecha.contains(llave) {
      fecha_traducida = fecha_traducida.replace(llave, meses.at(llave))
    }
  }
  fecha_traducida
}

// Variable definition
#let body-font = ("Charis SIL", "Charter")
#let sans-font = ("Open Sans", "Noto Sans")
#let ugr-color = rgb(233, 44, 48)

// Project definition
#let project(title: "", subtitle: "", authors: (), city: "", date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  // Disable numbering by default, numbering will be set on footer manually
  set page(numbering: none)

  // Define custom color for links
  show link: it => {
    text(fill: ugr-color, it)
  }

  // Define custom caption
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.caption: it => (
    context {
      set text(fill: ugr-color, weight: "bold")
      it.supplement + " "
      it.counter.display() + ": "
      set text(fill: black, weight: "regular")
      it.body
    }
  )

  // Define custom color for references
  show ref: set text(fill: ugr-color)

  // Define custom enum with format
  set enum(
    indent: 1em, full: true, // necessary to receive all numbers at once, so we can know which level we are at
    numbering: (..nums) => {
      let nums = nums.pos() // just positional args
      let num = nums.last() // just the current level’s number
      let level = nums.len() // level is the amount of numbers available

      // format for current level (or stop at i. If going too deep)
      let format = ("1.", "[a]", "i.").at(calc.min(2, level - 1))
      let result = numbering(format, num) // formatted number
      text(fill: ugr-color, weight: "bold", result)
    },
  )
  // Necessary to not accumulate indentation
  show enum: it => {
    set enum(indent: 0em)
    it
  }

  // Define custom list
  set list(
    indent: 1em,
    marker: (
      text(fill: ugr-color)[■],
      text(fill: ugr-color)[□],
      text(fill: ugr-color)[◦],
    ),
  )
  show list: it => {
    // Necessary to not accumulate indentation
    set list(indent: 0em)
    it
  }

  // Set body font family.
  set text(font: body-font, lang: "es")

  // Adjust heading settings
  show heading: set text(font: sans-font, fill: ugr-color)
  show heading: set block(below: 16pt) // Bottom margin
  set heading(numbering: "1.1.")

  // Define custom code block
  show raw.where(block: true): code => {
    show raw.line: line => {
      text(fill: gray)[#line.number]
      h(1em)
      line.body
    }
    block(
      fill: color.linear-rgb(240, 240, 240),
      stroke: 0.5pt + gray,
      width: 100%,
      inset: 1em,
      code,
    )
  }

  // Title page.
  //set page(margin: 4cm)
  v(0.6fr)
  grid(
    columns: (1fr, 2fr), rows: auto, align: horizon, column-gutter: 16pt, image(
      "UGR-MARCA-01-color.svg",
      width: 100%,
    ), grid.cell(
      block(
        outset: 10pt,
        stroke: (left: 2pt + red),
        stack(
          spacing: 16pt,
          par(leading: 0.3em, text(font: sans-font, 18pt, weight: 700, title)),
          if subtitle != "" {
            par(leading: 0.3em, text(font: sans-font, 14pt, weight: 500, subtitle))
          },
        ),
      ),
    ),
  )
  v(2fr)
  // Author information.
  align(
    center,
    table(columns: (auto), align: center, stroke: none, if authors.len() > 1 {
        table.header(strong("Autores"))
      } else {
        table.header(strong("Autor"))
      }, table.hline(), ..authors.map(author => author)),
  )

  v(9.6fr)

  if date != none {
    text(1.1em, date)
  } else {
    align(
      center,
      text(
        1.1em,
        city + ", " + traducir_mes(datetime.today().display("[day] de [month repr:long] de [year]")),
      ),
    )
  }

  v(1.2em, weak: true)
  pagebreak()

  set page(
    margin: auto,
    // Header with logo and title
    header: grid(
      columns: (1fr, 1fr), rows: auto, pad(bottom: 4pt, image("UGR-MARCA-02-color.svg", width: 30%)), align(right + horizon, par(leading: 0.3em, title)), grid.hline(stroke: 0.5pt + black),
    ),
  )

  // Table of contents settings
  show outline.entry.where(level: 1): it => {
    v(16pt, weak: true)
    strong(it)
  }
  outline(depth: 3, indent: true, fill: repeat([.], gap: 3pt))
  pagebreak()

  // Main body.
  //set page(numbering: "1", number-align: center)
  counter(page).update(1)

  // Page footer definition
  set page(footer: context [
    #line(length: 100%, stroke: 0.5pt + black)
    #set align(center)
    Página
    #counter(page).display("1")
  ])

  set par(justify: true)

  body
}

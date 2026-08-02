#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

// ctk-invoice definition starts here

#let ctk-invoice(
  title: none,
  authors: none,
  date: none,
  invoice-number: none,
  invoice-period: none,
  invoice-re: none,
  rate: none,
  cols: 1,
  margin: (x: 1in, y: 1in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  linestretch: 1,
  linkcolor: "#800000",
  doc,
) = {

  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(
    justify: true,
    leading: linestretch * 0.65em,
  )
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )

  show link: this => {
    if type(this.dest) != label {
      text(this, fill: rgb(linkcolor.replace("\\#", "#")))
    } else {
      text(this, fill: rgb("#0000CC"))
    }
  }

  // Title
  if title != none {
    align(center)[
      #text(weight: "bold", size: 18pt)[#smallcaps(title)]
    ]
    v(4pt)
  }

  // Invoice metadata
  if date != none or invoice-number != none {
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [#if date != none [*Invoice date:* #date]],
      [#if invoice-number != none [*Invoice \#:* #invoice-number]],
    )
  }
  if invoice-period != none {
    [*Invoice period:* #invoice-period]
  }

  v(1em)
  line(length: 100%)
  v(0.5em)

  // Author block (from)
  if authors != none {
    for author in authors {
      text(weight: "bold")[From:]
      linebreak()
      author.name
      if "address" in author {
        linebreak()
        author.address
      }
      if "email" in author {
        linebreak()
        link("mailto:" + to-string(author.email))
      }
    }
  }

  // Re: matter
  if invoice-re != none {
    v(1em)
    [*Re:* #invoice-re]
  }

  v(0.5em)
  line(length: 100%)
  v(1em)

  // Rate note
  if rate != none {
    [*Rate:* #rate]
    v(0.5em)
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#let _last-row = state("_last-row", -1)

#show table: it => {
  let body-cells = it.children.filter(c => c.func() == table.cell)
  let ncols = if type(it.columns) == int { it.columns } else { it.columns.len() }
  let nrows = calc.div-euclid(body-cells.len(), ncols)
  // body rows are y=1..nrows (header is y=0), so last body row is y=nrows
  _last-row.update(nrows)
  align(center, block(stroke: (bottom: 0.75pt + black), it))
}

#set table(
  inset: 6pt,
  stroke: (x, y) => (
    top: if y <= 1 { 0.75pt + black } else { none },
    bottom: none,
    left: none,
    right: none,
  ),
)
#show table.cell.where(y: 0): set text(weight: "bold")
#show table.cell: it => context {
  let last = _last-row.get()
  if it.y == last {
    set text(weight: "bold")
    place(top, line(length: 100%, stroke: 0.75pt + black))
    v(2pt)
    it
  } else {
    it
  }
}

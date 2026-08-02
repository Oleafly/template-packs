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

#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  headerleft: none,
  headerright: none,
  cols: 1,
  margin: (x: 1in, y: 1in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  linkcolor: "#A41034",
  linestretch: 1,
  doc,
) = {

  if headerleft == none {
    headerleft = hide("left")
  }
  if headerright == none {
    headerright = hide("right")
  }

  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    header: [
      #headerleft
      #h(1fr) #headerright
      #v(-8pt)
      #line(length: 100%)
    ],
    header-ascent: 30%,
  )
  set par(
    justify: true,
    first-line-indent: 1em,
    leading: linestretch * 0.65em,
  )
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )
  set heading(numbering: sectionnumbering)

  show link: this => {
    if type(this.dest) != label {
      text(this, fill: rgb(linkcolor.replace("\\#", "#")))
    } else {
      text(this, fill: rgb("#0000CC"))
    }
  }

  show ref: this => {
    text(this, fill: rgb("#640872"))
  }

  if title != none {
    align(center)[
      #text(weight: "bold", size: 18pt)[#smallcaps(title)]
      #if subtitle != none {
        linebreak()
        text(smallcaps(subtitle), size: 12pt, weight: "semibold")
        v(10pt)
      }
    ]
    v(-10pt)

  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 0em,
      inset: 0pt,
      ..authors.map(author => align(
        center,
        {
          text(size: 14pt)[#author.name]
        },
      ))
    )
  }

  if date != none {
    align(center)[
      #date
    ]
  }

  if abstract != none {
    block(inset: 2em)[
      #text(weight: "semibold")[$labels.abstract$] #h(1em) #abstract
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none,
)

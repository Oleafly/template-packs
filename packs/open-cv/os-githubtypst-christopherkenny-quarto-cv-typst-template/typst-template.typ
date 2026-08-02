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

#set bibliography(style: "chicago-author-date")

#let cv(
  authors: none,
  date: none,
  cols: 1,
  margin: (x: 1in, y: 1in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: none,
  fontsize: 12pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  linestretch: 1,
  linkcolor: "#800000",
  doc,
) = {

  // sorry no sharing CVs
  let author = if authors != none {
    authors.first()
  } else {
    none
  }

  set page(
    paper: paper,
    margin: margin,
    numbering: "1"
  )
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize
  )

    show link: this => {
    if type(this.dest) != label {
      text(this, fill: rgb(linkcolor.replace("\\#", "#")))
    } else {
      text(this, fill: rgb("#0000CC"))
    }
  }

  // handle first page header
  set heading(numbering: sectionnumbering)
  show heading.where(level: 1): head => block(width: 100%)[#text(weight: "bold", to-string(head.body)) #v(-14pt) #line(length: 100%)]

  if authors != none {
    align(center, {
      if "degrees" in author {
        text(weight: "bold", size: 24pt, author.name + ", " + author.degrees)
      } else {
        text(weight: "bold", size: 24pt, author.name)
      }
      if "role" in author [
        \ #author.role
      ]

      if "department" in author [
        \ #author.department
      ]

      if "university" in author [
        \ #author.university
      ]
    })

    let contact_block = ()
    let approx_fills = ()
    if "phone" in author {
      contact_block.push([#link("tel:" + author.phone)])
      approx_fills.push(1fr)
    }
    if "email" in author {
      contact_block.push([#link("mailto:" + to-string(author.email))])
      approx_fills.push(2fr)
    }
    if "website" in author {
      contact_block.push([#link(to-string(author.website))])
      approx_fills.push(3fr)
    }

    let n_contacts = contact_block.len()

    if n_contacts > 0 {
      grid(
        columns: approx_fills,
        inset: 0pt,
        gutter: 0pt,
        ..contact_block.map(contact => align(center, {
          contact
          })
        )
      )
    }
  }

  if date != none {
    align(center)[#date]
  }
  //line(length: 100%)

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
    line(length: 100%)
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)

#let proc-years(yrs) = {
  if "start" in yrs {
    if "end" in yrs {
      str(yrs.start) + sym.dash.en + str(yrs.end)
    } else {
      str(yrs.start) + sym.dash.en + "Present"
    }
  } else if "end" in yrs {
      str(yrs.end)
  } else {
    none
  }
}

#let list-education(file) = {
  let info = yaml(file).education

  let n_uni = info.len()

  for i in range(n_uni) {
    text(weight: "bold", size: 16pt, info.keys().at(i))
    v(-0.5em)
    for uni in info.values().at(i) {
      grid(
        inset: 0pt,
        columns:(4fr, 1fr),
        align: (left, right),
        gutter: 0pt,
        uni.degree, proc-years(uni.year)
      )
    }
  }
}

#let list-appointments(file) = {
  let info = yaml(file).appointments

  let n_jobs = info.len()

  for i in range(n_jobs) {
    text(weight: "bold", size: 16pt, info.keys().at(i))
    v(-0.5em)
    for job in info.values().at(i) {

      grid(
          columns:(4fr, 1fr),
          align: (left, right),
          gutter: 0pt,
          job.position, if "year" in job { proc-years(job.year) } else { "" }
      )
    }
  }
}

#let list-positions(file) = {
  let info = yaml(file).positions

  let n_jobs = info.len()

  for i in range(n_jobs) {
    text(weight: "bold", size: 16pt, info.keys().at(i))
    v(-0.5em)
    for job in info.values().at(i) {

      grid(
          columns:(4fr, 1fr),
          align: (left, right),
          gutter: 0pt,
          job.position, if "year" in job { proc-years(job.year) } else { "" }
      )
    }
  }
}

#let list-honors(file) = {
  let honors = yaml(file).honors

  for honor in honors {
    grid(
      columns: (1fr, 11fr),
      align: (left, left),
      gutter: 0.75em,
      // Show year if it exists
      if "year" in honor { str(honor.year) } else { "" },
      block[
        #strong(honor.title)
        #if "organization" in honor {
          sym.dash.em
          emph(" " + honor.organization)
        }
        #if "description" in honor {
          sym.dash.em
          text(" " + honor.description)
        }
      ]
    )
    v(0.5em)
  }
}

#let list-bibliography(file) = {
  bibliography(file, title: none,
    full: true, style: "chicago-author-date")
}

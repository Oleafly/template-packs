#import "@preview/tablex:0.0.6": tablex


#let TABLE_STROKE = 0.5pt + black

#show terms: it => {
  it
    .children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
    ])
    .join()
}

#let swedish_month(month_num) = {
  let months = (
    "januari",
    "februari",
    "mars",
    "april",
    "maj",
    "juni",
    "juli",
    "augusti",
    "september",
    "oktober",
    "november",
    "december",
  )

  let month = months.at(month_num - 1)

  return month
}

#let format_date(date, lang: none) = {
  if lang == "sv" [
    #date.day() #swedish_month(date.month()) #date.year()
  ] else {
    date.display("[month repr:long] [day padding:none], [year]")
  }
}

#let is_outline_page = state("is_outline_page", false)
#let last_outline_page = state("last_outline_page", false)

#let page_header(
  subtitle: none, // Text in the top-left corner
  skip_chapter_numbers_for: (), // A list of chapter names to skip numbering for
) = (
  context {
    let page_number = counter(page).get().first()

    // In this context, a "chapter" would be a level 1 heading

    let chapter_headings = query(heading.where(level: 1)).rev()

    let chapter_heading = chapter_headings.find(h => (
      h.location().page() <= here().page()
    ))

    if (chapter_heading == none) {
      return
    }

    let chapter_number = counter(heading).at(chapter_heading.location()).first()

    if page_number > 0 {
      if chapter_heading != none {
        let numbering_scheme = if chapter_heading.numbering != none {
          chapter_heading.numbering
        } else {
          "1."
        }

        let chapter = (
          name: chapter_heading.body,
          number: chapter_number,
        )

        let can_number_chapter = (
          (not is_outline_page.get()) and chapter_number != none
        )
        let should_number_chapter = not skip_chapter_numbers_for.contains(
          chapter.name.text,
        )

        let num_text = if can_number_chapter and should_number_chapter {
          numbering(numbering_scheme, chapter_number)
        } else {
          none
        }

        block(below: 0.5em)[
          #smallcaps(subtitle) #h(1fr) #num_text #chapter.name
        ]
        line(length: 100%)
      }
    }
  }
)

#let pagefooter(date: none, lang: none) = (
  context {
    let pagenumber = counter(page).get().first()

    if pagenumber != 0 [
      #line(length: 100%)
      #columns(3)[
        // #author.name, #username

        #colbreak()

        #set align(center)

        #if is_outline_page.get() or last_outline_page.get() {
          counter(page).display("i")
        } else {
          counter(page).display()
        }

        #colbreak()

        #set align(right)

        #format_date(date, lang: lang)
      ]
    ]
  }
)

#let title_page(
  title: none,
  subtitle: none,
  authors: none,
  graders: (),
  graders_label: none,
  date: none,
  lang: none,
) = {
  set table(stroke: TABLE_STROKE)

  columns(2)[
    // Empty top left corner.

    #colbreak()

    #set align(right)

    *#format_date(date, lang: lang)*
  ]

  v(4cm)

  if title != none {
    align(center)[
      #block(
        inset: 1em,
        above: 4em,
        below: 1em,
      )[
        #text(size: 24pt)[
          #title
        ]
      ]]
  }

  if subtitle != none {
    align(
      center,
      block(
        inset: 1em,
        text(
          weight: "thin",
          size: 20pt,
        )[
          #subtitle
        ],
      ),
    )
  }

  // The DOA template had labels for name and username
  // let name_label = if lang == "sv" [Namn] else [Name]
  // let username_label = if lang == "sv" [Användarnamn] else [Username]

  if authors != none {
    align(
      center,
      block(
        inset: 1em,
        grid(
          columns: array.range(authors.len()).map(n => auto),
          row-gutter: 1.5em,
          column-gutter: 3em,
          ..authors.map(author => {
            [
              #set align(center)
              #set text(size: 14pt)

              #author.name
            ]
          }),
          ..authors.map(author => block(if "email" in author {
            let link_title = if "username" in author {
              author.username
            } else {
              author.email
            }

            let email_link = "mailto:" + author.email

            link(email_link)[#raw(link_title)]
          } else {
            if "username" in author {
              raw(author.username)
            }
          }))
        ),
      ),
    )
  }

  v(1fr)

  let graders_label = if graders_label != none {
    graders_label
  } else {
    if lang == "sv" [Labrättare] else [Graders]
  }

  if graders.len() > 0 {
    align(
      center,
      block()[
        #text(size: 14pt)[
          *#graders_label*
        ] \
        #text(size: 12pt)[
          #graders.join(pagebreak())
        ]
      ],
    )
  }
}

// Call this function to use the template
#let conf(
  title: none,
  authors: none,
  subtitle: none,
  date: datetime.today(),
  graders: (),
  graders_label: none,
  skip_chapter_numbers_for: ("References", "Referenser"),
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "a4",
  lang: "sv",
  region: "SE",
  font: none,
  fontsize: 12pt,
  outline: outline(),
  doc,
) = {
  show figure.where(kind: table): set figure.caption(position: top)

  // Decimal comma for Swedish
  show math.equation: it => if lang == "sv" {
    show regex("\d+\.\d+"): it => {
      show ".": {
        "," + h(0pt)
      }
      it
    }
    it
  } else {
    it
  }

  show heading: it => {
    set text(weight: "regular")

    let above = if it.level > 1 {
      2em
    } else {
      1em
    }

    block(
      above: above,
      it,
    )
  }

  counter(page).update(0)

  set page(
    paper: paper,
    margin: margin,
    header: page_header(
      subtitle: subtitle,
      skip_chapter_numbers_for: skip_chapter_numbers_for,
    ),
    footer: pagefooter(
      date: date,
      lang: lang,
    ),
  )

  set text(
    lang: lang,
    region: region,
    size: fontsize,
  )

  if font != none {
    set text(font: font)
  }

  title_page(
    title: title,
    subtitle: subtitle,
    authors: authors,
    graders: graders,
    graders_label: graders_label,
    date: date,
    lang: lang,
  )

  set par(justify: true)
  set heading(numbering: "1.1")

  if (outline != none) {
    is_outline_page.update(true)

    pagebreak()

    counter(page).update(1)
    outline

    last_outline_page.update(true)
    is_outline_page.update(false)

    pagebreak()

    last_outline_page.update(false)
  }

  set page(numbering: "1")

  counter(page).update(1)

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

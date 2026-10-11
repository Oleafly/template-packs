#import "helpers.typ": *
#import "../common.typ": default-accent-color

// Default signature block
#let default-signature(author, language, alignment, padding) = {
  align(alignment, pad(..padding)[
    #text(weight: "light")[
      #linguify("sincerely", from: lang-data)#if (language != "de") [#sym.comma]
    ] \
    #if ("signature" in author) {
      author.signature
    } \
    #text(weight: "bold")[#author.firstname #author.lastname]
  ])
}

// Default closing block
#let default-closing() = {
  align(bottom)[
    #text(weight: "light", style: "italic")[
      #linguify("attached", from: lang-data)#sym.colon #linguify(
        "curriculum-vitae",
        from: lang-data,
      )
    ]
  ]
}

// Main cover letter show rule
#let coverletter(
  author: (:),
  profile-picture: none,
  contact-items-separator: box(width: 6pt, align(center, sym.bar.v)),
  contact-items-inset: (:),
  heading-padding: (above: 2em, below: 1em),
  signature-padding: (top: 1em),
  signature-alignment: left,
  par-spacing: 1.5em,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: default-accent-color,
  language: "en",
  font: "Source Sans 3",
  header-font: "Roboto",
  show-footer: true,
  signature: none,
  closing: none,
  paper-size: "a4",
  use-smallcaps: true,
  show-address-icon: false,
  description: none,
  keywords: (),
  body,
) = {
  if type(accent-color) == str {
    accent-color = rgb(accent-color)
  }

  if signature == none {
    signature = default-signature(
      author,
      language,
      signature-alignment,
      signature-padding,
    )
  }

  if closing == none {
    closing = default-closing()
  }

  let desc = if description == none {
    (
      lflib._linguify("cover-letter", lang: language, from: lang-data).ok
        + " "
        + author.firstname
        + " "
        + author.lastname
    )
  } else {
    description
  }

  show: body => context {
    set document(
      author: author.firstname + " " + author.lastname,
      title: lflib
        ._linguify("cover-letter", lang: language, from: lang-data)
        .ok,
      description: desc,
      keywords: keywords,
    )
    body
  }

  set text(
    font: font,
    lang: language,
    size: 11pt,
    fill: color-darkgray,
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (
      left: 15mm,
      right: 15mm,
      top: 10mm,
      bottom: if show-footer { 20mm } else { 10mm },
    ),
    footer: if show-footer [
      #__coverletter_footer(
        author,
        language,
        date,
        use-smallcaps: use-smallcaps,
      )
    ] else [],
    footer-descent: 35%,
  )

  set par(..default-par)
  set heading(numbering: none, outlined: false)

  show heading: it => block(..heading-padding)[
    #set text(size: 16pt, weight: "regular")
    #align(left)[
      #text[#strong[#text(accent-color)[#it.body]]]
      #box(width: 1fr, line(length: 100%))
    ]
  ]

  // Name (right-aligned for cover letter)
  let name = {
    align(right)[
      #pad(bottom: 5pt)[
        #block[
          #set text(size: 32pt, style: "normal", font: header-font)
          #if language == "zh" or language == "ja" [
            #text(accent-color, weight: "bold")[#author.lastname]#text(
              weight: "bold",
            )[#author.firstname]
          ] else [
            #text(accent-color, weight: "thin")[#author.firstname]
            #text(weight: "bold")[#author.lastname]
          ]
        ]
      ]
    ]
  }

  let positions = {
    set text(accent-color, size: 9pt, weight: "regular")
    align(right)[
      #__apply_smallcaps(
        author.positions.join(text[#"  "#sym.dot.c#"  "]),
        use-smallcaps,
      )
    ]
  }

  let address = {
    set text(size: 9pt, weight: "bold", fill: color-gray)
    align(right)[
      #if ("address" in author) [
        #if show-address-icon [
          #__contact_item(
            (icon: address-icon, text: text(author.address)),
            inset: contact-items-inset,
          )
        ] else [
          #text(author.address)
        ]
      ]
    ]
  }

  let contacts = {
    set text(size: 8pt, weight: "light", style: "normal")
    let items = __format_contact_items(author)
    align(right, items.join(contact-items-separator))
  }

  // Cover letter header: photo left, info right (or info alone if no photo)
  let letter-header = if profile-picture != none {
    grid(
      columns: (1fr, 2fr),
      rows: 100pt,
      align(left + horizon)[
        #block(
          clip: true,
          stroke: 0pt,
          radius: 2cm,
          width: 4cm,
          height: 4cm,
          profile-picture,
        )
      ],
      [
        #name
        #positions
        #address
        #contacts
      ],
    )
  } else {
    name
    positions
    address
    contacts
  }

  letter-header
  {
    set par(spacing: par-spacing)
    set text(weight: "light")
    body
  }
  signature
  closing
}

// --- Cover Letter Content Functions ---

// Hiring company information block
#let hiring-entity-info(
  entity-info: (:),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  use-smallcaps: true,
) = {
  set par(leading: 1em, ..default-par)
  pad(top: 1.5em, bottom: 1.5em)[
    #__justify_align[
      #text(weight: "bold", size: 12pt)[#entity-info.target]
    ][
      #text(weight: "light", style: "italic", size: 9pt)[#date]
    ]
    #pad(top: 0.65em, bottom: 0.65em)[
      #text(weight: "regular", fill: color-gray, size: 9pt)[
        #__apply_smallcaps(entity-info.name, use-smallcaps) \
        #entity-info.street-address \
        #entity-info.city \
      ]
    ]
  ]
}

// Letter heading with job position and salutation
#let letter-heading(
  job-position: "",
  addressee: "",
  dear: "",
  padding: (top: 1em, bottom: 1em),
) = {
  set par(..default-par)
  underline(evade: false, stroke: 0.5pt, offset: 0.3em)[
    #text(weight: "bold", size: 12pt)[
      #linguify("letter-position-pretext", from: lang-data) #job-position
    ]
  ]
  pad(..padding)[
    #text(weight: "light", fill: color-gray)[
      #if dear == "" [
        #linguify("dear", from: lang-data)
      ] else [
        #dear
      ]
      #addressee,
    ]
  ]
}

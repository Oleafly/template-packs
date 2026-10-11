#import "helpers.typ": *
#import "../common.typ": default-accent-color

// Main resume show rule
#let resume(
  author: (:),
  profile-picture: none,
  contact-items-separator: h(10pt),
  contact-items-inset: (left: 4pt),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: default-accent-color,
  colored-headers: true,
  show-footer: true,
  language: "en",
  font: "Source Sans 3",
  header-font: "Roboto",
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

  let desc = if description == none {
    (
      lflib._linguify("resume", lang: language, from: lang-data).ok
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
      title: lflib._linguify("resume", lang: language, from: lang-data).ok,
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
      #__resume_footer(author, language, date, use-smallcaps: use-smallcaps)
    ] else [],
    footer-descent: 35%,
  )

  set par(spacing: 0.75em, justify: true)
  set heading(numbering: none, outlined: false)

  show heading.where(level: 1): it => block(sticky: true)[
    #set text(size: 16pt, weight: "regular")
    #set align(left)
    #set block(above: 1em)
    #let color = if colored-headers { accent-color } else { color-darkgray }
    #text[#strong[#text(color)[#it.body]]]
    #box(width: 1fr, line(length: 100%))
  ]

  show heading.where(level: 2): it => {
    set text(color-darkgray, size: 12pt, style: "normal", weight: "bold")
    it.body
  }

  show heading.where(level: 3): it => {
    set text(size: 10pt, weight: "regular")
    __apply_smallcaps(it.body, use-smallcaps)
  }

  // Name block
  let name = {
    align(center)[
      #pad(bottom: 5pt)[
        #block[
          #set text(size: 32pt, style: "normal", font: header-font)
          #if language == "zh" or language == "ja" [
            #text(accent-color, weight: "bold")[#author.lastname]#text(
              weight: "thin",
            )[#author.firstname]
          ] else [
            #text(accent-color, weight: "thin")[#author.firstname]
            #text(weight: "bold")[#author.lastname]
          ]
        ]
      ]
    ]
  }

  // Positions line
  let positions = {
    set text(accent-color, size: 9pt, weight: "regular")
    align(center)[
      #__apply_smallcaps(
        author.positions.join(text[#"  "#sym.dot.c#"  "]),
        use-smallcaps,
      )
    ]
  }

  // Address line
  let address = {
    set text(size: 9pt, weight: "regular")
    align(center)[
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

  // Contact items
  let contacts = {
    set box(height: 9pt)
    set text(size: 9pt, weight: "regular", style: "normal")
    let items = __format_contact_items(author, item-inset: contact-items-inset)
    align(center, items.join(contact-items-separator))
  }

  // Header layout (with or without photo)
  if profile-picture != none {
    grid(
      columns: (100% - 4cm, 4cm),
      rows: 100pt,
      gutter: 10pt,
      [
        #name
        #positions
        #address
        #contacts
      ],
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
    )
  } else {
    name
    positions
    address
    contacts
  }

  body
}

// --- Resume Content Functions ---

// Body content for resume entries (bullet points, descriptions)
#let resume-item(body) = {
  set text(size: 10pt, style: "normal", weight: "light", fill: color-darknight)
  set block(above: 0.75em, below: 1.25em)
  set par(leading: 0.65em)
  block(above: 0.5em)[#body]
}

// Resume entry header (title/location/date/description in justified layout)
#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: "",
  title-link: none,
  accent-color: default-accent-color,
  location-color: default-location-color,
) = {
  let title-content
  if type(title-link) == str {
    title-content = link(title-link)[#title]
  } else {
    title-content = title
  }
  block(above: 1em, below: 0.65em, sticky: true)[
    #pad[
      #justified-header(title-content, location)
      #if description != "" or date != "" [
        #secondary-justified-header(description, date)
      ]
    ]
  ]
}

// Display cumulative GPA
#let resume-gpa(numerator, denominator) = {
  set text(size: 12pt, style: "italic", weight: "light")
  text[Cumulative GPA: #box[#strong[#numerator] / #denominator]]
}

// Certification entry
#let resume-certification(certification, date) = {
  justified-header(certification, date)
}

// Skill category label
#let resume-skill-category(category) = {
  set text(size: 11pt, style: "normal", weight: "bold", hyphenate: false)
  category
}

// Skill values (comma-separated)
#let resume-skill-values(values) = {
  set text(size: 11pt, style: "normal", weight: "light")
  values.join(", ")
}

// Single skill category with values
#let resume-skill-item(category, items) = {
  set block(below: 0.65em)
  set pad(top: 2pt)
  pad[
    #grid(
      columns: (3fr, 8fr),
      gutter: 10pt,
      align: left + top,
      resume-skill-category(category), resume-skill-values(items),
    )
  ]
}

// Multi-category skill grid
#let resume-skill-grid(categories-with-values: (:)) = {
  set block(below: 1.25em)
  set pad(top: 2pt)
  pad[
    #grid(
      columns: (auto, auto),
      gutter: 10pt,
      align: left + top,
      ..categories-with-values
        .pairs()
        .map(((key, value)) => (
          resume-skill-category(key),
          resume-skill-values(value),
        ))
        .flatten()
    )
  ]
}

// GitHub project link with icon
#let github-link(github-path) = {
  set box(height: 11pt)
  align(right + horizon)[
    #fa-icon("github", fill: color-darkgray) #h(2pt) #link(
      "https://github.com/" + github-path,
      github-path,
    )
  ]
}

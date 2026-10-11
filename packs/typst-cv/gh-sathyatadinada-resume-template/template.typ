#let accent_state = state("accent", rgb("#ba0404"))
#let font_state = state("font", "Times New Roman")
#let font_size_state = state("font_size", 11pt)
#let font_color_state = state("font_color", rgb("#050505"))

#let set_variables(
  accent_color,
  font,
  font_size,
  font_color,
) = {
  accent_state.update(accent_color)
  font_state.update(font)
  font_size_state.update(font_size)
  font_color_state.update(font_color)
}

#let resume(body) = {
  context {
    set list(indent: 1em)
    show list: set text(size: 0.92em)

    set text(
      size: font_size_state.get(),
      // font: font_state.get(),
      weight: 300,
      font_color_state.get(),
    )

    body
  }
}

#let name_header(name) = {
  context {
    set text(size: 2em, accent_state.get(), weight: "bold")
    [*#name*]
  }
}

// #let linkedin = text(font: "FontAwesome")[#symbol(
//   "\u{f08c}",
// )]
// #let github = text(font: "FontAwesome")[#symbol(
//   "\u{f09b}",
// )]
// #let home = text(font: "FontAwesome")[#symbol(
//   "\u{f015}",
// )]
// #let envelope = text(font: "FontAwesome")[#symbol(
//   "\u{f0e0}",
// )]
// #let mobile = text(font: "FontAwesome")[#symbol(
//   "\u{f10b}",
// )]
// #let share = text(font: "FontAwesome")[#symbol(
//   "\u{f14d}",
// )]

#let icon(path, size: 10pt) = image(path, width: size, height: size)
#let icon_size = 7.5pt

#let ico_phone = icon("icons/smartphone.svg", size: icon_size)
#let ico_mail = icon("icons/mail.svg", size: icon_size)
#let ico_home = icon("icons/house.svg", size: icon_size)
#let ico_linkedin = icon("icons/linkedin.svg", size: icon_size)
#let ico_github = icon("icons/github.svg", size: icon_size)
#let ico_share = icon("icons/external-link.svg", size: 7pt)

#let header_item(
  ico,
  label,
  size: 0.8em,
  icon_baseline: 0.35em,
  text_baseline: 0.6em,
) = box[
  #grid(
    columns: (auto, auto),
    column-gutter: 0.35em,
    align: (left, center),
    box(baseline: icon_baseline)[#ico],
    box(baseline: text_baseline)[#text(label, size: size)],
  )
]

#let header(
  name: "Sathya Tadinada",
  title: "Student",
  phoneNumber: "123-456-7890",
  email: "sathya@utah.edu",
  linkedinLink: "linkedin.com/in/sathya-tadinada",
  linkedinUsername: "sathya-tadinada",
  githubLink: "github.com/SathyaTadinada",
  githubUsername: "SathyaTadinada",
  site: "tadinada.com",
) = {
  v(-4pt)
  align(center, block[
    #name_header(name) \
    #v(-8pt)

    #let clean_phone = "+1" + phoneNumber.replace(regex("[^0-9]"), "")
    #link("tel:" + clean_phone)[#header_item(ico_phone, phoneNumber, size: 0.9em)]
    | #link("mailto:" + email)[#header_item(ico_mail, email, size: 0.8em)]
    | #link("https://" + site)[#header_item(ico_home, site, size: 0.8em)]
    | #link("https://" + linkedinLink)[#header_item(ico_linkedin, "in/" + linkedinUsername, size: 0.8em)]
    | #link("https://" + githubLink)[#header_item(ico_github, githubUsername, size: 0.8em)]
  ])
  v(-8pt)
}

#let header_with_share_and_title(
  name: "Sathya Tadinada",
  title: "Student",
  phoneNumber: "123-456-7890",
  email: "sathya@utah.edu",
  linkedinLink: "linkedin.com/in/sathya-tadinada",
  linkedinUsername: "sathya-tadinada",
  githubLink: "github.com/SathyaTadinada",
  githubUsername: "SathyaTadinada",
  site: "tadinada.com",
) = {
  v(-4pt)
  align(center, block[
    #name_header(name) \
    #text(title, size: 0.9em) \
    #v(-8pt)
    #let clean_phone = "+1" + phoneNumber.replace(regex("[^0-9]"), "")
    #link("tel:" + clean_phone)[#header_item(ico_phone, phoneNumber, size: 0.9em)] |
    #link("mailto:" + email)[#header_item(ico_mail, email, size: 0.8em)#text(ico_share, size: 0.6em)] |
    #link("https://" + site)[#header_item(ico_home, site, size: 0.8em)#text(ico_share, size: 0.6em)] |
    #link("https://" + linkedinLink)[#header_item(ico_linkedin, "in/" + linkedinUsername, size: 0.8em)#text(ico_share, size: 0.6em)] |
    #link("https://" + githubLink)[#header_item(ico_github, githubUsername, size: 0.8em)#text(ico_share, size: 0.6em)]
  ])
  v(-8pt)
}

#let resume_heading(txt) = {
  v(2pt)
  context {
    show heading: set text(size: 0.92em, weight: "semibold", accent_state.get())

    block[
      = #smallcaps(txt)
      #v(-4pt)
      #line(length: 100%, stroke: 1pt + black)
    ]
  }
}

#let edu_item(
  name: "University of Utah",
  degree: "B.S in Computer Science",
  location: "Salt Lake City, UT",
  date: "Aug. 2022 - May 2026",
  ..details,
) = {
  set block(above: 0.5em, below: 0.3em)
  pad(left: 1em, right: 0.5em, box[#grid(
      columns: (3fr, 1fr),
      align(left)[
        *#name* \
        _#text(degree, size: 0.9em)_ \
      ],
      context align(right)[
        #text(accent_state.get(), date) \
        _#text(location, size: 0.95em)_
      ],
    )
    #list(..details)
  ])
}

#let exp_item(
  name: "Example Workplace",
  role: "Worker",
  date: "June 2023 - May 2028",
  location: "Salt Lake City, UT",
  ..points,
) = {
  set block(above: 0.5em, below: 0.3em)
  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (3fr, 1fr),
      align(left)[
        *#role* \
        _#name _
      ],
      context align(right)[
        #text(accent_state.get(), date) \
        _#text(location, size: 0.95em)_
      ],
    )
    #list(..points)
  ])
}

#let project_item(
  name: "Sample Project",
  details: "Details",
  date: "June 2023 - May 2028",
  ..points,
) = {
  set block(above: 0.5em, below: 0.3em)
  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (3fr, 1fr),
      align(left)[
        *#name* \
        _#text(details, size: 0.91em)_
      ],
      context align(right)[
        #text(accent_state.get(), date) \
      ],
    )
    #list(..points)
  ])
}

#let skill_item(
  category: "Skills",
  skills: "Details, Details, Details",
) = {
  set block(above: 0.7em)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[*#category*: #skills])
}

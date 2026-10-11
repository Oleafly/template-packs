#import "@preview/scienceicons:0.0.6": orcid-icon
#import "@preview/fontawesome:0.6.0": *

#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  orcid: "",
  image-path: "",
  accent-color: "#000000",
  font: "Monaspace Neon NF",
  paper: "a4",
  body,
) = {
  set document(author: author, title: author)

  set text(
    font: font,
    size: 10pt,
    lang: "en",
    ligatures: false,
  )

  set page(
    margin: (top: 0.9in, x: 0.7in),
    paper: paper,
  )

  show link: underline


  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      weight: 700,
      size: 20pt,
    )
    #pad(it.body)
  ]

  // Level 1 Heading
  [= #(author)]

  // Personal Info Helper
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix)]
      } else {
        value
      }
    }
  }

  let headshot(value) = {
    if value != "" {
      box(width: 7em, {
        place(
          bottom + right,
          dy: 0.5em,
          image(value, width: 7em),
        )
      })
    }
  }
  pad(
    top: 0.25em,
    grid(
      columns: (1fr, 7em),
      // Fixed width for the image column
      align: (personal-info-position + bottom, right + bottom),
      column-gutter: 1em,
      [
        #{
          let items = (
            contact-item(pronouns),
            contact-item(phone),
            contact-item(location),
            contact-item(email, prefix: [#fa-icon("envelope")], link-type: "mailto:"),
            contact-item(github, prefix: [#fa-icon("github")], link-type: "https://"),
            contact-item(linkedin, prefix: [#fa-icon("linkedin")], link-type: "https://"),
            contact-item(personal-site, prefix: [#fa-icon("user")], link-type: "https://"),
          )
          items.filter(x => x != none).join("  |  ")
        }
      ],
      headshot(image-path),
    ),
  )
  set par(justify: true)

  body
}

#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(institution),
    top-right: dates,
    bottom-left: emph(degree),
    bottom-right: emph(gpa),
  )
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: company,
    bottom-right: emph(location),
  )
}

#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
) = {
  generic-one-by-two(
    left: {
      if role == "" {
        [*#name* #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      } else {
        [*#role*, #name #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      }
    },
    right: {
      if dates == "" and url != "" {
        link("https://" + url)[#url]
      } else {
        dates
      }
    },
  )
}

#let certificates(
  name: "",
  issuer: "",
  url: "",
  date: "",
) = {
  [
    *#name*, #issuer
    #if url != "" {
      [ (#link("https://" + url)[#url])]
    }
    #h(1fr) #date
  ]
}

#let extracurriculars(
  activity: "",
  dates: "",
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
}

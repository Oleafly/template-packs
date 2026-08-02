#import "@preview/fontawesome:0.5.0": *

#let text-color = black
#let background-color = luma(100%, 0%) // Transparent white
#let primary-color = rgb("#3A468C")
// To avoid messing up with contexts
// #let layoutwidth = layout(size => {return size.width})
// #layoutwidth
#let full-width = 453.45pt
#let bodywidth = 317.41pt
#let line-spacing = 0.8em
// Helper function to get value from sys.inputs or fallback
#let get-input(key, fallback) = {
  if key in sys.inputs.keys() {
    sys.inputs.at(key)
  } else {
    fallback
  }
}

// Define a function to set up style that accepts external variables (fallbacks)
#let setup-style(
  // These values come from the Pandoc template ($variable$) and act as fallbacks
  author: "Default Author",
  email: "default@example.com", // Keep default, likely always needed
  title: "Default Title", // Keep default
  website: none, // Change default to none
  github: none, // Change default to none
  gitlab: none, // Change default to none
  linkedin: none, // Change default to none
  keywords: ("Default",),
  language: "en",
  date: auto,
  hyphenate: auto,
  doc,
) = {
  // Prioritize sys.inputs (from --input args) over template variables (from YAML)
  let effective-author = get-input("author", author)
  let effective-email = get-input("email", email)
  let effective-title = get-input("title", title)
  let effective-website = get-input("website", website)
  let effective-github = get-input("github", github)
  let effective-gitlab = get-input("gitlab", gitlab)
  let effective-linkedin = get-input("linkedin", linkedin)
  // Keywords and date are less likely to be overridden via CLI, but could be added if needed
  let effective-keywords = keywords
  let effective-date = date

  // Document settings
  set text(
    font: "Bitter",
    size: 10.5pt,
    lang: language, // Language might need override too? get-input("language", language)
    fill: text-color,
    hyphenate: hyphenate,
  )

  show heading: set text(
    fill: primary-color,
    font: "Source Sans 3",
    tracking: -0.02em,
    weight: "medium",
    size: 1.4em,
    hyphenate: auto,
  )

  set strong(delta: 200)

  set document(
    title: effective-title,
    author: effective-author,
    date: effective-date,
    keywords: effective-keywords,
  )

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3.0cm),
    header: [
      #set text(
        font: "Source Sans 3",
        size: 0.9em,
      )
      #effective-author // Use effective value
      #h(1fr)
      // Phone only comes from sys.inputs (no YAML equivalent planned)
      #if "phone" in sys.inputs.keys() [
        #link("tel:" + sys.inputs.phone.replace(regex("[^0-9+]"), ""))[
          #text(fill: primary-color)[#fa-phone()]
          #sys.inputs.phone.replace("_", " ") // Allow underscores for spacing
        ]
        |
      ]
      // Use effective email (checks sys.inputs first, then YAML via template var)
      #link("mailto:" + effective-email)[
        #text(fill: primary-color)[#fa-envelope()]
        #effective-email
      ]
      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt)
      #v(-1em)
    ],
    footer: [
      #set text(
        font: "Source Sans 3",
        size: 0.9em,
      )
      #v(-1em)
      #line(length: 100%, stroke: 0.5pt)
      #v(-0.5em)
      // Use effective values for footer links, checking for none
      #if effective-website != none {
        [
          #text(fill: primary-color)[#fa-arrow-up-right-from-square()]
          #link("https://" + effective-website)[#effective-website]
        ]
      }
      #h(1fr) // Keep horizontal space regardless
      // Group social links and add separators conditionally
      #let social-links = ()
      #if effective-github != none {
        social-links.push([#text(fill: black)[#fa-github()] #link(
            "https://github.com/" + effective-github,
          )[#effective-github]])
      }
      #if effective-gitlab != none {
        social-links.push([#text(fill: orange)[#fa-gitlab()] #link(
            "https://gitlab.com/" + effective-gitlab,
          )[#effective-gitlab]])
      }
      #if effective-linkedin != none {
        social-links.push([#text(fill: blue)[#fa-linkedin()] #link(
            "https://www.linkedin.com/in/" + effective-linkedin,
          )[#effective-linkedin]])
      }
      // Display social links with separators
      #social-links.join([ | ])
    ],
  )

  // Paragraph settings
  set par(
    justify: false,
    leading: line-spacing,
  )

  doc
}

// Custom macros
#let horizontalrule = context {
  let current-position = here().position().y
  if current-position > 100pt and current-position < 730pt [
    #line(length: full-width, stroke: 1.5pt + primary-color)
  ]
}

#let hidden-heading(title) = (
  context {
    let heading-size = measure(title)
    [
      #show heading: set text(fill: background-color)
      #v(-1.5 * heading-size.height)
      #title
      #v(-heading-size.height)
    ]
  }
)

#let body-side(body, side: []) = (
  context {
    let body-after-text = measure(block()[Text \ #body], width: bodywidth)
    let text-only = measure([Text])
    [
      #body
      #box()[
        #place(
          right,
          dy: -(body-after-text.height - text-only.height),
          dx: full-width,
        )[
          #set text(
            font: "Source Sans 3",
            size: 0.9em,
          )
          #side
        ]
      ]
      #h(-0.25em)
    ]
  }
)

#let company-location(body) = [
  #text(fill: primary-color)[#fa-location-dot()]
  #body
]

#let event-date(body) = [
  #text(fill: primary-color)[#fa-calendar()]
  #body
]

#let profile-photo(photo) = [
  #box(clip: true, stroke: 1.5pt + primary-color, radius: (
    bottom-left: 0pt,
    bottom-right: 50%,
    top-left: 50%,
    top-right: 0pt,
  ))[#photo]
]

#import "@preview/fontawesome:0.6.0": *

// const icons
#let linkedin-icon = box(
  fa-icon("linkedin"),
)
#let github-icon = box(
  fa-icon("github"),
)
#let twitter-icon = box(
  fa-icon("twitter"),
)
#let google-scholar-icon = box(
  fa-icon("google-scholar"),
)
#let orcid-icon = box(
  fa-icon("orcid"),
)
#let location-icon = box(
  fa-icon("map-marker-alt"),
)
#let phone-icon = box(fa-icon("square-phone"))
#let email-icon = box(fa-icon("envelope"))
#let website-icon = box(fa-icon("globe"))

/// Helpers

/// Left-right aligned header
/// - left (content): The left section of the header
/// - right (content): The right section of the header
#let lr-header(left-content, right-content) = {
  set block(
    above: 0.7em,
    below: 0.7em,
  )
  pad[
    #block[
      #left-content
      #box(width: 1fr)[
        #align(right)[#right-content]
      ]
    ]
  ]
}

/// ---- Resume Template ----

/// Based on [modern-cv](https://github.com/DeveloperPaul123/modern-cv)
///
/// - firstname (string): Author's first name
/// - lastname (string): Author's last name
/// - positions (array): Array of position titles
/// - address (string): Author's address (optional)
/// - phone (string): Author's phone number (optional)
/// - email (string): Author's email (optional)
/// - homepage (string): Author's homepage URL (optional)
/// - github (string): Author's GitHub username (optional)
/// - linkedin (string): Author's LinkedIn username (optional)
/// - twitter (string): Author's Twitter username (optional)
/// - scholar (string): Author's Google Scholar ID (optional)
/// - orcid (string): Author's ORCID ID (optional)
/// - website (string): Author's website URL (optional)
/// - location (string): Author's location (optional)
/// - font (string): The font to use for the resume
/// - body (content): The body of the resume
/// -> none
#let resume(
  firstname: "",
  lastname: "",
  positions: (),
  address: none,
  phone: none,
  email: none,
  homepage: none,
  github: none,
  linkedin: none,
  twitter: none,
  scholar: none,
  orcid: none,
  website: none,
  location: none,
  font: "libertinus serif",
  body,
) = {
  show: body => context {
    set document(
      author: firstname + " " + lastname,
      title: "Resume",
    )
    body
  }

  set text(
    font: font,
    size: 10pt,
    fallback: true,
  )

  set list(
    spacing: 0.75em,
  )

  set page(
    paper: "us-letter",
    margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
  )

  set par(
    spacing: 0.75em,
    justify: true,
  )

  set heading(
    numbering: none,
    outlined: false,
  )

  show heading: it => [
    #set text(
      weight: "thin",
    )
    #set align(left)
    #set block(above: 1em)
    #block(spacing: 0.4em)[
      #smallcaps[#strong[#text[#it.body]]]
    ]
    #box(width: 1fr, line(length: 100%))
  ]

  let name = {
    align(center)[
      #pad(bottom: 0pt)[
        #block[
          #set text(
            size: 28pt,
            style: "normal",
            font: font,
          )
          #text[
            #firstname
            #lastname
          ]
        ]
      ]
    ]
  }

  let positions = {
    set text(
      size: 9pt,
      weight: "regular",
    )
    align(center)[
      #smallcaps[
        #if type(positions) == array [
          #positions.join(
            text[#"  "#sym.dot.c#"  "],
          )
        ] else [
          #positions
        ]
      ]
    ]
  }

  let address = {
    set text(
      size: 9pt,
      weight: "regular",
    )
    align(center)[
      #if address != none [
        #address
      ]
    ]
  }

  let contacts = {
    set box(height: 9pt)

    let separator = box(width: 5pt)

    align(center)[
      #set text(
        size: 9pt,
        weight: "regular",
        style: "normal",
      )
      #block[
        #align(horizon)[
          #if phone != none [
            #phone-icon
            #h(0.5em)
            #box[#text(phone)]
            #separator
          ]
          #if email != none [
            #email-icon
            #h(0.5em)
            #box[#link("mailto:" + email)[#email]]
          ]
          #if homepage != none [
            #separator
            #homepage-icon
            #h(0.5em)
            #box[#link(homepage)[#homepage]]
          ]
          #if github != none [
            #separator
            #github-icon
            #h(0.5em)
            #box[#link("https://github.com/" + github)[#github]]
          ]
          #if linkedin != none [
            #separator
            #linkedin-icon
            #h(0.5em)
            #box[
              #link("https://www.linkedin.com/in/" + linkedin)[#linkedin]
            ]
          ]
          #if twitter != none [
            #separator
            #twitter-icon
            #h(0.5em)
            #box[#link("https://twitter.com/" + twitter)[\@#twitter]]
          ]
          #if scholar != none [
            #let fullname = str(firstname + " " + lastname)
            #separator
            #google-scholar-icon
            #h(0.5em)
            #box[#link("https://scholar.google.com/citations?user=" + scholar)[#fullname]]
          ]
          #if orcid != none [
            #separator
            #orcid-icon
            #h(0.5em)
            #box[#link("https://orcid.org/" + orcid)[#orcid]]
          ]
          #if website != none [
            #separator
            #website-icon
            #h(0.5em)
            #box[#link("https://" + website)[#website]]
          ]
          #if location != none [
            #separator
            #location-icon
            #h(0.5em)
            #box[
              #location
            ]
          ]
        ]
      ]
    ]
  }

  name
  positions
  address
  contacts
  body
}

/// The base item for resume entries.
/// This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - body (content): The body of the resume entry
#let resume-item(body) = {
  set block(
    above: 0.75em,
    below: 1.25em,
  )
  block(above: 0.5em)[
    #body
  ]
}

/// The base item for resume entries. This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - title (string): The title of the resume entry
/// - location (string): The location of the resume entry
/// - start-date (string): The start date of the resume entry
/// - end-date (string): The end date of the resume entry
/// - description (content): The body of the resume entry
/// - title-link (string): The link to use for the title (can be none)
#let resume-entry(
  title: none,
  start-date: "",
  end-date: "",
  description: "",
  title-link: none,
) = {
  let title-content = [
    #strong[#title]
    #if type(title-link) == str [
      #link(title-link)[#fa-link()]
    ]
    #if description != "" [
      ---
      #emph[#description]
    ]
  ]
  let date = [
    #if start-date == "" {
      end-date
    } else {
      [
        #start-date
        ---
        #end-date
      ]
    }
  ]
  block(above: 1em, below: 0.65em)[
    #pad[
      #lr-header(title-content, date)
    ]
  ]
}

#let resume-skill-items(..categories-items) = {
  set block(below: 0.65em)

  block(below: 1.25em)[
    #for entry in categories-items.pos() {
      let category = entry.at(0)
      let items = entry.at(1)

      pad[
        #grid(
          columns: (10fr, 80fr),
          gutter: 10pt,
          align(left)[
            #set text(hyphenate: false)
            *#category*
          ],
          align(left)[
            #set text(
              style: "normal",
              weight: "light",
            )
            #items.join(", ")
          ],
        )
      ]
    }
  ]
}

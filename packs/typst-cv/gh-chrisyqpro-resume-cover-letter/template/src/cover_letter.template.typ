// Inspired by the template from the following guide:
// https://career.engin.umich.edu/sample-cover-letter/
// https://github.com/AbdullahHendy/clickworthy-resume
// From https://github.com/steadyfall/simple-technical-resume-template
//
// Use the same heading from resume
#let cover-letter(
  paper: "us-letter",
  top-margin: 0.5in,
  bottom-margin: 1in,
  left-margin: 1in,
  right-margin: 1in,
  font: "New Computer Modern",
  font-size: 11pt,
  personal-info-font-size: 10pt,
  lang: "en",
  author-name: "",
  author-position: center,
  personal-info-position: center,
  phone: "",
  location: "",
  email: "",
  website: "",
  linkedin-user-id: "",
  github-username: "",
  date: datetime.today(),
  contact-name: "",
  contact-institution: "",
  contact-address: "",
  contact-city: "",
  contact-state: "",
  contact-country: "",
  contact-zip: "",
  body,
) = {
  set document(
    title: "Cover Letter | " + author-name,
    author: author-name,
    keywords: "cover-letter",
    date: date,
  )

  set page(
    paper: paper,
    margin: (
      top: top-margin,
      bottom: bottom-margin,
      left: left-margin,
      right: right-margin,
    ),
  )

  set text(
    font: font,
    size: font-size,
    lang: lang,
    ligatures: false,
  )

  show heading.where(level: 2): it => block(width: 100%)[
    #set text(font-size + 1.5pt, weight: "regular")
    #smallcaps(it.body)
    #v(-0.8em)
    #line(length: 100%, stroke: stroke(thickness: 0.4pt))
    #v(-0.2em)
  ]

  let contact_item(value, link-type: "", prefix: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  align(
    author-position,
    [
      #smallcaps(text(font-size + 13pt, weight: "bold")[#author-name])
      #v(-1.8em)
    ],
  )

  align(
    personal-info-position,
    text(personal-info-font-size)[
      #{
        let sepSpace = 0.2em
        let items = (
          contact_item(phone),
          contact_item(email, link-type: "mailto:"),
          contact_item(website, link-type: "https://"),
          contact_item(linkedin-user-id, link-type: "https://linkedin.com/in/", prefix: "linkedin.com/in/"),
          contact_item(github-username, link-type: "https://github.com/", prefix: "github.com/"),
          contact_item(location),
        )
        items
          .filter(x => x != none)
          .join([
            #show "|": sep => {
              // h(sepSpace)
              [|]
              // h(sepSpace)
            }
            |
          ])
      }
    ],
  )

  pad(
    top: 2em,
    bottom: 2em,
    align(left)[
      #strong()[#date.display("[month repr:long] [day padding:none], [year]")]
    ],
  )

  pad(
    bottom: 2em,
    align(left)[
      #strong[#contact-name] \
      #contact-institution \
      #contact-address \
      #{ contact-city + ", " + contact-state + " " + contact-zip } \
      #contact-country
    ],
  )

  set par(justify: true)

  body

  text(
    font: font,
    size: font-size,
    lang: lang,
  )[
    #"" \ \
    #"Sincerely," \
    #strong[#author-name]
  ]
}

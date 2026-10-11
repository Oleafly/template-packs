#import "typst-letter-template.typ": *

#show: letter.with(
  author: (
    firstname: "Lai",
    lastname: "Wei",
    email: "lai-wei@whu.edu.cn",
    homepage: "https://weilai.group",
    phone: "(+86) 138-0000-0000",
    orcid: "0009-0007-5002-0930",
    github: "WHULai",
    address: "Room A9302, School of Power and Mechanical Engineering,  Wuhan University",
    positions: (
      "Undergraduate Student",
    ),
  ),
  profile-picture: none,
  language: "en",
  font: ("Source Sans Pro", "Source Han Sans SC"),
  header-font: ("Roboto", "Source Han Sans SC"),
  description: "Letter from Lai Wei",
  keywords: "Business Correspondence",
  signature-path: "signature_example.png",
  // attachment-text: "CV",
)

#recipient-info(
  recipient-info: (
    target: "Prof. Alan Turing",
    name: "Department of Computing, University of Manchester",
    street-address: "Manchester, M13 9PL.",
    city: "United Kingdom",
  ),
)

#letter-heading(
  addressee: "Prof. Alan Turing",
  subject: "Subject: Typst Letter Template Adapted from Modern CV"
)

#letter-content[
  I am writing to share the Typst letter template included in this repository, which is adapted from the Modern CV package originally developed by DeveloperPaul123. Whereas the original project presents a cover-letter workflow for job applications, this version reshapes that component into a more general-purpose letter format intended for academic and professional correspondence.
]

#letter-content[
  The revised template preserves the clean typography and balanced header layout of the original design, while making several deliberate changes. In particular, it replaces the `coverletter` and `hiring-entity-info` interface with the more neutral `letter` and `recipient-info` structure, substitutes the job-position heading with an optional subject line, introduces a `letter-content` helper with indented paragraphs, and updates the footer and language metadata from "Cover Letter" to "Letter" for broader multilingual use.
]

#letter-content[
  It also removes the assumption that every letter must accompany a curriculum vitae, so attachments can now be declared only when needed, and it reworks the closing section around a straightforward local signature block better suited to routine standalone letters. In this way, the adaptation keeps the visual discipline of Modern CV while contributing a clearer and lighter interface for everyday formal communication.
]

#letter-content[
  I am grateful to DeveloperPaul123 for the original Modern CV work, which provided the Typst design foundation for this adaptation. I hope this revised template will prove useful to students and faculty members seeking a formal Typst-based alternative for regular correspondence.
]

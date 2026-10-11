// depends: section
#import "template.typ": section, resume

#let wrap-shevron(body) = [#text()[«#body»]]
#let company = none

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
  footer: [
    #set text(gray, 9pt)
    #if company != none [
      Special for #wrap-shevron(company) \
    ]
    Resume updated in #datetime.today().display()
  ]
)

#set text(
  font: "Libertinus Serif",
  size: 11pt,
  lang: "en" // possible to be ru
)

#resume(
  contacts: (
    email: "examle@example.com",
    tel: "+79331860953",
  ),
  socials: (
    telegram: "jogndoe",
    github: "example_user"
  )
)
#section(
  header: [Experience --- 1 year 6 month],
  subsections: (
    (
      label: [August 2025 --- September 2025 \ (2 month)],
      title: [Beautiful work],
      title-postfix: "a bit of information about company",
      description: lorem(7),
    ),
    (
      label: "2020",
      title: "First work exp",
      description: lorem(7),
    )
  )
)
#section(
  header: [Education],
  subsections: (
    (
      label: "2030",
      title: "OmTSU",
      description: lorem(7),
    ),
    (
      label: "2019",
      title: "Musical collegue",
    )
  )
)
#section(
  header: [Certifications],
  subsections: (
    (
      label: "2050",
      title: "Cerify that you're good worker",
      title-postfix: "some additional info",
      href: "https://example.com/they_are_good_worker",
    ),
    (
      label: "2050",
      title: "Certify that you're well being",
      href: "https://example.com/they_are_healthy"
    )
  )
)
#section(
  header: [Skills],
  subsections: (
    (
      label: "Language skills",
      description: "English - B1 - intermidiete",
    ),
    (
      label: "Skills",
      description: "C, gcc, make, valgringd, check, lcov, etc.",
    )
  )
)
#section(
  header: [Additional info],
  subsections: (
    (
      label: "Recomandation",
      title: "Recomendation from well-known organization",
    ),
    (
      label: "About me",
      description: lorem(100),
    )
  )
)
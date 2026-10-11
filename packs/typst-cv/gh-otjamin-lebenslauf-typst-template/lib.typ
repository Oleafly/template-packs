#import "@preview/scienceicons:0.1.0": github-icon, linkedin-icon

#let lebenslauf(
  akzentfarbe: "#92A8D1", // Color Of The Year 2016
  unterschrift: false,
  ort: "Musterhausen",
  name: "Max Mustermann",
  adresse: "Musterstraße 1, 12345 Musterhausen",
  geburtsdatum: none,
  geburtsort: none,
  telefonnummer: "1234 56789",
  email: "max@mustermann.de",
  linkedin: "max-mustermann",
  github: none,
  body,
) = {
  set page(
    paper: "a4",
    margin: 2.5cm,
  )

  set text(
    lang: "de",
  )

  show heading: set text(
    fill: rgb(akzentfarbe),
  )

  show link: set text(
    fill: rgb(akzentfarbe),
  )
  show link: underline

  show heading.where(level: 1): it => {
    set text(
      weight: "bold",
      size: 20pt,
    )
    block(it.body)
  }

  show heading.where(level: 2): it => {
    pad(bottom: -10pt, smallcaps(it.body))
    line(length: 100%, stroke: 0.5pt)
  }

  [= #name]

  if geburtsdatum != none and geburtsort != none {
    pad([
      Geburtsdatum / -ort: #geburtsdatum in #geburtsort
    ])
  }

  if email != none { email = link("mailto:" + email) }
  if linkedin != none {
    linkedin = linkedin-icon(color: rgb(akzentfarbe)) + " " + link("https://www.linkedin.com/in/" + linkedin, linkedin)
  }
  if github != none {
    github = github-icon(color: rgb(akzentfarbe)) + " " + link("https://github.com/" + github, github)
  }

  pad(top: 0.25em, {
    let items = (
      adresse,
      telefonnummer,
      email,
      linkedin,
      github,
    )
    items.filter(x => x != none).join(" | ")
  })

  if linkedin != none { linkedin = linkedin-icon(color: rgb(akzentfarbe)) + " " + linkedin }
  github = github-icon(color: rgb(akzentfarbe)) + " " + github

  body

  if unterschrift {
    pad(top: 4em, [
      #ort, #datetime.today().display("[day].[month].[year]")
    ])
  }
}

#let zwei-mal-zwei(
  oben-links: "",
  oben-rechts: "",
  unten-links: "",
  unten-rechts: "",
) = [
  #oben-links #h(1fr) #oben-rechts \
  #unten-links #h(1fr) #unten-rechts
]

#let ein-mal-zwei(
  links: "",
  rechts: "",
) = [
  #links #h(1fr) #rechts
]

#let zeit-helfer(
  anfangsdatum: datetime(day: 01, month: 01, year: 1970),
  enddatum: datetime(day: 01, month: 01, year: 2016),
) = {
  if anfangsdatum != none {
    if enddatum != none [
      #anfangsdatum.display("[month]/[year]") - #enddatum.display("[month]/[year]")
    ] else [
      Seit #anfangsdatum.display("[month]/[year]")
    ]
  } else []
}

#let arbeit(
  jobtitel: "",
  firma: "",
  ort: "",
  anfangsdatum: datetime(day: 01, month: 01, year: 2016),
  enddatum: none,
) = {
  zwei-mal-zwei(
    oben-links: strong(jobtitel),
    oben-rechts: zeit-helfer(anfangsdatum: anfangsdatum, enddatum: enddatum),
    unten-links: firma,
    unten-rechts: emph(ort),
  )
}

#let bildung(
  einrichtung: "",
  abschluss: "",
  ort: "",
  anfangsdatum: datetime(day: 01, month: 01, year: 2016),
  enddatum: none,
) = {
  zwei-mal-zwei(
    oben-links: strong(einrichtung),
    oben-rechts: zeit-helfer(anfangsdatum: anfangsdatum, enddatum: enddatum),
    unten-links: emph(abschluss),
    unten-rechts: emph(ort),
  )
}

#let sonstiges(
  bezeichnung: "",
  anfangsdatum: datetime(day: 01, month: 01, year: 2016),
  enddatum: none,
) = {
  ein-mal-zwei(
    links: strong(bezeichnung),
    rechts: zeit-helfer(anfangsdatum: anfangsdatum, enddatum: enddatum),
  )
}

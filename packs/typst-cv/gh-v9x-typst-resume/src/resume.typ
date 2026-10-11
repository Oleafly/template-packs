#let font_size(..p) = 10pt * calc.pow(1.250, p.at(0, default: 0))
#let yaml = yaml(sys.inputs.at("loc", default: "../examples/example.yaml"))
#let lang = yaml.at("lang", default: "en")
#let doc = (
  heading_spacing_above: 25pt,
  name_title_spacing: 8pt,
  title_contact_spacing: 10pt,
  leading: 6pt,
  spacing: 8pt,
  bold: 700,
  footer_size: 5pt,
)

#let headings = (
  skills: "SKILLS",
  experience: "WORK EXPERIENCE",
  education: "EDUCATION",
  languages: "LANGUAGES",
) + yaml.at("sections", default: (:))

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2cm),
  footer: context {
    if "footer" in yaml and counter(page).get().first() == counter(page).final().first() {
      text(yaml.footer, size: doc.footer_size)
    }
  },
)
#set text(font: "Inter 18pt", font_size(), lang: lang)
#set par(leading: doc.leading, spacing: doc.spacing)
#set grid(row-gutter: doc.leading)
#show link: c => text(c, weight: 600)

#let section(name, opt: none, content) = {
  block(
    inset: (bottom: 8pt),
    stroke: (bottom: stroke(0.7pt)),
    width: 100%,
    above: doc.heading_spacing_above,
    below: doc.heading_spacing_above / 2,
    heading(text(name, weight: doc.bold, font_size(1))),
  )

  block(inset: (x: 1%), content)
}

#let split(..items) = block(below: doc.heading_spacing_above / 2, above: doc.heading_spacing_above, grid(
  columns: (1fr, 1fr),
  column-gutter: 50pt,
  ..items,
))


#block()[
  #let header_informations = [
    #text(yaml.header.name, font_size(3), weight: doc.bold) \
    #v(doc.name_title_spacing, weak: true)
    #text(yaml.header.title, font_size(2)) \
    #v(doc.title_contact_spacing, weak: true)

    #for (key, value) in yaml.header.contact {
      let display_contact(icon, content) = {
        box(inset: (left: 1pt))[
          #icon
          #h(5pt, weak: true)
          #content
        ]
      }

      let format_value(..template) = {
        if template.at(0, default: none) != none {
          let display = template.at(0).replace("{}", value)
          link(template.at(1, default: "https://www.{}").replace("{}", display), display)
        } else {
          value
        }
      }

      let matches(expected, icon, ..content) = {
        if key == expected {
          display_contact(icon, format_value(..content))
        }
      }

      matches("github", "\u{f09b}", "github.com/{}")
      matches("linkedin", "\u{f08c}", "linkedin.com/in/{}")
      matches("email", "\u{f0e0}", "{}", "mailto:{}")
      matches("phone", "\u{f3cf}")
      matches("location", "\u{f3c5}")

      if key == "other" {
        for (icon, value, ..rest) in value {
          let url = rest.at("url", default: none)

          display_contact(icon, if url != none { link(url, value) } else { value })
        }
      }

      h(15pt)
    }
  ]

  #grid(
    columns: (3fr, 1fr),
    header_informations,
    if "image" in yaml.header {
      grid.cell(align: right, layout(size => {
        let size = calc.min(measure(width: size.width * 3, header_informations).height, size.width)
        block(
          image(yaml.header.image, height: 100%, width: 100%),
          radius: 50%,
          clip: true,
          height: size,
          width: size,
        )
      }))
    },
  )

  #if "intro" in yaml.header {
    v(18pt, weak: true)
    yaml.header.intro
  }
]

#section(headings.skills, grid(
  columns: 2,
  column-gutter: 15pt,
  ..yaml
    .skills
    .pairs()
    .map(c => (grid.cell(text(c.at(0), weight: doc.bold), align: right), c.at(1).join(", ")))
    .flatten(),
))


#section(headings.experience, context {
  let dates_width = calc.min(
    100pt,
    calc.max(..yaml.experience.map(c => (c.date_from, c.date_to)).flatten().map(c => measure(c).width)) + 6pt,
  )

  for (title, company, date_from, date_to, description, ..rest) in yaml.experience {
    let skills = rest.at("skills", default: none)

    block(below: doc.heading_spacing_above / 2, grid(
      columns: (dates_width, auto),
      align: right,
      grid.cell([#date_to \ #date_from], inset: (right: 6pt)),
      grid.cell(align: left, stroke: (left: 0.8pt), inset: (left: 6pt))[
        #text(title, weight: doc.bold) \
        #company
        #block(list(..description), inset: (left: 8pt))
      ],
    ))
  }
})

#section(headings.education, grid(
  columns: 2,
  column-gutter: 15pt,
  ..for (title, place, date_from, date_to) in yaml.education {
    (
      text(date_from + " - " + date_to, weight: doc.bold),
      [#text(title, weight: doc.bold) \ #place],
    )
  }
))

#section(headings.languages, grid(
  columns: 2,
  column-gutter: 15pt,
  ..yaml.languages.pairs().map(c => (text(c.at(0), weight: doc.bold), c.at(1))).flatten()
))

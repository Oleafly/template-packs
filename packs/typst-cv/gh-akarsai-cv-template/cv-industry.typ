// Industry CV.
// Content: cv-data.yaml, appearance: config/cv-settings-industry.yaml.

#let content = yaml("cv-data.yaml")
#let settings = yaml("config/cv-settings-industry.yaml")

#set par(justify: true)
#set page(margin: (x: 1.3cm, y: 1cm))
#set text(font: settings.font.general)
#set par(leading: eval(settings.paragraph.leading))

// alternative link styling: #show link: set text(gradient.linear(..color.map.crest))
#show link: set text(eval(settings.accent-color))

#show heading: h => [
  #v(-5pt)
  #set text(size: eval(settings.font.size.heading_large))
  #h
]

// ------------------------------------------------------------------ header --

#let header = [
  #text(size: eval(settings.font.size.heading_huge))[*#content.name*]
  #v(-8pt)
  #text(size: eval(settings.font.size.heading), font: settings.font.minor_highlight)[#content.title]
]

// contact links, rendered top to bottom in the order of cv-data.yaml
// optional portrait: #image("assets/portrait.jpg", width: 100%)
#let sidebar = [
  #stack(
    dir: ttb,
    spacing: 4pt,
    ..content.contacts.map(contact => text(
      size: eval(settings.font.size.description),
    )[
      #link(contact.link)[#contact.name]
      #v(2pt)
    ]),
  )
]

#grid(
  columns: (1fr, 20%),
  column-gutter: 1em,
  align: (left, left),
  header,
  sidebar,
)

#text(
  eval(settings.font.size.description),
  font: settings.font.minor_highlight,
)[
  #v(3pt)
  #par(justify: true, leading: eval(settings.paragraph.leading))[
    #eval(content.industry-summary, mode: "markup")
  ]
]

// ------------------------------------------------------------------ content --

= Research Highlights

#{
  for highlight in content.research_highlights [
    #text(size: eval(settings.font.size.description))[
      *#highlight.name*\
      #eval(highlight.info, mode: "markup")
      #h(1fr)
      #highlight.further_reading.map(source => link(source.url)[#source.name]).join(", ")
      #v(-2pt)
    ]
  ]
}

= Experience

#for job in content.experience {
  text(
    size: eval(settings.font.size.description),
    font: settings.font.minor_highlight,
  )[
    *#job.name*
    (#h(-3pt)
    #if "bonusname" in job [
      #job.bonusname,
    ]
    #if "since" in job [
      since #job.since)
    ] else if "from" in job [
      #job.from - #job.to)
    ] else [
      #job.to)
    ]
    •
    #job.employer
    \
    #text(size: eval(settings.font.size.description))[
      #job.activity
    ]
  ]
  v(-3pt)
}

#v(3pt)

= Education

#{
  for place in content.education [
    #text(size: eval(settings.font.size.description))[
      *#place.degree #place.major*
      #text(
        eval(settings.font.size.description),
        font: settings.font.minor_highlight,
      )[
        #if "since" in place [
          #if "expected" in place [
            (since #place.since, expected completion #place.expected)
          ] else if "defended" in place [
            (since #place.since, defended #place.defended)
          ] else [
            (since #place.since)
          ]
        ] else if "from" in place [
          (#place.from - #place.to)
        ] else [
          (#place.to)
        ]
        •
        #place.university.name
        #if "grade" in place [
          • #if not "no_grade_title" in place [Grade] #eval(place.grade, mode: "markup")
        ]
        #if "grading_system" in place [
          #text(size: eval(settings.font.size.tiny))[(#place.grading_system)]
        ]
        #v(-7pt)
        #par(leading: eval(settings.paragraph.leading))[
          #if "thesis" in place [
            Thesis: #emph[#place.thesis]
            #if "thesis_note" in place [(#place.thesis_note)]
          ]
          #if "coursework" in place [
            \
            Relevant Coursework: #eval(place.coursework, mode: "markup")
          ]
        ]
        #v(-3pt)
      ]
    ]
  ]
}

= Skills

// one skill category. per-item `info` goes in parentheses.
#let render-category(category) = if category != none [
  #text(
    size: eval(settings.font.size.description),
    font: settings.font.minor_highlight,
  )[
    *#category.name*
    #linebreak()
    #category.items.map(skill => if "info" in skill [#skill.name#text(size: eval(settings.font.size.description))[ (#skill.info)]] else [#skill.name]).join(", ")
  ]
]

// categories fill the two columns row by row, so both columns stay aligned
#let half = calc.ceil(content.skills.len() / 2)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  row-gutter: 0.5em,
  align: (left, left),
  ..range(half).map(i => (
    render-category(content.skills.at(i)),
    render-category(content.skills.at(i + half, default: none)),
  )).flatten(),
)

= Awards

#let render-award(award) = text(
  size: eval(settings.font.size.description)
)[
  #link(award.link)[#award.name]
  #text(size: eval(settings.font.size.description))[
    (#award.year)
    #v(-6pt)
    #par(
      justify: false,
      leading: eval(settings.paragraph.leading),
    )[#award.description]
  ]
  #v(12pt)
]

#v(5pt)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: left,
  ..content.awards.map(render-award),
)

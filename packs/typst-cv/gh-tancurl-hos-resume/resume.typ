#import "vantage.typ": vantage, cbox, icon, entry, display-contact, cage, education-entry
        // arrange the first 4 item in a 2x2 grid

#let configuration = yaml("resume.yml")
#let config = configuration.config
#let contacts = configuration.contacts

#let separator(x: -2pt, y: 3pt) = box(
  outset: (x: x, y: y),
  inset:  (x: x, y: y),
)[
  #text(size: 2pt)[#icon(solid: false, "minus")]
]

#vantage(
  name: configuration.contacts.name,
  position: configuration.position,
  picture: config.picture,
  color: (config.color),
  tagline: (configuration.tagline),
  [
    == Experiences
    #pad(
      left: 4pt,
      right: 4pt,
    )[

      #for (j, job) in configuration.jobs.enumerate() [

        #let company = job.company
        #let product = job.product
        #let position = job.position

        #entry(
          company: job.company,
          product: job.product,
          position: job.position,
        )[]


      ]
    ]
  ],
  [

    == Contact Info

    #pad(
      left: 6pt,
      right: 6pt,
    )[


        #contacts.info.map(item => cbox[
          #let txt = text(
            size: 7pt,
            font: config.font.mono,
            weight: "bold",
          )[
            #item.text
          ]
          #icon(item.icon)
          #if "link" in item [
            #if item.link != "" [
              #link(item.link, txt)
            ]
          ] else [
            #txt
          ]
          #v(1pt)
        ]).join(
          [  ]
        )


      ]
    #v(4pt)

    == Skills

    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #configuration.skills.map(item => cbox(item)).join(
        [ #h(-2pt) #text(fill: rgb(config.color.separator))[#separator()] #h(0pt) ]
      )
      #v(4pt)
    ]

    == Tools

    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #configuration.tools.map(item => cbox(item)).join(
        [ #h(-2pt) #text(fill: rgb(config.color.separator))[#separator()] #h(0pt) ]
      )
      #v(4pt)
    ]

    == Programming

    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #configuration.programming.map(item => cbox(item)).join(
        [ #h(-2pt) #text(fill: rgb(config.color.separator))[#separator()] #h(0pt) ]
      )
      #v(4pt)
    ]

    == Languages

    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #configuration.languages.map(item => cbox(item)).join(
        [ #h(-2pt) #text(fill: rgb(config.color.separator))[#separator()] #h(0pt) ]
      )
      #v(4pt)
    ]

    == Studies
    #pad(
      left: 4pt,
      right: 4pt,
    )[
        #for studies in configuration.studies [
          #cbox[
            #text(weight: "bold", size: 8pt)[
              #studies.name
            ]
            #if studies.description != "" [
              ---
              #text(size: 7pt)[
                #studies.description
              ]
            ]
          ]
          #v(-4pt)
        ]
        #v(4pt)
    ]
    #v(4pt)

    == Education

    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #for edu in configuration.education [
        #education-entry(edu)
      ]
    ]

    == Interests

    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #configuration.interests.map(item => cbox(item)).join(
        [ #h(-2pt) #text(fill: rgb(config.color.separator))[#separator()] #h(0pt) ]
      )
      #v(4pt)
    ]

  ],
  [
    #pagebreak()

    == Achievements

    #pad(
      left: 4pt,
      right: 4pt,
    )[

      #let first2 = configuration.achievements.slice(0, calc.min(2, configuration.achievements.len()))
      #let rest   = configuration.achievements.slice(calc.min(2, configuration.achievements.len()))

      #columns(2, gutter: 8pt)[
        #for (i, achievement) in first2.enumerate() [
          #entry(
          company:    achievement,
          )[
            #v(-1pt)
            #pad(
              left: 5pt, right: 5pt,
            )[
              #text(size: 8pt, list.item(achievement.description))
            ]
            #v(-1pt)
          ]
          #if i == 0 [
            #colbreak()
          ]
        ]
      ]

      #for achievement in rest [
        #entry(
          company:    achievement,
        )[
          #v(-1pt)
          #pad(
            left: 5pt, right: 5pt,
          )[
            #text(size: 8pt, list.item(achievement.description))
          ]
          #v(-1pt)
        ]
      ]

    ]
  ],
  [

    == Projects

    #columns(1, gutter: 8pt)[

      #pad(
        left: 10pt,
        right: 10pt,
      )[

        #let first4 = configuration.projects.slice(0, calc.min(2, configuration.projects.len()))
        #let rest   = configuration.projects.slice(calc.min(2, configuration.projects.len()))

        #columns(2, gutter: 8pt)[
          #for (i, project) in first4.enumerate() [
            #entry(
              company:    project,
            )[
              #for point in project.description [
                #v(-1pt)
                #pad(
                  left: 5pt, right: 5pt,
                )[
                  #text(size: 8pt, list.item(point))
                ]
                #v(-1pt)
              ]
            ]
            #if i == 0 [
              #colbreak()
            ]
          ]
        ]

        #for project in rest [
          #entry(
            company: project,
          )[
            #for point in project.description [
              #v(-1pt)
              #pad(
                left: 5pt, right: 5pt,
              )[
                #text(size: 8pt, list.item(point))
              ]
              #v(-1pt)
            ]
          ]
        ]

      ]
    ]

  ]
)

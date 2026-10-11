#let labels = yaml(sys.inputs.at("labelsFile", default: "input/locales/en/labels.yaml"))
#let content = yaml(sys.inputs.at("contentFile", default: "input/locales/en/content.yaml"))
#let profile = yaml("input/profile.yaml")
#let release-version = sys.inputs.at("releaseVersion", default: "dev")

#set document(
  title: [
    #if "jobTitle" in profile {
      profile.fullName + " - " + profile.jobTitle
    } else {
      profile.fullName
    }
  ],
  author: profile.fullName,
)

#set page(
  paper: "a4",
  margin: 1.2cm,
  footer: [
    #text(fill: gray)[
      #release-version,
      #datetime.today().display()
    ]
    #if "githubName" in profile [
      #h(1fr)
      #text(fill: gray)[
        #link("https://github.com/" + profile.githubName + "/cv/releases")[
          #labels.downloadCv GitHubWithIcon
        ]
      ]
    ]
  ]
)

#set par(
  justify: true,
)

#set text(
  font: "Inria Sans",
  lang: "de",
  size: 10pt,
)

#show link: underline

#show "GitHubWithIcon": _ => box[
  #box(image(
    "icons/github.svg",
    height: 0.7em,
  ))
  GitHub
]

#show "LinkedInWithIcon": _ => box[
  #box(image(
    "icons/linkedin.svg",
    height: 0.7em,
  ))
  LinkedIn
]

#let primaryColor = rgb(50, 110, 180)

#let section-title(title) = [
  #grid(
    columns: (3pt, 1fr),
    gutter: 8pt,
    align: (start, start),
    [
      #rect(width: 3pt, height: 1em, fill: primaryColor)
    ],
    [
      #align(horizon)[
        #text(weight: "bold", size: 12pt)[
          #smallcaps[
            #title
          ]
        ]
      ]
    ],
  )
]

#let section-subtitle(title) = [
  #grid(
    columns: (2pt, 1fr),
    gutter: 4pt,
    align: (start, start),
    [
      #rect(width: 2pt, height: 1em, fill: primaryColor)
    ],
    [
      #align(horizon)[
        *#title*
      ]
    ],
  )
]

#let style-date(value) = text(number-width: "tabular")[#value]

#let join-or-break(first: none, second: none, delimiter-join: none, delimiter-break: [ \ ]) = box(layout(size => {
  let joined = first + delimiter-join + second
  let (height,) = measure(width: size.width, joined)
  let sizeLine = measure(width: size.width, "I")
  if height >= sizeLine.height * 2 {
    first + delimiter-break + second
  } else {
    joined
  }
}))

#grid(
  columns: (23%, 75%),
  gutter: 2%,
  [
    #if "profilePictureFileName" in profile [
      #rect(
        inset: 0pt,
        stroke: 2pt + primaryColor,
      )[
        #image(
          "input/images/" + profile.profilePictureFileName,
          width: 90%,
        )
      ]
    ]

    #v(4pt)

    #if "personalDetails" in content [
      #section-title(labels.personalDetails)
      #for element in content.personalDetails [
        *#element.name* \
        #element.value
        #v(4pt)
      ]

      #v(4pt)
    ]

    #section-title(labels.social)

    #if "linkedInName" in profile [
      *LinkedInWithIcon* \
      #link("https://www.linkedin.com/in/" + profile.linkedInName)[
        #profile.fullName
      ]
      #v(4pt)
    ]

    #if "githubName" in profile [
      *GitHubWithIcon* \
      #link("https://github.com/" + profile.githubName)[
        #profile.githubName
      ]
      #v(4pt)
    ]

    #v(4pt)

    #section-title(labels.contact)

    #if "emailAddress" in profile [
      *#labels.emailAddress* \
      #link("mailto:" + profile.emailAddress)
      #v(4pt)
    ]

    #if "phoneNumber" in profile [
      *#labels.phone* \
      #link("tel:" + profile.phoneNumber)
      #v(4pt)
    ]

    #v(4pt)

    #section-title(labels.languages)

    #for language in content.languages [
      *#language.name* \
      #language.proficiency
      #v(4pt)
    ]

    #text(fill: white)[
      #labels.easterEgg
    ]
  ],

  [
    #text(size: 28pt, weight: "bold")[
      #smallcaps(profile.fullName)
    ]
    #if "jobTitle" in profile [
      #linebreak()
      #text(size: 12pt, fill: primaryColor, weight: "bold")[
        #smallcaps(profile.jobTitle)
      ]
    ]

    #if "profile" in content [
      #v(4pt)

      #section-title(labels.profile)

      #content.profile
    ]

    #if "coreSkills" in content [
      #v(4pt)

      #section-title(labels.coreSkills)

      #for skill in content.coreSkills [
        - #skill
      ]
    ]

    #if "coreTechnologies" in content [
      #v(4pt)

      #section-title(labels.coreTechnologies)

      #for technology in content.coreTechnologies [
        - #technology
      ]
    ]

    #v(4pt)

    #section-title(labels.workExperience)

    #for company in content.workExperience [
      #section-subtitle(company.name)

      #grid(
        columns: (25%, 75%),
        gutter: 10pt,
        ..company.positions.map(position => (
          if "to" in position [
            #style-date(position.from) \- #style-date(position.to)
          ] else [
            #style-date(position.from)
          ],
          [ *#position.title* ],
        )).flatten(),
      )

      #if "tasks" in company [
        *#labels.tasks:*
        #for task in company.tasks [
          - #task
        ]
      ]

      #if "technologies" in company [
        *#labels.technologies:*
        #company.technologies.join(", ")
      ]

      #if "pagebreak" in company and company.pagebreak { colbreak() } else { v(4pt) }
    ]

    #section-title(labels.education)

    #for step in content.education [
      #grid(
        columns: (25%, 75%),
        gutter: 10pt,
        if "to" in step [
          #style-date(step.from) \- #style-date(step.to)
        ] else [
          #style-date(step.from)
        ],
        join-or-break(
          first: [ *#step.title* ],
          second: step.institution,
          delimiter-join: [ \- ],
        ) + (if "grading" in step { [ \ ] + text(size: 8pt)[#step.grading] } else { [] }),
      )

      #if "projects" in step [
        #if "grading" in step [
          #v(-12pt)
        ]

        *#labels.projects:*
        #for project in step.projects [
          - *#project.title*#if "link" in project [#footnote(link(project.link))]#if "description" in project [\ #project.description]
        ]
      ]

      #if "pagebreak" in step and step.pagebreak { colbreak() } else { v(4pt) }
    ]
  ],
)

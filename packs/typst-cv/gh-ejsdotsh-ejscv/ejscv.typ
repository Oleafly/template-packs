#import "@preview/fontawesome:0.6.2": *

// utility functions
#import "utils.typ": *

// title/contact block
#let contact(
  author: "ejsdotsh",
  location: "",
  phone: "",
  email: "contactme@ejs.sh",
) = {
  grid(
    columns: (2fr, 1fr),
    [
      #align(left)[#text(32pt)[#author]]
    ],
    [
      #align(right)[
        #set list(marker: none)
        #if location != "" [
          - #fa-icon(
              "location-dot",
              size: 0.9em,
            ) #h(0.05cm) #location
        ]
        #if phone != "" [
          - #fa-icon("phone", size: 0.9em) #h(0.05cm) #phone
        ]
        #if email != "" [
          - #fa-icon("envelope", size: 0.9em) #h(0.05cm) #email
        ]
      ]
    ],
  )
}

// summary
#let main_summary(cvdata) = {
  set list(marker: (none, [•]))
  [
    - #block(breakable: false)[
        #if (
          cvdata.summary != none
        ) [#cvdata.summary]
        #if cvdata.highlights != none [
          #for highlight in cvdata.highlights {
            [- #highlight]
          }
        ]
      ]
  ]
  set par(justify: true, spacing: 1.2em)
}

// technologies and languages
#let technologies_and_languages(technologies) = {
  [= technologies and languages]
  set par(justify: true, spacing: 1.2em)
  for category in technologies {
    set list(marker: none)
    [- / #category.label: #category.skill.join(" - ")]
  }
}

// professional experience
#let professional_experience(jobs) = {
  [= professional experience]
  let _today = strpdate(today.display())
  for job in jobs {
    let start = strpdate(job.start_date)
    let end = strpdate(job.end_date)
    set list(marker: (none, none, [•]))
    [
      - #block(breakable: false)[
          #grid(
            columns: (1fr, auto),
            [
              #align(left)[ == #job.company \
                === #job.title
              ]
            ],
            [
              #align(right)[ #job.location \
                #daterange(start, end)]
            ],
          )
          #if job.highlights != none and not olderThan(21, job.end_date) [
            - #for item in job.highlights { [- #item] }
          ]
        ]
    ]
  }
}

// projects and affiliations/membership
#let projects_and_affiliations(projects, affiliations) = {
  [= projects and affiliations]
  for project in projects {
    set list(marker: (none, [•]))
    [
      - #grid(
          columns: (1fr, auto),
          [
            #align(left)[#text(weight: "bold")[#project.name]]
          ],
          [
            #align(right)[#text(style: "italic")[#if project.url != none [#project.url]]]
          ],
        )
    ]
    [
      #if project.summary != none [- #project.summary]
    ]
  }
  set list(marker: none)
  for afln in affiliations {
    [
      - #grid(
          columns: (auto, 1fr),
          [
            #align(left)[
              #if afln.name != none [== #afln.name] \
              #if afln.roles != none [#for role in afln.roles { [#role.name \ ] }]
            ]
          ],
          [
            #align(right)[
              #if afln.url != none [#text(style: "italic")[#afln.url \ ]] else [ \ ]
              #if afln.roles != none [#for role in afln.roles { [#daterange(role.start_date, role.end_date) \ ] }] ]
          ],
        )
    ]
  }
}

// links to linkedin, github, website, etc.
#let links(links) = {
  [= links]
  set list(marker: none)
  for link in links {
    [- #fa-icon(link.name, size: 0.9em) #h(0.05cm) #text(9pt)[#link.url]]
  }
}

// education and certifications
#let education_and_certifications(education, certifications) = {
  [= education and certifications ]
  set list(marker: none)
  for cert in certifications {
    if cert.current {
      [
        - #grid(
            columns: (auto, 1fr),
            [
              #align(left)[
                #if cert.name != none [#cert.name]
              ]
            ],
            [
              #align(right)[#cert.start_date\-#cert.end_date]
            ],
          )
      ]
    }
  }
  for edu in education {
    [
      - #grid(
          columns: (auto, 1fr),
          [
            #align(left)[
              #text(weight: "bold")[#edu.degree, #edu.area]
            ]
          ],
          [
            #align(right)[
              #daterange(
                if edu.start_date != none [#strpdate(edu.start_date)],
                if edu.end_date != none [#strpdate(edu.end_date)],
              )
            ]
          ],
        )
      - #edu.institution
    ]
  }
}

// footer definition
#let footer(
  email: "contactme@ejs.sh",
  phone: "",
) = {
  set text(8pt)
  grid(
    columns: (1fr, 1fr, 1fr),
    [
      #align(left)[
        last updated: #today.display()
      ]
    ],
    [
      #align(center)[
        #counter(page).display("1 of 1", both: true)
      ]
    ],
    [
      #align(right)[
        #email | #phone
      ]
    ],
  )
}


// finally, define the CV layout
#let ejscv(
  cvdata,
  doc,
) = {
  set par(justify: true)
  set text(
    font: "Noto Sans",
    size: 10pt,
    hyphenate: false,
  )
  // underline and make smallcaps H1
  show heading.where(level: 1): it => block(width: 100%)[
    #set align(left)
    #set text(13pt, weight: "regular")
    #underline[#smallcaps(it.body)]
  ]
  // italicize and bold H2
  show heading.where(level: 2): it => text(
    size: 11pt,
    weight: "bold",
    style: "italic",
    it.body,
  )
  // italicize and bold H3
  show heading.where(level: 3): it => text(
    size: 10pt,
    weight: "bold",
    // style: "italic",
    it.body,
  )
  // set the page size
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 1cm),
    footer: context [
      #footer(
        email: cvdata.contact.email,
        phone: cvdata.contact.phone,
      )
    ],
  )
  // populate the contact information
  contact(
    author: cvdata.contact.name,
    email: cvdata.contact.email,
    phone: cvdata.contact.phone,
    location: cvdata.contact.location,
  )
  // draw a horizontal line
  line(length: 100%, start: (0%, 0%), stroke: 0.5pt)
  // insert 1em of vertical spacing
  v(1em)
  // add more space to the side margins for the summary block
  pad(
    left: 1.5em,
    right: 1.5em,
    main_summary(cvdata.main_summary),
  )
  // insert 1em of vertical spacing
  v(1em)
  technologies_and_languages(cvdata.skills)
  // insert 1em of vertical spacing
  v(1em)
  professional_experience(cvdata.jobs)
  // insert 1em of vertical spacing
  v(1em)
  projects_and_affiliations(cvdata.projects, cvdata.affiliations)
  // insert 1em of vertical spacing
  v(1em)
  grid(
    columns: (1fr, 2fr),
    [
      #if cvdata.contact.links != none [
      #links(cvdata.contact.links)
      ]
    ],
    [
      #education_and_certifications(cvdata.education, cvdata.certifications)
    ],
  )
}

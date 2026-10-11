#import "_setup.typ": *

#v(5%)

#image(
  "figures/Logo_DHSN.png",
  width: 100%,
  height: 3cm,
  fit: "contain",
)

#v(5%)

#align(center, text(FontSizeL)[
  *#School*
])

#align(center, text(FontSizeM)[
  \- Studienrichtung #FieldOfStudy -
])

#v(7%)

#align(center, text(hyphenate: false, FontSizeXL)[
  *#Title*
])

#v(7%)

#align(center, text(FontSizeM)[
  #Paper
])

#align(center, text(FontSizeM)[
  #MyDegree
])

#align(center, text(FontSizeS)[
  (#MyDegreeShort)
])

#v(5%)

#align(center, text(FontSizeM)[
  vorgelegt am #SubmissionDate von
])

#align(center, text(FontSizeM)[
  *#Author*
])

#align(center, text(FontSizeM)[
  Matrikelnummer: #MatrikelNr
])

#v(10%)

#align(center)[
  #block(width: 80%)[
    #grid(
      columns: (1fr, auto),
      align(left)[
        Ausbildender Praxispartner: \
        \
        Begutachtung Praxispartner: \
        Begutachtung Hochschule: \
      ],
      align(left)[
        #Company \
        #CompanyAddress \
        #CompanySupervisor \
        #UniversitySupervisor \
      ]
    )
  ]
]

#pagebreak(to: "odd")

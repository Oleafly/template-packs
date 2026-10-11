#let header(profile) = [
  #align(center)[

    // Name
    #text(
      size: 20pt,
      weight: "bold",
    )[
      #profile.name
    ]


    // Title
    #text(
      size: 10.5pt,
      weight: "medium",
      fill: rgb("#444444"),
    )[
      #profile.title
    ]


    // email / phone contact line
    #text(
      size: 8.8pt,
      fill: rgb("#666666"),
    )[
      #link("mailto:" + profile.email)[#profile.email]
      •
      #profile.phone
    ]


    // contact line
    #text(
      size: 8.8pt,
      fill: rgb("#666666"),
    )[
      // #link(profile.website_url)[#profile.website]
      #text(fill: rgb("#1a73e8"))[
        #link(profile.website_url)[
          #underline[#profile.website]
        ]
      ]
      •
      #link(profile.github_url)[#profile.github]
      •
      #link(profile.linkedin_url)[#profile.linkedin]

    ]
  ]


  #line(
    length: 100%,
    stroke: 0.4pt + rgb("#D8D8D8"),
  )

]

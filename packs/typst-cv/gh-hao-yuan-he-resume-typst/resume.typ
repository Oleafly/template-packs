#let resume(
  author: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  social_media: "",
  accent-color: "#000000",
  img: "",
  body,
) = {
  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: ("Calibri", "PingFang SC"),
    size: 10pt,
    lang: "en",
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: true,
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: 0.5in,
    "us-letter",
  )


  // Link styles
  show link: underline


  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(
      weight: 400,
      size: 18pt,
      font: ("Times New Roman", "Yuanti TC"),
    )
    #it.body
  ]

  show image: it => block(
    radius: 50pt,
    clip: true,
  )[#it]


  let personal_info = (
    if phone != "" {
      phone
    },
    if location != "" {
      location
    },
    if email != "" {
      link("mailto:" + email)[#email]
    },
    if github != "" {
      link("https://" + github)[#github]
    },
    if linkedin != "" {
      link("https://" + linkedin)[#linkedin]
    },
    if personal-site != "" {
      link("https://" + personal-site)[#personal-site]
    },
  )
    .filter(x => x != none)
    .join("  |  ")


  let social_media = (
    if social_media != "" {
      [#social_media]
    },
  )
    .filter(x => x != none)
    .join("  |  ")


  // Level 1 Heading
  [= #(author)]
  // Personal Info
  pad(
    top: 0.25em,
    align(left)[
      #(personal_info)

      #(social_media)
    ],
  )


  place(
    image(img, width: 75pt),
    dx: 6.5in,
    dy: -.8in,
  )

  // Main body.
  set par(justify: true)

  body
}

// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  pad[
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  pad[
    #left #h(1fr) #right
  ]
}

// Cannot just use normal --- ligature becuase ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.en$ + " " + end-date
}

// Section components below
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(institution),
    bottom-left: text[
      #set text(
        weight: 100,
        size: 9pt,
        font: ("Calibri", "STFangsong"),
      )
      #degree
    ],
    top-right: text(gray)[#dates],
  )
}

#let description(
  des: "",
) = {
  align(left)[
    #set text(
      weight: 200,
      size: 8pt,
      font: ("Calibri", "STFangsong"),
    )
    #des
  ]
}


#let work(
  title: "",
  dates: "",
  des: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: text[
      #set text(
        weight: 100,
        size: 9pt,
        font: ("Calibri", "STFangsong"),
      )
      #des
    ],
    bottom-right: emph[
      #set text(
        weight: 100,
        size: 9pt,
        font: ("Calibri", "STFangsong"),
      )
      #location
    ],
  )
}

#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
) = {
  pad[
    *#role*, #name (#link("https://" + url)[#url]) #h(1fr) #dates
  ]
}


#let extracurriculars(
  activity: "",
  dates: "",
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
}

#let award(
  name: "",
  des: "",
  dates: "",
) = {
  generic-two-by-two(
    top-left: strong(name),
    bottom-left: text[
      #set text(
        weight: 100,
        size: 9pt,
        font: ("Calibri", "STFangsong"),
      )
      #des
    ],
    top-right: dates,
  )
}

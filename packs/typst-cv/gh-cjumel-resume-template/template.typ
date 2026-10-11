#let resume(
  author: "",
  description: "",
  phone: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  image-path: "",
  accent-color: "#000000",
  body,
) = {

  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: "New Computer Modern",
    size: 10pt,
    lang: "en",
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: (0.5in),
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
      weight: 700,
      size: 20pt,
    )
    #it.body
  ]

  let personal_data = [
    #(
      phone,
      location,
      link("mailto:" + email)[#email],
      link(github)[GitHub],
      link(linkedin)[LinkedIn],
    ).join(" | ")
  ]

  let personal_section = [
    = #(author) // Level 1 Heading
    #pad(
      top: 0.25em,
      align(left)[
        #(description)\ // Add a line break after description (smaller separation than new paragraph)
        #(personal_data)
      ],
    )
  ]

  if image-path == "" [
    #personal_section
  ] else [
    #let personal_image = image(image-path)
    #grid(
      columns: (82%, 16%),
      gutter: 2%,
      align: horizon, // Center the line vertically
      personal_section,
      personal_image,
    )
  ]

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
  start-date + " " + $dash.em$ + " " + end-date
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
    top-right: dates,
    bottom-left: degree,
    bottom-right: emph(location),
  )
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(company),
    top-right: dates,
    bottom-left: title,
    bottom-right: emph(location),
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

// From https://github.com/steadyfall/simple-technical-resume-template
#let resume(
  paper: "us-letter",
  top-margin: 0.5in,
  bottom-margin: 0.5in,
  left-margin: 0.5in,
  right-margin: 0.5in,
  font: "New Computer Modern",
  font-size: 11pt,
  personal-info-font-size: 10pt,
  lang: "en",
  author-name: "",
  author-position: center,
  personal-info-position: center,
  phone: "",
  location: "",
  email: "",
  website: "",
  linkedin-user-id: "",
  github-username: "",
  date: datetime.today(),
  body,
) = {
  set document(
    title: "Résumé | " + author-name,
    author: author-name,
    keywords: "cv",
    date: date,
  )

  set page(
    paper: paper,
    margin: (
      top: top-margin,
      bottom: bottom-margin,
      left: left-margin,
      right: right-margin,
    ),
  )

  set text(
    font: font,
    size: font-size,
    lang: lang,
    ligatures: false,
  )

  show heading.where(level: 2): it => block(width: 100%)[
    #set text(font-size + 1.5pt, weight: "regular")
    #smallcaps(it.body)
    #v(-0.8em)
    #line(length: 100%, stroke: stroke(thickness: 0.4pt))
    #v(-0.2em)
  ]

  let contact_item(value, link-type: "", prefix: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  align(
    author-position,
    [
      #smallcaps(text(font-size + 13pt, weight: "bold")[#author-name])
      #v(-1.8em)
    ],
  )

  align(
    personal-info-position,
    text(personal-info-font-size)[
      #{
        let sepSpace = 0.2em
        let items = (
          contact_item(phone),
          contact_item(email, link-type: "mailto:"),
          contact_item(website, link-type: "https://"),
          contact_item(linkedin-user-id, link-type: "https://linkedin.com/in/", prefix: "linkedin.com/in/"),
          contact_item(github-username, link-type: "https://github.com/", prefix: "github.com/"),
          contact_item(location),
        )
        items
          .filter(x => x != none)
          .join([
            #show "|": sep => {
              // h(sepSpace)
              [|]
              // h(sepSpace)
            }
            |
          ])
      }
    ],
  )

  body
}

// ---
// Custom functions

#let generic_2x2(cols, r1c1, r1c2, r2c1, r2c2) = {
  // sanity checks
  assert.eq(type(cols), array)

  grid(
    columns: cols,
    align(left)[#r1c1 \ #r2c1],
    align(right)[#r1c2 \ #r2c2]
  )
}

#let custom-title(title, spacing-between: 0em, body) = {
  [== #title]
  body
  v(spacing-between)
}

// Custom list to be used inside custom-title section.
#let skills(body) = {
  if body != [] {
    set par(leading: 0.6em)
    set list(
      body-indent: 0.1em,
      indent: 0em,
      marker: [],
    )
    body
  }
}

// Converts datetime format into readable period.
#let period_worked(start-date, end-date) = {
  // sanity checks
  assert(start-date == none or type(start-date) == datetime)
  assert(type(end-date) == datetime or type(end-date) == str)

  if type(end-date) == str and end-date == "Present" {
    end-date = datetime.today()
  }

  return [
    #if (start-date != none) [
      #start-date.display("[month repr:short] [year]") --
    ]
    #if (
      (end-date.month() == datetime.today().month()) and (end-date.year() == datetime.today().year())
    ) [
      Present
    ] else [
      #end-date.display("[month repr:short] [year]")
    ]
  ]
}

// Pretty self-explanatory.
#let work-heading(title, company, location, start-date, end-date, body) = {
  // sanity checks
  assert.eq(type(start-date), datetime)
  assert(type(end-date) == datetime or type(end-date) == str)

  generic_2x2(
    (1fr, 1fr),
    [*#title*],
    [*#period_worked(start-date, end-date)*],
    [#company],
    emph(location),
  )
  v(-0.2em)
  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.5em)
    body
  }
}

// Pretty self-explanatory.
#let project-heading(name, info: "", stack: "", project-url: "", body) = {
  let project_name = []
  if project-url.len() != 0 {
    project_name = link("https://" + project-url)[#name]
  } else {
    project_name = [#name]
  }
  generic_2x2(
    (1fr, 1fr),
    [*#project_name*],
    emph(stack),
    [#info],
    [],
  )
  v(-0.2em)
  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.5em)
    body
  }
}

// Pretty self-explanatory.
#let education-heading(institution, location, degree, major, start-date, end-date, gpa: none, body) = {
  // sanity checks
  assert.eq(type(start-date), datetime)
  assert(type(end-date) == datetime or type(end-date) == str)

  if gpa != none {
    gpa = " - GPA: " + gpa + "/4.0"
  }
  generic_2x2(
    (70%, 30%),
    [*#degree, #major*],
    [*#period_worked(start-date, end-date)*],
    [#institution#gpa],
    emph(location),
  )
  v(-0.2em)
  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.5em)
    body
  }
}

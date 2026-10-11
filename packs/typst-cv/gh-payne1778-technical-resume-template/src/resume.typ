#let resume(
  paper: "a4",
  top-margin: 0.4in,
  bottom-margin: 0.4in,
  left-margin: 0.4in,
  right-margin: 0.4in,
  font: "Liberation Serif ",
  font-size: 11pt,
  personal-info-font-size: 10pt,
  author-name: "",
  author-position: center,
  personal-info-position: center,
  phone: "",
  location: "",
  email: "",
  website: "",
  linkedin-user-id: "",
  github-username: "",
  body
) = {
  set document(
    title: "Résumé | " + author-name,
    author: author-name,
    keywords: "cv",
    date: none
  )

  set page(
    paper: "a4",
    margin: (
      top: top-margin, bottom: bottom-margin,
      left: left-margin, right: right-margin
    ),
  )

  set text(
    font: font, size: font-size, lang: "en", ligatures: true
  )

  show heading.where(
    level: 1
  ): it => block(width: 100%)[
    #set text(font-size + 2pt, weight: "regular")
    #smallcaps(it.body)
    #v(-1em)
    #line(length: 100%, stroke: stroke(thickness: 0.4pt))
    #v(-0.2em)
  ]

  let contact_item(value, link-type: "", prefix: "") = {
    if value != "" {
      if link-type != "" {
        underline(offset: 0.3em)[#link(link-type + value)[#(prefix + value)]]
      } else {
        value
      }
    }
  }

  align(author-position, [
    #text(font-size+16pt, weight: "extrabold")[#author-name]
    #v(-2em)
  ])

  align(personal-info-position, text(personal-info-font-size)[
    #{
      let sepSpace = 0.2em
      let items = (
        contact_item(phone),
        contact_item(location),
        contact_item(email, link-type: "mailto:"),
        contact_item(website, link-type: "https://"),
        contact_item(linkedin-user-id, link-type: "https://linkedin.com/in/", prefix: "linkedin.com/in/"),
        contact_item(github-username, link-type: "https://github.com/", prefix: "github.com/"),
      )
      items.filter(x => x != none).join([
        #show "|": sep => {
          h(sepSpace)
          [|]
          h(sepSpace)
        }
        |
      ])
    }
  ])

  body
}

#let generic_1x2(cols: (1fr, 1fr), r1c1, r1c2) = {
  assert.eq(type(cols), array)
  grid(
    columns: cols,
    align(left)[#r1c1],
    align(right)[#r1c2]
  )
}

#let generic_2x2(cols: (1fr, 1fr), r1c1, r1c2, r2c1, r2c2) = {
  assert.eq(type(cols), array)
  grid(
    columns: cols,
    align(left)[#r1c1 \ #r2c1],
    align(right)[#r1c2 \ #r2c2]
  )
}

#let spacer() = {
    v(0.5em)
}

#let custom-title(title, body) = {
  [= *#title*]
  body
  v(0.2em)
}

#let education-heading(
  major: "", 
  grad-date: "", 
  uni: "", 
  location: "", 
  gpa: "", 
  body
) = {
  assert(major != "", message: "major should not be null")
  assert(uni != "", message: "uni name should not be null")
  assert(location != "", message: "university name should not be null")

  if gpa != "" {
    gpa = "GPA: " + gpa
  }

  generic_2x2(
    cols: (70%, 30%),
    [*#major*], [*#grad-date*],
    [#uni | #location], gpa
  )
  v(-0.1em)

  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.5em)
    body
  }
}

#let skills(body) = {
  assert(body != [], message: "skills body should not be null")

  set par(leading: 0.6em)
  set list(
    body-indent: 0.1em,
    indent: 0em,
    marker: []
  )
  body
}

#let project-heading(
  name: "", 
  technologies: "", 
  repo-name: "", 
  github-username: "",
  start-date: "", 
  end-date: "Present", 
  body
) = {
  assert(body != [], message: "project body should not be null")
  assert(start-date != "", message: "project start date should not be null")

  generic_1x2(
    [*#name*], [*#start-date* - *#end-date*]
  )
  v(-0.7em)

  if technologies != "" and repo-name != "" {
    generic_1x2(
      cols: (70%, 30%),
      emph(technologies), 
      link("https://github.com/" + github-username + "/" + repo-name)[
        #underline(offset: 0.2em)[gh.com/#repo-name]
      ]
    )
    v(-0.5em)
  }

  v(-0.1em)
  set par(leading: 0.6em)
  set list(indent: 0.6em)
  body
}

#let work-heading(
  title: "", 
  company: "", 
  location: "", 
  start-date: "", 
  end-date: "Present", 
  body
) = {
  assert(body != [], message: "work body should not be null")
  assert(title != "", message: "work title should not be null")
  assert(company != "", message: "company title should not be null")
  assert(location != "", message: "company location title should not be null")
  assert(start-date != "", message: "start date should not be null")

  generic_2x2(
    [*#title*], [*#start-date* - *#end-date*],
    emph(company), emph(location)
  )
  v(-0.04em)
  
  v(-0.4em)
  set par(leading: 0.6em)
  set list(indent: 0.5em)
  body
}

#let activity-heading(
  position: "", 
  activity: "", 
  start-date: "", 
  end-date: ""
) = {
  assert(activity != "", message: "activity name should not be null")
  assert(start-date != "", message: "activity start date should not be null")

  let activity-position = ""; 
  let dates = ""; 

  if end-date == "" {
    dates = start-date;
  }
  else {
    dates = [#start-date - #end-date]
  }

  if position == "" {
    activity-position = activity
  }
  else {
    activity-position = [#emph(position), #activity]
  }
  
  generic_1x2(
    activity-position, dates
  )
  v(-0.5em)
}

// Accent color state — accessible by all component functions
#let _accent = state("accent", "#26428b")

#let resume(
  author: "",
  location: "",
  email: "",
  github: "",
  github-display: "GitHub",
  linkedin: "",
  linkedin-display: "LinkedIn",
  instagram: "",
  instagram-display: "Instagram",
  phone: "",
  personal-site: "",
  personal-site-display: "",
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "a4",
  author-font-size: 18pt,
  font-size: 9pt,
  lang: "en",
  body,
) = {
  _accent.update(accent-color)

  set document(author: author, title: author)
  set text(font: font, size: font-size, lang: lang, ligatures: false)
  set page(margin: (top: 0.25in, bottom: 0.5in, left: 0.5in, right: 0.5in), paper: paper)

  // Links: underlined, accent colored
  show link: underline
  show link: set text(fill: rgb(accent-color))

  // Section headings (==): black bold uppercase + full-width rule
  show heading.where(level: 2): it => [
    #set text(fill: black, weight: 700)
    #pad(top: 4pt, bottom: -10pt, upper(it.body))
    #line(length: 100%, stroke: 1pt)
  ]

  // Name (=): left-aligned, accent colored, bold, large
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(weight: 700, size: author-font-size, fill: rgb(accent-color))
    #pad(bottom: 2pt, it.body)
  ]

  [= #(author)]

  // Single contact line — left-aligned, all items pipe-separated
  // Order: phone | location | email | linkedin | github | instagram | personal-site
  let contacts = ()
  if phone != "" { contacts.push(phone) }
  if location != "" { contacts.push(location) }
  if email != "" { contacts.push(link("mailto:" + email)[#email]) }
  if linkedin != "" { contacts.push(link("https://" + linkedin)[#linkedin-display]) }
  if github != "" { contacts.push(link("https://" + github)[#github-display]) }
  if instagram != "" { contacts.push(link("https://instagram.com/" + instagram)[#instagram-display]) }
  if personal-site != "" {
    let display = if personal-site-display != "" { personal-site-display } else { personal-site }
    contacts.push(link("https://" + personal-site)[#display])
  }

  if contacts.len() > 0 {
    pad(top: 0.1em, bottom: 0.05em, align(left)[#contacts.join("  |  ")])
  }

  set par(justify: true)
  body
}

// Work entry: title accent-colored left, dates bold right; company bold, location regular
#let work(title: "", dates: "", company: "", location: "") = {
  context {
    let ac = _accent.get()
    [
      #text(fill: rgb(ac), weight: "bold")[#title] #h(1fr) *#dates* \
      *#company*, #location
    ]
  }
}

// Education entry: degree accent-colored left, dates bold right; institution bold, location regular
#let edu(institution: "", dates: "", degree: "", gpa: "", location: "", consistent: false) = {
  context {
    let ac = _accent.get()
    [
      #text(fill: rgb(ac), weight: "bold")[#degree] #h(1fr) *#dates* \
      *#institution*, #location
    ]
  }
}

// Project entry
#let project(role: "", name: "", url: "", dates: "") = {
  context {
    let ac = _accent.get()
    [
      #{
        if role == "" { [*#name*] } else { [*#role*, #name] }
        if url != "" and dates != "" { [ (#link("https://" + url)[#url])] }
      }
      #h(1fr)
      #{
        if dates == "" and url != "" { link("https://" + url)[#url] }
        else { dates }
      }
    ]
  }
}

#let certificates(name: "", issuer: "", url: "", date: "") = {
  [
    *#name*, #issuer
    #if url != "" { [ (#link("https://" + url)[#url])] }
    #h(1fr) #date
  ]
}

#let extracurriculars(activity: "", dates: "") = {
  [*#activity* #h(1fr) #dates]
}

#let generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "") = {
  [#top-left #h(1fr) #top-right \ #bottom-left #h(1fr) #bottom-right]
}

#let generic-one-by-two(left: "", right: "") = {
  [#left #h(1fr) #right]
}

#let dates-helper(start-date: "", end-date: "") = {
  if start-date == "" { end-date }
  else { start-date + " " + sym.dash.em + " " + end-date }
}

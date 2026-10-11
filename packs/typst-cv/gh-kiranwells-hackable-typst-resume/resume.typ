/*
* Typst Resume Template
*
* Designed as a simple and hackable template for resumes.
* It is recommended to change the template to fit your needs.
*/

// These are used to add the accent color and gradient in the header
#let default_accent = color.map.flare.at(37)
#let default_gradient = (
  ..color.map.flare,
)
#let icon(name) = {
  // select a font with the Nerd Font icons 
  // (ideally the "Propo" version for spacing)
  // https://www.nerdfonts.com/
  set text(font: "FiraCode Nerd Font Propo")
  // fill in any missing icons here; the names are always lower-case
  // https://www.nerdfonts.com/cheat-sheet
  if name == "profile" []
  if name == "mail" [󰇮]
  if name == "github" []
  if name == "linkedin" [󰌻]
  if name == "openapi" [󰞵]
  if name == "python" []
  if name == "c" []
  if name == "c++" []
  if name == "rust" []
  if name == "javascript" []
  if name == "css" []
  if name == "html" []
  if name == "glsl" []
  if name == "hlsl" []
  if name == "linux" []
  if name == "windows" []
  if name == "apple" []
  if name == "microsoft word" []
}

/// The following are the resume element functions that handle the structure of each block

// The main document header with social links. This
// is automatically created by the resume class function
#let header(
  name: "", email: "", linkedin: "", github: "", website: "", font: "Noto Serif", color: default_gradient
) = {
  let name = text(font: font, weight: "black", size: 20pt)[#name]
  let socials = grid(
    columns: (auto, 0pt, auto),
    gutter: 6pt,
    rows: (auto, auto),
    align(right, link("https://" +website)[#icon("profile") #website]),
    grid.vline(position: start),
    [],
    align(left, link("mailto:"+email)[#icon("mail") #email]),
    align(right, link("https://github.com/"+github)[#icon("github") #github]),
    [],
    align(left, link("https://linkedin.com/in/"+linkedin)[#icon("linkedin") #linkedin])
  )

  set block(spacing: 8pt)
  context {
    let name_size = measure(name)
    let socials_size = measure(socials)
    align(center, {
      name
      line(length: (name_size.width + socials_size.width) / 2, stroke: 2pt + color)
      socials
    })
  }
}

// A simple "highlight" element that pulls focus to key details
#let chip(color: default_accent, content) = {
  underline(stroke: 1pt + color)[#content]
}

// A set of skills, with the important_skills highlighted and an optional label
#let skills(label: none,important_skills, other_skills, accent_color: default_accent) = {
  set block(spacing: 2pt)
  if label != none {
    block(
      smallcaps(text(size: 7pt, label))
    )
  }
  box(important_skills.map(chip.with(color: accent_color)).join(", "))
  if important_skills.len() > 0 {
    [, ]
  }
  other_skills.join(", ")
}

// A block that can display work experience, education, or other experiences
#let experience(
  name: "Title",
  highlight: "Highlight",
  detail,
  date,
  accent_color: default_accent,
  body
) = block(inset: (left: 2em))[
  #grid(columns: (1fr, 1fr),
    [== #name],
    align(right, text(fill: accent_color, weight: "bold", size: 11pt)[#highlight])
  )
  #text(style: "italic", detail) #h(2fr) #text(style: "italic", date)

  #body
]

// A block that can link to a website and have an image. Useful for portfolio items or certifications
#let linked_block(
  name: "Name",
  address: "",
  github: none,
  tech: ("",),
  image_file: none,
  accent_color: default_accent,
  body
) = {
  let inner = {
    let true_link = if github != none {
      "https://" + github
    } else {
      address
    }
    link(true_link)[== #name]

    block[
      #body
    ]

    tech.map(it => [#text(fill: accent_color, icon(lower(it))) *#it*]).join(h(1em))
  }
  if image_file != none {
    grid(
      columns: (40pt, auto),
      column-gutter: 5pt,
      image(image_file),
      inner
    )
  } else {
    inner
  }
}

// This is the main resume class, which sets up the header and styles for the document
#let resume(
  name: "First Last",
  contacts: (
    email: "mail@example.com",
    linkedin: "linkedin",
    github: "github",
    website: "example.com",
  ),
  keywords: (),
  paper: "us-letter",
  accent_color: default_accent,
  header_gradient: default_gradient,
  header_font: "Noto Serif",
  body_font: "Noto Sans",
  spacing: 1em,
  debug: false,
  doc
) = {
  let debug_stroke = if debug { 0.1pt + red } else { none }
  set block(
    spacing: spacing,
    stroke: debug_stroke,
  )

  set text(font: body_font, size: 9pt)
  set page(
    paper: paper,
    margin: 0.5in,
    background: [#block(width:100%, height: 100%, fill: white)]
  )
  // This changes the default look of the level 1 headings
  show heading.where(level: 1): it => block(
    outset: (left: -2.5pt),
    stroke: (left: 6pt + accent_color),
    width: 100%,
    inset: (left: 7pt, bottom: 2.5pt, top: 5pt),
    spacing: spacing,
    block(
      spacing: spacing,
      width: 100%,
      stroke: (
        bottom: (paint: black, thickness: 1pt, dash: "dotted"),
      ),
      inset: (
        bottom: 2.5pt,
      ),
      text(weight: "extrabold", it)
    )
  )
  show heading.where(level: 3): it => {
    v(-0.8em)
    it
  }
  show list: it => block(inset: (left: 1em), it)

  set document(
    title: [#name's Resume],
    author: name,
    keywords: keywords,
  )

  header(name: name, ..contacts, color: gradient.linear(..header_gradient, relative: "self"))

  doc
}

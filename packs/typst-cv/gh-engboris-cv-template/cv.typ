#import "@preview/fontawesome:0.5.0": *

/* ==============================================
   Style functions
   ============================================== */
#let sepline(color) = {
  v(-12pt);
  line(length: 100%, stroke: color);
  v(3pt)
}

/* ==============================================
   CV constructors
   ============================================== */
#let cv_block(
  title: "",
  year: "",
  subtitle: "",
  place:"",
  description: ""
) = {
  grid(
    columns: (1fr, auto),
    rows: 1em,
    gutter: 4pt,
    [*#title*],
    year,
    text(black.lighten(40%), subtitle),
    align(right)[#place]
  )
  v(-8pt)
  text(weight: "light", size: 11pt, description)
}

#let cv_list(..content) = {
  grid(
    columns: (30em, 1fr, auto),
    rows: 1em,
    gutter: 4pt,
    ..content
  )
}

#let cv_item(title, description) = {
  [*#title* #h(3pt) #description]
}

/* ==============================================
   Project configuration
   ============================================== */
#let project(
  title: "",
  firstname: "",
  familyname: "",
  website: "",
  email: "",
  github: "",
  phone: "",
  main_color: black,
  main_font: "Helvetica",
  socials_below_name: false,
  body) = {

  /* -----------------------------------
     Header
     ----------------------------------- */
  set page(margin: (left: 12mm, right: 12mm, top: 12mm, bottom: 12mm))
  set text(font: main_font, lang: "en")
  let title_size = 35pt;

  show heading.where(level: 1): it => text(
    size: 12pt,
    weight: "semibold",
    fill: main_color,
    block(it + sepline(main_color))
  )

  let full_name = {
    align(left)[
      #text(title_size)[
        *#text(fill: main_color, title_size)[#firstname] #familyname*
    ]]
  }

  let info_compact = {
    grid(
      columns: (120pt, 150pt),
      rows: (15pt, auto),
      gutter: 1pt,
      [#fa-icon("envelope", solid: true) #h(2pt) #email],
      [#fa-icon("phone", solid: true) #h(2pt) #phone],
      [#fa-icon("globe", solid: true) #h(2pt) #link(website)],
      [#fa-icon("github", solid: true) #h(2pt) #link(github)],
    )
  }

  let info_extended = {
    [#fa-icon("envelope", solid: true) #h(2em) #email]
    [#fa-icon("phone", solid: true) #h(2em) #phone]
    [#fa-icon("globe", solid: true) #h(2em) #link(website)]
    [#fa-icon("github", solid: true) #h(2em) #link(github)]
  }

  if socials_below_name {
    full_name
    v(-2.5em)
    text(weight: "light", 10pt, black.lighten(10%), info_extended)
    v(0em)
  }
  else {
    grid(
      columns: (230pt, 200pt),
      rows: (25pt),
      gutter: 3pt,
      full_name,
      text(weight: "light", 10pt, black.lighten(10%), info_compact)
    )
  }

  text(black.lighten(40%), weight: "semibold", 14pt, title)

  v(1em)

  /* -----------------------------------
     Main content
     ----------------------------------- */
  body
}

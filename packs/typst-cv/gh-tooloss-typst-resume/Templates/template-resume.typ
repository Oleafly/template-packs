#import "@preview/datify-core:1.0.0": *

// colors
#let color_dark = rgb("#131A28")
#let color_gray = rgb("333333")
#let color_neutral = rgb("444444")
#let color_maybe = rgb("#3F4970")

#let textsize_title = 14pt
#let textsize_subtitle = 12pt
#let textsize_text = 11pt

#let picture_size = 70pt
#let icon_size = 10pt

#let contact_margin = 1pt

#let paragraph_spacing = 0.75em


#let align_left_right(left_element, right_element) = {
  block[
    #left_element
    #box(width: 1fr)[
      #align(right)[
        #right_element
      ]
    ]
  ]
}


// gparams
// - lang
// - firstname
// - lastname
// - position
// - contacts

#let resume(gparams: (:), body) = {

  // document metadata
  set document(
    author: gparams.firstname + " " + gparams.lastname,
    title: "cv"
  )

  // text default parameters
  set text(
    //font: 
    lang: gparams.lang,
    size: textsize_text,
    fill: color_dark,
    fallback: false,
    font: "New Computer Modern"
  )

  // document margin
  set page(
    paper: "a4",
    margin: (left: 0.30in, right: 0.30in, top: 0.3in, bottom: 0.3in),
  )

  // disable header numbering, border, ...
  set heading(
    numbering: none,
    outlined: false,
  )

  let photo = {
    align(right)[
      #box(fill: gray, width: picture_size, height: picture_size, gparams.picture)
    ]
  }

  let name = {
    align(left)[
      #pad(bottom: -5pt)[
        #block[
          #smallcaps[
            #set text(size: 25pt, style: "normal")
            #text(weight: "bold")[#gparams.firstname]
            #text(weight: "bold")[#gparams.lastname]
          ]
        ]
      ]
    ]
  }

  let position = {
    set text(size: textsize_title, weight: "regular", ligatures: false)
    align(left)[
      #pad(bottom: 1pt)[
        #smallcaps[
          #gparams.position.join(text[#" "#sym.dot.c#" "])
        ]
      ]
    ]
  }

  let contact = {
    set box(height: 1pt)
    set text(size: textsize_text)

    let separator = box(width: contact_margin)

    align(left)[
      #block(height: 0pt)[
        #align(horizon)[
          #let i = 0
          #for (icon, string) in gparams.contact {
            i = i + 1
            {box(icon, height: icon_size, width: icon_size, baseline: icon_size/2)}
            box(width: 5pt)
            {box[#text(string)]}
            if gparams.contact.len() != i [
              #separator
              #text(baseline: 2pt)[|]
              #separator
            ]
          }
        ]
      ]
    ]
  }
  if gparams.show_picture [
    #grid(
      align: horizon,
      columns: (1fr, 5fr),
      column-gutter: 2em,
      photo,
      {name; position; contact},
    )
  ] else [
    #grid(
      align: horizon,
      columns: 5,
      column-gutter: .2em,
      box(width: 1pt),
      {name; position; contact},
    )
  ]

  body
}

#let new_section(name) = {
  set text(
    size: textsize_title,
    weight: "bold",
    fill: color_maybe
  )
  align(left)[
    #smallcaps[#name]
    #box(width: 1fr, line(length: 100%), fill: color_maybe)
    #box(height: 15pt)
  ]
}

#let date_range(start, end) = {
  set text(weight: "thin")

  let start_month = start.at(0)
  let start_year = start.at(1)

  let end_month = end.at(0)
  let end_year = end.at(1)

  context[

    #let start_month_text = if start_month != 0 {get-month-name(start_month, width: "abbreviated", lang: text.lang)} else {""}
    #let end_month_text = if end_month != 0 {get-month-name(end_month, width: "abbreviated", lang: text.lang)} else {""}
    
    #let total_text = start_month_text + " " + start_year + " - " + end_month_text + " " + end_year
    
    #text(total_text, style: "italic")
  ]
}

#let new_infos(name, positions, location, start_date, end_date, infos) = {
  
  pad(bottom: -7pt)[
    #align_left_right[
      #text(name, weight: "bold", size: textsize_subtitle)
    ][
      #text(location, weight: "regular", style: "italic")
    ]
  ]
  pad(bottom: -7pt)[
    #align_left_right[
      #smallcaps[
        #let i = 0
        #for pos in positions {
          i += 1
          text(pos, fill: color_neutral)
          if i != positions.len() [
            #box(width: -5pt)
            #sym.dot.c
            #box(width: -5pt)
          ]
        }
      ]
    ][
      #date_range(start_date, end_date)
    ]
  ]
  for i in infos {
    "-" + text(i)
    linebreak()
  }
}

#let new_project(name, infos) = {
  pad(bottom: -7pt)[
    #text(name, weight: "bold", size: textsize_subtitle, fill: color_maybe)
  ]
  for i in infos {
    "-" + text(i)
    linebreak()
  }
}

#let new_skill(category, infos) =  {
  pad(bottom: -7pt)[
    #grid(
      align: top,
      columns: (1.5fr, 5fr),
      column-gutter: 2em,
      align(right)[#smallcaps[#text(category, weight: "bold")]],
      {
        let index = 0
        for i in infos {
          index += 1
          text(i)
          if index != infos.len() [
            #text(",")
          ]
        } 
      },
    )
  ]
}

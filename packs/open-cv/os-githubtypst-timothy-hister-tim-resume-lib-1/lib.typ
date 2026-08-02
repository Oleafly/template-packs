#let v1 = -2pt   // space after jump up list 
#let v2 = -4pt   // space after indented list
#let v3 = 4pt    // space before new section
#let margins = (x: 1.9cm, top: 1.5cm, bottom: 2cm)


#let github() = image("www/github.svg")
#let linkedin() = image("www/linkedin.svg")
#let envelope() = image("www/envelope.svg")

#let line_of_links(vspace: 0pt) = {
  v(vspace)
  text(font: "Source Sans Pro", size: 11pt, fill: rgb("#00004d"))[
  #link("https://github.com/timothy-hister")[
    #box(height: 10pt, [#v(1.5pt) #github()]) timothy-hister
  ]
  #text(fill: black)[|]
  #link("https://linkedin.com/in/timothy-hister")[
    #box(height: 10pt, [#v(1.5pt) #linkedin()]) timothy-hister
  ]
  #text(fill: black)[|]
  #link("mailto:timothyhister@protonmail.com")[
    #box(height: 10pt, [#v(1.5pt) #envelope()]) timothyhister\@protonmail.com
  ]
  ]
}

#let ou(country) = if country == "USA" [o] else [ou]
#let sz(country) = if country == "Britain" [s] else [z]
#let printCanada(country) = {
  if country != "Canada" {
    [, Canada]
  }
}

#let resume(
  my_name: "Timothy Hister",
  my_job: "Data Scientist/Economist",
  document_name: "Résumé",
  margins: (x: 1.9cm, top: 1.5cm, bottom: 2cm),
  TN_visa: false,
  show_line_of_links: true,
  show_lines_in_heading: true,
  show_footer: true,
  body
) = {
  set document(author: my_name, title: document_name + "of" + my_name)
  set text(font: "Source Sans Pro", size: 11pt, fill: black)
  set page(
    paper: "us-letter",
    margin: margins,
    footer: {
      if show_footer [
        #align(center)[
          #document_name of #my_name: Page #context counter(page).display("1 of 1", both: true)
        ]
      ]
    }
  )

  text(font: "Alegreya Sans SC", size: 26pt)[*#my_name*] // Title
  text(font: "Source Sans Pro", fill: gray, size: 10pt)[ #my_job] // My Job
  if show_line_of_links [#line_of_links(vspace: -7pt)]

  set par(justify: true)
  set list(marker: ([•], [--]))

  show heading: xx => [
    #v(v3)
    #text(font: "Alegreya Sans SC", size: 16pt, fill: black)[#xx]
    #v(-12pt)
    #if show_lines_in_heading [#line(length: 150pt, stroke: .3pt + black)] else [#v(14pt)]
  ]

  show link: xx => [
    #set text(fill: blue)
    #xx]
  
  body
}

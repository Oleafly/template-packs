#import "template.typ": conf,va,theorem,proof,example
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: house, hexagon

#set smartquote(quotes: "»«")
#let title = "Lab 1"
#let kurs = "Digital IC-design"
#let kurskod = "ETIN20"
#let authors = (
    (
      name: "Enar Sundgren",
      email: "en5604su-s@student.lu.se",
    ),
    (
      name: "David Dahlin",
      email: "da5607da-s@student.lu.se"
    )


  )


#show: conf.with(
  title: [
      #title
  ],
  authors: authors,
  kurs: kurs,
  kurskod: kurskod,

  //Settings
  lang: "en", //sv or en
  toc: false,
  indent: false,
  ncols: 1,
  numbering: none
)

#set heading(numbering: "1.")

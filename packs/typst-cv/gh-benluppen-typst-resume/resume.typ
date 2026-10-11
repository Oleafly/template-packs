/* VARIABLES */
#import "vars.typ": email, github, linkedin, location, name, phonenum, website, summary, projects

#let emailclick = link("mailto:" + email)
#let font = "Open Sans"
#let li-symbol = image("icons/linkedin-brands-solid-full.svg")
#let git-symbol = image("icons/git-alt-brands-solid-full.svg")
#let github-symbol = image("icons/github-brands-solid-full.svg")
#let globe-symbol = image("icons/globe-solid-full.svg")

/* DOCUMENT SETTINGS */
#set document(author: name, title: [#name Resume])

#set page(
  paper: "us-letter",
  margin: 2em,
  height: auto
)

#set text(
  size: 10pt,
  font: font,
  stretch: 95%
)

#set line(
  length: 100%,
  stroke: 0.5pt
)

/* Applies font to math */
#show math.equation: set text(font: font)

/* RESUME */

/*Header*/
#align(right)[
  = #text(size: 1.5em)[#name ]\
  #phonenum | #emailclick | #location \
  #box(li-symbol, height: 0.85em)#h(4pt)#linkedin\
  #box(github-symbol, height: 0.85em)#h(4pt)#github\
  #box(globe-symbol,height: 0.85em)#h(4pt)#website
]

/*Professional Summary*/
== Professional Summary
#line()
#summary

/*Professional Experinece*/
== Professional Experience
#line()

#include "experience/fmt.typ"

/*Education*/
== Education
#line()

#include "education/fmt.typ"

/*Certs*/
== Certifications
#line()

#include "certification.typ"

/*Personal Projects*/
== Independent Projects
#line()

#include "project.typ"

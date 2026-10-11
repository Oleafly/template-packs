#import "@preview/charged-ieee:0.1.4": ieee

// ===================================
// Thesis Title Page & Front Matter
// ===================================
#let titleDE = "Deutscher Titel\nMaximal zwei Zeilen"
#let titleEN = "English Title\nTwo lines at most"
#let student = "Nico Dilger"
#let matrnr = "22302719"
#let submissiondate = "XX. Monat 20XX"
#let supervisor = "Prof. Dr. <PROFESSOR>"
#let secsupervisor = "Prof. Dr. <ZWEITPRÜFER>"
#let studies = "Bachelor Künstliche Intelligenz"
#let faculty = "Angewandte Informatik"

#set page("a4", numbering: "1")
#set text(font: "Libertinus Serif", lang: "de", size: 11pt)
#show heading: set block(above: 1.4em, below: 1em)

#align(center)[
  #v(3cm)
  #text(size: 20pt, weight: "bold")[#titleDE]
  
  #v(1cm)
  #text(size: 16pt)[#titleEN]
  
  #v(2.5cm)
  #text(size: 14pt)[
    Prüfungsstudienarbeit \
    
    im Studiengang #studies \
    an der Fakultät #faculty
  ]
  
  #v(2.5cm)
  #text(size: 14pt)[
    Vorgelegt von: \
    *#student* \
    Matrikelnummer: #matrnr \
  ]
  
  #v(1.5cm)
  #text(size: 14pt)[
    Betreuer: #supervisor \
    #if secsupervisor != none [Zweitprüfer: #secsupervisor \ ]
  ]
  
  #v(1.5cm)
  #text(size: 14pt)[
    Eingereicht am: #submissiondate
  ]
]

#pagebreak()

// ===================================
// Declaration of originality
// ===================================
#heading(level: 1, outlined: false)[Eigenständigkeitserklärung]

Ich erkläre hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe. \ \

#v(2cm)
#line(length: 100%, stroke: 0.5pt)
Ort, Datum #h(1fr) Unterschrift

#pagebreak()

// ===================================
// Table of Contents
// ===================================
#outline(title: "Inhaltsverzeichnis", depth: 3, indent: auto)

#pagebreak()
#set page(numbering: "1")

// ===================================
// IEEE Paper Content
// ===================================
#show: ieee.with(
  title: titleDE,
  paper-size: "a4",
  abstract: [
    The abstract goes here.
  ],
  authors: (
    (
      name: student,
      department: studies,
      organization: faculty,
      location: [Deggendorf, Germany],
      email: "nico.dilger@stud.th-deg.de"
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    numbering("I.", n.at(0))
  } else if n.len() == 2 {
    numbering("1.", n.at(1))
  } else if n.len() <= 4 {
    n.slice(1).map(str).join(".")
  } else {
    none
  }
})

#show heading.where(level: 3): it => block(above: 1.2em, below: 0.6em)[
  #set text(weight: "bold", style: "normal", size: 10pt)
  #if it.numbering != none [
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #h(0.5em)
  ]
  #it.body
]

#show heading.where(level: 4): it => block(above: 1.0em, below: 0.4em)[
  #set text(weight: "bold", style: "italic", size: 10pt)
  #if it.numbering != none [
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #h(0.5em)
  ]
  #it.body
]

#show heading.where(level: 5): it => block(above: 0.8em, below: 0.4em)[
  #set text(weight: "regular", style: "italic", size: 10pt)
  #if it.numbering != none [
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #h(0.5em)
  ]
  #it.body
]


= Introduction
Scientific writing is a crucial part of the research process, allowing researchers to share their findings with the wider scientific community. However, the process of typesetting scientific documents can often be a frustrating and time-consuming affair, particularly when using outdated tools such as LaTeX. Despite being over 30 years old, it remains a popular choice for scientific writing due to its power and flexibility. However, it also comes with a steep learning curve, complex syntax, and long compile times, leading to frustration and despair for many researchers @netwok2020 @netwok2022.

== Paper overview
In this paper we introduce Typst, a new typesetting system designed to streamline the scientific writing process and provide researchers with a fast, efficient, and easy-to-use alternative to existing systems. Our goal is to shake up the status quo and offer researchers a better way to approach scientific writing.

By leveraging advanced algorithms and a user-friendly interface, Typst offers several advantages over existing typesetting systems, including faster document creation, simplified syntax, and increased ease-of-use.

To demonstrate the potential of Typst, we conducted a series of experiments comparing it to other popular typesetting systems, including LaTeX. Our findings suggest that Typst offers several benefits for scientific writing, particularly for novice users who may struggle with the complexities of LaTeX. Additionally, we demonstrate that Typst offers advanced features for experienced users, allowing for greater customization and flexibility in document creation.

Overall, we believe that Typst represents a significant step forward in the field of scientific writing and typesetting, providing researchers with a valuable tool to streamline their workflow and focus on what really matters: their research. In the following sections, we will introduce Typst in more detail and provide evidence for its superiority over other typesetting systems in a variety of scenarios.

= Methods <sec:methods>
#lorem(45)

$ a + b = gamma $ <eq:gamma>

#lorem(80)

#figure(
  placement: none,
  circle(radius: 15pt),
  caption: [A circle representing the Sun.]
) <fig:sun>

In @fig:sun you can see a common representation of the Sun, which is a star that is located at the center of the solar system.

#lorem(120)

#figure(
  caption: [The Planets of the Solar System and Their Average Distance from the Sun],
  placement: top,
  table(
    // Table styling is not mandated by the IEEE. Feel free to adjust these
    // settings and potentially move them into a set rule.
    columns: (6em, auto),
    align: (left, right),
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  { rgb("#efefef") },

    table.header[Planet][Distance (million km)],
    [Mercury], [57.9],
    [Venus], [108.2],
    [Earth], [149.6],
    [Mars], [227.9],
    [Jupiter], [778.6],
    [Saturn], [1,433.5],
    [Uranus], [2,872.5],
    [Neptune], [4,495.1],
  )
) <tab:planets>

In @tab:planets, you see the planets of the solar system and their average distance from the Sun.
The distances were calculated with @eq:gamma that we presented in @sec:methods.

#lorem(240)

#lorem(240)

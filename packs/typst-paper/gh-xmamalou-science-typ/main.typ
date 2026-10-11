/*
    Science-typ - A typst template for writing beautiful scientific papers
    Copyright (C) 2025 Christoforos-Marios Mamaloukas

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

// Logo
#let logo = "./res/img/logo.png"

// Names of author, paper and institution
#let author_name = [
    My name
]
#let paper_name = [
    My paper name
]
#let institution_name = [
    My institution name
]

// Abstract
#let abstract = [
    Summarize the reason for this paper and the most important results of your research.
]

#let date = datetime.today()

#set par(justify: true)

// text properties
#set text(
    font: "Alegreya",
    size: 8pt)

#show heading: it => [
  #set align(center)
  #set text(
      10pt, 
      font: "Cantarell", weight: "extrabold")
  #block(smallcaps(it.body))
]

#show figure: it => [
    #set align(center)
    #set text(
        9pt,
        font: "Alegreya",
        weight: "bold")
    #block(it)]

#show link: underline

#set page(
    paper: "a4",
    header: align(
        left,
    )[
        #paper_name - #date.display() \
        #line(length: 250pt)],
    footer: align(
        left
    )[
        #line(length: 250pt) \
        #author_name - Page #context[
            #counter(page).display(
                "1",
                both: false,
        )]
    ],
    columns: 2,
    margin:(x: 1.0cm,
    ),
)

#place(
    dx: 400pt,
    dy: -165pt,
    float: false,
)[
    #image(logo, width: 60%)
]

#place(
    top + center,
    dy: 10pt,
    float: true,
    scope: "parent",
    clearance: 2em,
)[
    #par(
        justify: false
    )[
        #text(18pt, font:"Cantarell", weight: "bold")[
            *#paper_name*
        ] \
        #text(10pt, author_name) \
        #text(8pt, institution_name) \
        \
        #text(10pt, font:"Cantarell", weight: "bold")[
            *ABSTRACT*
        ] \
        #text(8pt, abstract) \
    ]
]

Start with a small introduction

= BACKGROUND
Then present the background of the paper and what you are researching

= METHOD
Describe any method you used to get any results

= RESULTS
Present and analyze your results

= CONCLUSIONS
Describe any further conclusions from your results

= MISCELLANEOUS
Describe what needs further research or what wasn't covered in this paper

= REFERENCES
Have your references here

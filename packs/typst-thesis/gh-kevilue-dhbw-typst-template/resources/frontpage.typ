/*
frontpage.typ

This file contains the front page of the document.
*/

#let frontpage(
  workTitle: "Bachelor thesis", 
  title: "My Title", 
  studyProgram: "Faculty x", 
  universityName: "DHBW Stuttgart",
  author: "Max Mustermann",
  matrNum: "0000000",
  course: "XYIN",
  supervisor: "Max Mustermann",
  lang: "en"
) = {
  // Logo
  place(top + right, image("../images/logo.png", width: 35%))
  align(horizon)[
    #align(center, text(20pt)[
      #workTitle
    ])
    // #v(1em)
    #align(center, text(12pt)[
    #if lang == "en" [
      on the topic
    ] else if lang == "de" [
      zum Thema
    ] else [
      Language not implemented yet.
    ]
    ])
    // Title
    #align(center, text(24pt)[
      *#title*
    #align(center, text(12pt)[
      #studyProgram #parbreak()
      #if lang == "en" [
        at the 
      ] else if lang == "de" [
        an der 
      ] else [
        Language not implemented yet.
      ]
      #universityName
    ])
    ])
  ]
  // Details
  align(bottom + center)[
  #grid(
    columns: (auto, auto),
    column-gutter: -0.8em,
    row-gutter: -1em,
    inset: 1em,
    align: left,
    text()[*Student*], author,
    if lang == "en" {text()[*Matriculation Number*]} 
    else if lang == "de" {text()[*Matrikelnummer*]}, 
    matrNum,
    if lang == "en" {text()[*Course*]} 
    else if lang == "de" {text()[*Kurs*]}, 
    course,
    if lang == "en" {text()[*Supervisor*]} 
    else if lang == "de" {text()[*Betreuer*]}, 
    supervisor,    
  )  
  ]
}
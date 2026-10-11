#import "template/thesis_template.typ": thesis


// Enter your thesis data here
#let english_title = "English Title"
#let dutch_title = "Dutch Title" // in dutch
#let cover_info = "It is an amazing image."
#let degree = "PhD"
#let supervisor = "Prof. dr. ir. M. Dijkstra"
#let defense_date = "maandag 25 juni 0001 des ochtends te 10.30 uur" // in dutch
#let author = "Tom de Jerry"
#let author_birth = "someday somewhere, Earth" // in dutch
#let author_funding = "The Sponsor"
#let bib_file = "ref.bib"


#show: thesis.with(
    english_title: english_title,
    dutch_title: dutch_title,
    cover_info: cover_info,
    degree: degree,
    supervisor: supervisor,
    defense_date: defense_date,
    author: author,
    author_birth: author_birth,
    author_funding: author_funding,
    bib_file: bib_file,
    acknowledgements: include "backmatter/acknowledgements.typ",
    publications: include "backmatter/publications.typ",
    about_author: include "backmatter/about_author.typ",
)

= Introduction

In this chapter, we introduce the thesis.

#pagebreak()

== SPQR

#lorem(600) @amazing_work

// #include "chapter1/chapter.typ"
// #include "chapter2/chapter.typ"
// #include "chapter3/chapter.typ"
// #include "chapter4/chapter.typ"

#import "uh-thesis.typ": uh-thesis, default-header, include_paper

#let m_title = "My thesis"
#let m_author = "JZ"

#show: uh-thesis.with(
  title: m_title,
  author: m_author,
  date: datetime(year: 2023, month: 10, day: 24), // datetime.today()
)
// -------------------------
// pre matter
// -------------------------

#if m_title != "" {
    page(header: none, footer: none, numbering: none)[
    #align(center)[
      #set par(justify: false)
      UNIVERSITY OF HELSINKI #h(1fr) REPORT SERIES IN PHYSICS #v(2em)
      HU-P-D??? #v(3em)
      #text(size: 1.8em, weight: "bold")[#m_title] #v(2em)
      #text(size: 1.3em, weight: "bold")[#m_author] #v(3em)
      Helsinki Accelerator Laboratory \ 
      Division of Materials Physics \
      Department of Physics \
      Faculty of Science \
      University of Helsinki \
      Helsinki, Finland #v(1em)
      
      // #text(size: 14pt)[#date.display("[month repr:short] [day], [year]")]
      #v(1fr)
      DOCTORAL DISSERTATION #v(1em)
      #text(style: "italic", size: 0.9em)[To be presented for public discussion with the permission of the Faculty of Science of University of Helsinki, in ??? place, on the ?? time] #v(1em)
       HELSINKI 20??
    ]]
  }

#include "pre.typ"

// -------------------------
// Main matter
// -------------------------

#set page(numbering: "1",
  header: default-header,
)
#counter(page).update(1)

#include "part_1.typ"

// -------------------------
// Bibliography
// -------------------------

#pagebreak(weak: true)

#bibliography("ref.bib", title: "Bibliography", style: "american-physics-society")

// include your articles in (file name, file page) here
// #let articles = (("1.pdf", 4),
//                  ("1.pdf", 4),
//                  ("1.pdf", 4),
//                  ("1.pdf", 4))
//
// #include_paper(articles)

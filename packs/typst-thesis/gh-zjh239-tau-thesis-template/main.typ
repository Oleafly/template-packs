#import "tau-thesis.typ": tau-thesis, include_paper 

#let m_title = "My thesis"
#let m_subtitle = "And here is the subtitle"
#let m_author = "JZ"

#show: tau-thesis.with(
  title: m_title,
  author: m_author,
  date: datetime(year: 2023, month: 10, day: 24), // datetime.today()
)

// // title page
// #if m_title != "" {
//     page(header: none, footer: none, numbering: none)[
//     #align(center)[
//       Tampere University Dissertations ??? #h(1fr)
//       #v(10%)
//       #h(1fr)#text(size: 1.4em)[#m_author] #v(3em)
//       #h(1fr)#text(size: 1.8em, weight: "semibold")[#m_title]\
//       #h(1fr)#text(size: 1.4em)[#m_subtitle] #v(2em)
//
//       // #text(size: 14pt)[#date.display("[month repr:short] [day], [year]")]
//       #v(1fr)
//       ACADEMIC DISSERTATION #v(1em)
//       #text(style: "italic", size: 0.9em)[
//         To be presented for public discussion with the permission\ of the Faculty of Engineering and Natural Sciences\ of Tampere University,\ in ??? place,\ on the ?? time] #v(1em)
//     ]]
//   }

// #includepdf("title_page.pdf", 2)

// pre matter
#include "pre.typ"

// #page()[]
// -------------------------
// Main matter
// -------------------------

#set page(numbering: "1",
  footer: context{ 
      align(center)[#counter(page).display()]
    },
)
#counter(page).update(1)


#include "part_1.typ"

// -------------------------
// Bibliography
// -------------------------

#pagebreak()

// #heading(numbering: none, outlined: true, depth: 1)[Bibliography]
#bibliography("ref.bib", title: "Bibliography", style: "american-physics-society")

// include your articles in (file name, file page) here
// #let articles = (("cover_1.pdf","1.pdf", 4),
//                  ("cover_1.pdf","1.pdf", 4),
//                  ("cover_1.pdf","1.pdf", 4),
//                  ("cover_1.pdf","1.pdf", 4))
//
// #include_paper(articles)

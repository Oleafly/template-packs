#import "template/lib.typ": *
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary

#show: supercharged-dhbw.with(
  title: "Title",
  type-of-thesis: "Bachelorarbeit",
  type-of-degree: "3. Studienjahr",
  authors: (
    (
      name: "Max Mustermann",
      student-id: "1111111",
      course: "INF2023AI",
      course-of-studies: "Allgemeine Informatik",
      company: (
        (name: "Company123", post-code: "111111", city: "Heidenheim")
      ),
    ),
    // here you can add a second author
  ),
  show-acronyms: true,
  acronyms: acronyms, // displays the acronyms defined in the acronyms dictionary
  show-abstract: true,
  ai-table: true,
  appendix: true,
  at-university: false, // if true the company name on the title page and the confidentiality statement are hidden
  bibliography: bibliography("bibliography.bib"),
  date: datetime.today(),
  show-glossary: true,
  glossary: glossary, // displays the glossary terms defined in the glossary dictionary
  reset-footnote-counter: true,
  list-indent: 1em,
  language: "de", // en, de
  university: "Dualen Hochschule Baden-Württemberg",
  university-location: "Heidenheim",
  university-short: "DHBW",
  weeks: 12,
  supervisor: (company: "Otto Normalverbraucher", university: "Erika Mustermann"),
  // for more options check the package documentation (https://typst.app/universe/package/supercharged-dhbw)
)

// Edit this content to your liking and adjust the second number, to the count of the existing chapters + 1
#for i in range(1, 4) {
  include "chapters/" + str(i) + ".typ"
}

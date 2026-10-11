#import "lib/lib.typ": *

// This block configures the main information of your report.
// These variables will be used automatically in the cover page and title page.
#show: project.with(
  // The name of your campus (e.g., Purwanchal Campus)
  campus: [Somethinganchal Campus],
  // Title prefix or report type (e.g., A Major Project Progress Report On)
  type: [A Major Project Progress Report On],
  // The main title of your project/report
  title: [Implementing A Super Cool Project using All the Knowledge I have Acquired.],
  // List of authors and their roll numbers
  by: (
    [Example Karki (PUR000BCT000)],
    [Example Khanal (PUR000BCT000)],
    [Example Guragain (PUR000BCT000)],
    [Example Subedi (PUR000BCT000)]
  ),
  // The name and designation of your supervisor
  supervisor: [Asst. Prof. Example Guragai],
  // Your department's full name
  department: [Department of Something and Something Engineering],
  // Faculty specialization (e.g., Computer, Civil, Mechanical)
  faculty: [Computer],
  // The location of your campus
  address: [City, Nepal],
  // The date to display on the cover/title page
  date: [March, 2026],
  // Set to true to include the cover page in the final PDF
  show-coverpage: true,
  // Set to true to include the inner title page in the final PDF
  show-titlepage: true,
)


#include-if-exists("./content/declaration.typ")
#pagebreak()

#include-if-exists("./content/copyright.typ")
#pagebreak()

#include-if-exists("./content/acknowledgement.typ")
#pagebreak()

#include-if-exists("./content/abstract.typ")
#pagebreak()

// Customize outline entries
#show outline.entry.where(level: 1): it => {
  v(0pt)
  link(it.element.location())[
    #strong[#it.prefix() #upper[#it.body()]] #h(1fr) #it.page()]
}
#outline()
#pagebreak()

// Reset the outline entries for List of Figures
= List of Figures
#show outline.entry: it => link(
  it.element.location(),
  it.indented(strong[#it.prefix()], it.inner()),
)
#outline(
  title: none,
  target: figure,
)
#pagebreak()

#include-if-exists("./content/list-of-abbreviations.typ")
#pagebreak()

// Reset page numbering for main content
#set page(numbering: "1")
#counter(page).update(1)
#set heading(
  supplement: [Chapter],
  numbering: "1.1.1.1"
)
#show heading.where(level: 1): it => {
  align(center)[
    #upper[
      #it.supplement #counter(heading).display("1")
      #linebreak()
      #it.body
    ]
  ]
  v(12pt)
}
#show heading.where(level: 2): it => {
  v(6pt)
  [#counter(heading).display("1.1") #it.body]
  v(12pt)
}
#show heading.where(level: 3): it => {
  [#counter(heading).display("1.1.1") #it.body]
  v(6pt)
}

#include-if-exists("./content/introduction.typ")
#pagebreak()

#include-if-exists("./content/related-theory.typ")
#pagebreak()

#include-if-exists("./content/literature-review.typ")
#pagebreak()

#include-if-exists("./content/methodology.typ")
#pagebreak()

#include-if-exists("./content/implementation.typ")
#pagebreak()

#include-if-exists("./content/current-status.typ")
#pagebreak()

#include-if-exists("./content/conclusion.typ")
#pagebreak()

#set heading(numbering: none)
#show heading.where(level: 1): it => {
  align(center)[
    #upper[#it.body]
  ]
  v(12pt)
}

#include-if-exists("./content/references.typ")
#pagebreak()

#set heading(numbering: none)
#show heading.where(level: 1): it => {
  align(center)[#upper[#it.body]]
  v(12pt)
}
#show heading.where(level: 2): it => {
  v(6pt)
  [#it.body]
  v(12pt)
}
#show heading.where(level: 3): it => {
  [#it.body]
  v(6pt)
}

#include-if-exists("./content/appendix.typ")

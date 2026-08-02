#import "@preview/classic-aau-report:0.3.0": project, mainmatter, chapters, backmatter, appendix

// Any of the below can be omitted, the defaults are either empty values or CS specific
#show: project.with(
  meta: (
    project-group: "CS-xx-DAT-y-zz",
    participants: (
      "Alice",
      "Bob",
      "Chad",
    ),
    supervisors: "John McClane",
  ),
  en: (
    title: "An Awesome Project",
    theme: "Writing a project in Typst",
    abstract: [],
  ),
  // omit the `dk` option completely to remove the Danish titlepage
  dk: (
    title: "Et Fantastisk Projekt",
    theme: "Et projekt i Typst",
    abstract: [],
  ),
)

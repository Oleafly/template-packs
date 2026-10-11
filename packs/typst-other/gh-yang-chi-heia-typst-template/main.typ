#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Mon projet",
  subtitle: "Sous titre",
  authors: (
    (name: "Student", email: "student@mail.com", affiliation: "HEIA-FR"),
  ),
  teachers: (
    (name: "[Placeholder]", email: "[Placeholder]@example.email]", affiliation: "HEIA-FR"),
  )
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

#include "chapter/01_introduction.typ"
#pagebreak()

#include "chapter/02_analyse.typ"
#pagebreak()

#include "chapter/03_conception.typ"
#pagebreak()

#include "chapter/04_implementation.typ"
#pagebreak()

#include "chapter/05_evaluation.typ"
#pagebreak()

#include "chapter/06_conclusion.typ"
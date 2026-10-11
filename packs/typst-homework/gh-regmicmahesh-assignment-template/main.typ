#import "lib/elements.typ": *
#import "lib/lib.typ": *

#assignment-content[

  #cover-page(
    subject-name: "<SUBJECT-CODE>: " + lorem(3),
    assignment-title: lorem(8),
    lecturer-name: "Lecturer Name",
    group-members: (
      (name: lorem(2), sid: 12345),
      (name: lorem(2), sid: 12345),
      (name: lorem(2), sid: 12345),
      (name: lorem(2), sid: 12345),
    ),
  )

  #toc-page()

  #counter(page).update(1)

  #assignment-content-page[
    #include "/sections/intro.typ"
  ]

  #assignment-content-page[
    #include "/sections/importance-of-dogs.typ"
  ]

  #bibliography-page(filename: "/main.bib")
]

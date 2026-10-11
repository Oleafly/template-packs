#let abstractEN(title: "Abstract", layoutConfig: none) = {
  show: layoutConfig

  heading(numbering: none, outlined: false, bookmarked: true, title)

  v(1em)

  text()[
    A short summary of the contents in English of about one page. The following points should be addressed in particular: \
    \
    - Motivation: Why did this work come about? Why is the topic of the work interesting (for the general public)? The motivation should be abstracted as far as possible from the specific tasks that may be given by a company.
    - Content: What is the content of this thesis? What exactly is covered in the thesis? The methodology and working method should be briefly discussed here.
    - Results: What are the results of this work? A brief overview of the most important results as a teaser to read the complete thesis.\
    \
    BTW: A great guide by Kent Beck how to write good abstracts can be found here:
  ]

  align(center, [
    https://plg.uwaterloo.ca/~migod/research/beckOOPSLA.html]
  )
}

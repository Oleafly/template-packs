#set document(title: "A Working Title", author: ("First Author",))
#set page(paper: "us-letter", margin: (x: 0.75in, y: 1in))
#set text(size: 10pt)
#set heading(numbering: "I.A.1.")
#set par(justify: true)

#align(center)[
  #text(size: 16pt, weight: "bold")[A Working Title for a Conference Paper]

  First Author and Second Author

  #text(size: 9pt)[Example University, City, Country]
]
#v(1em)

#show: rest => columns(2, gutter: 0.3in, rest)

*Abstract - * Replace with the abstract: problem, approach, evaluation, and
the headline result.

= Introduction
Motivate the problem and list the contributions.

= Method
Display math works across the column:
$ h_t = sigma(W x_t + U h_(t-1) + b) $

= Evaluation
Describe the setup and report results.

= Conclusion
Summarize the contribution.

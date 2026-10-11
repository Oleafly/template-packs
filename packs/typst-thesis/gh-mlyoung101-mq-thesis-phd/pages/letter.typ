#let config = yaml("../config.yaml")

#align(right)[
    = Statement of Originality
]

#v(2em)

This thesis is submitted to Macquarie University in fulfilment of the requirements for
the degree of #config.degrees_candidate.

To the best of my knowledge and belief, the thesis contains no material previously
published or written by another person, except where due reference is made in the
thesis.

Any contribution by other people, including co-authors of papers included in the thesis,
has been acknowledged in the Authorship Contribution Statements.

#v(8em)

#align(right)[
#grid(columns: (auto, auto), gutter: 5em,
[
    // https://www.reddit.com/r/typst/comments/1oi9t8e/comment/nltx8jm/
    Signature: #h(10pt) #box(line(length: 5cm, stroke: 0.8pt)) \
    #config.author
],
[
    Date: #datetime.today().display("[day] [month repr:long] [year]")
]
)
]

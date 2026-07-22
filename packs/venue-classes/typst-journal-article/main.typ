#set document(title: "A Working Title", author: ("First Author",))
#set page(paper: "us-letter", margin: 1in, numbering: "1")
#set text(size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true)

#align(center)[
  #text(size: 17pt, weight: "bold")[A Working Title for a Journal Article]

  First Author #super[1] and Second Author #super[2]

  #text(size: 9pt)[#super[1] Example University #h(1em) #super[2] Example Institute]
]

#v(1em)
#align(center)[#box(width: 85%)[
  *Abstract.* Replace with a concise abstract: problem, approach, and the
  principal quantitative result.
]]
#v(1em)

= Introduction
State the problem, why it matters, and the contributions.

= Method
Inline math like $e = m c^2$ and display math:
$ cal(L)(theta) = EE_x [ ell(f_theta (x)) ] $

= Results
Report findings; tables and figures use standard Typst syntax.

= Conclusion
Summarize and note open questions.

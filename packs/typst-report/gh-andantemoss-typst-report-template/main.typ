#import "template.typ": *

#set text(size: 11pt)
#show: project.with(
  title: "70.077 Hypothetical Subject",
  ulinetitle: true,
  project_title: "4D Project",
  authors: (
    (name: "Jane Doe", id: "1009996", info: "Wrote the Report"),
    (name: "John Doe", id: "1009997", info: "Drew diagrams"),
    (name: "Richard Doe", id: "1009998", info: "Wrote the code"),
  ),
  logo: "sutdlogo.jpg"
)
#show link: underline



= Introduction

We can #hl("highlight") this problem by using statistics @Stat

#lorem(50)

== Problem Statement
#blockquote[How might we solve this problem through the use of technology?]

#lorem(200)

#set text(12pt)

#blockquote(stroke: (left: 5pt + blue))[_#underline[*How might we*]_ solve this problem?]

#set text(12pt)

#lorem(150)

#pagebreak()

= Optimal Solution
```py
for i in range(5):
  print(asc)
```

= Equations

== Labelled Equations

#numbered_eq(
$
bb(P)(A) &= integral_(-infinity)^infinity  bb(P)(A | X= x) dif F_X (x) 
$
)

#numbered_eq(
$
integral_(-infinity)^infinity  bb(P)(A | X= x) f_X(x) dif x
$
)

== Unlabelled Equations

Alternatively, you can also just have unlabelled equations
$
bb(P)(A) &= integral_(-infinity)^infinity  bb(P)(A | X= x) dif F_X (x) \
&= integral_(-infinity)^infinity  bb(P)(A | X= x) f_X(x) dif x
$

== Inline equations
You can also have $f(x) = x^2$ inline equations. You can also make text #colgr[green].

#pagebreak()
= More content

#lorem(200)


// Bibliography
#pagebreak(weak: true)
#set page(header: [])


= Bibliography
#bibliography("bib.yaml", style:"apa", title:none)

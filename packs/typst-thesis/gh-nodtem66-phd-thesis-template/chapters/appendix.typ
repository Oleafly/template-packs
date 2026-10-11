#heading(level: 1, numbering: none)[Appendix]
#counter(heading).step()

#lorem(50)

#pagebreak()

#show heading.where(level: 2): it => context {
  [#numbering("A", counter(heading).get().at(1)) #it.body]
} 

== Introduction

#lorem(200)

== Methods

#lorem(300)

== Results

#lorem(200)

== Discussion

#lorem(200)

== References

#lorem(100)
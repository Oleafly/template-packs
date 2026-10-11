#import "@preview/theorion:0.6.0": *
#import "../../utils/utils.typ": *

#counter(heading).update(0)
#set heading(numbering: appendix-heading-numbering("B"))
#set-theorion-numbering("B.1")

= 记号表

#notation-table((
  ([$NN$], [自然数集合]),
  ([$ZZ$], [整数集合]),
  ([$QQ$], [有理数集合]),
  ([$RR$], [实数集合]),
  ([$CC$], [复数集合]),
  ([$FF$], [实数或复数集合]),
))

#pagebreak()

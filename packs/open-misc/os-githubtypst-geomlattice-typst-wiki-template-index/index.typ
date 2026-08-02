#set quote(block: true)
#show link: set text(fill: blue)
#set text(fill: white, font: "DejaVu Sans Mono",  size: 10pt)

#let title = align(center, text(17pt)[ *Typst Wiki Template*])
#grid(
  columns: (auto, 1fr),
  [#pad(y: 10pt, title)],
  grid.hline(stroke: orange)
)

#show link: set text(fill: blue)

Soon, a Search Engine will be implemented over the text files before compilation to pdf with linkage to relevant pdf files. Maybe webassembly can be used to this end? For now however, please refer to the index or use direct links.

== Mathematicians
- #link("mathematicians/thomas-harriot.html")[Thomas Harriot]
	=== Scholastic Reductions
	- #link("scholastic/harriot_magisteria_magna-9783037190593.html")[Magisteria Magna]
	=== Topics
	- #link("topics/stirling-numbers.html")[Stirling Numbers]
- #link("mathematicians/augustin-cauchy.html")[Augustin Cauchy]  
  === Scholastic Reductions
  - #link("scholastic/cauchy_creation_of_complex_function_theory-9780521068871.html")[Cauchy and the Creation of Complex Function Theory]
- Augustus De Morgan
  === Topics
  - #link("topics/logic.html")[Logic]

== Philosophers
- #link("philosophers/nicomachus-of-gerasa.html")[Nicomachus of Gerasa]

== General Topics
- #link("topics/linear-algebra.html")[Linear Algebra]
- #link("topics/continued-fractions.html")[Continued Fractions]
- #link("topics/neural-networks.html")[Neural Networks]
- #link("topics/deep-learning.html")[Deep Learning]
  === Scholastic Reductions
  - #link("scholastic/continued_fractions-0201135108.html")[Continued Fractions: Analytic Theory and Applications]
  - #link("scholastic/continued_fractions_and_chaos-10_1080-00029890_1992_11995835.html")[Continued Fractions and Chaos]

#show heading.where(level: 2): it => block[
  #set text(weight: "bold") // Maintain standard heading weight
  Appendix #counter(heading).display((..nums) => numbering("1.", ..nums.pos().slice(1))) #it.body
]

= Appendices

== Data Sheets
=== System Hardware Specifications
=== Cryptographic Library Versions

== Extended Mathematical Proofs
=== Proof of Unlinkability
=== Security Analysis of RSA Accumulators
#pagebreak()

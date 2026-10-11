#let text1 = [
  I hereby declare that the work presented in this thesis is entirely my own. I did not use any other sources and references than the listed ones. I have marked all direct or indirect statements from other sources contained therein as quotations. Neither this work nor significant parts of it were part of another examination procedure. I have not published this work in whole or in part before. The electronic copy is consistent with all submitted hard copies.
]

#let text2 = [
#set par(spacing: 12.8pt, 
  leading: 6.2pt)
I hereby declare that the work presented in this thesis is entirely my own. I did not use any other sources and aids than the listed ones. I have marked all direct or indirect transfers from other sources contained therein as referenced quotations. I assure that I have not used any aids that were explicitly ruled out by the examiner.

In Appendix "Use of AI Tools" I have documented to what extent AI tools were used for generating any significant parts of this work. By submitting this work, I assume full responsibility for all content. I have taken notice of and I comply with the Principles for the Use of Artificial Intelligence by Students at the University of Stuttgart.

Neither this work nor significant parts of it were part of another examination procedure. I have not
published this work in whole or in part before. The electronic copy is consistent with all submitted
hard copies.
]

#page(
  header: none,
  footer: none,
  margin: 0cm
)[
  #pad(top: 7.335cm, x: 5.5cm)[
    #set par(spacing: 0cm)
    *Declaration*
    #v(1.2cm)
    #text2
     #v(3.46cm)
    #line(length: 100%, stroke: 0.14mm)
    #v(12.8pt)
    place, date, signature
  ]
]
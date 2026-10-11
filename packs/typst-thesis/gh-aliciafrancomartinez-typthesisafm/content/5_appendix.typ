

#import "../lib.typ": lettrine, note-box, prose, paren-cite

#block(height: 0pt, above: 0pt, below: 0pt)[
  #set text(size: 0pt, fill: white.transparentize(100%))
  #set par(spacing: 0pt, leading: 0pt)
  #heading(level: 1, numbering: none, outlined: true)[Appendices]
]
#counter(heading).update(0) // Resets the count
#set heading(numbering: none)
== Appendix A
#align(center)[
  #text(size:15pt)[*Post-experiment PAS Questionnaire*]
]


*Instructions*: _Next, we will ask you a few questions about the 1–4 scale you have been using on each trial of the experiment. We would appreciate it if you could provide as much detail as possible, as your answers will be very valuable for our research. Thank you in advance!_

*Q1*: _Please try to reproduce the scale *as faithfully as possible*:_

- _What was the question in the scale stem?_ [Open-ended response]
- _What did the label for category 1 say?_ [Open-ended response]
- _What did the label for category 2 say?_ [Open-ended response]
- _​​What did the label for category 3 say?_ [Open-ended response]
- _What did the label for category 4 say?_ [Open-ended response]

*Q2*: _Please reproduce the scale texts (the prompt and the labels) that you would write *based on how you used the scale during the experiment*:_

- _What would the stem of your scale be?_ [Open-ended response]
- _What would the label for your category 1 be?_ [Open-ended response]
- _What would the label for your category 2 be?_ [Open-ended response]
- _What would the label for your category 3 be?_ [Open-ended response]
- _What would the label for your category 4 be?_ [Open-ended response]

*Q3*: _Did the way you used the scale change over the course of the experiment?_ 
[Yes / Maybe / No]  If Yes or Maybe: 
- *Q3+*: _In what way did your use of the scale change over the course of the experiment?_ [Open-ended response]

*Q4*: _To what extent did the scale’s labels match your perceptual experiences during the task?_
[Not at all / A little / Moderately / Quite a lot / Completely]

  #set par(first-line-indent: 0pt)
  
  *Q5*: _If you had to design the scale yourself, what would you change? (for example, the label descriptions, the number of categories, the way it is displayed, etc.)_ [Open-ended response]

  *Q6*: _Any other comments, suggestions, or criticisms you would like to share about the scale or any other aspect of the experiment?_ [Open-ended response]

  #pagebreak()

  
== Appendix B

*Table B1* \
_Criteria for preprocessing participants' responses in Q1 and Q2 items_

#table(
  columns: (1.5in, 1fr),
  stroke: none,
  align: horizon,
  table.hline(stroke: 1pt),
  [*Orthographic*], [
    #set enum(indent: 0.5em)
    1. Convert all text to lowercase.
    2. Remove _final periods_ and symbols (e.g., question marks, quotation marks).
    3. Correct spelling mistakes.
    4. Add a comma before occurrences of "but".
  ],
  table.hline(stroke: 0.5pt),
  [*Gramatical*], [
    #set enum(indent: 0.5em)
    5. Standardize verb conjugations to match the target form ("I did not see the Gabor"). For example:
      - "I have not seen" $arrow$ "I did not see"
      - "I have perceived" $arrow$ "I perceived"
      - "I believe I have seen" $arrow$ "I believe I saw"
    6. Adjust word order to the correct one:
      - "I clearly saw the Gabor" $arrow$ "I saw the Gabor clearly"
  ],
  table.hline(stroke: 0.5pt),
  [*Vocabulary*], [
    #set enum(indent: 0.5em, start: 7)
    7. Standardize references to "Gabor": many participants wrote alternative forms (e.g., Gaub, Gerbo, blanc, Igor); replace all with "Gabor."
    8. Correct "direction" to "orientation", except when it refers to "rotation" (the working memory task).
  ],
  table.hline(stroke: 0.5pt),
  [*Unnecessary \ information*], [
    #set enum(indent: 0.5em, start: 9)
    9. Remove the word "first" when used in phrases such as "the first Gabor" or "the first stimulus."
    10. Remove unnecessary clarifying parentheses (e.g., "(I do not remember the name)").
  ],
  table.hline(stroke: 1pt),
)

#import "../../template.typ": doc, plain-unnumbered-chapter

// Declaration on honest academic work (englisch)
// Kein Eintrag ins Inhaltsverzeichnis -> outlined: false
#let affirmation-en = [
  #plain-unnumbered-chapter("“Declaration on honest academic work“", outlined: false)

  With this document I, #doc.vorname #doc.nachname, declare that I have drafted and created the piece of work in hand myself. I declare that I have only used such aids as are permissible and used no other sources or aids than the ones declared. I furthermore assert that any passages used, be that verbatim or paraphrased, have been cited in accordance with current academic citation rules and such passages have been marked accordingly. Additionally, I declare that I have laid open and stated all and any use of any aids such as AI-based chatbots (e.g. ChatGPT), translation (e.g. Deepl), paraphrasing (e.g. Quillbot) or programming (e.g. Github Copilot) devices and have marked any relevant passages accordingly.

  I am aware that the use of machine-generated texts is not a guarantee in regard of the quality of their content or the text as a whole. I assert that I used text-generating AI-tools merely as an aid and that the piece of work in hand is, for the most part, the result of my creative input. I am entirely responsible for the use of any machine-generated passages of text I used.

  I also confirm that I have taken note of the document “Satzung der Hochschule Furtwangen (HFU) zur Sicherung guter wissenschaftlicher Praxis” dated October 27, 2022 and that I have followed the statements there.

  I am aware that my work may be examined to determine whether any non-permissible aids or plagiarism were used. I also acknowledge that a breach of § 10 or § 11 section 4 and 5 of HFU’s study and examination regulations’ general part may lead to a grade of 5 or «nicht ausreichend» (not sufficient) for the work in question and / or the exclusion from any further examinations.

  // Zwei Unterschriftslinien mit Beschriftung "place, date" bzw. "signature" (2.11)
  #v(2.5cm)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2.5em,
    [
      #place(top, dy: -1.0em)[#doc.ort, #doc.abgabedatum]
      #line(length: 100%, stroke: 0.4pt)
      place, date
    ],
    [
      #line(length: 100%, stroke: 0.4pt)
      signature
    ],
  )
]

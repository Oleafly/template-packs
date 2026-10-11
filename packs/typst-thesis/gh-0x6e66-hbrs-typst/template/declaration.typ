#import "../ads/meta.typ": *
#import "utils.typ": *

#let declaration = {
  set page(background: none)

  align(
    left,
    text(
      size: 20pt,
      if language == "de" {
        [Eigenständigkeiserklärung]
      }
      else if language == "en" {
        [Declaration]
      }
    )
  )

  align(
    left,
    text(
      if language == "de" {
        [Ich versichere hiermit, dass ich meine #language_switch(thesis_subject_type) mit dem Titel]
      }
      else if language == "en" {
        [I hereby affirm that my #language_switch(thesis_subject_type) entitled]
      }
    )
  )

  v(0.3cm)

  align(
    left,
    text(
      smallcaps[#language_switch(thesis_title)]
    )
  )

  v(0.3cm)

  align(
    left,
    text(
      if language == "de" {
        [selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt, falls beide Fassungen gefordert sind.]
      }
      else if language == "en" {
        [was authored independently and does not use any sources and aids other than those indicated. I also affirm that the submitted electronic version is identical with the printed version, if both versions are required.]
      }
    )
  )

  v(5cm)

  line(length: 40%, stroke: 0.5pt)
  
  v(-0.3cm)

  align(
    left,
    text(
      if language == "de" {
        [Sankt Augustin, der #today]
      }
      else if language == "en" {
        [Sankt Augustin, the #today]
      }
    )
  )
}
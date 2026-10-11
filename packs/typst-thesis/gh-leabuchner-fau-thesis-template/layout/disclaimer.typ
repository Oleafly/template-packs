#import "/layout/fonts.typ": *

#let disclaimer(
  title: "",
  degree: "",
  author: "",
  submissionDate: "",
) = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body,
    size: 11pt,
    lang: "en"
  )

  set par(leading: 1em)


  // --- Declaration of Originality ---


    v(20mm)  // Top margin
    align(left, text(font: fonts.sans, size: 2.3em, weight: "semibold", "Declaration Of Originality"))
    v(10mm)
    align(left, text(font: fonts.sans, size: 1em, weight: "regular", "I confirm that the submitted thesis is original work and was written by me without further assistance. Appropriate credit has been given where reference has been made to the work of others. The thesis was not examined before, nor has it been published. The submitted electronic version of the thesis matches the printed version."))
    v(18mm)
    align(left, text(font: fonts.sans, size: 1em, weight: "regular", line(length: 43%)))
    v(-2mm)
    align(left, text(font: fonts.sans, size: 1em, weight: "regular", "Erlangen, " + submissionDate))
    v(20mm)  // Top margin
    align(left, text(font: fonts.sans, size: 2.3em, weight: "semibold", "License"))
    v(10mm)
    align(left, text(font: fonts.sans, size: 1em, weight: "regular", "This work is licensed under the Creative Commons Attribution 4.0 International license (CC BY 4.0), see " + link("https://creativecommons.org/licenses/by/4.0/") + " for details."))
    v(18mm)
    align(left, text(font: fonts.sans, size: 1em, weight: "regular", line(length: 43%)))
    v(-2mm)
    align(left, text(font: fonts.sans, size: 1em, weight: "regular", "Erlangen, " + submissionDate))

}
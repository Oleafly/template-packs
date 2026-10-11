#import "/layout/fonts.typ": fonts

#let titlepage(
    title: "",
    degree: "",
    faculty: "",
    author: "",
    supervisor: "",
    submissionDate: "",
    professorship: "",
    professor: "",
) = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm,),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.sans,
    size: 11pt,
    lang: "en"
  )

  set par(leading: 1em)

    // --- Cover ---
    v(4mm)
    align(center, text(font: fonts.sans, size: 2.03em, weight: "semibold", title))
    v(1mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", upper(degree) + " THESIS"))
    v(1mm)
    align(center, text(font: fonts.sans, size: 1.5em, weight: "semibold", author))
    v(2mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", "Submitted on " + submissionDate))
    v(3mm)
    align(center, image("./Logo_FAU_Sigil.png", width: 27%))
    v(7mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", "Friedrich-Alexander-Universität Erlangen-Nürnberg"))
    v(-2mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", faculty))
    v(-2mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", professorship))
    v(14mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", underline("Supervisor:")))
    v(-2mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", supervisor))
    v(-2mm)
    align(center, text(font: fonts.sans, size: 1em, weight: "regular", professor))
    v(5mm)
    align(center, image("./Logo_FAU_TechFak_EN.png", width: 60%))


}
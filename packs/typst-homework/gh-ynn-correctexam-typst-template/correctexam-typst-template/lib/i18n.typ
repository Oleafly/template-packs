#let _i18n-data = (
  fr: (
    exercise: "Exercice",
    lastname: "NOM :",
    firstname: "PRENOM :",
    studentid: "N° ETUDIANT :",
    anonymousid: "N° ANONYMAT :",
    question-prefix: "Q",
  ),
  en: (
    exercise: "Exercise",
    lastname: "LAST NAME:",
    firstname: "FIRST NAME:",
    studentid: "STUDENT ID:",
    anonymousid: "ANONYMOUS ID:",
    question-prefix: "Q",
  ),
)

#let correctexam-i18n = state("correctexam-i18n", (:))

#let _i18n-map(lang) = {
  let base = _i18n-data.at(lang, default: _i18n-data.en)
  let override = correctexam-i18n.get()
  base + override
}

#let _i18n(lang, key) = {
  let data = _i18n-map(lang)
  data.at(key, default: _i18n-data.en.at(key))
}

#let _points-label(lang, n) = {
  let value = str(n)
  if lang == "fr" {
    "≈ " + value + " points"
  } else {
    "≈ " + value + " points"
  }
}

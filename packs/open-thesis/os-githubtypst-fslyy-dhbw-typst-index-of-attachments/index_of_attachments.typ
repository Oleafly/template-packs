#let __strings = (
  title: (
    en: "Index of Attachments",
    de: "Beigabenverzeichnis",
  ),
)

#let indexOfAttachmentsWith(lang: "en") = [
  #let s(key) = __strings.at(key).at(lang)

  #set heading(numbering: none)
  = #s("title")

  #set enum(numbering: "1.1.", full: true)

// structure your attachment like so 
// + SQuelltexte
//    + source_code_1
//    + source_code_2
// + Projektdokumentationen
//    + documentation_1
// ...

  + Quelltexte
  + Projektdokumentationen
  + Elektronische Quellen
  + Sonstiges
]

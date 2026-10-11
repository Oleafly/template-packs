#import "../_functions.typ": *
#let raw-glossary = yaml("../glossar.yml")
#show: make-glossary

#let parsed-glossary = raw-glossary.map(entry => {
  if "description" in entry {
    entry.description = eval(entry.description, mode: "markup")
  }
  return entry
})

#register-glossary(parsed-glossary)

= Glossar

#print-glossary(parsed-glossary)

#pagebreak()

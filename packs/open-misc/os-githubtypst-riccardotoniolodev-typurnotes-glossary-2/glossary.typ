#set heading(numbering: none)
#import "@preview/glossarium:0.4.1": print-glossary
#show figure.caption : set text(font: "EB Garamond",size: 12pt)
= Glossary
#print-glossary(
  (
    (key: "ft", short: "first term", desc: "The first term in the glossary."),
    (key: "st", short: "second term", desc: "The second term in the glossary."),
    (key: "tt", short: "third term", desc: "The third term in the glossary."),
  )
)

#let erklaerung(
  workTitle: "Bachelorarbeit",
  title: "Mein Thema",
  location: "Stuttgart",
  date: "01.01.2025",
  author: "Max Mustermann",
  lang: "de"
) = {
  
  if lang == "de" {
    heading([Erklärung zur Eigenleistung], numbering: none, outlined: false)
    text()[Ich versichere hiermit, dass ich meine #workTitle mit dem Thema _#title _ selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt. \ ]
  } else if lang == "en" {
    // UNOFFICIAL TEXT!
    // This text was translated with deepl.com and is not an official text from the DHBW.
    // Make sure this text is alright to use before inserting it into your document.
    heading([Declaration of personal contribution], numbering: none, outlined: false)
    text()[I hereby confirm that I have written my #workTitle on the topic _#title _ independently and have not used any sources or aids other than those specified. I also confirm that the electronic version submitted is identical to the printed version. \ ]
  } else {
    text()[Language not implemented yet.]
  }
  
  v(2.5em)
  text()[#location, #date ]
  v(2em)
  
  line(length: 40%, stroke: (thickness: 0.7pt))
  author
}
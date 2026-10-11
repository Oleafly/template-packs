#import "../template.typ": authors, date, title

#heading(outlined: false, "Ehrenwörtliche Erklärung")

#v(1em)

Hiermit versichere ich, dass ich die vorliegende Arbeit mit dem Thema "#text(style: "italic")[#title]" selbstständig verfasst habe und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt.

#v(1em)

#text("Mannheim, " + date.display("[day].[month].[year]"))

#v(0.8em)

#align(left, image("../assets/unterschrift.png", height: 1cm))

#for author in authors [
  #align(left, text(author))
]

#pagebreak(weak: true)

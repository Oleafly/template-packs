#import "/metadata.typ": *
#import "/template/tp-functions.typ": get-full-name

= Eidesstatliche Erklärung <affidavit>

Ich versichere, die von mir vorgelegte Arbeit selbstständig verfasst zu haben. Alle Stellen, die wörtlich oder sinngemäß aus veröffentlichten oder nicht veröffentlichten Arbeiten anderer entnommen sind, habe ich als entnommen kenntlich gemacht. Sämtliche Quellen und Hilfsmittel, die ich für die Arbeit benutzt habe, sind angegeben. Die Arbeit hat mit gleichem Inhalt bzw. in wesentlichen Teilen noch keiner anderen Prüfungsbehörde vorgelegen.
#v(6mm)
I declare that I have written this thesis independently. I have labelled all passages taken verbatim or in spirit from published or unpublished works by others as having been taken from them. All sources and aids that I have used for the work are indicated. The thesis has not been submitted to any other examination authority with the same content or in substantial parts.

#v(3cm)

#for author in authors {
  [
    Karlsruhe, #datetime.today().display("[day].[month].[year]") 
    #line(start: ( 80mm, -3mm),length: 80mm, stroke: 1pt)
    #place(dx: 80mm, dy: -6mm, get-full-name(author))#linebreak()#v(8mm)
  ]
}
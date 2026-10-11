#import "../template.typ": authors, date

#heading(outlined: false, "Selbstständigkeitserklärung")

#v(1em)

Hiermit versichere ich, dass ich die vorgelegte Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe. Alle direkt oder indirekt aus fremden Quellen übernommenen Texte, Gedankengänge, Konzepte, Grafiken o. Ä. habe ich als solche gekennzeichnet und mit vollständigen Quellenangaben versehen.

Mir ist bewusst, dass die Nutzung von mittels generativer KI erstellten Inhalten keine Garantie für deren Qualität bietet und dass ich die volle Verantwortung für daraus resultierende fehlerhafte Inhalte, Datenschutz- oder Urheberrechtsverstöße sowie wissenschaftliches Fehlverhalten (z. B. Plagiate) trage.

Weiterhin erkläre ich:

- dass ich generative KI-Tools ausschließlich als Hilfsmittel eingesetzt habe und mein eigener gestalterischer Einfluss in der vorliegenden Arbeit überwiegt,
- dass ich offengelegt habe, welche generativen KI-Tools ich zu welchem Zweck und mit welcher Vorgehensweise verwendet habe.

#v(1em)

#text("Mannheim, " + date.display("[day].[month].[year]"))


#align(left, image("../assets/unterschrift.png", height: 1cm))


#for author in authors [
  #align(left, text(author))
]

#pagebreak(weak: true)

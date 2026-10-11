#import "packages.typ":*

#set page(
	margin : (top: 2.5cm, bottom: 2.0cm, left: 4.0cm, right: 2.0cm)
)

#set text(
	size: 11pt,
	lang: "de",
	font: "Nimbus Sans"
)
//https://github.com/typst/typst/issues/4224
//https://forum.typst.app/t/getting-office-365-word-line-spacing-in-typst/3422/7
// this might have to change in the future but for now it should work
#set par(leading: 0.75em, spacing: 0.75em, justify: true)
/*
as suggested by
https://forum.typst.app/t/how-can-i-switch-from-roman-to-arabic-page-numbers-without-breaking-the-total-page-count/4130
*/
#let roman-numbering(..n) = context {
  numbering("I/I", n.at(0), counter(page).at(<last-roman-page>).at(0))

}


// auschließen von allen Headern
#import("Inhalt/Information.typ"):*

// title page
#if (Bachlorthesis) [
#set page(
	margin: (top: 1.31cm, bottom:0.49cm, left:2.29cm, right: 2.29cm)
)
#h(4cm)
//TODO Bachlor und Master arbeit blatt bereitstellen
#align(center)[

]




] else [
#set page(
	margin: (top: 1.31cm, bottom:0.49cm, left:2.29cm, right: 2.29cm)
)
#v(4cm)
#align(left)[
#Hochschulnahme\
#Studiengang\
Betreut durch #Pruefer\


]
#v(4cm)

#align(center)[
#Arbeitsart\
im Fach #Modul im #Semester\
#v(2cm)

*#titel*
]
#v(4cm)
#align(left)[
#author\
#Addresse\
Matr.-Nr.:#MatrNummer\
#Email\
Abgabedatum : #datetime.today().display()
]

]

#pagebreak()

#if (Sperrvermerk) [
#heading(outlined: false)[Sperrvermerk]

 Die in dieser schriftlichen Arbeit enthaltenen Informationen sind vertraulichund ausschließlich
 für die entsprechenden Prüfer und Mitarbeiter der  #Hochschulnahme bestimmt.
Jeglicher Zugriff durch andere Personen, Veröffentlichung, Vervielfältigung,
Verteilung oder sonstige in diesem Zusammenhang stehende Handlung sind nur mit ausdrücklicher
Genehmigung der Verf. und #Firma zulässig. Darüber hinaus besitzt der
Verf. die urheberrecht\-lichen Ansprüche und #Firma die Nutzungsrechte
an bzw. aus dieser Arbeit.
#pagebreak()

]


// Inhaltsverzeichniss
#outline()
#pagebreak()

//abkürzungen
#include "Inhalt/abkuerzung.typ"
#abbr.list(title: "Abkürzung")

#pagebreak()

// end of Roman page numbering
#metadata("last-roman-page") <last-roman-page>
#counter(page).update(1)
#set page(numbering: "1")


#set page(
	margin : (top: 2.5cm, bottom: 2.0cm, left: 4.0cm, right: 2.0cm)
)



// user supplied text
#set heading(numbering: "1.") // so one can use labels and refere to them without having to add this themselfes
#include "Inhalt/Introduction.typ"

#include "Inhalt/Main_part.typ"

#include "Inhalt/Ending.typ"




#pagebreak()
#bibliography(
	style:  "apa",
"quellen.bib")



#pagebreak()
#heading(outlined: false)[Ehrenwörtliche Erklärung ]

Hiermit versichere ich, dass die vorliegende Arbeit von mir selbstständig und ohne unerlaubte Hilfe
angefertigt worden ist, insbesondere, dass alle Stellen, die wörtlich oder sinngemäß aus
Veröffentlichungen entnommen sind, durch Zitate als solche kenntlich gemacht wurden.
Diese Versicherung bezieht sich auch auf die in der Arbeit verwendete bildliche Darstellungen,
Tabellen, Zeichnungen, Skizzen, graphischen Darstellungen und dergleichen sowie auch für die
Verwendung von text- oder codegenerierenden KI-Werkzeugen als Quelle.
#v(1pt)\
Die Arbeit hat in gleicher oder ähnlicher Form noch keiner Prüfungsbehörde vorgelegen und ist nicht
veröffentlicht. Sie wurde nicht, auch nicht auszugsweise, für eine andere Prüfungs- oder
Studienleistung verwendet.
#v(1pt)\
Ich bin damit einverstanden, dass die Arbeit einer elektronischen Plagiatsprüfung unterzogen werden
kann. Die Regelungen der Prüfungsordnung zur Täuschung habe ich zur Kenntnis genommen.

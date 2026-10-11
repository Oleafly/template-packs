#import "Daten.typ": *
#import "Templates/1_Titelblatt.typ": *
#import "Templates/2_Inhaltsverzeichnis.typ": *
#import "Templates/3_Abbildungsverzeichnis.typ": *
#import "Templates/5_Glossar.typ": *
#import "Templates/4_Tabellenverzeichnis.typ": *
#import "Templates/6_Anhangsverzeichnis.typ": *
#import "Templates/7_Literaturverzeichnis.typ": *
#import "Templates/8_Erklärung.typ": *
#show: make-glossary

#set document(title: Titel, author: Author)
//Seitenlayout
#set page(
  paper: "a4", 
  margin: (left: 3cm, right: 2cm, top: 2.5cm, bottom: 2.5cm),
)
//Text und Paragrapheneinstellungen
#set text(lang: "de", font: Font, size: 12pt)

#include "Templates/5_Glossar.typ"

#titelblatt()

#set par(leading: 14pt, justify: true, spacing: 20pt)
//Überschrifteinstellungen und Regel, dass alle H1 Überschriften auf eine neue Seite kommen
#show heading.where(level:1): it => [
  #pagebreak()
  #set text(font: Font, size: 16pt, weight: "bold", kerning: false)
  #set block(below: 1em + 12pt)
  #it
]
#show heading.where(level:2): it => [
  #set text(font: Font, size: 14pt, weight: "bold", kerning: false)
  #set block(above: 24pt, below: 1em + 10pt)
  #it
]
#show heading.where(level:3): it => [
  #set text(font: Font, size: 12pt, weight: "bold")
  #set block(above: 22pt, below: 1em + 6pt)
  #it
]
#show heading.where(level:4): it => [
  #set text(font: Font, size: 12pt, weight: "bold")
  #set block(above: 20pt, below: 1em + 2pt)
  #set heading(bookmarked: false, numbering: none, outlined: false)
  #it
]

//Nummerierung Römisch
#set page(numbering: " I", number-align: end)
#counter(page).update(1)

#heading("Abstract", numbering: none, outlined: false)
#include "/abstract.typ"

#inhaltsverzeichnis()


#heading("Abbildungsverzeichnis", numbering: none)
#abbildungsverzeichnis() <abb>

//heading("Tabellenverzeichnis", numbering: none) // (optional)
//#tabellenverzeichnis() <tab>

//Merkpunkt um die Nummerierung dann nach dem Schriftteil fortzusetzen
#metadata(none)<merkpunkt>


    ///// Schriftteil Anfang /////

    
//Seitennummerierung
#set page(numbering: " 1")
#counter(page).update(1)
#set heading(numbering: "1.1")

//Abstandregel für Bilder
#show figure: it => [
  #set block(above: 1em+6pt, below: 1em+6pt)
  #it
]


//Schriftteil
#include "/Schriftteil.typ"

    
    ///// Schriftteil Ende /////

    
// Römisch weiter Nummerieren
//#set page(numbering: " I")
//#context counter(page).update(counter(page).at(locate(<merkpunkt>))) // seitenzahl vom Merkpunkt abfragen
//#counter(page).step() //++1

//#heading("Anhangsverzeichnis", numbering: none)
//#anhangsverzeichnis()

#pagebreak()
#include "Anhang.typ"

#heading("Glossar", numbering: none)
#print-glossary(
  entry-list,
  disable-back-references: true,
  show-all: true,
)

#heading("Literaturverzeichnis", numbering: none)
#literatur()

#selbstständigkeitserklärung()

#pagebreak()

#freigabeerklärung()

#pagebreak()

#abgabeerklärung()
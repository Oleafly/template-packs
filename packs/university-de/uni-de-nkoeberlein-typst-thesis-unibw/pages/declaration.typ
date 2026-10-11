// =============================================================
// declaration.typ – Eidesstattliche Erklärung
// =============================================================

#import "../metadata.typ": myfaculty, myname, myplace, mytitle, myuniversity, timeend
#import "../lib/colors.typ": *

// Seite ohne Kopfzeile
#set page(header: none)

#heading(level: 1, numbering: none)[Eidesstattliche Erklärung]
<eidesstattliche-erklaerung>

Hiermit versichere ich eidesstattlich, dass die der #myfaculty der #myuniversity vorliegende wissenschaftliche Arbeit mit dem Thema:

#v(6pt)
#align(center)[
  #emph[#mytitle]
]
#v(6pt)

vollkommen selbstständig angefertigt wurde und ich die mit ihr unmittelbar verbundenen Tätigkeiten selbst erbracht habe.

Ich erkläre weiter, dass ich keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe, insbesondere keine anderen als die angegebenen Informationen. Alle aus gedruckten, ungedruckten oder dem Internet im Wortlaut oder im wesentlichen Inhalt übernommenen Formulierungen und Konzepte sind gemäß den Regeln für wissenschaftliche Arbeiten zitiert und durch genaue Quellenangaben gekennzeichnet.

Die wissenschaftliche Arbeit ist noch nicht anderweitig für Prüfungszwecke und keiner anderen Prüfungsbehörde vorgelegt worden. Sie wurde bisher auch nicht veröffentlicht.

Der Speicherung meiner Arbeit zum Zweck der Plagiatsprüfung stimme ich zu. Ich versichere, dass die elektronische mit der gedruckten Version inhaltlich übereinstimmt.

Mir ist bekannt, dass ich verpflichtet bin, die Zustimmung der Hochschule einzuholen, soweit die Verwertung der Arbeit durch mich selbst unter Nennung der Hochschule erfolgen soll.

#v(2cm)

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  [
    #myplace, den #timeend.display("[day].[month].[year]")
  ],
  [
    #v(1.2cm)
    #line(length: 70%, stroke: 0.5pt + rgb(150, 150, 150))
    #text(fill: rgb(150, 150, 150), style: "italic", size: 10pt)[(Unterschrift)]
  ],
)

// Wird automatisch ins Inhaltsverzeichnis eingefuegt.
// Jedes Kapitel sollte in einer eigenen Datei liegen; der Import leitet eine
// neue Seite ein.
//
// Dieses Beispielkapitel zeigt die drei wichtigsten Bausteine einer
// wissenschaftlichen Arbeit und kann komplett ersetzt werden:
//   1. Abkuerzungen (#ac / #acs / #acl / #acf)
//   2. Quellenangaben (@schluessel)
//   3. Abbildungen und Tabellen mit Quellenangabe (#source)

// Abkuerzungsbefehle aus dem Abkuerzungsverzeichnis importieren
#import "../framework/abbreviations.typ": ac, acs, acl, acf
// Verweis auf einen Eintrag im Stichwortverzeichnis
#import "../framework/index.typ": sw
// Quellenangabe-Hilfsbefehl unter Abbildungen/Tabellen
#import "../../template.typ": source

#let chapter-1 = {
  [= Beispielkapitel]

  [
    Dieses Kapitel demonstriert die Funktionen, die in einer wissenschaftlichen
    Arbeit am häufigsten gebraucht werden: das Einführen von Abkürzungen, das
    Zitieren von Quellen sowie das Einbinden von Abbildungen und Tabellen.
  ]

  [== Abkürzungen]

  [
    Abkürzungen werden bei der erstmaligen Verwendung automatisch ausgeschrieben
    und in Klammern eingeführt -- so verlangt es die HFU-Richtlinie (Kapitel
    2.8). Dafür sorgt der Befehl #raw("#ac(\"KI\")"): Die #ac("KI") ist heute
    fester Bestandteil vieler Anwendungen. Bei jeder weiteren Nennung erscheint
    nur noch die Kurzform, etwa wenn ein #acs("KI")-System trainiert wird.
  ]

  [
    Die Definitionen der Abkürzungen stehen in
    #raw("content/framework/abbreviations.typ"). Nur tatsächlich im Text
    verwendete Abkürzungen landen automatisch im Abkürzungsverzeichnis. Neben
    #raw("#ac(...)") gibt es:
  ]

  [
    - #raw("#acs(\"ML\")") -- nur die Kurzform: #acs("ML")
    - #raw("#acl(\"ML\")") -- nur die Langform: #acl("ML")
    - #raw("#acf(\"ML\")") -- immer die Vollform: #acf("ML")
  ]

  [
    Auch eine #ac("API") oder die #ac("HFU") lassen sich auf diese Weise
    einführen und tauchen danach nur noch als #acs("API") bzw. #acs("HFU") auf.
  ]

  [== Quellen zitieren]

  [
    Quellen werden in #raw("bibtex.bib") gepflegt und im Text mit
    #raw("@schluessel") zitiert; es erscheint automatisch eine nummerierte
    Referenz im #acl("IEEE")-Stil. Ein sinngemäßes (indirektes) Zitat sieht so
    aus: Moderne Lehrbücher führen umfassend in die Grundlagen der #acs("KI")
    ein @russell2021. Mehrere Quellen lassen sich ebenso angeben
    @russell2021 @lecun2015.
  ]

  [
    Eine konkrete Seitenangabe wird als Zusatz übergeben
    (#raw("@russell2021[S. 42]")): Demnach gilt das Lernen aus Daten als zentrale
    Fähigkeit intelligenter Systeme @russell2021[S. 42]. Nur zitierte Quellen
    erscheinen am Ende im Literaturverzeichnis.
  ]

  [== Abbildungen und Tabellen]

  [
    Abbildungen werden mit #raw("figure(image(...))") eingebunden und automatisch
    nummeriert; die Beschriftung steht unterhalb (Kapitel 2.6). Wird eine
    Abbildung aus einer fremden Quelle übernommen, ist die Quelle direkt darunter
    mit #raw("#source[...]") anzugeben -- diese Zeile erscheint bewusst nicht im
    Abbildungsverzeichnis. @abb-hfu zeigt das offizielle Logo der #acs("HFU").
  ]

  [
    // <abb-hfu> haengt direkt an der Abbildung -> Referenzierung mit @abb-hfu
    #figure(
      image("../pictures/hfu.jpg", width: 60%),
      caption: [Logo der Hochschule Furtwangen],
    ) <abb-hfu>

    // Quellenangabe direkt unter der Beschriftung; die Quelle selbst steht im
    // Literaturverzeichnis, diese Zeile nicht im Abbildungsverzeichnis.
    #source[@hfu_logo]
  ]

  [
    Tabellen werden ebenfalls als #raw("figure") gesetzt, damit sie im
    Tabellenverzeichnis erscheinen (Kapitel 2.7). @tab-stile fasst die an der
    #acs("HFU") empfohlenen Zitierstile zusammen.
  ]

  [
    #figure(
      table(
        columns: (auto, 1fr),
        align: (left, left),
        table.header([*Zitierstil*], [*Herausgeber*]),
        [#acs("IEEE")], [#acl("IEEE")],
        [APA], [American Psychological Association],
      ),
      caption: [Empfohlene Zitierstile],
    ) <tab-stile>

    #source[Eigene Darstellung]
  ]

  [== Stichwörter]

  [
    Zentrale Begriffe können auf ihren Eintrag im Stichwortverzeichnis
    verweisen. Der Befehl #raw("#sw(\"Stichwort\")") erzeugt einen klickbaren
    Verweis -- etwa auf #sw("Stichwort") oder #sw("Weiteres Stichwort") --, der
    zum jeweiligen Eintrag im Stichwortverzeichnis springt.
  ]
}

#import "../../Daten.typ": *

// ---------------------------------------------------------------------------
// Eigenständigkeitserklärung und Erklärung zur Nutzung von KI-Werkzeugen
//
// Beide Erklaerungen stehen bewusst zusammen auf einer Seite: Der Wortlaut
// zur Nutzung von KI-Werkzeugen bildet den Kern, die zusaetzlichen Aussagen
// der klassischen Eidesstattlichen Erklaerung (keine andere
// Pruefungsbehoerde, Hinweis auf die Rechtsfolgen) sind darin aufgenommen.
//
// TODO: Wortlaut und Umfang mit der betreuenden Person und der aktuell
// gueltigen Pruefungsordnung abgleichen. Einige Fakultaeten geben ein eigenes
// Formular vor, das dann anstelle dieser Seite verwendet wird.
//
// Die gesamte Seite laesst sich in main.typ ueber die zugehoerige
// #include-Zeile ein- und ausblenden.
// ---------------------------------------------------------------------------

// --- Schalter -------------------------------------------------------------
// true  = die Tabelle der eingesetzten Werkzeuge wird gezeigt
// false = die Tabelle entfaellt ersatzlos
// Manche Betreuende verlangen die Tabelle, andere nicht.
#let zeige-werkzeugtabelle = true

// --- Hilfsfunktionen ------------------------------------------------------
// Ankreuzfeld fuer die Liste weiter unten. Der Schalter an: steuert, ob das
// Kaestchen bereits im PDF angekreuzt wird:
//   #ankreuzfeld(an: true)[...]   Kaestchen mit Kreuz
//   #ankreuzfeld(an: false)[...]  leeres Kaestchen, per Hand anzukreuzen
#let kasten(an: false) = box(
  width: 3mm,
  height: 3mm,
  baseline: 0.3mm,
  stroke: 0.6pt,
  inset: 0pt,
)[
  #if an [#align(center + horizon, text(size: 10pt, weight: "bold")[#sym.times])]
]

#let ankreuzfeld(inhalt, an: false) = [
  #kasten(an: an) #h(2mm) #inhalt
]

// Ausfuellbare Linie fuer handschriftliche Eintraege
#let linie(breite) = box(
  width: breite,
  baseline: 0pt,
  stroke: (bottom: 0.5pt),
  outset: (bottom: 3pt),
)[]

// --- Erklärung ------------------------------------------------------------
#text(size: 16pt, weight: "bold")[
  Eigenständigkeitserklärung
]

#v(0.6em)

Ich versichere, dass ich die vorliegende Arbeit selbstständig, ohne Hilfe Dritter und ohne Benutzung anderer als der angegebenen Quellen und Hilfsmittel verfasst habe. Alle Stellen, die wörtlich oder sinngemäß aus fremden Quellen übernommen wurden, sind als solche einzeln kenntlich gemacht. Sofern ich KI-basierte Werkzeuge genutzt habe, wurde deren Umfang vorab mit meiner Betreuerin oder meinem Betreuer abgestimmt und ist nachstehend vollständig angegeben. Die Verantwortung für Auswahl, Prüfung und inhaltliche Korrektheit aller übernommenen Ergebnisse trage ich vollständig selbst.

Diese Arbeit ist bislang keiner anderen Prüfungsbehörde vorgelegt und auch nicht veröffentlicht worden. Ich bin mir bewusst, dass eine falsche Erklärung rechtliche Folgen haben wird.

#v(0.6em)

Ich habe KI-Werkzeuge für folgende Zwecke eingesetzt (Zutreffendes ankreuzen):

#v(0.4em)

// TODO: Zutreffende Felder auf an: true setzen. Wer die Erklaerung lieber
// handschriftlich ausfuellt, laesst ueberall an: false stehen.
#block(inset: (left: 2mm))[
  #set par(justify: false, leading: 0.65em)
  #ankreuzfeld(an: true)[Keine Nutzung von KI-Werkzeugen]

  #ankreuzfeld(an: false)[Rechtschreibung, Grammatik und sprachliche Überarbeitung]

  #ankreuzfeld(an: false)[Literaturrecherche und Recherche-Unterstützung]

  #ankreuzfeld(an: false)[Ideenfindung, Gliederung, Strukturierung]

  #ankreuzfeld(an: false)[Unterstützung bei der Softwareentwicklung (Code-Generierung, Debugging)]

  #ankreuzfeld(an: false)[Erstellung von Abbildungen, Diagrammen oder Datenvisualisierungen]

  #ankreuzfeld(an: false)[Generierung von Textpassagen]

  #ankreuzfeld(an: false)[Sonstiges: #linie(8cm)]
]

#v(0.8em)

#if zeige-werkzeugtabelle [
  Verwendete Werkzeuge:

  #v(0.4em)

  // TODO: Beispielzeile durch die tatsaechlich eingesetzten Werkzeuge
  // ersetzen und nicht benoetigte Leerzeilen entfernen.
  //
  // Hinweis: Die Seite ist bewusst knapp gesetzt, damit beide Erklaerungen
  // gemeinsam auf eine Seite passen. Wer mehr Tabellenzeilen braucht, loescht
  // dafuer die leeren Zeilen oder kuerzt die Abstaende (#v(...)) weiter oben.
  #table(
    columns: (auto, auto, 1fr,),
    align: (left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),

    table.header(
      [*Werkzeug*], [*Version/Stand*], [*Zweck*]
    ),

    [z. B. ChatGPT], [GPT-5, 09/2026], [Debugging von Python-Code],
    [], [], [],
    [], [], [],
  )
]

#v(1.2em)

// Ort und Datum stammen aus Daten.typ und werden dort zentral gepflegt.
#ort, #datum

#v(1.2cm)
#table(
  columns: (9cm, 2.5cm, 1fr),
  inset: 1pt,
  gutter: 0.3cm,
  stroke: none,
  [#line(length: 6cm)], [], [],
  [#vorname #name], [], [],
)

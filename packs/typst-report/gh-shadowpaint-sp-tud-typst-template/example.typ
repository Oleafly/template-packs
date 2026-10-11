#import "template.typ": *

#show: tud-thesis.with(
  lang: "de",
  university: "Technische Universität Dresden",
  faculty: "Fakultät Informatik",
  institute: "Institut für Software- und Multimediatechnik",
  chair: "Professur für Beispielsysteme",
  thesis-type: "Bachelorarbeit",
  title: "Ein vielseitiges Typst-Template für \nAbschlussarbeiten",
  subtitle: "Optionaler Untertitel",
  logo: "assets/tud-logo-blue.svg",
  date: "Dresden, 27. April 2026",
  authors: (
    (
      name: "Max Mustermann",
      student-id: "123456789",
      email: "max@example.com",
    ),
    // More authors are supported:
    // (name: "Zweite Person", student-id: "7654321", email: "person@example.com"),
  ),
  supervisors: (
    (name: "Dr. Max Mustermann", affiliation: "TU Dresden"),
  ),
  examiners: (
    (name: "Prof. Dr. Erika Musterfrau", affiliation: "TU Dresden"),
  ),
  abstract: [
    Diese Arbeit untersucht beispielhaft, wie ein Abschlussarbeits-Template in Typst
    für die Informatik an der #acr("TU") Dresden strukturiert werden kann.
  ],
  abstract-en: [
    This thesis illustrates how a Typst thesis template for computer science at
    #acr("TU") Dresden can be structured.
  ],
  declaration: [
    Ich erkläre, dass ich die vorliegende Arbeit selbstständig und nur unter
    Verwendung der angegebenen Quellen und Hilfsmittel angefertigt habe.
  ],
  acronyms: (
    "TU": "Technische Universität",
  ),
  bibliography-file: "example-ref.bib",
  appendix: [
    = Zusätzliche Materialien

    Hier können ergänzende Tabellen, Abbildungen oder längere Beweise stehen.
  ],
)

= Einleitung

Dies ist ein Beispiel für den Haupttext der Arbeit. Das Template verwendet
standardmäßig eine Textspalte, kann aber über `columns: 2` auch zweispaltig verwendet werden.

Typst unterstützt Literaturverweise direkt, zum Beispiel @vaswani2017attention.


== Motivation

Die Struktur ist an wissenschaftliche Paper-Templates angelehnt: Titelseite,
Zusammenfassungen, Schlagwörter, Verzeichnisse, Hauptteil, Anhang und Literatur.

= Grundlagen

#figure(
  rect(width: 80%, height: 35mm),
  caption: [Beispielabbildung.],
)

#figure(
  table(
    columns: 2,
    table.hline(),
    table.header([Eigenschaft], [Wert]),
    table.hline(),
    [Sprache], [Deutsch und Englisch],
    [Spalten], [Konfigurierbar],
    table.hline(),
  ),
  caption: [Beispieltabelle.],
)

= Fazit

Das Template ist bewusst minimal gehalten und kann für konkrete Vorgaben der
Fakultät oder Professur erweitert werden.

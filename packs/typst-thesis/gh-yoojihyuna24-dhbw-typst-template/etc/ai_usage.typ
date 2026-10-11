// etc/ai_usage.typ
// ═══════════════════════════════════════════════════════════════════════════
// Hilfsmittelverzeichnis (H 3.13)
//
// "… bei der Erstellung eingesetzte KI-Tools müssen in einer Liste verwendeter
// Hilfsmittel im Anhang der Arbeit angegeben werden." (H 3.13)
// Grundlage ist die Erklärung nach H 3.3, in der die Nutzung ausschließlich der
// angegebenen Quellen und Hilfsmittel versichert wird. Details regelt das
// Dokument "Hinweise zum Einsatz von KI-basierten Werkzeugen bei der
// Anfertigung von wissenschaftlichen Arbeiten".
//
// Vorgehen: Nur die Blöcke ausfüllen, die tatsächlich zutreffen — nicht
// benötigte Blöcke löschen. Pro Nutzung eine Zeile mit vier Einträgen:
//
//   #hilfsmittel-block("Textgenerierung",
//     [Name des Werkzeugs und Version],
//     [Wofür wurde es eingesetzt?],
//     [Beispielhafter Prompt bzw. Art der Eingabe],
//     [Wie wurde das Ergebnis geprüft und verantwortet?],
//   )
//
// Keine KI eingesetzt? Dann alle Blöcke löschen und den einleitenden Satz
// entsprechend anpassen ("Bei der Erstellung dieser Arbeit wurden keine
// KI-basierten Werkzeuge eingesetzt.").
// ═══════════════════════════════════════════════════════════════════════════

#import "../lib/components.typ": hilfsmittel-block

Die folgende Übersicht dokumentiert die bei der Erstellung dieser Arbeit
eingesetzten KI-basierten Werkzeuge, den jeweiligen Zweck, den Umfang der
Nutzung sowie die kritische Reflexion der Ergebnisse.

#hilfsmittel-block("Ideenfindung",
  [], [], [], [],
)

#hilfsmittel-block("Literaturrecherche",
  [], [], [], [],
)

#hilfsmittel-block("Textgenerierung",
  [], [], [], [],
)

#hilfsmittel-block("Strukturierung",
  [], [], [], [],
)

#hilfsmittel-block("Korrektur und Übersetzung",
  [], [], [], [],
)

#hilfsmittel-block("Verständnis von Fachinhalten",
  [], [], [], [],
)

// Nur bei empirischen Arbeiten relevant — sonst löschen:
#hilfsmittel-block("Methodik",
  [], [], [], [],
)

#hilfsmittel-block("Datenerhebung und -auswertung",
  [], [], [], [],
)

Weitere, nicht KI-basierte Hilfsmittel: Literaturverwaltung (z. B. Zotero oder
Citavi) zur Verwaltung der Quellen und Erzeugung der Kurzbelege sowie das
Satzsystem Typst für die Formatierung. Beide haben keinen Einfluss auf die
inhaltlichen Aussagen der Arbeit.

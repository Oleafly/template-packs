// =====================================================================
// Beigabenverzeichnis
//
// Steht laut DHBW-Reihenfolge NACH dem Literaturverzeichnis. Laut den
// Hinweisen optional — die Betreuung erwartet es aber häufig ausdrücklich,
// also vorher klären.
//
// Das Verzeichnis spiegelt die Ordnerstruktur der Beigaben-ZIP. Die
// Vorgabedokumente und die Betreuung nennen teils unterschiedliche Ordner;
// vor dem Packen abstimmen, welche Struktur gilt. Die DHBW-Hinweise nennen:
//
//   Quelltexte                 (bei Bedarf)
//   Projektdokumentationen     (bei Bedarf)
//   Elektronische Quellen      PFLICHT
//   Sonstiges                  (bei Bedarf)
//
// "Elektronische Quellen" ist der einzige Ordner ohne "(bei Bedarf)", also
// Pflicht — Inhalt laut Vorgabe: "Druckversionen von verwendeten
// Online-Quellen oder nicht öffentlich zugänglichen Dokumenten im
// PDF-Format". Für Quelltexte gilt: "Die Quelltexte müssen unabhängig von
// Entwicklungswerkzeugen lesbar sein (ASCII-, Word- oder PDF-Format)."
//
// Für die ZIP-Datei selbst gibt es KEINE Namensvorgabe — nur für das PDF
// ("KURS_Nachname_Vorname_Art des Dokuments.pdf").
//
// Kommt die Arbeit ohne Beigaben aus, wird der `include` dieser Datei in
// main.typ gelöscht.
// =====================================================================

#import "../vorlage/dhbw.typ": LEADING_EINZEILIG, verzeichnis-titel, ZEILENABSTAND

#verzeichnis-titel[Beigabenverzeichnis]

// Machart wie das Abkürzungs- und das Hilfsmittelverzeichnis: bewusst KEIN
// `#tab(...)`. Das Beigabenverzeichnis ist ein Verzeichnis und keine
// nummerierte Tabelle des Textteils — es hat weder eine Nummer noch einen
// Eintrag im Tabellenverzeichnis und wird im Fließtext nicht referenziert.
// Eine nummerierte Tabelle hier verstieße gegen die Vorgabe, dass auf jede
// Tabelle im Text mit ihrer Nummer Bezug genommen werden muss.
//
// Linien und `inset.x` kommen aus `set table(...)` in dhbw.typ; die
// senkrechte Polsterung ist aus ZEILENABSTAND gerechnet, damit die
// Zeilenhöhe zum Fließtext passt.
//
// Beispielinhalt — nach dem Packen der ZIP durch den tatsächlichen Inhalt
// ersetzen.
#[
  #set par(leading: LEADING_EINZEILIG, justify: false)

  #table(
    columns: (5cm, 1fr),
    align: left + top,
    inset: (x: 4pt, y: ZEILENABSTAND / 2),
    table.header(
      text(weight: "bold")[Ordner],
      text(weight: "bold")[Inhalt],
    ),
    [Arbeit], [WWI00X0_Nachname_Vorname_Art.pdf],
    [Elektronische Quellen], [PDF-Fassungen aller online bezogenen Quellen, benannt nach DOI],
    [Quelltexte], [Auswertungsskripte, lesbar ohne Entwicklungswerkzeug],
    [Sonstiges], [Quelldateien der Abbildungen in Originalauflösung],
  )
]

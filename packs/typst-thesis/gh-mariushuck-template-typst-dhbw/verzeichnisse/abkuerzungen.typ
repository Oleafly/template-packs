// =====================================================================
// Abkürzungsverzeichnis
//
// Laut DHBW optional, Abkürzungen im Text aber sparsam verwenden.
// Aufgenommen wird nur, was im Text tatsächlich abgekürzt vorkommt und
// nicht Duden-Allgemeingut ist ("z. B.", "usw." gehören nicht hierher).
//
// Zwei Regeln, die vor der Abgabe abzugleichen sind:
//   - Jeder Eintrag muss im Text als Abkürzung auftauchen. Abkürzungen,
//     die nur auf dem Titelblatt oder im Vorspann stehen, gehören nicht
//     ins Verzeichnis.
//   - Umgekehrt muss jede im Text verwendete Abkürzung hier stehen und
//     bei ihrer ersten Verwendung im Text eingeführt werden.
//
// Kommt die Arbeit ohne Abkürzungen aus, wird der `include` dieser Datei
// in main.typ gelöscht.
// =====================================================================

#import "../vorlage/dhbw.typ": LEADING_EINZEILIG, verzeichnis-titel, ZEILENABSTAND

// Alphabetisch sortiert. Beispieleinträge — durch die eigenen ersetzen.
#let abkuerzungen = (
  ("DHBW", [Duale Hochschule Baden-Württemberg]),
  ("ERP", [Enterprise Resource Planning]),
  ("KI", [Künstliche Intelligenz]),
  ("MAE", [Mean Absolute Error (mittlerer absoluter Fehler)]),
)

#verzeichnis-titel[Abkürzungsverzeichnis]

// Schlichte Tabelle: nur waagerechte Linien oben, unter dem Kopf und unten,
// keine senkrechten Linien, keine Flächenfarbe. `columns` legt die
// Spaltenbreite fest — eine Tabulatorlösung verrutscht beim Bearbeiten.
//
// Das ist bewusst KEIN `#tab(...)`: das Abkürzungsverzeichnis ist ein
// Verzeichnis und keine nummerierte Tabelle des Textteils — es hat weder
// eine Nummer noch einen Eintrag im Tabellenverzeichnis.
//
// Zeilenhöhe: Typst berechnet die Höhe einer einzeiligen Tabellenzelle als
// Versalhöhe + 2 * inset.y. Für 1,5-zeiligen Abstand (20,70 pt bei Arial
// 12 pt) muss inset.y also die Hälfte des leading-Werts sein — dann stimmt
// die Zeilenhöhe der Tabelle genau mit dem Fließtext überein.
//
// Keine Silbentrennung, mehrzeilige Beschreibungen 1-zeilig — wie in allen
// anderen Verzeichnissen.
#set text(hyphenate: false)
#set par(leading: LEADING_EINZEILIG)

#table(
  columns: (3.2cm, 1fr),
  align: left + top,
  inset: (x: 0pt, y: ZEILENABSTAND / 2),
  stroke: none,
  table.hline(y: 0, stroke: 0.5pt),
  table.header(
    text(weight: "bold")[Abkürzung],
    text(weight: "bold")[Beschreibung],
  ),
  table.hline(y: 1, stroke: 0.5pt),
  ..abkuerzungen.map(((kurz, lang)) => (kurz, lang)).flatten(),
  table.hline(stroke: 0.5pt),
)

// Kapitel 3 — Hauptteil (Methodik, Durchführung, Ergebnisse).
// Überschriften nie manuell nummerieren, das macht Typst über `= ` / `== `.

// Bausteine für Abbildungen, Tabellen und Formeln (siehe README):
#import "../vorlage/dhbw.typ": abb, formel, tab

= Hauptteil <kap-hauptteil>

== Methodisches Vorgehen

Welches Vorgehen gewählt wurde und warum es zur Forschungsfrage passt. Die Begründung gehört in den
Text, nicht in eine Fußnote — Fußnoten sind in dieser Vorlage nicht vorgesehen.

#lorem(70)

== Durchführung und Ergebnisse

Was gemacht wurde und was dabei herauskam. Zahlen, auf die sich die Arbeit später stützt, gehören
mit ihrer Herkunft in den Text oder in eine Tabelle mit Quellenangabe.

#lorem(60)

// =====================================================================
// BEISPIELABSCHNITT — beim Schreiben der eigenen Arbeit löschen.
//
// Er führt jeden Baustein einmal vor und sorgt dafür, dass die Vorlage
// beim ersten Kompilieren ein vollständiges PDF ergibt: mit Abbildungs-
// und Tabellenverzeichnis, nummerierter Gleichung, Zitaten und
// Querverweisen.
// =====================================================================

== Bausteine dieser Vorlage

Datumsangaben brauchen ein geschütztes Leerzeichen: vom 30.~Januar 2023 bis zum 6.~Januar 2025.
Ohne das liest Typst `30. Januar` am Zeilenanfang als Aufzählung mit der Nummer 30, rückt die Zeile
ein und zerlegt den Absatz — ohne Warnung.

Eine Abbildung entsteht mit `#abb(...)`. Das erste Argument ist entweder ein Pfad zu einer
Bilddatei oder beliebiger Inhalt, etwa ein in Typst gezeichnetes Schema. Das Etikett muss als
Argument übergeben werden; hinter dem Aufruf wäre es nicht referenzierbar.

#abb(
  grid(
    columns: (auto, auto, auto, auto, auto),
    align: horizon,
    column-gutter: 8pt,
    rect(inset: 8pt, [Datenquelle]),
    sym.arrow.r,
    rect(inset: 8pt, [Aufbereitung]),
    sym.arrow.r,
    rect(inset: 8pt, [Ergebnis]),
  ),
  [Ablauf der Untersuchung],
  quelle: [eigene Darstellung],
  etikett: <abb-beispiel>,
)

// Dieselbe Abbildung aus einer Bilddatei. Der Pfad wird relativ zu
// vorlage/dhbw.typ aufgelöst, weil der image()-Aufruf dort steht — eine
// Datei in abbildungen/ heißt also immer "../abbildungen/name.png".
//
// #abb(
//   "../abbildungen/ablauf.png",
//   [Ablauf der Untersuchung],
//   quelle: [eigene Darstellung],
//   breite: 12cm,
//   etikett: <abb-ablauf>,
// )

Jede Abbildung und jede Tabelle muss im Text mit ihrer Nummer angesprochen werden. Über das Etikett
kann man das nicht vergessen: @abb-beispiel zeigt den Ablauf, @tab-beispiel die Kennzahlen dazu.
Die Nummer setzt Typst.

#tab(
  table(
    columns: (1fr, auto, auto),
    // Spaltenausrichtung immer angeben: Text linksbündig, Zahlen rechts.
    align: (left, right, right),
    table.header([Maß], [Schätzzeitraum], [Prüfzeitraum]),
    [MAE], [4,21], [5,08],
    [RMSE], [9,77], [11,43],
  ),
  [Fehlermaße im Schätz- und Prüfzeitraum],
  quelle: [eigene Berechnung],
  etikett: <tab-beispiel>,
)

Formeln stehen mittig und werden durchlaufend nummeriert:

#formel($ y_i = beta_0 + beta_1 dot x_i + epsilon_i $)

Zitiert wird im Text, mit Stellenangabe @mustermann2024buch[S. 42], mit Abschnitt statt Seite
@beispiel2023artikel[Abschn. 4.1] oder ohne Stellenangabe @beispielorg2025online. Die Nummern im
Literaturverzeichnis vergibt Typst nach der Reihenfolge des ersten Auftretens; eine Nummernliste
von Hand zu pflegen ist damit hinfällig.

Aufzählungen stehen linksbündig statt im Blocksatz — das erzwingt die Vorlage:

- erster Punkt
- zweiter Punkt
- dritter Punkt

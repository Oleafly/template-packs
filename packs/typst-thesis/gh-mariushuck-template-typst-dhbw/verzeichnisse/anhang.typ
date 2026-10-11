// =====================================================================
// Anhang
//
// Reihenfolge laut DHBW-Hinweisen: Anhang VOR dem Literaturverzeichnis.
// Der Anhang liegt in der arabischen Seitennummerierung und wird mit
// Buchstaben gegliedert (A, A.1, A.2 …) — die Umschaltung steht in
// main.typ.
//
// DREI VORGABEN, die beim Füllen mitzudenken sind:
//
// 1. UMFANG: "Ein Anhang sollte keinesfalls mehr als die Hälfte des
//    Textteils umfassen." Die Grenze wächst mit dem Text — am
//    Inhaltsverzeichnis des aktuellen PDF ablesen, nicht schätzen.
//
// 2. VERWEIS: "Auf alle Abbildungen oder Tabellen muss im Text mit der
//    Abbildungs- oder Tabellennummer Bezug genommen werden." Das gilt auch
//    für Anhangtabellen. Was im Text nicht referenziert wird, gehört nicht
//    in den Anhang.
//
// 3. AUSWAHL: "Hintergrundinformationen, allgemein umfangreiches
//    Quellenmaterial oder komplexe Darstellungen, die für den Text nicht
//    von zentraler Bedeutung sind, werden im Anhang dargestellt."
//    Umgekehrt gehört alles, was im Text diskutiert wird, in den Text.
// =====================================================================

// Bausteine für Abbildungen, Tabellen und Formeln (siehe README);
// ZEILENABSTAND und LEADING_EINZEILIG für das Hilfsmittelverzeichnis unten.
#import "../vorlage/dhbw.typ": abb, formel, LEADING_EINZEILIG, tab, ZEILENABSTAND

= Anhang

// Zwischenblatt: "Der Anhang wird […] hinter einem Zwischenblatt 'Anhang'
// eingefügt." Die Überschrift steht deshalb allein auf der Seite, der
// Inhalt beginnt danach.
#pagebreak()

// Hier die eigenen Anhänge einfügen, jeden mit einer eigenen Überschrift
// (`== Titel`, wird zu A.1, A.2 …). Jede Tabelle mit `#tab(...)` setzen,
// damit sie ins Tabellenverzeichnis kommt und im Text referenzierbar ist;
// dasselbe gilt für Abbildungen mit `#abb(...)`.

== Verzeichnis der verwendeten Hilfsmittel

// =====================================================================
// Hilfsmittelverzeichnis (KI-Werkzeuge)
//
// PFLICHT, nicht optional. Zwei Vorgabedokumente, gleiche Aussage:
//   - "Hinweise zur Anfertigung von Projekt- und Bachelorarbeiten":
//     "in einer Liste verwendeter Hilfsmittel im Anhang der Arbeit"
//   - "Hinweise zum Einsatz von KI-basierten Werkzeugen bei der
//     Anfertigung von wissenschaftlichen Arbeiten": "Aus diesem Grund ist
//     ein Hilfsmittelverzeichnis zu erstellen und im Anhang der Arbeit zu
//     platzieren, in dem die Tools und ihre Einsatzformen anzuführen
//     sind."
//
// Beides ist im KI-Hinweisdokument mit Vorlage und Beispiel abgedruckt.
// Daraus stammen wortgetreu: der Vorspannsatz unten, die vier
// Spaltenköpfe und die zwölf Zeilenbezeichnungen der Spalte
// "Arbeitsschritt".
//
// SPALTE 1 IST AMTLICH UND DARF NICHT VERÄNDERT WERDEN — weder im
// Wortlaut noch in der Reihenfolge, und es darf keine Zeile entfallen.
// Nicht genutzte Arbeitsschritte bleiben stehen und werden wie im
// amtlichen Beispiel in Spalte 2 und 3 mit "----" gefüllt; Spalte 4 bleibt
// dann leer.
//
// ZWEI PFLICHTEN, die NICHT in dieser Tabelle stehen:
//   - Ein KI-Werkzeug zur Literaturanalyse ist zusätzlich "im
//     Rechercheprozess zu dokumentieren und dessen Auswahl zu begründen" —
//     das gehört in den Fließtext (Vorgehensweise oder Methodik).
//   - Eine mit KI übersetzte Zitatpassage verlangt den Zusatz bei der
//     Zitation, Muster "(Meier 2007, S. 208-209; übersetzt durch XYZ)",
//     und die übersetzte Datei in den elektronischen Beigaben.
//
// Die Position dieses Verzeichnisses ist in den Vorgaben zweideutig: der
// eigene Abschnitt sagt "im Anhang der Arbeit", die Reihenfolgeliste
// stellt es hinter das Beigabenverzeichnis. Umgesetzt ist "im Anhang",
// weil der ausgeschriebene Ort zweimal genannt wird. Im Zweifel bei der
// Betreuung nachfragen; der Umbau wäre klein — diesen Abschnitt in eine
// eigene Datei und in main.typ hinter den `include` von beigaben.typ.
// =====================================================================

Bei der Erstellung der Arbeit wurden die folgenden auf Künstlicher Intelligenz (KI)
basierende Systeme in der beschriebenen Weise benutzt:

// "----" muss als String stehen, nicht als Markup: Typst ersetzt "--" im
// Text durch einen Halbgeviert- und "---" durch einen Geviertstrich. Vier
// Bindestriche im Markup ergäben also "—-" statt "----".
#let NICHT_GENUTZT = "----"

// Die zwölf amtlichen Arbeitsschritte in originaler Reihenfolge. Eine
// Zeile ist beispielhaft gefüllt, damit die Machart erkennbar ist —
// Spalte 2 nennt System und Anbieter, Spalte 3 beschreibt die
// Verwendungsweise, Spalte 4 die betroffenen Teile der Arbeit. Werden in
// einem Arbeitsschritt mehrere Systeme eingesetzt, werden sie wie im
// amtlichen Beispiel nummeriert ("1. … 2. …"), wobei die Nummern in
// Spalte 2 und 3 einander entsprechen.
#let hilfsmittel = (
  ([Generierung von Ideen und Konzeption der Arbeit], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Literatursuche], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Literaturanalyse], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Literaturverwaltung und Zitationsmanagement], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Auswahl von Methoden und Modellen], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Datensammlung und -analyse], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Generierung von Programmcodes], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Erstellung von Visualisierungen], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Interpretation und Validierung], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  ([Strukturierung des Texts der Arbeit], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
  (
    // BEISPIELZEILE — durch die eigenen Angaben ersetzen oder auf "----" setzen.
    [Formulierung des Texts der Arbeit],
    [Beispiel-KI (Anbieter)],
    [Erstellung von Textentwürfen und Formulierungsvorschlägen. Die Entwürfe wurden überarbeitet,
     gekürzt und inhaltlich verantwortet.],
    [Abschnitte 2.1, 3.2],
  ),
  ([Sonstiges], [#NICHT_GENUTZT], [#NICHT_GENUTZT], []),
)

// Machart wie im Abkürzungsverzeichnis: bewusst KEIN `#tab(...)`. Das
// Hilfsmittelverzeichnis ist ein Verzeichnis und keine nummerierte Tabelle
// des Textteils — es hat weder eine Nummer noch einen Eintrag im
// Tabellenverzeichnis und wird im Fließtext nicht referenziert.
//
// Linien und `inset` kommen aus `set table(...)` in dhbw.typ (0,5 pt,
// 5 pt); nur die senkrechte Polsterung ist wie im Abkürzungsverzeichnis
// aus ZEILENABSTAND gerechnet, damit die Zeilenhöhe zum Fließtext passt.
// Spaltenbreiten fest, Summe 15,0 cm = Satzspiegelbreite (21,0 - 3,5
// - 2,5 cm). Die Tabelle bricht über Seiten um; `table.header`
// wiederholt den Kopf.
//
// Die Silbentrennung bleibt in Spalte 1, 3 und 4 EINGESCHALTET — anders
// als in den übrigen Verzeichnissen. Die Spalten sind so schmal, dass
// lange Komposita wie "Literaturverwaltung" sonst über den Zellenrand
// hinausragen; auch die amtliche Vorlage trennt sie
// ("Literaturverwal-tung"). Im Kopf und in Spalte 2 ist sie aus, weil dort
// alle Wörter in die Spaltenbreite passen und "Eingesetz-te(s)" nur
// unschön wäre. Die Breiten sind daran gerechnet (Arial 12 pt,
// Spaltenbreite abzüglich 2 × 4 pt Polsterung): Kopf fett
// "Eingesetzte(s)" 2,87 cm < 3,20 - 0,28; "Programmcodes" 3,11 cm
// < 3,50 - 0,28.
//
// Set-Regeln in einem Inhaltsblock, damit sie nur für diese Tabelle
// gelten und nicht für Anhanginhalte, die später darunter entstehen.
#[
  #set par(leading: LEADING_EINZEILIG, justify: false)
  #let kopf(inhalt) = text(weight: "bold", hyphenate: false, inhalt)

  #table(
    columns: (3.5cm, 3.2cm, 1fr, 2.9cm),
    align: left + top,
    inset: (x: 4pt, y: ZEILENABSTAND / 2),
    table.header(
      kopf[Arbeitsschritt],
      kopf[Eingesetzte(s) KI-System(e)],
      kopf[Beschreibung der Verwendungsweise],
      kopf[Betroffene Teile der Arbeit],
    ),
    ..hilfsmittel.map(((schritt, system, beschreibung, teile)) => (
      schritt,
      text(hyphenate: false, system),
      beschreibung,
      teile,
    )).flatten(),
  )
]

// Das Beigabenverzeichnis gehört laut DHBW-Reihenfolge NICHT hierher,
// sondern nach das Literaturverzeichnis. Es steht in beigaben.typ.

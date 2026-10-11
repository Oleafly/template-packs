// chapters/03-structure.typ — Dokumentstruktur

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, code-block, key-concept, side-note
#import "../components/tables.typ": comparison-table, styled-table
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Dokumentstruktur],
  lead: [Ordnung schafft Verständnis — wie die richtige Gliederung
    die kognitive Belastung reduziert und den Lernprozess unterstützt.],
)

== Kognitive Belastung und Struktur

#key-concept(term: "Cognitive Load Theory (CLT)")[
  Nach John Sweller (1988) verfügt das Arbeitsgedächtnis über eine
  begrenzte Kapazität von etwa 7 ± 2 Informationseinheiten. Gut
  strukturierte Materialien reduzieren die #emph[extrinsische] kognitive
  Belastung und schaffen Kapazität für das eigentliche Lernen.
]

Die Struktur eines medizinischen Lehrbuchs dient nicht nur der
Orientierung, sondern ist selbst ein didaktisches Werkzeug. Wenn ein
Studierender die Gliederung#index[Gliederung] eines Kapitels überblicken kann, aktiviert
er vorhandenes Vorwissen und schafft mentale Anknüpfungspunkte für
neues Material — ein Prozess, den die kognitionspsychologische
Forschung als _Advance Organizer_#index[Advance Organizer] bezeichnet.

== Gliederungsebenen

Ein medizinisches Lehrbuch verwendet typischerweise drei bis vier
Gliederungsebenen:

+ *Kapitel* — thematisch abgeschlossene Einheiten (z. B. _Kardiologie_)
+ *Abschnitte* — Unterthemen innerhalb eines Kapitels (z. B. _Herzinsuffizienz_)
+ *Unterabschnitte* — spezifische Aspekte (z. B. _Diagnostik der Herzinsuffizienz_)
+ *Absatzüberschriften* — Detailpunkte (z. B. _BNP-Werte_)

#callout(title: "Best Practice", tone: "info")[
  Verwenden Sie nicht mehr als vier Gliederungsebenen. Tiefere Verschachtelung
  signalisiert, dass der Inhalt in ein eigenes Kapitel ausgelagert werden sollte.
]

#section-break()

== Tabellen in der Medizin

Tabellen#index[Tabellen] sind das bevorzugte Format für strukturierte klinische Daten.
Vitalparameter, Laborwerte, Medikationspläne und Differenzialdiagnosen#index[Differenzialdiagnose]
lassen sich tabellarisch schneller erfassen als im Fließtext.

=== Patientendaten

#styled-table(
  columns: 4,
  table.header(
    text(fill: white, weight: "bold", size: type-scale.small)[Parameter],
    text(fill: white, weight: "bold", size: type-scale.small)[Wert],
    text(fill: white, weight: "bold", size: type-scale.small)[Referenz],
    text(fill: white, weight: "bold", size: type-scale.small)[Bewertung],
  ),
  [Systolischer RR],
  [138 mmHg],
  [< 140],
  [Grenzwertig],
  [Diastolischer RR],
  [88 mmHg],
  [< 90],
  [Grenzwertig],
  [Herzfrequenz],
  [76/min],
  [60–100],
  [Normal],
  [Temperatur],
  [36.8 °C],
  [36.1–37.2],
  [Normal],
  [SpO#sub[2]],
  [97 %],
  [95–100],
  [Normal],
  [Atemfrequenz],
  [16/min],
  [12–20],
  [Normal],
)

=== Lehrmethoden im Vergleich

#comparison-table(
  headers: ([Methode], [Effektivität], [Aufwand], [Eignung]),
  rows: (
    ([Vorlesung], [Mittel], [Niedrig], [Große Gruppen]),
    ([PBL], [Hoch], [Hoch], [Kleine Gruppen]),
    ([Simulation], [Sehr hoch], [Sehr hoch], [Praktische Skills]),
    ([E-Learning], [Variabel], [Mittel], [Selbststudium]),
    ([Peer Teaching], [Hoch], [Niedrig], [Vertiefung]),
  ),
)

#side-note(title: "Hinweis")[
  PBL = Problem-Based Learning. Diese Methode wurde 1969 an der
  McMaster University in Kanada entwickelt und hat sich seitdem
  international in der medizinischen Ausbildung etabliert.
]

== Listen und Aufzählungen

Ungeordnete Listen eignen sich für gleichwertige Punkte ohne implizite
Reihenfolge. Geordnete Listen signalisieren Sequenzen — etwa
diagnostische Algorithmen#index[Algorithmus] oder Behandlungsschritte.

=== Diagnostischer Algorithmus bei Brustschmerz

+ Vitalzeichen erheben und 12-Kanal-EKG anlegen
+ Troponin-Schnelltest und D-Dimere bestimmen
+ Anamnese: Schmerzcharakter, Auslöser, Begleitsymptome
+ Risikostratifizierung nach HEART-Score
+ Bildgebung bei Verdacht (Sonografie, CT-Angiografie)
+ Fachärztliche Konsultation und Therapieeinleitung

#callout(title: "Achtung", tone: "warning")[
  Bei hochgradigem Verdacht auf akutes Koronarsyndrom (ACS) darf die
  Diagnostik die Therapieeinleitung nicht verzögern. Die erste Troponin-
  Bestimmung kann falsch-negativ sein — eine Verlaufskontrolle nach
  3 Stunden ist obligat.
]

== Querverweise und Fußnoten

Medizinische Texte leben von präzisen Verweisen auf Quellen, Leitlinien
und andere Kapitel. Typst unterstützt automatische Nummerierung für
Fußnoten#index[Fußnoten], Abbildungen und Tabellen, sodass bei Ergänzungen keine
manuelle Umnummerierung nötig wird.

#code-block(title: "Querverweise in Typst")[
  ```typ
  Wie in @kapitel-typografie beschrieben, ist die
  Wahl der Schriftart entscheidend.

  Die Laborwerte (siehe @tab:vitalwerte) zeigen...
  ```
]

#section-break()

== Dokumentennavigation

Neben der Gliederung durch Überschriften bietet ein durchdachtes
Lehrbuch weitere Navigationshilfen. Kopfzeilen#index[Kopfzeilen] mit Kapitelangabe,
farbcodierte Abschnittskennzeichnungen und ein detailliertes
Inhaltsverzeichnis#index[Inhaltsverzeichnis] helfen Studierenden, schnell zu relevanten
Abschnitten zu springen.

#key-concept(term: "Advance Organizer")[
  Ein vom Pädagogen David Ausubel (1960) eingeführtes Konzept: Eine
  vorangestellte Übersicht über die kommenden Inhalte aktiviert
  vorhandenes Vorwissen und bildet ein kognitives Gerüst, in das
  neue Informationen eingebettet werden können.
]

Die Struktur dieses Buches selbst demonstriert diese Prinzipien:
Jedes Kapitel beginnt mit einem _Chapter Opener_, der Titel, Nummer
und eine kurze Einleitung prominent präsentiert. Innerhalb der Kapitel
gliedern _Section Breaks_ visuelle Zäsuren zwischen thematischen
Blöcken. Und die _Part Pages_ am Anfang jedes Buchteils schaffen
größere thematische Klammern.

#callout(title: "Praxis-Tipp", tone: "success")[
  Planen Sie die Dokumentstruktur, bevor Sie mit dem Schreiben beginnen.
  Eine nachträgliche Umstrukturierung ist aufwendig und führt oft zu
  inkonsistenten Querverweisen und verwaisten Abschnitten.
]

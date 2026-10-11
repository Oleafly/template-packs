// chapters/00_beispiele.typ
// ═══════════════════════════════════════════════════════════════════════════
// KURZANLEITUNG — dieses Kapitel dient nur zum Nachschlagen.
// Vor der Abgabe löschen: Datei entfernen und die `#include`-Zeile in main.typ.
// ═══════════════════════════════════════════════════════════════════════════

#import "../lib/components.typ": quelle, quelle-links, epigraph

= Typst in fünf Minuten

Überschriften entstehen mit Gleichheitszeichen: `=` ist ein Hauptkapitel, `==`
ein Unterkapitel, `===` die dritte Ebene. Die Nummerierung, der Seitenumbruch
vor jedem Hauptkapitel und alle Abstände kommen automatisch.

Absätze werden durch eine Leerzeile getrennt. Kursiv schreibt man mit
`_Wort_`, also _so_. Auf Fettdruck im Fließtext solltest du verzichten --- die
DHBW-Hinweise sehen zur Hervorhebung keinen Fettdruck vor, und Betreuende lesen
ihn häufig als Kennzeichen KI-generierter Texte.

== Zitieren

Die Hinweise verlangen einen Kurzbeleg nach dem Autor-Jahr-System direkt im
Fließtext (H 3.11). Mit dem mitgelieferten APA-7-Stil sieht das so aus:

- `@Freund2014` ergibt @Freund2014
- `@Freund2014[S. 42]` ergibt @Freund2014[S. 42]
- `#cite(<Hevner2004>, form: "prose")` ergibt #cite(<Hevner2004>, form: "prose")
  und eignet sich, wenn die Autoren Satzsubjekt sind
- mehrere Quellen: `@Freund2014 @Peffers2007` ergibt @Freund2014 @Peffers2007

Die Quellen stehen in `etc/bibliography.bib`. Nur zitierte Einträge erscheinen
im Literaturverzeichnis --- genau wie in H 3.11 gefordert. Die Datei enthält für
jeden gängigen Quellentyp ein Muster: Monographie @Freund2014,
Sammelwerksbeitrag @Meuser2009, Zeitschriftenartikel @Hevner2004, Konferenzbeitrag
@Peffers2007, Internetquelle @OMG2011, Studie @Bitkom2024, Norm @DINISO690,
Abschlussarbeit @Musterfrau2025, firmeninternes Dokument @Musterfirma2025 und
Interview @Expertmann2026.

Fußnoten sind damit frei für inhaltliche Anmerkungen.#footnote[Eine Fußnote
entsteht mit `#footnote[Text]`; sie wird automatisch durchgehend nummeriert und
in Schriftgröße 10 mit einzeiligem Abstand gesetzt (H 2.4).]

== Abbildungen

Abbildungen erhalten eine Unterschrift, Tabellen eine Überschrift (H 2.5). Auf
jede Abbildung muss im Text mit ihrer Nummer verwiesen werden --- etwa auf
@fig-logo. Stammt eine Darstellung nicht von dir, gehört die Quelle unter die
Beschriftung, erscheint aber nicht im Abbildungsverzeichnis; genau das erledigt
`#quelle[…]`.

#block(breakable: false)[
  #figure(
    image("/img/DHBW_logo.png", width: 45%),
    caption: [Logo der Dualen Hochschule Baden-Württemberg],
  ) <fig-logo>
  #quelle[@OMG2011]
]

== Tabellen

#figure(
  table(
    columns: (auto, 1fr, auto),
    align: (left, left, right),
    [Kriterium], [Beschreibung], [Gewicht],
    [Konsistenz], [Übereinstimmung der Zwischenergebnisse], [40 %],
    [Effizienz], [Aufwand pro Durchlauf], [35 %],
    [Akzeptanz], [Einschätzung der Fachbereiche], [25 %],
  ),
  caption: [Beispielhafte Bewertungskriterien],
) <tab-kriterien>

Die erste Zeile wird automatisch als Kopfzeile gesetzt. Verwiesen wird wie bei
Abbildungen: @tab-kriterien. Für Tabellen aus fremden Quellen steht
`#quelle-links[…]` bereit (linksbündig unter der Tabelle).

== Aufzählungen, Verweise und Sonderzeichen

Ungeordnete Listen beginnen mit `-`, geordnete mit `+`:

- erster Punkt
- zweiter Punkt

+ erster Schritt
+ zweiter Schritt

Querverweise auf Kapitel gibt H 4.2 als konkrete Kapitelnummer an, also etwa
"vgl. Abschnitt 2.1". Setze dafür ein Label wie `<sec-grundlagen>` hinter die
Überschrift und verweise mit `@sec-grundlagen`.

Anführungszeichen schreibst du einfach mit `"…"`, Typst setzt daraus
automatisch die typografisch richtigen Zeichen. Gedankenstriche entstehen mit `---`,
geschützte Leerzeichen mit `~` (z.~B. bei "S.~42" oder "Abb.~3").

== Was du auf keinen Fall ändern musst

Ränder, Zeilenabstand, Schriftgrößen, Seitenzahlen (römisch für die
Verzeichnisse, arabisch ab dem Textteil), Reihenfolge der Bestandteile,
Deckblatt, Erklärung und Sperrvermerk sind fertig eingestellt. Wenn deine
Betreuung abweichende Wünsche hat, findest du alle Regeln kommentiert in
`lib/template.typ`.

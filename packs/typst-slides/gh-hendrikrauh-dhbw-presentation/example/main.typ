#import "../src/lib.typ": *

#show: dhbw-theme.with(
  aspect-ratio: "16-9",
  // auto-title-slide: true,      // erste `=`-Heading → Titelfolie
  // chapter-slides: true,        // spätere `=`-Headings → Kapitelfolien
  // progress: "both",            // "dots" (default) | "number" | "both" | none
  // footer-text: auto,           // Fußzeile: auto = Datum · Autor · Thema
  // logo: auto,                  // Wortmarke in der Kopfzeile, none = ohne
  // size: 24pt,                  // Grundgröße der Schrift
  // primary: dhbw-red,           // Akzentfarbe (Alert, Linien, aktiver Punkt)
  // margin: (x: 2.2em, top: 3.5em, bottom: 1.5em),
  // font: "Source Sans 3",       // Fließtext
  // code-font: "FiraCode Nerd Font Mono",
  // math-font: "Fira Math",
  // link-text: [www.dhbw.de],    // roter Link unten links (Titel-/Kapitelfolie)
  // link-url: "https://www.dhbw.de",
  // sources-title: [Quellen],
  config-info(
    title: [Funktionen des DHBW-Themes],
    subtitle: [Musterfach #sym.dot Musterstudiengang],
    author: ("Max Mustermann", "Erika Musterfrau"),
    date: datetime.today(),
  ),
  sources: (
    "DHBW Corporate Design, www.dhbw.de",
    "Typst-Dokumentation, typst.app/docs",
  ),
)

= Aufbau des DHBW-Themes

== Gliederungsebenen

- `=` → *Thema:* die erste `=` ist die Titelfolie, jede weitere eine Kapitelfolie
- `==` → *Folientitel:* steht links oben in der Kopfzeile
- `===` → *Zwischenüberschrift:* unterteilt den Folieninhalt

=== Auch das ist eine Zwischenüberschrift

Mit `---` beginnt die nächste Folie desselben Themas — die Punkte in der
Fußzeile wachsen um einen weiteren Eintrag, `#pause`-Unterfolien teilen sich
einen Punkt.

==== Stufe vier

Tiefere Überschriften sind kleiner und heller gesetzt.

---

== Fußzeile und Fortschritt

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  [
    *Links*
    - `Datum · Autoren · Thema` aus `config-info`
    - `Thema` = `config-info(title:)`, sonst erste `=`-Heading
    - `progress: "number"`: rote Foliennummer links
    - `footer-text:` ersetzt die Zeile, `none` blendet sie aus
  ],
  [
    *Rechts*
    - ein Punkt pro Folie, gruppiert nach Thema, aktiv rot
    - `#progress-dots()` und `#slide-number()` einzeln nutzbar
    - Titel-, Kapitel- und Quellenfolie haben keine Punkte
  ],
)

#alert[Hinweis: Titel- und Kapitelfolie sind Übergangsseiten — sie haben weder Kopf- noch Fußzeile.]

= Inhaltstypen

== Listen, Formatierung und Hinweise

- Aufzählung mit *Fettdruck*, _Kursiv_ und `Code`
  - verschachtelter Unterpunkt
    - dritte Ebene
- Zweiter Hauptpunkt

+ Nummerierte Liste
+ Zweiter Eintrag
+ Dritter Eintrag

#alert[Darstellung: `#alert` und *Fettdruck* nutzen die DHBW-Akzentfarbe.]

Weiterführende Informationen in der
#link("https://www.dhbw.de", [DHBW-Website]).#footnote[Beispiel für eine Fußnote: sie wird kleiner gesetzt und erscheint am Seitenende.]

---

== Unterfolien: pause, uncover, only

- Sichtbar ab der ersten Unterfolie

#pause

- Nach `#pause` — die Unterfolie teilt sich den Punkt dieser Folie

#uncover(2)[
  - `#uncover(2)[...]`: reserviert Platz, sichtbar ab Unterfolie 2
]

#only(2)[
  - `#only(2)[...]`: nur auf Unterfolie 2, ohne reservierten Platz
]

== Mathematik

Inline-Mathematik wie $U_F approx 0.7 "V"$ oder $I_D = I_S (e^(U_F / U_T) - 1)$,
und als eigenständige Gleichung:

$ u_L = L (d i) / (d t) quad "mit" quad W = 1/2 L i^2 $

=== Formelzeichen

- `#sym.arrow.r` ergibt #sym.arrow.r
- `#sym.dot` ergibt #sym.dot
- `#sym.ast` ergibt #sym.ast

== Tabellen

#table(
  columns: (auto, 1fr, auto),
  align: (left, left, right),
  inset: .5em,
  table.header([*Argument*], [*Wirkung*], [*Default*]),
  [`aspect-ratio`], [Seitenverhältnis `"16-9"` oder `"4-3"`], [`"16-9"`],
  [`size`], [Grundgröße der Schrift], [`24pt`],
  [`primary`], [Akzentfarbe für Alert, Linien und aktiven Punkt], [`dhbw-red`],
  [`margin`], [Seitenränder], [`2.2em / 3.5em / 1.5em`],
)

Inline-Code wie `#show: dhbw-theme.with(..)` nutzt die `code-font`,
Inline-Mathematik wie $U_F approx 0.7 "V"$ die `math-font`.

---

== Code in Blöcken

```typst
#show: dhbw-theme.with(
  aspect-ratio: "16-9",
  chapter-slides: true,
)
= Titel der Präsentation
== Folientitel
- Inhalt
```

= Gestaltung

== Fokusfolie

Ein eigener Folientyp für die Kernaussage — vollflächig DHBW-Rot, ohne Kopf-
und Fußzeile, zentrierter Text in großer Schrift:

#focus-slide[
  Kernbotschaften gehören auf eine eigene Folie — #alert[in DHBW-Rot].
]

---

== Farben, Schriften und Datum

#let swatches = (
  ("dhbw-red", dhbw-red),
  ("dhbw-red-dark", dhbw-red-dark),
  ("dhbw-slate", dhbw-slate),
  ("dhbw-ink", dhbw-ink),
  ("dhbw-gray", dhbw-gray),
  ("dhbw-gray-mid", dhbw-gray-mid),
  ("dhbw-gray-faint", dhbw-gray-faint),
  ("dhbw-white", dhbw-white),
)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: .7em,
  ..swatches.map(s => [
    #rect(
      width: 100%,
      height: 1.4em,
      radius: 2pt,
      fill: s.at(1),
      stroke: .5pt + dhbw-gray-faint,
    )
    #text(size: .7em, raw(s.at(0)))
  ]),
)

=== Schriften und Logo

- Fließtext *Source Sans 3* (`font:`), Code `FiraCode Nerd Font Mono`
  (`code-font:`), Gleichungen _Fira Math_ (`math-font:`)
- `dhbw-logo()` liefert das Wortbild der Kopfzeile, `dhbw-logo-full()` das
  vollständige Logo der Titelfolie

---

== Datumsausgabe

`format-date` baut die Datumsangaben selbst, weil `datetime.display()`
Monatsnamen noch nicht lokalisiert:

- `lang: "de"` (vom Theme gesetzt): #format-date(datetime(year: 2026, month: 12, day: 24))
- `lang: "en"`: #format-date(datetime(year: 2026, month: 12, day: 24), lang: "en")
- Heute: #format-date(datetime.today()) — so steht es auch in der Fußzeile
- `config-info(date: datetime.today())` speist Titelfolie und Fußzeile

= Schluss

== Kernaussagen

+ Die Gliederung steuert Titelfolie, Kapitelfolien und Fortschrittspunkte
+ Die Fußzeile zeigt links `Datum · Autoren · Thema`, rechts die gruppierten Punkte
+ `#focus-slide`, `#alert` und die DHBW-Farben setzen die Kernbotschaften
+ Die Quellenfolie am Ende erzeugt `sources:` — als `bibliography()` genauso
  wie als Liste; ohne Zitat entfällt sie von selbst

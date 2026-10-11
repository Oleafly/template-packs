// Tutorial & Starter-Vorlage für `modern-deck.typ`.
// PDF: `typst compile tutorial-deck.typ`
#import "modern-deck.typ": *
#import "@preview/polylux:0.4.0": item-by-item, uncover
#show: deck-setup

#let mono-small(body) = {
  set text(size: 0.48em, font: ("DejaVu Sans Mono", "Liberation Mono"))
  body
}

#let code-sample(src) = block(
  width: 100%,
  fill: rgb("#e8ecf1"),
  inset: 0.65em,
  radius: 0.35em,
  stroke: 0.5pt + rgb("#cfd6df"),
)[
  #mono-small(raw(src, block: true, lang: "typ"))
]

// --- Deck ---
#title-slide(
  [Modern-Deck],
  subtitle: [Tutorial & Vorlage für neue Präsentationen],
  author: [Jörg Kastning],
  date: [April 2026],
  tagline: [Polylux · `modern-deck.typ`],
)

#agenda-slide(
  (
    [Neue Präsentation anlegen],
    [Design-Tokens und Schrift],
    [Baustein: `#title-slide`],
    [Baustein: `#agenda-slide`],
    [Baustein: `#section-slide`],
    [Baustein: `#split-slide`],
    [Baustein: `#timeline-slide`],
    [Baustein: `#closing-slide`],
    [Normale Folie mit `#slide`],
    [Polylux-Overlays],
  ),
  title: [Inhalt dieses Decks],
)

#section-slide[Neue Präsentation anlegen]

#slide[
  = Minimaler Einstieg

  Lege eine neue `.typ`-Datei an und binde das Template ein. `#show: deck-setup` muss *einmal* gesetzt werden — danach folgen deine Folien.

  #v(0.45em)
  #code-sample(
    "#import \"modern-deck.typ\": *\n"
      + "#show: deck-setup\n\n"
      + "#title-slide([Mein Thema], author: [Du], date: [Heute])\n\n"
      + "#slide[\n"
      + "  = Erste Inhaltsfolie\n"
      + "  Hier normaler Text, Listen, Abbildungen …\n"
      + "]\n",
  )
]

#slide[
  = Dateien im Projekt

  - `modern-deck.typ` — wiederverwendbares Template (Farben, `#deck-setup`, Bausteine).
  - `mein-vortrag.typ` — deine Präsentation: nur `#import` + Inhalt.
  - Optional: Bilder unter z. B. `bilder/`; Pfade relativ zur `.typ`-Datei.

  #v(0.5em)
  #block(
    inset: 0.65em,
    radius: 0.35em,
    fill: c-surface,
    stroke: 0.55pt + rgb("#e1e6eb"),
  )[
    *Tipp:* Diese Datei (`tutorial-deck.typ`) kannst du per „Speichern unter …“ kopieren und Inhalt sowie Titel austauschen.
  ]
]

#section-slide[Design anpassen]

#slide[
  = Farben und Schrift

  Im Template sind zentrale Werte als Variablen definiert — bearbeite sie in `modern-deck.typ`:

  - `c-bg`, `c-surface`, `c-ink`, `c-muted` — Hintergrund, Karten, Text
  - `c-accent`, `c-accent-soft`, `c-bar` — Akzent und dunkle Flächen (z. B. Abschnittsfolien)
  - `font-stack` — Schriftfamilien (erste installierte Schrift gewinnt)

  #v(0.4em)
  `#deck-setup` setzt z. B. Seitenformat *16:9*, Ränder und Überschriften-Stil für alle Folien.
]

#section-slide[Baustein: `#title-slide`]

#slide[
  = `#title-slide`

  Erste Folie mit großem Titel, optional *Tagline*, *Untertitel*, *Autor* und *Datum*. Das erste Argument (Titel) ist *positional*; der Rest benannt.

  #v(0.45em)
  #code-sample(
    "#title-slide(\n"
      + "  [Haupttitel],\n"
      + "  subtitle: [Untertitel],\n"
      + "  author: [Name],\n"
      + "  date: [Datum],\n"
      + "  tagline: [Kurzzeile oben],\n"
      + ")\n",
  )
]

#section-slide[Baustein: `#agenda-slide`]

#slide[
  = `#agenda-slide`

  Erwartet eine *Liste* von Punkten (Inhalt in Klammern) als erstes Argument. Der Titel der Folie ist optional per `title:`.

  #v(0.45em)
  #code-sample(
    "#agenda-slide(\n"
      + "  (\n"
      + "    [Erster Punkt],\n"
      + "    [Zweiter Punkt],\n"
      + "  ),\n"
      + "  title: [Überblick],\n"
      + ")\n",
  )
]

#section-slide[Baustein: `#section-slide`]

#slide[
  = `#section-slide`

  Markiert einen neuen Kapitel-Abschnitt — eine Folie mit dunklem Hintergrund und großem Label. Argument: der sichtbare Abschnittstitel (in eckigen Klammern).

  #v(0.45em)
  #code-sample("#section-slide[Mein Abschnitt]\n")
]

#section-slide[Baustein: `#split-slide`]

#split-slide(
  heading(level: 1)[`#split-slide` — zwei Spalten],
  [
    *Links:* Überschrift (`title`) und Fließtext oder Liste (`left`).

    Optional rechts eine *Rail* mit Zitat, Kennzahl oder Grafik — Parameter `rail:` (benannt).
  ],
  rail: [
    #set align(center)
    #text(weight: 700, fill: c-accent)[Rail]
    #parbreak()
    #text(size: 0.82em, fill: c-muted)[Abgesetzte Karten-Fläche]
  ],
)

#slide[
  = `#split-slide` nur eine Spalte

  Ohne `rail:` nutzt die Funktion nur eine Spalte — praktisch, wenn du die gleiche Überschriften-Hierarchie wie bei der Zwei-Spalten-Variante willst.

  #v(0.45em)
  #code-sample(
    "#split-slide(\n"
      + "  heading(level: 1)[Titelblock],\n"
      + "  [\n"
      + "    Inhalt …\n"
      + "  ],\n"
      + ")\n",
  )
]

#section-slide[Baustein: `#timeline-slide`]

#timeline-slide(
  heading(level: 1)[`#timeline-slide`],
  (
    (
      [Phase A],
      [Kurztitel],
      [Organisation oder Detail],
    ),
    (
      [Phase B],
      [Nächste Station],
      [Jede Zeile: Tripel `(Zeitraum, Rolle, Detail)`],
    ),
  ),
)

#slide[
  = Daten für die Timeline

  `entries` ist ein *Array von Tupeln*. Jedes Tupel hat drei Einträge: Zeitraum, Rolle, Detail — jeweils beliebiger Inhalt (Text, Formatierung, Links).

  #v(0.45em)
  #code-sample(
    "#timeline-slide(\n"
      + "  heading(level: 1)[Werdegang],\n"
      + "  (\n"
      + "    ([2023–heute], [Rolle], [Firma]),\n"
      + "    ([2015–2023], [Rolle], [Firma]),\n"
      + "  ),\n"
      + ")\n",
  )
]

#section-slide[Baustein: `#closing-slide`]

#slide[
  = `#closing-slide`

  Zentrierte Abschlussfolie. Standardtexte sind vorgegeben; du überschreibst sie bei Bedarf benannt.

  #v(0.45em)
  #code-sample(
    "#closing-slide(\n"
      + "  message: [Vielen Dank.],\n"
      + "  sub: [Fragen?],\n"
      + ")\n",
  )

  Die *nächste* Folie zeigt ein Beispiel mit angepassten Texten.
]

#closing-slide(
  message: [Beispiel-Abschluss],
  sub: [`message` und `sub` angepasst],
)

#section-slide[Normale Folie mit `#slide`]

#slide[
  = Beliebiger Inhalt

  Jede Baustein-Funktion steckt intern in `#slide[…]` von Polylux. Für Standard-Folien schreibst du direkt:

  #code-sample(
    "#slide[\n"
      + "  = Folientitel\n"
      + "  == Untertitel optional\n"
      + "  - Listenpunkt\n"
      + "  #image(\"bilder/diagramm.png\", width: 70%)\n"
      + "]\n",
  )

  Überschriften *Level 1* und *2* werden vom `#deck-setup` automatisch formatiert.
]

#slide[
  == Abbildungen und Links

  - `#image("pfad.png", width: 60%)` für Bilder
  - `#link("https://…")[Beschriftung]` für URLs
  - Fußnoten: z. B. `Text#footnote[Quelle …]`

  #v(0.35em)
  #text(size: 0.85em, fill: c-muted)[Siehe auch: #link("https://polylux.dev/book/")[Polylux-Dokumentation].]
]

#section-slide[Polylux-Overlays]

#slide[
  = Schrittweise einblenden

  Zusätzlich zum Template-Import Polylux-Hilfen importieren (wie oben in dieser Datei):

  #code-sample(
    "#import \"@preview/polylux:0.4.0\": item-by-item, uncover\n",
  )

  #v(0.4em)
  *`#item-by-item`* — Bullet-Liste nacheinander. *`#uncover(n)`* — Inhalt ab Overlay-Schritt `n`.
]

#slide[
  = Demo: `#item-by-item`

  #item-by-item[
    - Erster Punkt erscheint allein
    - Zweiter nach „Weiter“
    - Dritter zuletzt
  ]
]

#slide[
  = Demo: `#uncover`

  Immer sichtbar: Einleitung.

  #uncover(2)[
    Ab Schritt 2: ergänzender Absatz oder Liste.
  ]

  #uncover(3)[
    Ab Schritt 3: z. B. Fazit oder Quelle.
  ]
]

#closing-slide(
  message: [Viel Erfolg mit neuen Decks],
  sub: [Diese Datei als Vorlage kopieren und anpassen],
)

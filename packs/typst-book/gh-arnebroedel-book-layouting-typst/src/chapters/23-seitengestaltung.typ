// chapters/23-seitengestaltung.typ — Seitengestaltung & Hintergrund

#import "../styles/theme.typ": fonts, gradients, palette, part-colors, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout
#import "../components/didactics.typ": cave, definition, memo
#import "../components/page-design.typ": (
  book-parts, corner-ornament, dot-tiling, full-bleed, gradient-panel, gradient-text, margin-band,
  page-frame, section-background, thumb-index, tiling-background, watermark,
)
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Seitengestaltung und Hintergrund],
  lead: [
    Bis hierher ging es um den _Inhalt_ der Seite — Boxen, Tabellen,
    Diagramme, Bilder. Dieses Kapitel widmet sich der Seite _selbst_:
    ihrem Hintergrund. Farbflächen, Verläufe, Wasserzeichen,
    vollflächige Hintergründe, dekorative Rahmen und ein
    Daumenregister, an dem man Kapitelübergänge schon von außen am
    Buchschnitt erkennt — „wie in einem Ordner".
  ],
)

Anders als beim Inhalt arbeitet die Seitengestaltung mit zwei nativen
Ebenen, die _hinter_ und _über_ dem Satzspiegel liegen:
`page(background:)` und `page(foreground:)`. Hinzu kommen Verläufe
(`gradient.linear/radial/conic`), Wiederholungsmuster (`tiling`) und
durchlaufende Flächen (`block(breakable: true, fill: …)`). Die
Komponenten dieses Kapitels (`src/components/page-design.typ`) kapseln
diese Techniken bindungsbewusst#footnote[Im aufgeschlagenen Buch liegt
der Außenschnitt bei geraden Seiten (verso) links, bei ungeraden (recto)
rechts. Rand-Elemente fragen dazu `calc.even(here().page())` ab, statt
„links/rechts" fest zu verdrahten.] hinter einer token-gebundenen API.

#memo(title: [Setzt eine neue Seite])[
  Jede Änderung an `set page(…)` — auch nur am Hintergrund — beginnt in
  Typst eine _neue Seite_. Die seitenweiten Helfer (`watermark`,
  `full-bleed`, `margin-band`, `thumb-index`, `page-frame`,
  `corner-ornament`) belegen daher automatisch je eine eigene Seite;
  ihr erklärender Text steht bewusst _innerhalb_ des Aufrufs, damit
  Überschrift, Text und Hintergrund zusammen auf derselben Seite landen.
]

== Farbflächen und Verläufe#index[Hintergrund]#index[Verlauf]

Ein #index[Gradient]Verlauf entsteht nativ mit `gradient.linear`,
`gradient.radial` oder `gradient.conic` und lässt sich überall als
`fill` einsetzen — als Flächenfüllung _oder_ als Schriftfarbe. Die
Preset-Verläufe liegen in `theme.gradients`.

#gradient-panel(fill: gradients.wash)[
  #text(size: type-scale.h3, weight: "bold", font: fonts.sans)[
    Lineare Verläufe tragen Akzentflächen
  ]
  #v(space.xs)
  Ein Panel mit Verlaufsfüllung eignet sich für Kapitel-Intros,
  Merkkästen oder Schlagzeilen. Der Text steht hier in Weiß für
  ausreichenden Kontrast.
]

#v(space.md)

Ein Verlauf kann auch direkt die #index[Schriftfarbe]Schrift füllen
(relativ zur Textbox):

#align(center, gradient-text(size: type-scale.display)[Verlaufsschrift])

#v(space.md)

Radiale und konische Verläufe erzeugen weichere bzw. fächerartige
Übergänge:

#grid(
  columns: (1fr, 1fr),
  gutter: space.md,
  rect(width: 100%, height: 3cm, radius: 6pt, fill: gradients.radial),
  rect(width: 100%, height: 3cm, radius: 6pt, fill: gradients.conic),
)

== Abschnittsflächen, die über Seitenumbrüche laufen#index[Abschnittsfläche]

Eine getönte Fläche _hinter_ fließendem Text markiert
zusammengehörige Passagen. Dank `block(breakable: true, fill: …)`
setzt sich der Hintergrund auf der Folgeseite nahtlos fort — anders als
ein starr platzierter Kasten.

#section-background(fill: palette.primary.lighten(92%), inset: space.md)[
  #text(weight: "bold", fill: palette.primary)[Ein durchlaufender Abschnitt.]
  #lorem(90)
]

#definition(term: [Breakable Block])[
  Ein umbrechbarer Block (`breakable: true`, in Typst der Standard) darf
  an einer Seitengrenze geteilt werden. Seine Füllung und sein Rahmen
  werden dabei auf beiden Seitenteilen fortgesetzt — die Grundlage für
  Abschnittshintergründe, die mit dem Text mitwachsen.
]

== Wiederholungsmuster mit `tiling`#index[Tiling]#index[Muster]

Für dezente Texturen kachelt `tiling` ein kleines Grundelement über
die Fläche. So entsteht z. B. ein feines Punktraster als ruhiger
Hintergrund für Hinweisflächen.

#tiling-background(inset: space.md)[
  #text(weight: "bold")[Punktraster-Textur.] #lorem(40)
]

#section-break()

#watermark(mark: [MUSTER], fill: palette.primary.transparentize(86%))[
  == Wasserzeichen#index[Wasserzeichen]

  Ein Wasserzeichen ist halbtransparenter Inhalt in
  `page(background:)` (hinter dem Text) oder `page(foreground:)` (über
  dem Text). Es kennzeichnet Entwürfe, Musterseiten oder
  Vertraulichkeit, ohne die Lesbarkeit zu zerstören.

  #lorem(70)

  #cave[
    Ein _Vordergrund_-Wasserzeichen (`fg: true`) legt sich sichtbar
    über den Text — wirksam für „ENTWURF"-Stempel, aber sparsam
    einsetzen, damit der Lesefluss nicht leidet.
  ]

  #lorem(50)
]

#full-bleed(
  bg: {
    image(
      "/src/assets/anatomy/cell.svg",
      width: 100%,
      height: 100%,
      fit: "cover",
      alt: "Dekoratives, schematisches Zellbild als blasser Seitenhintergrund.",
    )
    place(top + left, rect(width: 100%, height: 100%, fill: palette.primary-dark.transparentize(12%)))
  },
)[
  #align(center + horizon, block(width: 75%, {
    text(size: type-scale.display, weight: "bold", fill: white, font: fonts.sans)[
      Vollflächiger Hintergrund
    ]
    v(space.lg)
    text(size: type-scale.lead, fill: white.darken(8%), font: fonts.sans)[
      _full-bleed_ setzt Bild, Farbe oder Verlauf randlos von Kante zu
      Kante (Margin 0). Eine halbtransparente Farbschicht über dem Bild
      hält den Text lesbar. Für echten Druckanschnitt ergänzt man eine
      Anschnittzugabe (_bleed_) und zieht das Bild auf 100 %.
    ]
  }))
]

#margin-band(color: part-colors.at(6), width: 11mm)[
  == Rand-Farbbänder#index[Randmarkierung]

  Ein durchgehendes Farbband am Außenrand zieht sich über alle Seiten
  eines Bereichs und ordnet ihn farblich zu. Das Band sitzt
  bindungsbewusst stets am _Außenschnitt_ — auf dieser Seite also je
  nach gerader/ungerader Seitenzahl links oder rechts.

  #lorem(80)
]

#thumb-index(active: 7, parts: book-parts)[
  == Daumenregister / Griffregister#index[Daumenregister]#index[Griffregister]

  Das Griffregister ist die Krönung der Randmarkierung: je eine farbige
  Marke pro Teil, gestaffelt nach unten. Schlägt man das Buch zu, bildet
  die Abfolge der Marken am Schnitt eine „Leiter" — man sieht den
  Übergang von einem Teil zum nächsten von außen, _wie die Reiter in
  einem Ordner_.

  Auf dieser Seite ist die Marke von #text(fill: part-colors.at(6), weight: "bold")[Teil VII]
  hervorgehoben (breit und gefüllt), die übrigen Teile stehen blass
  daneben. Buchweit wandert die aktive Marke mit jedem Teil eine Stufe
  tiefer.

  #lorem(45)
]

#thumb-index(active: 3, parts: book-parts)[
  Auf der nächsten Seite ist — zur Veranschaulichung der Staffelung —
  #text(fill: part-colors.at(2), weight: "bold")[Teil III] aktiv: Die
  hervorgehobene Marke ist nach oben gerückt. Blättert man, wandert der
  Reiter sichtbar die Seitenkante entlang.

  #memo(title: [Buchweite Variante])[
    Im Showcase wird die aktive Marke explizit übergeben, damit das
    Register aufs Kapitel begrenzt bleibt. Buchweit leitet man sie aus
    dem Heading-Stand ab — wichtig: `counter(heading).at(loc)` nutzen,
    *nicht* einen eigenen `.where()`-Selektor-Zähler (der wird nicht
    automatisch hochgezählt).
  ]

  #lorem(30)
]

#page-frame(stroke: 0.8pt + palette.primary, inset: 12mm)[
  == Dekorative Rahmen#index[Seitenrahmen]

  Ein Linienrahmen im Vordergrund fasst die Seite ein — klassisch für
  Titelseiten, Merkblätter oder Urkunden. `page-frame` rückt den Rahmen
  um ein einstellbares Maß vom Seitenrand ein.

  #lorem(60)

  #callout(tone: "info")[
    Für aufwändigere Rahmen mit Kopf-/Fußlinien gibt es das Paket
    `@preview/s6t5-page-bordering`. Hier genügt der native Weg:
    `page(foreground: place(rect(stroke: …)))`.
  ]
]

#corner-ornament(len: 16mm, inset: 10mm, stroke: 1pt + palette.accent)[
  == Eck-Verzierungen#index[Eckverzierung]

  Winkel-Klammern in den vier Ecken setzen einen dezenten,
  hochwertigen Rahmen-Akzent, ohne die Seite vollständig einzufassen.
  Sie entstehen aus je zwei `line`-Segmenten pro Ecke, platziert über
  `page(foreground:)`.

  #lorem(55)

  #memo[
    Hintergrund- und Vordergrund-Dekoration ist rein gestalterisch.
    Damit der PDF/UA-Build sauber bleibt, tragen dekorative
    Hintergrundbilder einen Alt-Text (oder werden als Artefakt
    behandelt); reine Linien/Flächen brauchen keinen.
  ]
]

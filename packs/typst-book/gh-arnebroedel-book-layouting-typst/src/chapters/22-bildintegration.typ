// chapters/22-bildintegration.typ — Bildintegration & Text-Bild-Fluss

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout
#import "../components/tables.typ": comparison-table
#import "../components/didactics.typ": cave, definition, memo
#import "../components/figures.typ": (
  anatomie-figur, bild-detail, bildtafel, kontur-figur, plate, setup-figure-numbering, wrap-figure,
)
#import "@preview/in-dexter:0.7.2": index

// Abbildungsnummern lehrbuchüblich pro Kapitel: „Abb. 22.1", „Abb. 22.2" …
#show: setup-figure-numbering()

#chapter-opener(
  title: [Bildintegration und Text-Bild-Fluss],
  lead: [
    Ein Anatomieatlas lebt vom Zusammenspiel aus Abbildung und Erklärung.
    Dieses Kapitel zeigt den Werkzeugkasten, mit dem Bilddateien sauber
    auf der Seite sitzen und Text und Bild zu einer Einheit verschmelzen —
    von der gleitenden Tafel über den seitlichen Textfluss bis zum
    Umfließen beliebiger Konturen, zur beschrifteten Anatomie und zur
    Detaillupe.
  ],
)

Typst kennt mit `image()` und `figure()` zwei native Bausteine, doch das
saubere Verzahnen von Bild und Fließtext erfordert Sorgfalt und an einigen
Stellen gezielt ergänzte Pakete. Die Komponenten dieses Kapitels
(`src/components/figures.typ`) kapseln diese Muster hinter einer
einheitlichen, token-gebundenen API. Bildpfade werden dabei
wurzel-absolut angegeben (`/src/assets/…`), damit sie unabhängig vom
aufrufenden Kapitel auflösen.

== Gleitende Abbildungen mit `plate`#index[Float]

Die einfachste Stufe braucht kein Zusatzpaket: `plate` setzt ein Bild in
eine native #index[Figure]Figure und nutzt Typsts Float-Mechanismus.
Mit `placement: top`, `bottom` oder `auto` „schwimmt" die Abbildung an den
nächsten Spalten- oder Seitenrand, während der Text lückenlos nachfüllt.
`scope: "parent"` lässt eine Tafel über alle Spalten eines mehrspaltigen
Satzes reichen.

#plate(
  "/src/assets/anatomy/heart-schema.svg",
  width: 6cm,
  caption: [Schematischer Aufbau des Herzens mit Vorhöfen, Kammern,
    Klappenebene und abgehenden großen Gefäßen.],
  alt: "Schematische Darstellung eines Herzens im Längsschnitt mit vier "
    + "Binnenräumen, Klappenebene, Aorta, Truncus pulmonalis und oberer Hohlvene.",
)

#definition(term: [Float])[
  Eine _gleitende_ Abbildung ist nicht fest im Textfluss verankert,
  sondern wird vom Satzsystem an eine passende Position (Seitenanfang,
  -ende) verschoben. Das verhindert große Leerräume, wenn ein Bild nicht
  mehr auf die aktuelle Seite passt.
]

== Seitlicher Textfluss mit `wrap-figure`#index[wrap-it]

Der häufigste Wunsch — ein kompaktes Bild rechts oder links, der Text
läuft daneben weiter — ist in Typst nicht nativ vorgesehen (Issue
typst\#553). Die Komponente `wrap-figure` schließt die Lücke über das
Paket #index[wrap-it]`@preview/wrap-it` und bindet dessen Optionen an die
Design-Tokens.

#wrap-figure(
  "/src/assets/anatomy/neuron-compact.svg",
  [
    Das Neuron ist die funktionelle Grundeinheit des Nervensystems.
    Sein Zellkörper (Soma) integriert die über die Dendriten
    eintreffenden Signale. Überschreitet das Membranpotenzial am
    Axonhügel die Schwelle, läuft ein Aktionspotenzial über das Axon.
    Die Myelinscheiden#index[Myelin] beschleunigen die Erregungsleitung
    durch saltatorische Weiterleitung von Schnürring zu Schnürring. An
    den Axonterminalen wird das Signal chemisch über Synapsen auf die
    nächste Zelle übertragen. Der hier umflossene Aufbau zeigt diese
    Kompartimente im Überblick.
  ],
  width: 46%,
  side: right,
  caption: [Aufbau eines myelinisierten Neurons.],
  alt: "Neuron mit Soma, Dendritenbaum, myelinisiertem Axon und Axonterminalen.",
)

#cave[
  Vor jedem `wrap-figure` muss eine Leerzeile (Absatzgrenze) stehen, damit
  der umfließende Text als eigener Absatz erkannt wird. Sehr kurze Texte
  oder Aufzählungen umfließen nicht zuverlässig — dafür ist die nächste
  Stufe gedacht.
]

== Konturumfließen mit `kontur-figur`#index[meander]

Wo der Text eine Form _umschließen_ soll — auch rund oder unregelmäßig —
greift `kontur-figur` auf die Layout-Engine #index[meander]`@preview/meander`
zurück. Sie segmentiert den reservierten Bereich um das Hindernis herum.
Mit `round: true` wird eine kreisförmige Kontur ausgeschnitten; `side:
center` rückt das Bild horizontal in die Seitenmitte und führt den Text in
zwei Spalten _beidseitig_ um die runde Form. Damit keine Rechteckkante
sichtbar bleibt, blendet `frame: auto` bei runder Kontur den Rahmen aus —
das Bild trägt dafür einen transparenten Hintergrund.

#kontur-figur(
  "/src/assets/anatomy/cell.svg",
  [
    Die eukaryotische Zelle ist von einer Plasmamembran umschlossen, die
    den Stoffaustausch mit der Umgebung reguliert und das Zellinnere von
    der Umgebung abgrenzt. Im Inneren liegt der Zellkern mit dem Nucleolus,
    der die genetische Information birgt und die Ribosomenbiogenese steuert.
    Die Mitochondrien erzeugen über die Atmungskette das ATP, das die
    zellulären Prozesse antreibt und als universeller Energieträger dient.
    Das endoplasmatische Retikulum und der Golgi-Apparat falten,
    modifizieren und sortieren Proteine, während Vesikel den
    intrazellulären Transport zwischen den Kompartimenten übernehmen. Das
    Zytoskelett verleiht der Zelle Form und Stabilität und ermöglicht
    gerichtete Bewegungen. Der hier kreisförmig umflossene Querschnitt
    deutet diese Organellen schematisch an und zeigt zugleich, wie der
    Fließtext in zwei Spalten beidseitig eng an der runden Zellkontur
    entlanggeführt wird, ganz ohne harte Rechteckkanten zu hinterlassen.
  ],
  width: 4.6cm,
  height: 6.6cm,
  side: center,
  round: true,
  margin: 3mm,
  caption: [Querschnitt einer eukaryotischen Zelle.],
  alt: "Eukaryotische Zelle mit Zellkern, Nucleolus, Mitochondrien, "
    + "endoplasmatischem Retikulum und Vesikeln.",
)

#memo[
  Faustregel: `wrap-figure` für den schnellen seitlichen Fluss,
  `kontur-figur` für runde/unregelmäßige Formen und anspruchsvolle
  Anatomie-Spreads. Letztere ist mächtiger, aber rechenintensiver — die
  Bereichshöhe (`height`) sollte zur Textmenge passen.
]

== Mehrteilige Bildtafeln mit `bildtafel`#index[subpar]

Vergleichende Darstellungen — etwa mehrere Organe oder Schnittebenen —
gehören in eine gemeinsame Tafel mit Teilbild-Beschriftung (a), (b), (c).
`bildtafel` nutzt #index[subpar]`@preview/subpar` und vergibt die
Teilnummern automatisch unter einer Gesamtunterschrift.

#bildtafel(
  (
    (
      src: "/src/assets/anatomy/heart-schema.svg",
      caption: [Herz — Längsschnitt],
    ),
    (
      src: "/src/assets/anatomy/nephron.svg",
      caption: [Nephron — Funktionseinheit der Niere],
    ),
  ),
  columns: 2,
  caption: [Zwei Organschemata im direkten Vergleich; die Teilbilder
    tragen eigene Kurzunterschriften unter gemeinsamer Nummer.],
)

== Beschriftete Anatomie mit `anatomie-figur`#index[Beschriftung]

Im Atlas trägt jede Struktur eine Ziffer, die Legende benennt sie.
`anatomie-figur` legt nummerierte Marker (Position als Bruchteil der
Bildbox) über die Abbildung und setzt darunter oder daneben die Legende.
Weil die Beschriftung im Typst-Text lebt, bleibt sie übersetzbar,
indexierbar und konsistent gestylt — unabhängig von der Bilddatei.

#anatomie-figur(
  "/src/assets/anatomy/neuron.svg",
  width: 11cm,
  marker: (
    (x: 0.26, y: 0.5, n: 1),
    (x: 0.45, y: 0.5, n: 2),
    (x: 0.56, y: 0.5, n: 3),
    (x: 0.82, y: 0.42, n: 4),
    (x: 0.20, y: 0.24, n: 5),
  ),
  legend: (
    [*Soma* — integriert die eintreffenden Signale],
    [*Myelinscheide* — beschleunigt die Erregungsleitung],
    [*Ranvier-Schnürring* — Ort der saltatorischen Weiterleitung],
    [*Axonterminal* — synaptische Signalübertragung],
    [*Dendrit* — Empfang afferenter Signale],
  ),
  legend-side: bottom,
  caption: [Myelinisiertes Neuron mit nummerierten Strukturen.],
  alt: "Neuron mit fünf nummerierten Strukturen: Soma, Myelinscheide, "
    + "Ranvier-Schnürring, Axonterminal und Dendrit.",
)

#callout(tone: "info", title: [Verwandt: Pinit-Annotationen])[
  Für Beschriftungen, die an einer Stelle im _Fließtext_ verankert sind,
  zeigt Kapitel 18 das Paket `pinit`. `anatomie-figur` ergänzt es um den
  bildbezogenen Fall: Marker an festen Bildkoordinaten plus Legende.
]

== Detailvergrößerung mit `bild-detail`#index[Lupe]

Manche Strukturen sind erst im Ausschnitt erkennbar. `bild-detail`
vergrößert eine Stelle des Bildes als kreisförmige Lupe mit
Verbindungslinie. Die Komponente ist eigenständig umgesetzt
(`box(radius: 50%, clip: true)`), da das einschlägige Lupenpaket aktuell
nicht mit der `scale()`-API von Typst 0.15 kompatibel ist — ein
gutes Beispiel dafür, wann sich eine schlanke Eigenentwicklung lohnt.

#bild-detail(
  "/src/assets/anatomy/neuron.svg",
  width: 11cm,
  focus: (0.26, 0.5),
  lens-at: (0.78, 0.72),
  zoom: 2.4,
  lens-radius: 1.6cm,
  caption: [Detaillupe auf das Soma mit Zellkern.],
  alt: "Vergrößerter Ausschnitt des Neuron-Somas mit Zellkern.",
)

== Welches Werkzeug wann?

#comparison-table(
  headers: ([Aufgabe], [Komponente], [Grundlage]),
  rows: (
    ([Bild an Seiten-/Spaltenrand gleiten lassen], [`plate`], [nativ (Floats)]),
    ([Text seitlich vorbeiführen], [`wrap-figure`], [`wrap-it`]),
    ([Runde/unregelmäßige Kontur umfließen], [`kontur-figur`], [`meander`]),
    ([Mehrteilige Tafel (a)(b)(c)], [`bildtafel`], [`subpar`]),
    ([Strukturen nummerieren + Legende], [`anatomie-figur`], [eigen + `place`]),
    ([Detail vergrößern], [`bild-detail`], [eigen]),
    ([Nummerierung pro Kapitel (Abb. 22.1 …)], [`setup-figure-numbering`], [nativ]),
  ),
)

Alle Bildkomponenten reichen `alt`-Texte an die Figure weiter und sind
damit für den barrierefreien PDF/UA-Export vorbereitet. Die
Nummerierung dieses Kapitels läuft über `setup-figure-numbering` pro
Kapitel — die Abbildungen oben tragen daher die Form „Abb. 22.x".

#section-break()

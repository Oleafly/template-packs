// chapters/24-kunststuecke.typ — Experimentelle Seitenkunst

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener
#import "../components/art.typ": (
  art-page, aurora, guilloche, kaleidoscope, mandala, moire, mondrian, phyllotaxis, type-poster, wave-field,
)
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Kunststücke: Die Seite als Leinwand],
  lead: [
    Ein letzter Ausbruch — frei, farbenfroh, regellos. Hier wird die
    Seite nicht gesetzt, sondern _komponiert_: generative Muster,
    optische Täuschungen, Verlaufstypografie und Symmetrien, fast alles
    aus reinen Typst-Primitiven — `place`, Formen, Verläufe, native
    `curve` und ein wenig Mathematik. Buchuntypisch, absichtlich.
  ],
)

Die folgenden Doppelseiten sind ein Spielplatz#index[Generative Kunst]. Jedes
Blatt ist ein randloses Vollbild, erzeugt von einer Funktion aus
`src/components/art.typ` — und damit reproduzierbar, parametrisierbar und
frei von externen Werkzeugen (einzige Ausnahme: das Kaleidoskop greift
auf eine Anatomie-SVG zurück). Was hier als l’art pour l’art erscheint,
ist zugleich ein Beweis: Typsts Zeichen-Primitive tragen weit über
klassischen Buchsatz hinaus. Lassen wir es fließen.

#art-page(
  label: "01 · Aurora",
  note: [Überlagerte, transparentisierte radiale Verläufe bilden ein weiches Farbnebel-Mesh.],
)[#aurora()]

#art-page(
  label: "02 · Phyllotaxis",
  note: [Über 1000 Punkte im goldenen Winkel (137,5°); die Farbe folgt dem Spektrum. Reine Mathematik — die Anordnung der Sonnenblume.],
)[#phyllotaxis()]

#art-page(
  label: "03 · Moiré",
  label-fill: black,
  note: [Zwei minimal versetzte Kreisscharen erzeugen Interferenzmuster — Op-Art aus zwei Schleifen.],
)[#moire()]

#art-page(
  label: "04 · Wellenfeld",
  note: [Phasen- und frequenzverschobene Sinuskurven als native Kurven, mit Verlaufskontur (Interferenz).],
)[#wave-field()]

#art-page(
  label: "05 · Mandala",
  note: [Radiale Blütensymmetrie aus rotierten Ellipsen — Rotation um den Mittelpunkt, lagenweise.],
)[#mandala()]

#art-page(
  label: "06 · Neo-Plastizismus",
  label-fill: black,
  note: [Kühne Primärfarbblöcke und schwarze Gitterlinien — eine Mondrian-Hommage aus Rechtecken.],
)[#mondrian()]

#art-page(
  label: "07 · Typo-Poster",
  note: [Verlaufstypografie als Bildelement: ein Riesenwort mit Verlaufsfüllung, umspielt von rotierten Geisterwörtern.],
)[#type-poster(word: [FLUSS])]

#art-page(
  label: "08 · Guilloché",
  note: [Banknoten-Ornament: r(θ) = R + a·cos(kθ), mehrlagig und phasenverschoben — das „Sicherheitsgewebe" als Kunst.],
)[#guilloche()]

#art-page(
  label: "09 · Kaleidoskop",
  note: [Radial rotierte, abwechselnd gespiegelte SVG-Kopien plus konischer Riso-Farbschleier.],
)[#kaleidoscope()]

#pagebreak()

#align(center + horizon, block(width: 70%, {
  text(size: type-scale.h2, weight: "bold", font: fonts.sans, fill: palette.primary)[Vom Werkzeug zum Werk]
  v(space.md)
  text(size: type-scale.lead, fill: palette.text-muted)[
    Neun Seiten, neun Funktionen, kein einziges externes Bildprogramm.
    Wenn ein Satzsystem solche Bilder _rechnet_, verschwimmt die Grenze
    zwischen Layout und Illustration — und genau dort beginnt der Spaß.
  ]
}))

#import "metadata.typ": meta
#import "@preview/equate:0.3.1": equate

#let schrift-fliesstext = "Times New Roman"
#let schrift-code       = "Courier New"
#let schriftgroesse     = 11pt

// -------------------------------------------------------------
// Theorem-Umgebungen  (Satz, Lemma, Definition, Beweis)
// Gemeinsamer kapitelweiter Counter über alle Typen.
// Kein nummer-Parameter mehr — Nummerierung automatisch.
// Verweis im Text: @satz-hull-dobell, @def-gitter usw.
// -------------------------------------------------------------

#let theorem-counter = counter("theorem")

#let _theorem-block(art, name, body, label: none) = {
  theorem-counter.step()
  let nummer = context {
    let kapitel = counter(heading).get().at(0)
    let n = theorem-counter.get().at(0)
    str(kapitel) + "." + str(n)
  }
  v(0.6em)
  let inhalt = block(width: 100%)[
    #text(weight: "bold")[#art #nummer]#if name != "" [ (#text(style: "italic")[#name])].\ 
    #text(style: "italic")[#body]
  ]
  if label != none {
    [#figure(inhalt, kind: "theorem", supplement: art, caption: none)#label(label)]
  } else {
    inhalt
  }
  v(0.6em)
}

#let satz(name: "", label: none, body) = {
  _theorem-block("Satz", name, body, label: label)
}

#let lemma(name: "", label: none, body) = {
  _theorem-block("Lemma", name, body, label: label)
}

#let definition(name: "", label: none, body) = {
  _theorem-block("Definition", name, body, label: label)
}

#let beweis(body) = {
  v(0.3em)
  block(width: 100%)[
    #text(style: "italic")[Beweis.] #body #h(1fr) $square$
  ]
  v(0.6em)
}

// -------------------------------------------------------------
// Hilfsfunktionen Header/Footer
// -------------------------------------------------------------
#let dhbw-header() = context [
  #grid(
    columns: (auto, 1fr, auto),
    align: (left, center, right),
    if meta.zeige-firmenlogo {
      image("assets/logo_firma.png", height: 1.5cm)
    } else {
      []
    },
    [],
    image("assets/logo_dhbw.png", height: 1.5cm),
  )
]

#let dhbw-footer(nummerierung, prefix: "") = context [
  #grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    meta.art,
    meta.autor,
    prefix + counter(page).display(nummerierung),
  )
]

// -------------------------------------------------------------
// Titelblatt
// -------------------------------------------------------------
#let titelblatt() = {
  page(
    margin: (left: 2.5cm, right: 3.5cm, top: 4.5cm, bottom: 2.5cm),
    header: none,
    footer: none,
    numbering: none,
)[
    // ----- Titel + Art der Arbeit (wächst nach oben) -----
    #v(0.5fr)
    #align(center)[
      #text(size: 24pt, weight: "bold")[#meta.titel]
      #v(1cm)
      #text(size: 13pt, weight: "bold")[#upper(meta.art) (#meta.modul)]
    ]

    #v(1fr)

    // ----- Unterer Block (feste Höhe) -----
    #align(center)[
      #text(size: 11pt)[Studiengang #meta.studiengang]
      #v(0.3em)
      #text(size: 11pt)[#meta.institution]
      #v(1.5cm)
      #text(size: 11pt)[von]
      #v(0.3em)
      #text(size: 11pt)[#meta.autor]
      #v(0.6em)
      #text(size: 11pt)[#meta.datum]
    ]

    #v(3cm)

    #grid(
      columns: (auto, 1fr, auto),
      row-gutter: 1em,
      [Matrikelnummer, Kurs], [], [#meta.matrikelnummer, #meta.kurs],
      [Betreuer/Gutachter],   [], [#meta.erstgutachter],
    )
  ]
}

// -------------------------------------------------------------
// Hauptfunktion
// -------------------------------------------------------------
#let dhbw-vorlage(body) = {

  show: equate.with(breakable: true, sub-numbering: true)
  set math.equation(numbering: "(1.1)", supplement: "Gleichung")

  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 3.5cm, top: 2.5cm, bottom: 2.5cm),
    header: dhbw-header(),
    footer: dhbw-footer("I"),
    numbering: "I",
  )

  set text(
    font:     schrift-fliesstext,
    size:     schriftgroesse,
    lang:     "de",
    region:   "DE",
    hyphenate: true,
  )

  set par(
    justify:           true,
    first-line-indent: 0pt,
    spacing:           6pt,
    leading:           0.75em,
  )

  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    theorem-counter.update(0)
    v(1.5em)
    text(size: 14pt, weight: "bold", it)
    v(0.8em)
  }
  show heading.where(level: 2): it => {
    v(1em)
    text(size: 12pt, weight: "bold", it)
    v(0.5em)
  }
  show heading.where(level: 3): it => {
    v(0.8em)
    text(size: 11pt, weight: "bold", it)
    v(0.3em)
  }

  show raw: it => text(font: schrift-code, size: 10pt, it)

  show figure: it => {
    v(1.2em)
    align(center, it.body)
    v(0.5em)
    align(center,
      text(size: 10pt,
        [Abbildung #it.counter.display("1.1"): #it.caption.body]
      )
    )
    v(1.2em)
  }

  show figure.where(kind: table): it => {
    v(1.2em)
    align(center, it.body)
    v(0.5em)
    align(center,
      text(size: 10pt,
        [Tabelle #it.counter.display("1.1"): #it.caption.body]
      )
    )
    v(1.2em)
  }

  body
}

#let querformat(body) = {
  page(flipped: true)[
    #body
  ]
}

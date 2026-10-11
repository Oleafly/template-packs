// ============================================================
//  unimore-thesis — lib.typ
//  Logica del template: funzioni e show rules.
//  Gli utenti importano questo file tramite:
//    #import "@preview/unimore-thesis:0.1.0": *
// ============================================================

// ------------------------------------------------------------
// thesis-setup: configura l'intero documento.
// Chiamare all'inizio del main.typ con:
//   #show: thesis-setup.with(titolo: "...", autore: "...")
// ------------------------------------------------------------
#let thesis-setup(
  titolo:       "<Titolo dell'Elaborato>",
  autore:       "<Nome Cognome>",
  matricola:    "<Matricola>",
  relatore:     "Prof. <Nome Cognome>",
  correlatore:  "",     // lascia "" per omettere
  universita:   "Università degli Studi di Modena e Reggio Emilia",
  dipartimento: "",     // opzionale — lascia "" per omettere
  corso:        "",     // opzionale — lascia "" per omettere
  anno_acc:     "Anno Accademico 20XX/20XX",
  logo:         none,   // es. image("images/logo.png", width: 8cm)
  body,
) = {

  // ── Metadati documento ──────────────────────────────────
  set document(title: titolo, author: autore)

  // ── Testo e paragrafi ───────────────────────────────────
  set text(font: "New Computer Modern", size: 12pt, lang: "it")
  set par(justify: true, leading: 0.9em, spacing: 1.4em)

  // ── Pagina ──────────────────────────────────────────────
  set page(
    paper:  "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )

  // ── Headings ────────────────────────────────────────────
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(0.5cm)
    text(size: 18pt, weight: "bold")[#it]
    v(0.6cm)
  }
  show heading.where(level: 2): it => {
    v(0.5em)
    text(size: 14pt, weight: "bold")[#it]
    v(0.3em)
  }
  show heading.where(level: 3): it => {
    v(0.4em)
    text(size: 12pt, weight: "bold")[#it]
    v(0.2em)
  }

  // ── Link ────────────────────────────────────────────────
  show link: set text(fill: blue.darken(20%))

  // ── Blocchi di codice ───────────────────────────────────
  show raw.where(block: true): it => block(
    fill:   rgb("#f5f5ec"),
    inset:  (x: 10pt, y: 8pt),
    radius: 3pt,
    width:  100%,
    text(size: 9pt)[#it],
  )

  // ── FRONTESPIZIO ────────────────────────────────────────
  page(
    numbering: none,
    header:    none,
    footer:    none,
  )[
    #align(center)[

      // Logo (passato come parametro — nessuna immagine hardcoded)
      #if logo != none { logo }
      #v(0.5cm)

      #text(size: 16pt, weight: "bold", hyphenate: false)[#upper(universita)]

      #if dipartimento != "" {
        v(0.15cm)
        text(size: 12pt)[#dipartimento]
      }
      #if corso != "" {
        v(0.1cm)
        text(size: 12pt)[#corso]
      }

      #v(2.5cm)
      #text(size: 18pt, weight: "bold")[#titolo]
      #v(3cm)
    ]

    #grid(
      columns: (1fr, 1fr),
      {
        text(size: 12pt, weight: "bold")[Relatore:] + linebreak()
        text(size: 12pt)[#relatore]
        if correlatore != "" {
          linebreak()
          v(0.3em)
          text(size: 12pt, weight: "bold")[Correlatore:] + linebreak()
          text(size: 12pt)[#correlatore]
        }
      },
      align(right)[
        #text(size: 12pt, weight: "bold")[Candidato:] \
        #text(size: 12pt)[#autore] \
        #text(size: 12pt)[Matricola #matricola]
      ],
    )

    #v(1fr)
    #line(length: 100%, stroke: 0.6pt)
    #align(center)[
      #text(size: 12pt, weight: "bold")[#anno_acc]
    ]
  ]

  // Pagina bianca
  page(numbering: none)[]

  // ── Sezioni preliminari (numerazione romana) ─────────────
  set page(
    numbering:    "i",
    number-align: right,
    footer: context align(center)[
      #text(size: 9pt, fill: luma(120))[#counter(page).display("i")]
    ],
  )
  counter(page).update(1)

  body
}


// ------------------------------------------------------------
// thesis-body: da usare dopo gli indici, prima dei capitoli.
// Riporta la numerazione ad araba e la ricomincia da 1.
// Uso: #show: thesis-body
// ------------------------------------------------------------
#let thesis-body(body) = {
  set page(
    numbering:    "1",
    number-align: right,
    footer: context align(center)[
      #text(size: 9pt, fill: luma(120))[#counter(page).display("1")]
    ],
  )
  counter(page).update(1)
  body
}


// ------------------------------------------------------------
// algo: figura con pseudocodice in stile algorithmicx.
// Uso: #algo(caption: [Dijkstra])[corpo]
// ------------------------------------------------------------
#let algo(caption: [], body) = figure(
  kind:       "algorithm",
  supplement: [Algoritmo],
  block(
    stroke:  0.6pt + black,
    inset:   0pt,
    width:   100%,
    radius:  2pt,
    {
      block(
        fill:  luma(215),
        width: 100%,
        inset: (x: 8pt, y: 5pt),
        text(size: 10pt, weight: "bold")[#caption],
      )
      block(
        inset: (x: 10pt, y: 8pt),
        width: 100%,
        text(font: "New Computer Modern Mono", size: 9pt)[#body],
      )
    },
  ),
  caption: caption,
)

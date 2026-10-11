// =============================================================================
// Vertelvonk — Typst-template voor kinderverhalen
// Crème papier, regenboogtitels, rouleerende hoofdstukkleuren, tekstballonnen,
// geluidseffecten en sterretjes. Zustervariant van swoep-typst, maar dan
// voor voorleesverhalen in plaats van werkdocumenten.
// =============================================================================

// ----------------------------------------------------------------- kleurpalet
#let vonk-koraal = rgb("#EF6461") // warm rood-roze
#let vonk-zon = rgb("#FFB703") // zonnig geel
#let vonk-gras = rgb("#59B559") // frisgroen
#let vonk-lucht = rgb("#3FA7D6") // heldere lucht
#let vonk-druif = rgb("#9B5DE5") // speels paars
#let vonk-roze = rgb("#FF70A6") // snoeproze
#let vonk-inkt = rgb("#3B3540") // warme donkere inkt
#let vonk-inkt-zacht = rgb("#5C5566") // secundaire tekst
#let vonk-papier = rgb("#FFF9EF") // crème boekpapier

// Rouleerlijst: hoofdstuk 1 = koraal, 2 = lucht, 3 = gras, 4 = druif, 5 = roze…
#let vonk-kleuren = (vonk-koraal, vonk-lucht, vonk-gras, vonk-druif, vonk-roze, vonk-zon)

// ----------------------------------------------------------------- letterstapel
#let vonk-display = "Baloo 2" // titels: rond, dik en vriendelijk
#let vonk-body = "Andika" // lopende tekst: ontworpen voor beginnende lezers
#let vonk-hand = "Patrick Hand" // handschrift: dialoog en opdrachtjes

// ------------------------------------------------------------------- hulpjes
// Content → platte string (voor regenboogtitels).
#let to-string(content) = {
  if type(content) == str {
    content
  } else if content == none {
    ""
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join()
  } else if content.has("child") {
    to-string(content.child)
  } else if content.has("body") {
    to-string(content.body)
  } else {
    ""
  }
}

// Vijfpuntige ster, getekend (de fonts hebben geen ★-glyph).
#let ster(kleur, grootte: 12pt, draai: 0deg) = box(rotate(draai, origin: center, {
  let punten = ()
  for i in range(10) {
    let hoek = i * 36deg - 90deg
    let straal = if calc.even(i) { grootte / 2 } else { grootte / 5 }
    punten.push((grootte / 2 + straal * calc.cos(hoek), grootte / 2 + straal * calc.sin(hoek)))
  }
  polygon(fill: kleur, stroke: none, ..punten)
}))

// Rijtje van drie sterren, als versiering of scènewissel.
#let sterretjes(boven: 1.4em, onder: 1.4em) = block(above: boven, below: onder, width: 100%)[
  #align(center)[
    #ster(vonk-zon, grootte: 9pt, draai: -12deg)
    #h(8pt)
    #ster(vonk-koraal, grootte: 14pt)
    #h(8pt)
    #ster(vonk-lucht, grootte: 9pt, draai: 12deg)
  ]
]

// Titel waarvan elke letter een andere kleur krijgt. Per woord in een box,
// zodat lange titels gewoon kunnen afbreken.
#let regenboog(tekst) = {
  let i = 0
  let woorden = ()
  for woord in to-string(tekst).split(" ").filter(w => w != "") {
    let letters = ()
    for c in woord.clusters() {
      letters.push(text(fill: vonk-kleuren.at(calc.rem(i, vonk-kleuren.len())))[#c])
      i += 1
    }
    woorden.push(box(letters.join()))
  }
  woorden.join(" ")
}

// Grote gekleurde beginletter: "#groteletter[E]r was eens…"
#let groteletter(letter, kleur: vonk-koraal) = text(
  font: vonk-display,
  weight: 800,
  size: 1.9em,
  fill: kleur,
)[#letter]

// Geluidseffect: groot, gekleurd en een tikje scheef. "#knal[BOEM!]"
#let knal(inhoud, kleur: vonk-koraal, draai: -4deg, grootte: 28pt) = block(
  above: 1.2em,
  below: 1.2em,
  width: 100%,
)[
  #align(center)[
    #rotate(draai, origin: center)[
      #text(font: vonk-display, weight: 800, size: grootte, fill: kleur, tracking: 0.02em)[#inhoud]
    ]
  ]
]

// Tekstballon voor dialoog. Zonder kleur krijgt elk personage automatisch
// (en consequent) een eigen kleur, afgeleid van de naamlengte.
#let zegt(naam, lijn, kleur: auto) = {
  let k = if kleur == auto {
    vonk-kleuren.at(calc.rem(naam.clusters().len(), vonk-kleuren.len()))
  } else { kleur }
  block(breakable: false, above: 1.1em, below: 1.1em, inset: (left: 4mm))[
    #box(fill: k, radius: 999pt, inset: (x: 9pt, y: 3.5pt))[
      #text(font: vonk-display, weight: 600, size: 9.5pt, fill: white, tracking: 0.04em)[#naam]
    ]
    #v(2.5pt, weak: true)
    #block(
      fill: white,
      stroke: 1.2pt + k.lighten(35%),
      radius: (top-left: 3pt, rest: 12pt),
      inset: (x: 12pt, y: 9pt),
      width: 92%,
    )[
      #text(font: vonk-hand, size: 14pt, fill: vonk-inkt)[#lijn]
    ]
  ]
}

// "WIST JE DAT?"-kader voor leuke weetjes.
#let wistje(inhoud) = block(
  breakable: false,
  above: 1.3em,
  below: 1.3em,
  width: 100%,
  fill: vonk-lucht.lighten(82%),
  stroke: (paint: vonk-lucht, thickness: 1.4pt, dash: "dashed"),
  radius: 12pt,
  inset: (x: 14pt, y: 11pt),
)[
  #ster(vonk-lucht, grootte: 10pt)
  #h(5pt)
  #text(font: vonk-display, weight: 700, size: 10pt, fill: vonk-lucht.darken(15%), tracking: 0.06em)[WIST JE DAT?]
  #v(4pt, weak: true)
  #set text(fill: vonk-inkt)
  #inhoud
]

// Slot-ornament: sterren, "Einde." in regenboogletters en een naschriftje.
#let einde(tekst: "Einde", naschrift: "…en ze leefden nog lang en gelukkig.") = block(
  above: 2.5em,
  width: 100%,
)[
  #align(center)[
    #sterretjes(boven: 0em, onder: 0.9em)
    #text(font: vonk-display, weight: 800, size: 30pt)[#regenboog(tekst)#text(fill: vonk-zon)[.]]
    #if naschrift != none and naschrift != "" [
      #v(4pt)
      #text(font: vonk-hand, size: 14pt, fill: vonk-inkt-zacht)[#naschrift]
    ]
  ]
]

// Interne hoofdstuk-teller.
#let vonk-hoofdstuk = counter("vonk-hoofdstuk")

// ============================================================ hoofd-template
#let verhaal(
  titel: "Een verhaaltje",
  ondertitel: "",
  auteur: "Kaiyin Zhong",
  leeftijd: "4 tot 8 jaar",
  soort: "Een voorleesverhaal",
  opdracht: none,
  datum: none,
  inhoudsopgave: true,
  papier: "a4",
  body,
) = {
  let dag = if datum == none {
    datetime.today().display("[day]-[month]-[year]")
  } else { datum }

  // ---- documentbrede instellingen --------------------------------------
  set document(title: titel, author: auteur)
  set text(
    font: vonk-body,
    size: 12pt,
    fill: vonk-inkt,
    lang: "nl",
    hyphenate: false,
  )
  set par(leading: 0.8em, spacing: 1.15em, justify: false)

  // ---- inline opmaak ----------------------------------------------------
  show strong: set text(fill: vonk-inkt, weight: 700)
  show emph: it => text(fill: vonk-druif, style: "italic", it.body)
  show link: it => text(fill: vonk-lucht.darken(10%))[#underline(
      stroke: 1pt + vonk-lucht.lighten(40%),
      offset: 2pt,
    )[#it]]

  // ---- lijsten ----------------------------------------------------------
  set list(
    marker: (
      text(fill: vonk-koraal, weight: 700)[•],
      text(fill: vonk-lucht, weight: 700)[•],
      text(fill: vonk-gras, weight: 700)[•],
    ),
    indent: 4pt,
    body-indent: 8pt,
  )
  set enum(
    numbering: n => text(font: vonk-display, fill: vonk-druif, weight: 700)[#n.],
    indent: 4pt,
    body-indent: 8pt,
  )

  // ---- blockquote → "PSST!"-geheimpje ------------------------------------
  show quote.where(block: true): it => block(
    breakable: false,
    width: 100%,
    fill: vonk-roze.lighten(85%),
    stroke: (left: 3pt + vonk-roze),
    inset: (x: 15pt, y: 11pt),
    radius: (top-right: 12pt, bottom-right: 12pt),
  )[
    #text(font: vonk-display, weight: 700, size: 10pt, fill: vonk-roze.darken(15%), tracking: 0.06em)[PSST… EEN GEHEIMPJE]
    #v(4pt, weak: true)
    #set text(fill: vonk-inkt)
    #it.body
  ]

  // ---- koppen -----------------------------------------------------------
  set heading(numbering: none)

  // niveau 1 = nieuw hoofdstuk: badge + grote titel in de hoofdstukkleur
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    vonk-hoofdstuk.step()
    block(above: 0pt, below: 9mm)[
      #context {
        let n = vonk-hoofdstuk.get().first()
        let kleur = vonk-kleuren.at(calc.rem(n - 1, vonk-kleuren.len()))
        box(fill: kleur.lighten(80%), radius: 999pt, inset: (x: 11pt, y: 5pt))[
          #ster(kleur, grootte: 9pt)
          #h(5pt)
          #text(font: vonk-display, weight: 700, size: 10pt, fill: kleur.darken(12%), tracking: 0.08em)[HOOFDSTUK #n]
        ]
        v(4mm, weak: true)
        text(font: vonk-display, weight: 800, size: 27pt, fill: kleur.darken(8%), tracking: -0.01em)[#it.body]
      }
    ]
  }

  // niveau 2 = tussenkopje met gekleurd bolletje
  show heading.where(level: 2): it => block(above: 1.8em, below: 0.8em)[
    #box(baseline: -1pt, circle(radius: 3.5pt, fill: vonk-zon))
    #h(6pt)
    #text(font: vonk-display, weight: 700, size: 15pt, fill: vonk-inkt)[#it.body]
  ]

  // niveau 3 = klein kopje
  show heading.where(level: 3): it => block(above: 1.5em, below: 0.5em)[
    #text(font: vonk-display, weight: 600, size: 12.5pt, fill: vonk-inkt-zacht)[#it.body]
  ]

  // =================================================================== COVER
  page(
    paper: papier,
    fill: vonk-papier,
    margin: (top: 40mm, bottom: 28mm, left: 26mm, right: 26mm),
    header: none,
    footer: none,
    numbering: none,
  )[
    // zachte kleurvlekken in de hoeken
    #place(top + right, dx: 45mm, dy: -60mm, circle(radius: 42mm, fill: vonk-zon.lighten(78%)))
    #place(bottom + left, dx: -50mm, dy: 55mm, circle(radius: 45mm, fill: vonk-lucht.lighten(82%)))
    #place(top + left, dx: -18mm, dy: 60mm, circle(radius: 14mm, fill: vonk-roze.lighten(80%)))

    // rondgestrooide sterretjes
    #place(top + left, dx: 2mm, dy: -14mm, ster(vonk-koraal, grootte: 13pt, draai: -14deg))
    #place(top + right, dx: -8mm, dy: -6mm, ster(vonk-druif, grootte: 17pt, draai: 18deg))
    #place(top + right, dx: -30mm, dy: 12mm, ster(vonk-gras, grootte: 10pt, draai: -8deg))
    #place(bottom + right, dx: -4mm, dy: -30mm, ster(vonk-zon, grootte: 15pt, draai: 10deg))
    #place(bottom + left, dx: 6mm, dy: -12mm, ster(vonk-roze, grootte: 11pt, draai: -20deg))

    #text(font: vonk-hand, size: 15pt, fill: vonk-inkt-zacht)[#soort]

    #v(16mm)

    #block(width: 100%)[
      #set par(leading: 0.25em)
      #set text(font: vonk-display, weight: 800, size: 52pt, tracking: -0.02em)
      #regenboog(titel)#text(fill: vonk-zon)[.]
    ]

    #v(9mm)
    #block(width: 130mm)[
      #set par(leading: 0.6em)
      #text(font: vonk-body, style: "italic", size: 14pt, fill: vonk-inkt-zacht)[#ondertitel]
    ]

    #if opdracht != none [
      #v(7mm)
      #text(font: vonk-hand, size: 14pt, fill: vonk-druif)[— #opdracht —]
    ]

    #place(bottom + left, float: false)[
      #sterretjes(boven: 0em, onder: 4mm)
      #align(center)[
        #text(font: vonk-hand, size: 16pt, fill: vonk-inkt)[verteld door #auteur]
        #v(3mm, weak: true)
        #box(fill: vonk-zon, radius: 999pt, inset: (x: 12pt, y: 5pt))[
          #text(font: vonk-display, weight: 700, size: 10.5pt, fill: vonk-inkt)[voor kinderen van #leeftijd]
        ]
        #v(3mm, weak: true)
        #text(font: vonk-hand, size: 11pt, fill: vonk-inkt-zacht)[#dag]
      ]
    ]
  ]

  // ----------- pagina-setup voor alle volgende pagina's ------------------
  set page(
    paper: papier,
    fill: vonk-papier,
    margin: (top: 22mm, bottom: 24mm, left: 24mm, right: 24mm),
    footer: context {
      let n = counter(page).get().first()
      let kleur = vonk-kleuren.at(calc.rem(n, vonk-kleuren.len()))
      align(center)[
        #box(width: 19pt, height: 19pt, fill: kleur, radius: 999pt)[
          #align(center + horizon)[
            #text(font: vonk-display, weight: 700, size: 10pt, fill: white)[#n]
          ]
        ]
      ]
    },
    footer-descent: 25%,
  )

  // ====================================================== INHOUD (speels)
  if inhoudsopgave {
    context {
      let hoofdstukken = query(heading.where(level: 1))
      if hoofdstukken.len() > 1 {
        text(font: vonk-display, weight: 800, size: 30pt)[#regenboog("Waar gaan we heen")#text(fill: vonk-zon)[?]]
        v(4mm)
        text(font: vonk-hand, size: 14pt, fill: vonk-inkt-zacht)[Dit staat er allemaal in dit verhaal:]
        v(7mm)
        for (i, h) in hoofdstukken.enumerate() {
          let kleur = vonk-kleuren.at(calc.rem(i, vonk-kleuren.len()))
          block(above: 0pt, below: 5.5mm)[
            #grid(
              columns: (24pt, 1fr, auto),
              align: (left + horizon, left + horizon, right + horizon),
              box(width: 19pt, height: 19pt, fill: kleur, radius: 999pt)[
                #align(center + horizon)[#text(font: vonk-display, weight: 700, size: 10pt, fill: white)[#(i + 1)]]
              ],
              text(font: vonk-display, weight: 700, size: 13.5pt, fill: vonk-inkt)[#to-string(h.body)],
              text(font: vonk-hand, size: 12pt, fill: vonk-inkt-zacht)[bladzijde #h.location().page()],
            )
          ]
        }
      }
    }
  }

  // =============================================================== VERHAAL
  body
}

// =============================================================================
//  lib.typ  --  Zentrale Vorlage (Template) fuer die Abschlussarbeit
// -----------------------------------------------------------------------------
//  Diese Datei buendelt saemtliche Layout-Vorgaben des efi-Leitfadens der
//  TH Nuernberg an EINER Stelle. Der Inhalt (content/*.typ) bleibt dadurch frei
//  von Formatierungslogik. Die wichtigsten harten Vorgaben sind:
//    * Papier A4, Grundschrift 11pt, Serifenschrift
//    * Rand: links 3.0cm, rechts 2.0cm, oben 2.0cm, unten 3.0cm
//    * 1,5-facher Zeilenabstand, halber Absatzabstand ohne Erstzeileneinzug
//    * Kopfzeile: Kapitelname (links), Fusszeile: Seitenzahl (rechts)
//    * Kapitel starten auf neuer Seite mit Praefix "Chapter N"
//    * Abbildungen "Fig. N.M", Tabellen "Table N.M", Beschriftung ueber Tabellen
//    * Anhang mit Kapiteln "Appendix A", Seitenzahlen "A-1" (pro Kapitel neu)
// =============================================================================

// -- Farben (identisch zur LaTeX-Vorlage) -------------------------------------
#let grey = rgb(196, 196, 196)
#let lightgrey = rgb(226, 226, 226)
#let green = rgb(0, 176, 80)
#let red = rgb(255, 0, 0)

// -- Zustaende fuer Anhang-Umschaltung -----------------------------------------
#let in-appendix = state("in-appendix", false)

// -- Kleine Textbausteine (entsprechen den LaTeX-\newcommand-Makros) ----------
#let ua = [u.\u{202f}a.\u{00a0}]
#let zB = [z.\u{202f}B.\u{00a0}]
#let dahe = [d.\u{202f}h.,\u{00a0}]
#let bzw = [bzw.\u{00a0}]
#let bzgl = [bzgl.\u{00a0}]
#let eg = [e.\u{202f}g.\u{00a0}]
#let ie = [i.\u{202f}e.\u{00a0}]
#let wrt = [w.\u{202f}r.\u{202f}t.\u{00a0}]
#let etal = [_et\u{202f}al._\u{00a0}]

// -- Hilfsfunktion: Codeblock als nummeriertes, gerahmtes Listing --------------
//    Nutzt den normalen Raw-Flow (kann ueber Seiten umbrechen) und setzt
//    optional eine nummerierte Listing-Beschriftung darunter.
#let breakable-code-listing(body, caption: none, label: none) = context {
  let content = if caption != none {
    let c = counter(figure.where(kind: "listing"))
    let idx = c.get().first() + 1
    c.step()
    let ch = counter(heading).get().first()
    let pat = if in-appendix.get() { "A.1" } else { "1.1" }
    let num = numbering(pat, ch, idx)
    let entry = metadata((kind: "listing-entry", caption: caption, num: num))
    let cap = align(center)[
      #block(above: 0.7em, below: 0pt)[
        #text(weight: "bold")[Listing #num:]
        #caption
      ]
    ]
    if label != none { [#entry #body #cap #label] } else { [#entry #body #cap] }
  } else if label != none {
    [#body #label]
  } else {
    body
  }

  block(above: 1.6em, below: 3.0em, content)
}

// -- Externe Grafik einbinden ------------------
//    width als Bruchteil der Textbreite
#let fig-image(path, width: 100%, caption: none, label: none, ..args) = {
  let f = figure(image(path, width: width, ..args), caption: caption)
  if label != none { [#f #label] } else { f }
}

// =============================================================================
//  Titelseiten (Binding-Cover + Cover)
// =============================================================================
// Haelt eine Zeile immer einzeilig: ist der Text breiter als die Spalte, wird
// er minimal herunterskaliert
#let fit-line(size, body) = layout(dim => {
  let m = measure(text(size: size)[#body])
  let f = if m.width > dim.width { dim.width / m.width } else { 1.0 }
  text(size: size * f)[#body]
})

#let binding-cover(logo: none, hochschule: [], fakultaet: [], studiengang: [],
                   artderarbeit: [], autorBinding: [], titel: [], semester: []) = {
  set page(numbering: none, header: none, footer: none)
  set align(center)
  // 1,5-facher Zeilenabstand innerhalb mehrzeiliger Bloecke;
  // Absatzabstand aus, damit nur die expliziten v()-Abstaende wirken.
  set par(justify: false, leading: 0.9em, spacing: 0pt)
  if logo != none { image(logo, width: 60%) }
  v(1.3cm)
  fit-line(0.22in, hochschule)
  v(1.4em, weak: true)
  fit-line(0.22in, fakultaet)
  v(1.55cm)
  fit-line(0.22in, [Studiengang #studiengang])
  v(1.55cm)
  fit-line(0.22in, [#artderarbeit#sym.space.thin von])
  v(1.5em, weak: true)
  fit-line(0.22in, autorBinding)
  v(2.1cm)
  text(size: 0.27in, weight: "bold")[#titel]
  v(1.7cm)
  fit-line(0.22in, semester)
  pagebreak(weak: false)
  // Leerseite
  pagebreak(weak: false)
}

#let cover(logo: none, hochschule: [], fakultaet: [], studiengang: [],
           vertiefung: [], artderarbeit: [], autor: [], matrikelnr: [],
           titel: [], semester: [], abgabedatum: [], erstgutachter: [],
           zweitgutachter: [], betreuer: [], unternehmen: [], schlagworte: []) = {
  set page(numbering: none, header: none, footer: none)
  set par(justify: false, leading: 0.9em, spacing: 0pt)
  align(center)[
    #image(logo, width: 60%)
    #v(1.3cm)
    #fit-line(0.22in, hochschule)
    #v(1.4em, weak: true)
    #fit-line(0.22in, fakultaet)
    #v(1.45cm)
    #fit-line(0.20in, [Studiengang #studiengang])
    #v(1.10em, weak: true)
    #fit-line(0.20in, [Vertiefungsrichtung #vertiefung])
    #v(1.45cm)
    #fit-line(0.20in, [#artderarbeit#sym.space.thin von])
    #v(1.40em, weak: true)
    #fit-line(0.22in, autor)
    #v(0.60cm)
    #fit-line(12pt, [Matrikelnummer #matrikelnr])
    #v(2.1cm)
    #text(size: 0.27in, weight: "bold")[#titel]
    #v(2.1cm)
    #text(size: 0.20in)[#semester]
    #v(1.0em, weak: true)
    #text(size: 0.20in)[Abgabedatum: #abgabedatum]
  ]
  v(1fr)
  align(center)[
    #set text(size: 12pt)
    #set par(leading: 0.65em)
    #table(
      columns: (3cm, 11.5cm),
      stroke: none,
      align: (left, left),
      inset: (x: 0pt, y: 7.5pt),
      [Erstgutachter:], [#h(0.5cm) #erstgutachter],
      [Zweitgutachter:], [#h(0.5cm) #zweitgutachter],
      [Betreuer:], [#h(0.5cm) #betreuer],
      [Unternehmen:], [#h(0.5cm) #unternehmen],
      [Schlagworte:], [#h(0.5cm) #schlagworte],
    )
  ]
  pagebreak(weak: false)
}

// =============================================================================
//  Haupttemplate
// =============================================================================
#let thesis(
  titel: [],
  autor: "",
  keywords: (),
  body,
) = {
  // -- Dokument-Metadaten --------
  set document(title: titel, author: autor, keywords: keywords)

  // -- Grundschrift & Sprache -------------------------------------------------
  // set text(font: "New Computer Modern", size: 11pt, lang: "de", region: "DE")
  set text(font: "New Computer Modern", size: 11pt, lang: "en", region: "US")

  // -- Seitenmasse (efi-Vorgabe) ----------------------------------------------
  // 2.1cm statt 2.0cm bei top durch Abgleich mit Latex
  set page(
    paper: "a4",
    margin: (left: 3.0cm, right: 2.0cm, top: 2.1cm, bottom: 3cm),
  )

  // -- 1,5-facher Zeilenabstand, halber Absatzabstand, kein Erstzeileneinzug --
  set par(justify: true, leading: 0.815em, spacing: 1.40em, first-line-indent: 0pt)

  // -- Witwen/Waisen unterdruecken ---------
  set par(linebreaks: "optimized")

  // -- Ueberschriften nummerieren (bis Ebene 3) ---------------
  set heading(numbering: "1.1")

  // -- Formeln: kapitelweise nummerieren (z.B. 2.1) -------------
  show math.equation.where(block: true): set math.equation(numbering: (..n) => context {
    let ch = counter(heading).get().first()
    let pat = if in-appendix.get() { "(A.1)" } else { "(1.1)" }
    numbering(pat, ch, ..n)
  })

  // -- Abbildungen: "Fig.", Tabellen: "Table"; Nummerierung je Kapitel --------
  set figure(numbering: (..n) => context {
    let ch = counter(heading).get().first()
    let pat = if in-appendix.get() { "A.1" } else { "1.1" }
    numbering(pat, ch, ..n)
  })
  show figure.where(kind: image): set figure(supplement: [Fig.])
  show figure.where(kind: table): set figure(supplement: [Table])
  // Tabellenbeschriftung unterhalb der Tabelle
  show figure.where(kind: table): set figure.caption(position: bottom)
  show figure.where(kind: table): set figure(gap: 0.6em)
  show figure.where(kind: "listing"): set figure.caption(position: bottom)
  // Etwas Luft ober-/unterhalb jeder Abbildung/Tabelle
  show figure: set block(above: 1.6em, below: 3.0em)
  show figure.caption: it => [
    #text(weight: "bold")[#it.supplement #context it.counter.display(it.numbering):]
    #it.body
  ]

  // -- Tabellen: schlanke Linien, zentriert -----------------------------------
  set table(stroke: 0.5pt, align: center + horizon, inset: (x: 6pt, y: 4.5pt))

  // -- Nummerierte + Aufzaehlungslisten dezent --------------------------------
  set enum(indent: 0.5em)
  set list(indent: 1.0em, spacing: 1.6em, marker: ([•], [--], [·]))

  // -- Codebloecke: gerahmt mit Zeilennummern -------------
  show raw.where(block: true): it => block(
    width: 100%,
    fill: white,
    stroke: 0.6pt,
    inset: 6pt,
    radius: 0pt,
    text(size: 9pt, {
      set par(justify: false, leading: 0.55em)
      set align(left)
      grid(
        columns: (auto, 1fr),
        column-gutter: 8pt,
        row-gutter: 0.55em,
        ..it.lines.map(l => (
          align(right, text(fill: rgb(90, 90, 90))[#l.number]),
          l.body,
        )).flatten()
      )
    })
  )
  show raw.where(block: false): it => box(
    fill: luma(245), inset: (x: 2pt), outset: (y: 2pt), radius: 1pt, it,
  )

  // -- Links dezent --------------
  show link: it => text(fill: black, it)
  show ref: it => text(fill: black, it)
  show cite: it => text(fill: black, it)

  let last-block-kind = state("last-block-kind", "other")

  // Markiere Fließtext
  show par: it => {
    last-block-kind.update("text")
    it
  }

  // Markiere Nicht-Text (damit "direkt nach Text" sauber bleibt)
  show heading: it => {
    last-block-kind.update("other")
    it
  }
  show figure: it => {
    last-block-kind.update("other")
    it
  }
  show list: it => {
    last-block-kind.update("other")
    it
  }
  show enum: it => {
    last-block-kind.update("other")
    it
  }

  // -- Kapitel (Ebene-1-Ueberschrift): neue Seite + Praefix "Chapter N" -------
  show heading.where(level: 1): it => context {
    // Abbildungs-/Tabellen-/Listing-Zaehler je Kapitel zuruecksetzen
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: "listing")).update(0)
    counter(math.equation.where(block: true)).update(0)

    let appendix = in-appendix.at(here())

    pagebreak(weak: true)
    // Im Anhang Seitenzaehler pro Kapitel neu bei 1 beginnen (A-1, B-1, ...)
    // WICHTIG: erst nach dem Seitenumbruch zuruecksetzen.
    if appendix { counter(page).update(1) }
    v(2.3cm)
    block(above: 0pt, below: 1.6em, {
      if it.numbering != none {
        text(size: 0.24in, weight: "bold")[Chapter #counter(heading).display()]
        v(0.45cm, weak: false)
      }
      text(size: 0.24in, weight: "bold")[#it.body]
    })
    v(1.4cm, weak: true)
  }

  // -- Ueberschriftgroessen (11pt-Basis) -------------

  show heading.where(level: 2): it => context {
    block(above: 2.5em, below: 2.0em, {
      text(size: 0.20in)[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.2em)
        }
        #it.body
      ]
    })
  }
  
  show heading.where(level: 3): it => context {
    let extra = if last-block-kind.at(here()) == "text" { 1.4em } else { 0em }
    last-block-kind.update("other")

    block(above: 1.6em + extra, below: 1.95em, {
      text(size: 12pt)[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.2em)
        }
        #it.body
      ]
    })
  }

  show heading.where(level: 4): it => context {
    block(above: 2.9em, below: 2.1em, {
      text(size: 11pt)[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.2em)
        }
        #it.body
      ]
    })
  }
  
  // -- Kopf-/Fusszeile ---------------------------------------------------------
  //    Kopf: aktueller Kapitelname (nicht auf Kapitel-Startseiten).
  //    Fuss: Seitenzahl rechts.
  set page(
    header-ascent: 47.5%,
    footer-descent: 47.5%,
    header: context {
      let pg = here().page()
      let chapters = query(heading.where(level: 1))
      let current = none
      for h in chapters {
        if h.location().page() <= pg { current = h }
      }
      let starts-here = chapters.any(h => h.location().page() == pg)
      if current != none and not starts-here {
        let appendix = in-appendix.at(current.location())
        if current.numbering == none {
          align(left, text(size: 11pt, style: "italic")[#current.body])
        } else {
          let num = counter(heading).at(current.location())
          let prefix = if appendix { [Appendix] } else { [Chapter] }
          align(left, text(size: 11pt, style: "italic")[#prefix #numbering(
            if appendix { "A" } else { "1" }, num.first()
          )#h(0.5em)#current.body])
        }
      }
    },
    footer: context {
      align(right, text(size: 11pt, style: "italic")[#counter(page).display(here().page-numbering())])
    },
  )

  body
}

// =============================================================================
//  Verzeichnisse (Inhalt, Abbildungen, Tabellen, Listings) mit Punktleader
// =============================================================================
// Standortkorrekte Seitenzahl (Anhang: "A-1", sonst regulaere Nummerierung).
// Im Anhang wird die physische Seite RELATIV zum Start des jeweiligen
// Anhang-Kapitels berechnet, damit jedes Kapitel wieder bei 1 beginnt (A-1, B-1).
#let loc-pageno(loc, apx-chaps: ()) = {
  if in-appendix.at(loc) {
    let ln = calc.max(counter(heading).at(loc).first(), 1)
    let start = loc.page()
    for h in apx-chaps {
      if h.location().page() <= loc.page() { start = h.location().page() }
    }
    [#numbering("A", ln)-#(loc.page() - start + 1)]
  } else {
    numbering(loc.page-numbering(), ..counter(page).at(loc))
  }
}

// Eigenes Inhaltsverzeichnis:
//   * Kapitelzeilen fett, mit etwas Abstand davor
//   * Ebenen 1-3 (Kapitel, Section, Subsection)
//   * Punktleader, standortkorrekte Anhang-Seitenzahlen (B-1, C-1, ...)
#let table-of-contents() = {
  heading(level: 1, numbering: none, outlined: false)[Contents]
  v(1.3em)
  context {
    let items = query(heading.where(outlined: true))
    let apx = query(heading.where(level: 1)).filter(h => in-appendix.at(h.location()))
    for hd in items {
      if hd.level > 3 { continue }
      let loc = hd.location()
      let appendix = in-appendix.at(loc)
      let nums = counter(heading).at(loc)
      let num = if hd.numbering != none {
        if appendix { numbering("A.1.1", ..nums) } else { numbering("1.1.1", ..nums) }
      } else { none }
      let pageno = loc-pageno(loc, apx-chaps: apx)
      let bold = hd.level == 1
      let leader = box(width: 1fr, inset: (bottom: 2pt), repeat[.#h(3.5pt)])
      block(
        above: if hd.level == 1 { 1.55em } else { 0.65em },
        below: 0.35em,
        text(weight: if bold { "bold" } else { "regular" })[
          #grid(
            columns: (auto, 1fr, auto),
            column-gutter: 0.5em,
            {
              if num != none { box(num); h(0.9em) }
              link(loc, hd.body)
            },
            align(bottom, leader),
            align(bottom, link(loc, pageno)),
          )
        ],
      )
    }
  }
}

// Standortkorrektes Verzeichnis fuer Abbildungen/Tabellen/Listings.
// (Nummer und Seitenzahl werden an der ELEMENT-Position bestimmt, damit sie
//  auch im Anhang korrekt als "A.1" bzw. "A-1" erscheinen.)
#let figure-list(kind) = context {
  let apx = query(heading.where(level: 1)).filter(h => in-appendix.at(h.location()))
  if kind == "listing" {
    let entries = query(metadata).filter(m => m.value.kind == "listing-entry" and m.value.caption != none)
    for e in entries {
      let loc = e.location()
      let num = e.value.num
      let pageno = if in-appendix.at(loc) {
        let ln = calc.max(counter(heading).at(loc).first(), 1)
        let start = loc.page()
        for h in apx { if h.location().page() <= loc.page() { start = h.location().page() } }
        [#numbering("A", ln)-#(loc.page() - start + 1)]
      } else {
        numbering(loc.page-numbering(), ..counter(page).at(loc))
      }
      block(above: 0.6em, below: 0.6em, grid(
        columns: (auto, 1fr, auto),
        column-gutter: 0.5em,
        link(loc, [#num #h(0.6em) #e.value.caption]),
        align(bottom, box(width: 100%, inset: (bottom: 2pt), repeat[.#h(3pt)])),
        align(bottom, link(loc, pageno)),
      ))
    }
  } else {
    let figs = query(figure.where(kind: kind))
    for f in figs {
      let loc = f.location()
      let ch = counter(heading).at(loc).first()
      let pat = if in-appendix.at(loc) { "A.1" } else { "1.1" }
      let num = numbering(pat, ch, counter(figure.where(kind: kind)).at(loc).first())
      let pageno = if in-appendix.at(loc) {
        let ln = calc.max(counter(heading).at(loc).first(), 1)
        let start = loc.page()
        for h in apx { if h.location().page() <= loc.page() { start = h.location().page() } }
        [#numbering("A", ln)-#(loc.page() - start + 1)]
      } else {
        numbering(loc.page-numbering(), ..counter(page).at(loc))
      }
      block(above: 0.6em, below: 0.6em, grid(
        columns: (auto, 1fr, auto),
        column-gutter: 0.5em,
        link(loc, [#num #h(0.6em) #f.caption.body]),
        align(bottom, box(width: 100%, inset: (bottom: 2pt), repeat[.#h(3pt)])),
        align(bottom, link(loc, pageno)),
      ))
    }
  }
}

#let list-of-figures() = {
  heading(level: 1, numbering: none)[List of Figures]
  figure-list(image)
}
#let list-of-tables() = {
  heading(level: 1, numbering: none)[List of Tables]
  figure-list(table)
}
#let list-of-listings() = {
  heading(level: 1, numbering: none)[List of Listings]
  figure-list("listing")
}

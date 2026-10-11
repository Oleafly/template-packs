// =============================================================
// template.typ – Kernkonfiguration: Seite, Schriften, Kopf/Fuß
// Entspricht: setup.tex + layout.tex + style.tex (Struktur)
// =============================================================

#import "colors.typ": *

// =============================================================
// INHALTSVERZEICHNIS-HILFSFUNKTIONEN
// =============================================================

/// Standard-Inhaltsverzeichnis
#let toc() = {
  show <hide-in-outline>: none
  heading(level: 1, numbering: none, outlined: false)[Inhaltsverzeichnis]

  outline(
    title: none,
    indent: 0pt,
    depth: 2,
  )
}

/// Abbildungsverzeichnis
#let lof() = {
  show <hide-in-outline>: none
  heading(level: 1, numbering: none, outlined: true)[Abbildungsverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: image),
  )
}

/// Tabellenverzeichnis
#let lot() = {
  show <hide-in-outline>: none
  heading(level: 1, numbering: none, outlined: true)[Tabellenverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: table),
  )
}

/// Codeverzeichnis
#let loc() = {
  show <hide-in-outline>: none
  heading(level: 1, numbering: none, outlined: true)[Codeverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: raw),
  )
}

/// Anhang-Bereich einleiten – Aufruf via `#show: appendix-start` in main.typ
#let appendix-start(body) = {
  show heading: set heading(numbering: "A.1")
  show heading.where(level: 2): set heading(outlined: false)
  counter(heading).update(0)
  state("is_appendix", false).update(true)
  body
}

/// Aktuelle Seite als leer markieren (keine Kopf/Fußzeile)
#let this-page-empty() = {
  set page(header: none, footer: none)
}

// =============================================================
// HAUPT-TEMPLATE-FUNKTION
// Aufruf in main.typ: #show: template.with(meta: meta)
// =============================================================

#let template(
  meta: (:),    // Dictionary mit Metadaten aus metadata.typ
  is-print: false, // Doppelseiten-Layout: Kapitel starten auf ungerader Seite
  is-draft: false, // ENTWURF-Wasserzeichen auf jeder Seite anzeigen
  body,
) = {
  // --- Dokument-Metadaten ---
  set document(
    title: meta.at("mytitle", default: "Titel der Arbeit"),
    author: meta.at("myname", default: "Autor"),
  )

  // --- Seiten-Grundkonfiguration ---
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 30mm, top: 25mm, bottom: 30mm),

    // Zweiseitige Kopfzeile (gerade/ungerade Seiten)
    header: context {
      let phys-page = here().page()
      let is-odd = calc.odd(phys-page)

      let all-headings = query(heading)
      let on-page = all-headings.filter(h => h.location().page() == phys-page)
      let before-page = all-headings.filter(h => h.location().page() < phys-page)

      // Smart Empty Page Detection:
      // Wenn wir auf einer GERADEN Seite (links) sind, die KEINE Überschrift hat
      // und direkt danach (auf der nächsten Seite) ein neues Kapitel (Level 1) beginnt,
      // ist dies eine Füllseite -> Kopfzeile ausblenden.
      // Nur im Druck-Modus relevant.
      let is-filler = false
      if is-print {
        let next-h1 = query(heading.where(level: 1).after(here()))
        is-filler = (
          not is-odd and on-page.len() == 0 and next-h1.len() > 0 and next-h1.first().location().page() == phys-page + 1
        )
      }

      if is-filler { return [] }

      let header-title = if on-page.len() > 0 {
        let min-lvl = on-page.fold(999, (acc, h) => calc.min(acc, h.level))
        on-page.filter(h => h.level == min-lvl).first().body
      } else if before-page.len() > 0 {
        before-page.last().body
      } else { [] }

      set text(size: 9pt, fill: secondary)
      stack(
        dir: ttb,
        spacing: 3pt,
        // Titel an der Außenseite: rechts (ungerade) / links (gerade)
        if is-odd {
          align(right)[#header-title]
        } else {
          align(left)[#header-title]
        },
        line(length: 100%, stroke: 0.5pt + lightgray),
      )
    },

    footer: context {
      let phys-page = here().page()
      let is-odd = calc.odd(phys-page)

      // Filler-Check (analog zur Kopfzeile)
      let is-filler = false
      if is-print {
        let next-h1 = query(heading.where(level: 1).after(here()))
        is-filler = (
          not is-odd
            and query(heading).filter(h => h.location().page() == phys-page).len() == 0
            and next-h1.len() > 0
            and next-h1.first().location().page() == phys-page + 1
        )
      }

      if is-filler { return [] }

      set text(size: 9pt, fill: secondary)
      stack(
        dir: ttb,
        spacing: 3pt,
        line(length: 100%, stroke: 0.5pt + lightgray),
        // Seitenzahl an der Außenseite: rechts (ungerade) / links (gerade)
        if is-odd {
          align(right)[#counter(page).display()]
        } else {
          align(left)[#counter(page).display()]
        },
      )
    },

    background: if is-draft {
      rotate(-45deg, text(100pt, fill: rgb("#eeecec"))[*ENTWURF*])
    },

    numbering: "1",
  )

  // --- Schriftarten ---
  // Standardmäßig werden Libertinus Serif / New Computer Modern verwendet.
  // Falls Bookerly (aus /fonts) genutzt werden soll, muss beim Kompilieren:
  // typst compile --font-path fonts main.typ verwendet werden.
  set text(
    font: ("Libertinus Serif", "New Computer Modern"),
    size: 11pt,
    lang: "de",
    fill: black,
    hyphenate: true,
  )

  set par(
    justify: true,
    leading: 0.65em,
    spacing: 0.85em,
    first-line-indent: 0pt,
  )
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => context {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    if is-print and it.numbering == none {
      pagebreak(to: "odd", weak: true)
    } else {
      pagebreak(weak: true)
    }
    text(size: 22pt, weight: "bold", fill: headingcolor)[
      #if it.numbering != none {
        let num = numbering(it.numbering, ..counter(heading).at(here()))
        // Falls die Nummerierung mit einem Buchstaben beginnt -> Anhang, sonst Kapitel
        let prefix = if num.match(regex("^[A-Za-z]")) != none { "Anhang " } else { "Kapitel " }
        [#prefix #num]
        v(1em, weak: true) // 1 Zeile Abstand zum Titel
      }
      #it.body
    ]
    v(1.5em, weak: false)
  }

  // Abschnitt (Level 2)
  show heading.where(level: 2): it => context {
    v(1.8em, weak: true)
    block(above: 0pt, below: 0pt)[
      #text(size: 16pt, weight: "bold", fill: headingcolor)[
        #if it.numbering != none {
          numbering(it.numbering, ..counter(heading).at(here()))
          h(0.5em)
        }
        #it.body
      ]
    ]
    v(1.2em, weak: true)
  }

  // Unterabschnitt (Level 3)
  show heading.where(level: 3): it => context {
    v(1.4em, weak: true)
    block(above: 0pt, below: 0pt)[
      #text(size: 13pt, weight: "bold", fill: headingcolor)[
        #if it.numbering != none {
          numbering(it.numbering, ..counter(heading).at(here()))
          h(0.5em)
        }
        #it.body
      ]
    ]
    v(1.0em, weak: true)
  }

  // Unter-Unterabschnitt (Level 4) – ohne Nummerierung
  show heading.where(level: 4): it => {
    v(0.8em, weak: true)
    block(above: 0pt, below: 0pt)[
      #text(size: 12pt, weight: "bold", fill: secondary)[#it.body]
    ]
    v(0.6em, weak: true)
  }

  // --- Monospace / Code ---
  show raw: set text(
    font: "DejaVu Sans Mono",
    size: 1em,
  )
  show raw: set par(leading: 0.4em, spacing: 0.4em)

  // Code-Block mit Hintergrund und Rahmen
  show raw.where(block: true): it => {
    show raw.line: it => {
      text(fill: darkgray.lighten(20%), size: 0.8em)[
        #box(width: 1.5em, align(right, [#it.number]))
        #h(1.2em)
      ]
      it.body
    }

    block(
      width: 100%,
      fill: codebackground,
      stroke: 1pt + codeborder,
      radius: 4pt,
      inset: 10pt,
      align(left, it),
    )
  }

  // --- Tabellen: booktabs-ähnlicher Stil ---
  set table(
    stroke: (_, y) => if y == 0 {
      (bottom: 1.5pt + darkgray)
    } else {
      none
    },
    inset: (x: 8pt, y: 6pt),
  )
  show table.cell.where(y: 0): set text(weight: "bold")

  // --- Abbildungen ---
  set figure(gap: 1em)
  show figure: set block(above: 2em, below: 2em)
  let fig-numbering = n => context {
    let ch = counter(heading).get().at(0, default: 0)
    let is-appx = state("is_appendix", false).get()
    let prefix = if is-appx { "A" } else { "1" }
    [#numbering(prefix, ch).#n]
  }

  show figure.where(kind: image): set figure(
    numbering: fig-numbering,
    supplement: [Abb.],
  )
  show figure.where(kind: table): set figure(
    numbering: fig-numbering,
    supplement: [Tab.],
  )
  show figure.where(kind: raw): set figure(
    numbering: fig-numbering,
    supplement: [Code],
  )
  show figure.where(kind: raw): set align(left)

  show figure.caption: it => {
    set align(center)
    text(weight: "bold", fill: headingcolor)[
      #it.supplement #context it.counter.display(it.numbering):
    ]
    h(0.4em)
    text(fill: secondary)[#it.body]
  }

  // --- Verzeichnisse (Ziel-Zustand: Exakte Ausrichtung, luftige Punkte, saubere Linien) ---
  show outline.entry: it => {
    let loc = it.element.location()
    let is-lvl1 = it.level == 1 and it.element.func() == heading

    // Formatting: Level 1 (sowie Verzeichnisse selbst) fett & textfarbe, ansonsten normal & schwarz
    let c = if is-lvl1 { headingcolor } else { black }
    let w = if is-lvl1 { "bold" } else { "regular" }

    // Etwas mehr Abstand zwischen den Zeilen für bessere Lesbarkeit
    v(if is-lvl1 { 16pt } else { 8pt }, weak: true)

    // Nummerierung extrahieren. Standard-Headings erben die Nummerierung, weshalb .has() oft fehlschlägt.
    // Unnummerierte Headings haben "numbering: none" explizit gesetzt.
    let is-numbered-heading = it.element.func() == heading and it.element.at("numbering", default: "1.1") != none
    let is-figure = it.element.func() == figure

    let is-appendix = state("is_appendix", false).at(loc)
    let num-format = if is-appendix { "A.1" } else { "1.1" }
    let prefix-format = if is-appendix { "A" } else { "1" }

    let number = if is-numbered-heading {
      numbering(num-format, ..counter(heading).at(loc))
    } else if is-figure {
      let ch = counter(heading).at(loc).at(0, default: 0)
      let num = counter(figure.where(kind: it.element.kind)).at(loc).first()
      [#numbering(prefix-format, ch).#num]
    } else { none }

    // Titel extrahieren
    let title-text = if is-figure {
      it.element.caption.body
    } else {
      it.at("body", default: it.element.body)
    }

    let page = it.page()
    let dots = box(width: 1fr, text(fill: black, weight: "regular")[#repeat[.#h(4pt)]])

    // Link umschließt Nummer + Titel + Seitenzahl, aber NICHT die Punkte (sonst blau durch show link).
    if number != none {
      grid(
        columns: (2.4em, auto, 1fr, auto),
        gutter: 0pt,
        align: (left, left, left, right),
        link(loc)[#text(fill: c, weight: w)[#number]],
        link(loc)[#text(fill: c, weight: w)[#title-text]],
        [#h(6pt) #dots],
        link(loc)[#text(fill: c, weight: w)[#page]],
      )
    } else {
      // Ohne Nummerierung (Verzeichnisse, etc.)
      grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        align: (left, left, right),
        link(loc)[#text(fill: c, weight: w)[#title-text]], [#h(6pt) #dots], link(loc)[#text(fill: c, weight: w)[#page]],
      )
    }
  }

  // --- Listen ---
  set list(
    marker: (text(fill: primary)[•], text(fill: secondary)[–], text(fill: accent)[◦]),
    indent: 1.5em,
    spacing: 0.65em, // par spacing
  )
  set enum(
    numbering: "1.",
    indent: 1.5em,
    spacing: 0.65em,
  )
  show list: set block(above: 1.2em, below: 1.2em)
  show enum: set block(above: 1.2em, below: 1.2em)
  show list: set par(spacing: 0.65em)
  show enum: set par(spacing: 0.65em)

  // --- Links farbig ---
  show link: set text(fill: primary)

  // --- Fußnoten ---
  show footnote.entry: set text(size: 9pt, fill: darkgray)

  // Inhalt ausgeben
  body
}

// lib/template.typ
// ═══════════════════════════════════════════════════════════════════════════
// LAYOUT-ENGINE der DHBW-Vorlage — hier musst du normalerweise nichts ändern.
//
// Jede Regel ist mit der Fundstelle in den "Hinweisen zur Anfertigung von
// Projekt- und Bachelorarbeiten", Version 2.0 vom 11.11.2025 (DHBW Karlsruhe,
// Studiengänge Wirtschaftsinformatik sowie Data Science und Künstliche
// Intelligenz) kommentiert — im Folgenden kurz "H".
// ═══════════════════════════════════════════════════════════════════════════

#import "titlepage.typ": titlepage
#import "components.typ": *
#import "../etc/declaration.typ": declaration
#import "../etc/blocking_notice.typ": blocking_notice

// ───────────────────────────────────────────────────────────────────────────
// Fußzeile: durchgezogener Strich + rechtsbündige Seitenzahl (H 2.1.3/2.1.4)
// ───────────────────────────────────────────────────────────────────────────
#let _footer = context {
  set text(size: 10pt)
  set par(leading: 0.5em, spacing: 0em)
  stack(
    line(length: 100%, stroke: 0.5pt),
    v(0.4em),
    align(right)[#counter(page).display()],
  )
}

#let dhbw_paper(
  // ── Angaben für Deckblatt und Erklärung (H 3.1) ──────────────────────────
  title: "",
  thesis_type: "",
  degree: "",
  faculty: "",
  course_of_studies: "",
  course: "",
  author: "",
  company: (:),
  university_advisor: "",
  submission_date: none,

  // ── Erklärung (H 3.3) ────────────────────────────────────────────────────
  declaration_location: "",
  declaration_date: none,
  signature: none,             // Pfad zum Unterschriften-Scan, z. B. "/img/unterschrift.png"
  ai_declaration: false,       // zusätzliche KI-Erklärung auf der Erklärungsseite

  // ── Sperrvermerk (H 3.2) ─────────────────────────────────────────────────
  has_blocking_notice: false,  // "Ein Sperrvermerk sollte vermieden werden." (H 3.2)

  // ── Logos (H 3.1, beide optional) ────────────────────────────────────────
  dhbw_logo: "/img/DHBW_logo.png",
  company_logo: none,          // z. B. "/img/company_logo.png"

  // ── Schrift (H 2.2/2.3) ──────────────────────────────────────────────────
  // H 2.2 nennt Times New Roman und Arial ausdrücklich. Hier steht bewusst nur
  // EINE Familie: Jede zusätzliche Angabe, die auf dem eigenen Rechner fehlt,
  // meldet Typst als Warnung. Serifenschrift gewünscht? In main.typ
  // `font: "Times New Roman"` setzen.
  // Unter Linux ist Arial meist nicht installiert — dort entweder das Paket
  // `fonts-liberation` (metrisch identisch, Familienname "Liberation Sans")
  // installieren und hier eintragen oder eine vorhandene Schrift wählen.
  font: "Arial",
  heading_font: none,          // none = wie Fließtext
  font_size: 12pt,

  // ── Verzeichnisse ────────────────────────────────────────────────────────
  outline_depth: none,         // H 3.4: none = alle Ebenen, 3 = bis Ebene 1.1.1
  abstract_src: none,          // Kurzfassung (nicht vorgeschrieben, aber üblich)
  abbreviations_src: none,     // H 3.5 (optional)
  figure_index: auto,          // H 3.6 (optional) – auto = nur wenn Abbildungen existieren
  table_index: auto,           // H 3.7 (optional) – auto = nur wenn Tabellen existieren
  glossary_src: none,          // H 3.9 (optional)
  appendix_src: none,          // H 3.10 (optional)
  attachments_src: none,       // H 3.12 Beigabenverzeichnis (optional)
  ai_usage_src: none,          // H 3.13 Hilfsmittelverzeichnis
  bibliography_path: none,     // H 3.11
  bibliography_title: "Literaturverzeichnis",
  bibliography_style: "/etc/dhbw_style.csl",
  bibliography_first: false,   // false = Reihenfolge nach H 3 (Anhang vor Literaturverzeichnis)

  // ── Kopfzeile (H 2.1.2, optional) ────────────────────────────────────────
  header_text: none,

  body,
) = {

  // ═════════════════════════════════════════════════════════════════════════
  // 1. GLOBALE FORMATIERUNG
  // ═════════════════════════════════════════════════════════════════════════
  set document(title: title, author: author)

  // H 2.2: Schriftgröße 12, deutschsprachige Silbentrennung (H 2.1.6)
  set text(
    font: font,
    size: font_size,
    lang: "de",
    region: "DE",
    hyphenate: true,
    // H 2.1.5 "Absatzkontrolle" + H 2.1.6 "nicht mehr als drei aufeinander
    // folgende Trennstriche": höhere Kosten = Typst vermeidet Trennungen,
    // Schusterjungen und Hurenkinder stärker.
    costs: (hyphenation: 200%, runt: 200%, widow: 250%, orphan: 250%),
  )

  // H 2.1.6: Blocksatz mit Silbentrennung, Zeilenabstand 1,5
  // H 2.1.5: Abstand vor Absätzen 6 Punkte
  //
  // Word und Typst messen unterschiedlich, deshalb wird der Wert hier ausgerechnet
  // statt geschätzt:
  //   Word:  Basislinienabstand = 1,5 × Einzelzeilenhöhe.
  //          Die Einzelzeilenhöhe ist schriftabhängig — Arial und Times New Roman
  //          1,15 × Schriftgrad, Calibri/Carlito 1,22 × Schriftgrad.
  //   Typst: Basislinienabstand = `leading` + Versalhöhe (Standardeinstellung
  //          `top-edge: "cap-height"`) — Arial 0,688em, Times New Roman 0,662em,
  //          Calibri/Carlito 0,644em.
  //   ⇒ leading = 1,5 × Einzelzeilenhöhe − Versalhöhe
  //
  // Beim Wechsel der Schriftart die beiden Konstanten mit anpassen; die Formel
  // liefert dann wieder einen exakten Basislinienabstand (bei Arial 12 pt genau
  // 20,70 pt, nachgemessen im PDF).
  let einzelzeile = 1.15         // Arial, Times New Roman · Calibri/Carlito: 1.22
  let versalhoehe = 0.688em      // Arial · Times New Roman: 0.662em · Carlito: 0.644em
  let zeilenabstand = 1.5 * einzelzeile * font_size - versalhoehe
  //
  // `spacing` ist in Typst der GESAMTE Abstand zwischen zwei Absätzen, nicht ein
  // Zuschlag. H 2.1.5 fordert einen "zusätzlichen 6-Punkte-Zeilenabstand der
  // ersten Zeile des neuen Absatzes" → spacing = leading + 6 pt.
  set par(
    leading: zeilenabstand,
    spacing: zeilenabstand + 6pt,
    justify: true,
    linebreaks: "optimized",
  )

  // H 2.1.6: "Bei Aufzählungen ist der linksbündige Flattersatz angebracht."
  show list: set par(justify: false)
  show enum: set par(justify: false)
  show terms: set par(justify: false)
  // Abstand zwischen Listenpunkten wie der Zeilenabstand im Fließtext
  set list(indent: 1em, spacing: zeilenabstand)
  set enum(indent: 1em, spacing: zeilenabstand)

  show link: set text(fill: rgb("#00427f"))

  // ── Überschriften (H 2.3) ────────────────────────────────────────────────
  // 16 pt / 14 pt / 12 pt, fett, keine Kursivschrift, keine Unterstreichung
  let hfont = if heading_font == none { font } else { heading_font }
  show heading: set text(font: hfont, weight: "bold", hyphenate: false)
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 3): set text(size: 12pt)
  show heading.where(level: 4): set text(size: 12pt)

  // H 2.3: Abstand davor 12–24 pt, danach 9–18 pt.
  //
  // Achtung, Typst misst anders als Word: Die Textbox einer Zeile reicht nur
  // von der Versalienoberkante bis zur Basislinie (`top-edge: "cap-height"`,
  // `bottom-edge: "baseline"`). Ober- und Unterlängen liegen AUSSERHALB der Box
  // und verbrauchen einen Teil des eingestellten Abstands. Bei 12 pt Fließtext
  // und 14 pt Überschrift gehen so rund 5,6 pt verloren.
  // Deshalb sind hier die oberen Enden der zulässigen Bereiche gesetzt:
  //   davor  24 pt → ca. 18,4 pt sichtbarer Weißraum (Absatzabstand: 13,5 pt)
  //   danach 18 pt → ca. 12,4 pt sichtbarer Weißraum
  // Damit steht die Überschrift deutlich vom vorhergehenden Text ab und der
  // Abstand zum zugehörigen Text ist erkennbar kleiner (H 2.3).
  //
  // `sticky` = "Eine Überschrift […] steht nie alleine am Ende einer Seite."
  show heading: set block(above: 24pt, below: 18pt, sticky: true)

  // H 2.3: "Bei einem neuen Hauptkapitel wird eine neue Seite begonnen."
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  // ── Verzeichnisse (H 3.4, 3.6, 3.7) ──────────────────────────────────────
  // Inhaltsverzeichnis: Hauptüberschriften hervorgehoben und mit größerem
  // Abstand (H 3.4), Seitenzahlen rechtsbündig, Führungspunkte wie im Muster.
  // Abbildungs-/Tabellenverzeichnis: "Abb. 1: Titel …… Seite" (Anhang 7).
  show outline.entry: it => {
    // H 3.4: Einträge 1,5-zeilig; innerhalb eines mehrzeiligen Eintrags
    // 1-zeilig. `leading` = Abstand IM Eintrag, `spacing` = Abstand ZWISCHEN
    // Einträgen (0,42em ≈ 5 pt ergibt zusammen wieder 1,5-zeilig).
    set par(leading: 0.65em, spacing: 0.42em)
    if it.element.func() == heading {
      if it.level == 1 {
        // H 3.4: größerer Abstand vor Hauptüberschriften und Verzeichnissen.
        // Hervorgehoben werden nur Nummer und Titel, nicht Punkte und Seitenzahl.
        v(0.5em, weak: false)
        it.indented(
          if it.prefix() == none { none } else { strong(it.prefix()) },
          strong(it.body()) + box(width: 1fr, inset: (x: 0.4em), it.fill) + it.page(),
        )
      } else { it }
    } else {
      it.indented([#it.prefix():], it.inner())
    }
  }

  // ── Abbildungen und Tabellen (H 2.5) ─────────────────────────────────────
  // Abbildungen: Unterschrift · Tabellen: Überschrift
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  // Durchgehende Nummerierung "Abb. 1 / Tab. 1" (nicht kapitelweise)
  show figure.where(kind: image): set figure(supplement: [Abb.])
  show figure.where(kind: table): set figure(supplement: [Tab.])
  show figure.where(kind: raw): set figure(supplement: [Listing])
  set figure(gap: 0.8em)
  set figure.caption(separator: ": ")
  // Eine Stufe kleiner als der Fließtext
  show figure.caption: set text(size: 11pt)
  show figure.caption: set par(justify: false, leading: 0.55em)

  // Einheitliche, platzsparende Tabellen (H 2.5)
  set table(
    inset: (x: 7pt, y: 5pt),
    stroke: 0.4pt + luma(160),
    fill: (x, y) => if y == 0 { luma(232) },
  )
  show table.cell.where(y: 0): strong

  // ── Fußnoten (H 2.4) ─────────────────────────────────────────────────────
  // Schriftgröße 10, einzeiliger Abstand, Trennstrich zum Fließtext
  set footnote.entry(
    separator: line(length: 35%, stroke: 0.5pt),
    gap: 0.5em,
    indent: 1em,
  )
  show footnote.entry: set text(size: 10pt)
  show footnote.entry: set par(leading: 0.5em, justify: true)

  // ═════════════════════════════════════════════════════════════════════════
  // 2. SEITENEINRICHTUNG (H 2.1.1, 2.1.2, 2.1.3, 2.1.7)
  // ═════════════════════════════════════════════════════════════════════════
  // Ränder: oben 2,5 · unten 2,0 · links 3,5 · rechts 2,5 cm
  // Kopf- und Fußzeile stehen 1,25 cm vom Blattrand (H 2.1.2/2.1.3). Typst
  // rechnet `ascent`/`descent` von der Randlinie in den Rand hinein, deshalb:
  //   header-ascent  = 0,83 cm → Kopfzeilentext beginnt ca. 1,25 cm von oben
  //   footer-descent = 0,3 cm  → Seitenzahl endet ca. 1,25 cm über der Unterkante
  //                              (hält zugleich Reserve für den Beschnitt, H 2.1.1)
  let _header = if header_text == none { none } else {
    // H 2.1.2: Kopfzeile mit Rahmenlinie unten (optional)
    set text(size: 10pt)
    set par(leading: 0.5em, spacing: 0em)
    stack(
      align(right)[#header_text],
      v(0.4em),
      line(length: 100%, stroke: 0.5pt),
    )
  }

  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.0cm, left: 3.5cm, right: 2.5cm),
    header-ascent: 0.83cm,
    footer-descent: 0.3cm,
  )

  // ═════════════════════════════════════════════════════════════════════════
  // 3. TITELBLATT (H 3.1) — ohne Seitenzahl, nicht mitgezählt
  // ═════════════════════════════════════════════════════════════════════════
  set page(numbering: none, header: none, footer: none)

  titlepage(
    title: title, thesis_type: thesis_type, degree: degree,
    faculty: faculty, course_of_studies: course_of_studies, course: course,
    author: author, company: company, university_advisor: university_advisor,
    submission_date: submission_date, has_blocking_notice: has_blocking_notice,
    dhbw_logo: dhbw_logo, company_logo: company_logo,
  )
  pagebreak()

  // ═════════════════════════════════════════════════════════════════════════
  // 4. SPERRVERMERK (H 3.2) — eigenes Blatt, nicht nummeriert, nicht im IHV
  // ═════════════════════════════════════════════════════════════════════════
  if has_blocking_notice {
    blocking_notice()
    pagebreak()
  }

  // ═════════════════════════════════════════════════════════════════════════
  // 5. ERKLÄRUNG (H 3.3) — nicht nummeriert, nicht im Inhaltsverzeichnis
  // ═════════════════════════════════════════════════════════════════════════
  declaration(
    declaration_location: declaration_location,
    declaration_date: declaration_date,
    signature: signature,
    ai_declaration: ai_declaration,
  )
  pagebreak()

  // ═════════════════════════════════════════════════════════════════════════
  // 6. VORSPANN: VERZEICHNISSE (H 3.4–3.7)
  //
  // Seitenzahlen: römisch (H 2.1.4 — "Das Seitenzahlen-Format römische Ziffern
  // wird für Inhalts-, Abkürzungs-, Abbildungsverzeichnisse verwendet").
  // Titelblatt, Sperrvermerk und Erklärung sind laut H 3.2/3.3 nicht in die
  // Seitennummerierung aufgenommen, verbrauchen also keine Ziffer. Die erste
  // gezählte Seite ist damit die Kurzfassung bzw. das Inhaltsverzeichnis = I.
  //
  // Reihenfolge exakt nach der Auflistung in H 3:
  //   Kurzfassung (nicht in H 3 genannt, üblich; steht vor dem IHV)
  //   3.4 Inhaltsverzeichnis      – alle nachfolgenden Elemente inkl. Anlagen
  //   3.5 Abkürzungsverzeichnis   – Abkürzung → aufgelöste Bedeutung ("BPMN =
  //                                 Business Process Model and Notation")
  //   3.6 Abbildungsverzeichnis   – "Abb. 1: Titel … Seite"
  //   3.7 Tabellenverzeichnis     – "Tab. 1: Titel … Seite"
  // ═════════════════════════════════════════════════════════════════════════
  set page(numbering: "I", footer: _footer, header: _header)
  counter(page).update(1)

  // Kurzfassung — steht vor dem Inhaltsverzeichnis und wird dort deshalb
  // nicht aufgeführt (H 3.4: das IHV listet die "nachfolgenden Elemente").
  if abstract_src != none {
    heading(level: 1, numbering: none, outlined: false)[Kurzfassung]
    abstract_src
  }

  heading(level: 1, numbering: none, outlined: false)[Inhaltsverzeichnis]
  // H 3.4: Das Inhaltsverzeichnis erfasst ALLE nachfolgenden Überschriften.
  // `outline_depth: none` = alle Ebenen; auf 3 begrenzen, wenn die vierte Ebene
  // im Verzeichnis stören würde.
  outline(title: none, indent: 1.5em, depth: outline_depth)

  // Abkürzungsverzeichnis (H 3.5, optional)
  // Hinweis: H 3.6 formuliert "Das Abbildungsverzeichnis ist dem Inhalts-
  // verzeichnis unmittelbar nachgestellt", während die Auflistung in H 3 das
  // Abkürzungsverzeichnis (3.5) davor einordnet. Die Hinweise widersprechen
  // sich hier; die Vorlage folgt der Auflistung, weil sie die Reihenfolge
  // ausdrücklich vorgibt. Wer es anders braucht, tauscht die beiden Blöcke.
  if abbreviations_src != none {
    heading(level: 1, numbering: none, outlined: true)[Abkürzungsverzeichnis]
    abbreviations_src
  }

  // Abbildungsverzeichnis (H 3.6) — unmittelbar nach dem Inhaltsverzeichnis
  context {
    let show_it = if figure_index == auto {
      query(figure.where(kind: image)).len() > 0
    } else { figure_index }
    if show_it {
      heading(level: 1, numbering: none, outlined: true)[Abbildungsverzeichnis]
      outline(title: none, target: figure.where(kind: image))
    }
  }

  // Tabellenverzeichnis (H 3.7) — unmittelbar nach dem Abbildungsverzeichnis
  context {
    let show_it = if table_index == auto {
      query(figure.where(kind: table)).len() > 0
    } else { table_index }
    if show_it {
      heading(level: 1, numbering: none, outlined: true)[Tabellenverzeichnis]
      outline(title: none, target: figure.where(kind: table))
    }
  }

  // ═════════════════════════════════════════════════════════════════════════
  // 7. TEXTTEIL (H 3.8)
  // Seitenzahlen ab hier arabisch, beginnend bei 1 (H 2.1.4).
  // ═════════════════════════════════════════════════════════════════════════
  pagebreak(weak: true)
  set page(numbering: "1", footer: _footer, header: _header)
  counter(page).update(1)
  set heading(numbering: "1.1")   // H 2.3: Dezimalgliederung

  body

  // ═════════════════════════════════════════════════════════════════════════
  // 8. NACHSPANN
  //
  // Seitenzahlen: arabisch, ohne Neustart weiterlaufend — H 2.1.4: "durchgehend
  // für Textseiten und Literaturverzeichnis sowie Anhang". Es gibt hier also
  // KEINEN Rücksprung auf römische Ziffern.
  //
  // Reihenfolge exakt nach der Auflistung in H 3 (dort sind die Bestandteile
  // "in folgender Reihenfolge einzuordnen"):
  //   3.9  Glossar (optional)     – Fachbegriff → ausformulierte Definition.
  //                                 Nicht zu verwechseln mit dem Abkürzungs-
  //                                 verzeichnis, das nur Kürzel auflöst.
  //                                 H 3.9: kann meist entfallen.
  //   3.10 Anhang (optional)      – zusätzliches Material IM Dokument: lange
  //                                 Datentabellen, Programm-Listings, Leit-
  //                                 fäden. Hinter einem Zwischenblatt "Anhang",
  //                                 je Anlage eine fortlaufende Nummer.
  //   3.11 Literaturverzeichnis   – alle im Text zitierten Quellen.
  //   3.12 Beigabenverzeichnis    – Inhaltsübersicht der SEPARAT abgegebenen
  //        (optional)               Beigaben-ZIP (Quelltexte, Projektdokumen-
  //                                 tationen, elektronische Quellen, Sonstiges).
  //                                 Die Dateien selbst sind NICHT im PDF.
  //   3.13 Hilfsmittelverzeichnis – eingesetzte KI-Werkzeuge mit Zweck, Prompt
  //                                 und Reflexion.
  //
  // Kulanz: Viele Betreuende erwarten das Literaturverzeichnis VOR dem Anhang.
  // Das ist mit `bibliography_first: true` umschaltbar und in der Praxis
  // ebenso akzeptiert — die Auflistung in H 3 ist hier die strengere Lesart.
  // ═════════════════════════════════════════════════════════════════════════
  set heading(numbering: none)

  let literatur = {
    if bibliography_path != none {
      heading(level: 1, numbering: none, outlined: true)[#bibliography_title]
      bibliography(bibliography_path, title: none, style: bibliography_style)
    }
  }

  let anhang = {
    if appendix_src != none {
      // H 3.10: "hinter einem Zwischenblatt 'Anhang'"
      heading(level: 1, numbering: none, outlined: true)[Anhang]
      pagebreak()
      // H 3.10: fortlaufende Anlagenummern, im Inhaltsverzeichnis aufgeführt.
      // Eine Überschrift der Ebene 1 im Anhang wird damit zu "Anlage 1: …";
      // tiefere Ebenen bleiben ohne Nummer und ohne Einrückung (H 2.3).
      counter(heading).update(0)
      show heading.where(level: 1): set heading(
        numbering: (..n) => "Anlage " + str(n.pos().first()) + ":",
        supplement: none,
      )
      appendix_src
    }
  }

  // Glossar (H 3.9)
  if glossary_src != none {
    heading(level: 1, numbering: none, outlined: true)[Glossar]
    glossary_src
  }

  if bibliography_first { literatur; anhang } else { anhang; literatur }

  // Beigabenverzeichnis (H 3.12)
  if attachments_src != none {
    heading(level: 1, numbering: none, outlined: true)[Beigabenverzeichnis]
    attachments_src
  }

  // Hilfsmittelverzeichnis (H 3.13) — steht am Ende der Arbeit
  if ai_usage_src != none {
    heading(level: 1, numbering: none, outlined: true)[Hilfsmittelverzeichnis]
    ai_usage_src
  }
}

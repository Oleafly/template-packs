// ##################################################
// Vorlage: enthaelt saemtliche Layout-, Schrift- und Verzeichniseinstellungen
// ##################################################

// ##################################################
// Dokumentvariablen -> hier die dokument-/personenspezifischen Angaben
// eintragen. Die HFU-Identitaet (Logo, Name, Erklaerungstexte) ist fest in der
// Vorlage hinterlegt, da dies eine HFU-Vorlage ist.
// ##################################################
// Deutsches Langdatum (z. B. "19. Juni 2026")
#let _de-monate = (
  "Januar", "Februar", "März", "April", "Mai", "Juni",
  "Juli", "August", "September", "Oktober", "November", "Dezember",
)
#let de-datum(d) = str(d.day()) + ". " + _de-monate.at(d.month() - 1) + " " + str(d.year())

#let doc = (
  // Persoenliche Daten
  vorname: "[VORNAME]",
  nachname: "[NACHNAME]",
  strasse: "[STRASSE NR.]",
  plz: "[PLZ]",
  ort: "[ORT]",
  email: "[E-MAIL]",
  matrikelnummer: "[MATRIKELNUMMER]",

  // Dokumentdaten
  title: "[TITEL DER ARBEIT]",
  untertitel: "[UNTERTITEL DER ARBEIT]",
  artDerArbeit: "[ART DER ARBEIT]",
  studiengang: "[STUDIENGANG]",
  abgabedatum: de-datum(datetime.today()),
  ersterReferent: "[ERSTER REFERENT / REFERENT:IN]",
  korreferent: "[ZWEITER REFERENT / KORREFERENT:IN]",

  // Unternehmen (fuer den Sperrvermerk; das Praxisunternehmen der Arbeit)
  unternehmen: "[UNTERNEHMEN]",
)

// ##################################################
// Klickbare Elemente umrahmen (Korrektur-/Debug-Hilfe)
//
// show-link-boxes: Hauptschalter. false -> gar keine Rahmen (Standard fuer die
// Abgabe). true -> jeder Linktyp wird gemaess link-box-styles umrahmt.
//
// link-box-styles: pro Linktyp einstellbar, ob umrahmt wird (box) und in welcher
// Farbe (color). Einzelne Typen lassen sich so gezielt aus-/einschalten oder
// umfaerben. Linktypen:
//   acronym   -- Abkuerzungen (Verweis ins Abkuerzungsverzeichnis)
//   stichwort -- Stichwoerter (Verweis ins Stichwortverzeichnis)
//   citation  -- Zitate / Quellen (Verweis ins Literaturverzeichnis)
//   crossref  -- Querverweise auf Abbildungen/Tabellen
//   url       -- externe Links (URLs)
//   outline   -- Verzeichniseintraege (Inhalts-/Abbildungs-/Tabellenverzeichnis)
// ##################################################
#let show-link-boxes = true

#let link-box-styles = (
  acronym:   (box: true, color: rgb("#cc0000")), // rot
  stichwort: (box: true, color: rgb("#d2691e")), // orange
  citation:  (box: true, color: rgb("#1a8a3a")), // gruen
  crossref:  (box: true, color: rgb("#1565c0")), // blau
  url:       (box: true, color: rgb("#7b1fa2")), // violett
  outline:   (box: true, color: rgb("#cc0000")), // rot
)

// ##################################################
// Eigene Farben
// ##################################################
#let nameColor = rgb("#525f6a")
#let codegreen = rgb(0, 153, 0)
#let codegray = rgb(128, 128, 128)
#let codepurple = rgb(128, 0, 84)
#let codepurblue = rgb(41, 0, 255)
#let backcolour = rgb(242, 242, 235)
#let lightgray = luma(217)
#let ultralightgray = luma(242)
#let mygray = luma(179)

// ##################################################
// Hilfsbefehl: Quellenangabe unter Bildern/Tabellen
// Zentrierter, unnummerierter Beschriftungstext, der NICHT im Abbildungs-/
// Tabellenverzeichnis erscheint. Direkt nach dem #figure einsetzen, dann steht
// "Quelle: ..." unter der eigentlichen Beschriftung.
// ##################################################
#let source(body) = align(center, text(size: 12pt)[Quelle: #body])

// ##################################################
// Code-Block mit Beschriftung "Codeblock N: ...".
// Eigener Zaehler (unabhaengig von Abbildungen/Tabellen). Der Code wird als
// raw-Block uebergeben (```sprache ... ``` oder #raw(..., block: true)).
// Optional eine Quellenangabe mit #source[...] direkt darunter setzen.
// ##################################################
#let listing(body, caption: none) = figure(
  body,
  caption: caption,
  kind: "listing",
  supplement: [Codeblock],
)

// ##################################################
// Theorem-aehnliche Umgebungen (je ein eigener Zaehler):
//   #beispiel[...], #definition[...], #these[...]
// Ergibt z. B. "Definition 1: ..." mit fettem Label.
// ##################################################
#let _thm(name, label-text, body) = {
  counter("thm-" + name).step()
  context block(above: 1em, below: 1em)[
    *#label-text #counter("thm-" + name).display("1"):* #body
  ]
}
#let beispiel(body) = _thm("beispiel", "Beispiel", body)
#let definition(body) = _thm("definition", "Definition", body)
#let these(body) = _thm("these", "These", body)

// ##################################################
// Unnummeriertes Kapitel (Ueberschrift ohne Nummer)
// outlined steuert den Eintrag ins Inhaltsverzeichnis
// ##################################################
// Steuert, ob Kapitel auf einer rechten (ungeraden) Seite beginnen
#let openright = state("openright", true)

#let unnumbered-chapter(title, outlined: true) = {
  // Seitenumbruch erledigt die heading-show-Regel (abhaengig von openright)
  heading(level: 1, numbering: none, outlined: outlined, title)
}

// Wie unnumbered-chapter, aber ohne erzwungene rechte Seite
// (z.B. fuer die Eidesstattliche Erklaerung)
#let plain-unnumbered-chapter(title, outlined: true) = {
  openright.update(false)
  heading(level: 1, numbering: none, outlined: outlined, title)
}

// ##################################################
// Anhang (HFU-Richtlinie 2.13): je Anhang ein eigener Buchstabe mit eigener
// Seitennummerierung (A-1, A-2, ...) und der Kopfzeile "Anhang <Buchstabe>".
//   #anhang("A", "Titel", [ ... Inhalt ... ])
// Ein leeres Trennblatt vor dem ersten Anhang in main.typ einfuegen.
// ##################################################
#let _appendix-letter = state("appendix-letter", none)

#let anhang(letter, title, body) = {
  openright.update(true)
  _appendix-letter.update(letter)
  // Seitennummerierung "<Buchstabe>-<Zahl>"
  set page(numbering: (..n) => letter + "-" + str(n.pos().first()))
  // ERST auf die neue rechte Seite umbrechen, DANN dort den Zaehler auf 1 setzen
  // (sonst verschiebt der Umbruch der Ueberschrift die erste Seite auf <Buchstabe>-2)
  pagebreak(to: "odd", weak: true)
  counter(page).update(1)
  // 1,5-zeiligen Fliesstext wiederherstellen (das Literaturverzeichnis stellt
  // davor auf einzeilig um)
  set par(leading: 1em, spacing: 1.4em)
  // Ueberschrift "Anhang A: Titel" -- ohne Kapitelnummer, mit TOC-Eintrag
  heading(level: 1, numbering: none, outlined: true)[Anhang #letter: #title]
  body
}

// ##################################################
// Kopfzeile
//   aussen  : Seitenzahl
//   innen   : aktuelles Kapitel
//   darunter: Trennlinie
// ##################################################
#let header-content = context {
  let page-num = counter(page).get().first()
  let page-numbering = here().page-numbering()
  let cur = here().page()
  // Leere openright-Fuellseite erkennen:
  // gerade Seite, keine Ueberschrift hier, aber ein Kapitel auf der Folgeseite
  let headings-here = query(heading).filter(h => h.location().page() == cur)
  let next-chapter = query(heading.where(level: 1)).filter(h => h.location().page() == cur + 1)
  let is-filler = calc.even(cur) and headings-here.len() == 0 and next-chapter.len() > 0
  // keine Kopfzeile (Titelseite ODER leere Fuellseite)
  if page-numbering != none and not is-filler {
    let num = numbering(page-numbering, page-num)

    // aktuelles Kapitel -- letzte Kapitelueberschrift, deren Seite
    // <= aktueller Seite ist (ein Kapitel, das auf DIESER Seite beginnt, zaehlt mit)
    let mark = []
    let cur = here().page()
    let chapters = query(heading.where(level: 1)).filter(h => h.location().page() <= cur)
    if chapters.len() > 0 {
      let h = chapters.last()
      if h.numbering != none {
        let n = counter(heading).at(h.location()).first()
        mark = [#n. #h.body]
      } else {
        mark = h.body
      }
    }
    // Im Anhang nur "Anhang <Buchstabe>" in der Kopfzeile (Richtlinie 2.13)
    let ap = _appendix-letter.at(here())
    if ap != none { mark = [Anhang #ap] }

    // Seitenzahl aussen, Kapitel innen
    // Kopfzeile 12pt (auf Wunsch nicht fett, abweichend von Tabelle 2)
    set text(font: "Latin Modern Sans", size: 12pt, weight: "regular")
    // Kapitelmarke und Seitenzahl an die Aussenraender schieben (h(1fr)),
    // damit die Marke die volle Breite nutzen kann und nicht umbricht.
    if calc.odd(page-num) {
      // rechte Seite: Kapitel innen (links), Seitenzahl aussen (rechts)
      block(width: 100%)[#mark #h(1fr) #num]
    } else {
      // linke Seite: Seitenzahl aussen (links), Kapitel innen (rechts)
      block(width: 100%)[#num #h(1fr) #mark]
    }
    // Trennlinie naeher an den Text ruecken
    v(-0.9em)
    line(length: 100%, stroke: 0.4pt)
  }
}

// ##################################################
// Haupt-Template: setzt alle globalen Stile
// ##################################################
#let thesis(body) = {
  // ----- PDF-Metadaten (Titel/Autor) -----
  // Optionale Versions-/Tag-Angabe aus der CI: typst compile --input version=...
  // (in den PDF-Schluesselwoertern hinterlegt, z. B. "Version v1.0.0").
  let _version = sys.inputs.at("version", default: none)
  set document(
    title: doc.title,
    author: doc.vorname + " " + doc.nachname,
    keywords: if _version != none and _version != "" {
      ("Version " + _version,)
    } else {
      ()
    },
  )

  // ----- Sprache: Deutsch -----
  set text(lang: "de", region: "DE")

  // ----- Seitenformatierung -----
  // Bundsteg 1,5cm auf die innere Marge aufgeschlagen: 2.5cm + 1.5cm
  set page(
    paper: "a4",
    binding: left,
    margin: (inside: 2.5cm + 1.5cm, outside: 2.5cm, top: 3cm, bottom: 2cm),
    header: header-content,
    // keine Fusszeile -> Standardfusszeile unterdruecken
    footer: none,
    numbering: none,
  )

  // ----- Schriften (serifenlos, 12pt) -----
  set text(
    font: "Latin Modern Sans",
    size: 12pt,
  )
  show raw: set text(font: "DejaVu Sans Mono")

  // ----- Zeilen-/Absatzabstand -----
  // 1,5-zeilig, keine Absatzeinrueckung, Leerzeile zwischen Absaetzen
  set par(leading: 1em, spacing: 1.4em, first-line-indent: 0pt, justify: true)

  // ----- Ueberschriften-Schriftgroessen (Tabelle 2) -----
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => {
    // openright: auf rechte (ungerade) Seite umbrechen, ggf. Leerseite einschieben
    context {
      if openright.get() {
        pagebreak(to: "odd", weak: true)
      } else {
        pagebreak(weak: true)
      }
    }
    // grosser Abstand oberhalb der Kapitelueberschrift. block(above:) wird am
    // Seitenanfang verschluckt, daher explizit per v() (nicht weak) einfuegen.
    v(2.3 * 1.5em, weak: false)
    // Hauptkapitelueberschrift (Ebene 1): 14pt fett (Tabelle 2)
    set text(size: 14pt, weight: "bold")
    // Abstand unterhalb der Kapitelueberschrift
    block(above: 0pt, below: 1.725 * 1.5em)[#it]
  }
  // Unterkapitelueberschrift (Ebene 2): 12pt fett (Tabelle 2)
  show heading.where(level: 2): it => {
    set text(size: 12pt, weight: "bold")
    block(above: 1.3em, below: 0.8em)[#it]
  }
  // Unterkapitelueberschrift (Ebene 3): 12pt (nicht fett) (Tabelle 2)
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "regular")
    block(above: 1.2em, below: 0.7em)[#it]
  }

  // ----- Abbildungen / Tabellen -----
  // Nummerierung global arabisch (nicht je Kapitel)
  // Beschriftung: "Abbildung 1:" bzw. "Tabelle 1:"
  set figure.caption(separator: [: ])
  // Beschriftung von Tabelle oder Abbildung: 12pt (Tabelle 2)
  show figure.caption: set text(size: 12pt, weight: "regular")
  set figure(numbering: "1")

  // ----- Fussnoten (Tabelle 2: Fussnote 10pt) -----
  show footnote.entry: set text(size: 10pt)

  // ----- Tabelleninhalt (Tabelle 2: Tabelleninhalt 10pt) -----
  show table: set text(size: 10pt)

  // ----- Formeln: abgesetzte Gleichungen nummerieren -> "(1)", referenzierbar
  set math.equation(numbering: "(1)")

  // ----- Inline-Code (`...`): dezenter Chip (wie in Markdown) -----
  show raw.where(block: false): it => box(
    fill: rgb("#eef1f4"),
    inset: (x: 4pt),
    outset: (y: 3pt),
    radius: 4pt,
    it,
  )

  // ----- Code-Bloecke: modernes, ruhiges Card-Layout -----
  // Kuehles Hellgrau, weich gerundet, gedaempfte Zeilennummern mit feinem
  // Trennstrich zur Codespalte. raw.line ist im Block geschachtelt, damit nur
  // Bloecke Zeilennummern erhalten (Inline-Code nicht).
  show raw.where(block: true): it => block(
    fill: rgb("#f6f8fa"),
    stroke: 1pt + rgb("#e6e9ee"),
    inset: (left: 0em, right: 1em, y: 0.8em),
    radius: 6pt,
    width: 100%,
    {
      set text(size: 9pt)
      set par(leading: 0.7em, justify: false)
      set align(left)
      show raw.line: l => {
        box(width: 1.6em, align(right, text(fill: rgb("#a7b0bb"), str(l.number))))
        h(0.9em)
        l.body
      }
      it
    },
  )

  // ----- Klickbare Elemente umrahmen (per show-link-boxes / link-box-styles) -----
  // Inline-Rahmen (bricht ueber Zeilen um) pro Linktyp.
  let _box(cat, it) = {
    if not show-link-boxes { return it }
    let s = link-box-styles.at(cat)
    if not s.box { return it }
    highlight(fill: none, stroke: 0.6pt + s.color, radius: 1pt, extent: 0.5pt, it)
  }
  // Links: Ziel auswerten -> Abkuerzung (acr-), Stichwort (sw-) oder URL.
  show link: it => _box(
    if type(it.dest) == label {
      let r = repr(it.dest)
      if r.starts-with("<acr-") { "acronym" } else if r.starts-with("<sw-") { "stichwort" } else { "url" }
    } else { "url" },
    it,
  )
  // Verweise: Quelle/Zitat (element == none) vs. Querverweis (Abbildung/Tabelle).
  show ref: it => _box(if it.element == none { "citation" } else { "crossref" }, it)
  // Verzeichniseintraege: ganze (klickbare) Zeile in EINEN Rahmen.
  show outline.entry: it => if show-link-boxes and link-box-styles.outline.box {
    block(stroke: 0.6pt + link-box-styles.outline.color, radius: 1pt, inset: (x: 1pt, y: 1.5pt), above: 0.5em, it)
  } else { it }

  body
}

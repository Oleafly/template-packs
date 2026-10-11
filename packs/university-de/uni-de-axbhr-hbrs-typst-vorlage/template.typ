// ─── H-BRS Informatik Dokumentvorlage ───────────────────────────────────────
// Entspricht dem LaTeX-Paket aussehen/hbrs-inf.sty.
//
// Verwendung in main.typ:
//   #import "template.typ": hbrs-template
//   #show: hbrs-template

#import "meta.typ": *

/// Hauptvorlage – wird per `#show: hbrs-template` aktiviert.
/// Setzt Schrift, Absatz, Überschriften-Abstände u. ä.
/// Das Seiten-Layout (Ränder, Kopf-/Fußzeile) wird direkt in main.typ
/// gesteuert, da verschiedene Abschnitte unterschiedliche Seitenstile haben.
#let hbrs-template(body) = {

  // ── Dokument-Metadaten ──────────────────────────────────────────────────
  set document(
    title:    thesis-title,
    author:   thesis-author,
    keywords: thesis-keywords.split(",").map(k => k.trim()),
  )

  // ── Grundlegende Schrift- und Absatzformatierung ────────────────────────
  set text(
    font:   "New Computer Modern",
    size:   11pt,
    lang:   "de",
    region: "DE",
  )

  set par(
    justify:           true,
    leading:           0.65em,
    spacing:           0.5em,
    first-line-indent: 0pt,
  )

  // ── Überschriften-Nummerierung ───────────────────────────────────────────
  set heading(numbering: "1.1")

  // ── Überschriften-Abstände (entspricht \RedeclareSectionCommand) ─────────
  show heading.where(level: 1): it => {
    block(above: 12pt, below: 5pt, it)
  }
  show heading.where(level: 2): it => {
    block(above: 11pt, below: 5pt, it)
  }
  show heading.where(level: 3): it => {
    block(above: 11pt, below: 5pt, it)
  }
  show heading.where(level: 4): it => {
    block(above: 11pt, below: 0pt, it)
  }

  // ── Abbildungs-Captions ──────────────────────────────────────────────────
  set figure(supplement: "Abbildung")
  set figure.caption(separator: ": ")

  // ── Inhalts-Verzeichnis ──────────────────────────────────────────────────
  set outline(indent: auto)

  // ── Verknüpfungen ────────────────────────────────────────────────────────
  show link: set text(fill: black)
  show ref:  set text(fill: black)

  // ── Quellcode-Blöcke ─────────────────────────────────────────────────────
  show raw.where(block: true): it => {
    block(
      fill:   luma(210),
      inset:  (x: 6pt, y: 4pt),
      radius: 3pt,
      width:  100%,
      it,
    )
  }

  body
}

// ─── Hilfs-Funktion: Seitenrahmen ────────────────────────────────────────────
/// Standard-Kopfzeile: Titel rechts mit Trennlinie.
#let page-header = context {
  let page-num = counter(page).get().first()
  if page-num > 1 {
    place(top + right, dy: -4pt, text(size: 10pt, thesis-title))
  }
}

/// Einfache Kopfzeile mit Trennlinie (für Frontmatter und Hauptteil).
#let hbrs-header = [
  #align(right, text(size: 10pt, thesis-title))
  #v(-0.5em)
  #line(length: 100%, stroke: 0.4pt)
]

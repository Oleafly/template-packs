// Zentrale Werte aus der "Richtlinie für die Erstellung wissenschaftlicher Arbeiten" der Fakultät Informatik, Hochschule Furtwangen, Januar 2024.
// Diese Datei enthält ausschließlich Werte und keine Logik.
// Die Kommentare nennen jeweils die Fundstelle in der Richtlinie.

// ── Schriftarten ────────────────────────────────────────────────────────────
// §1.3 schreibt keine konkrete Schriftfamilie vor.
// Gefordert sind eine einheitliche Schriftart und der Verzicht auf Zier- und Schmuckschrift.
// Arial ist daher eine Vorlagenentscheidung und keine Vorgabe der Richtlinie.
// Liberation Sans ist metrikkompatibel zu Arial und dient als freier Fallback.
#let schrift = ("Arial", "Liberation Sans", "Nimbus Sans", "Helvetica")

// §1.3: Ausschließlich für Quellcode ist eine zweite, nicht-proportionale Schrift zulässig.
#let schrift-mono = ("Liberation Mono", "DejaVu Sans Mono", "Consolas", "Menlo")

// ── Seitenränder ────────────────────────────────────────────────────────────
// Tabelle 1: Der Bundsteg wird auf den inneren Rand aufgeschlagen.
// Die Richtlinie verlangt Klebebindung und 1,5 cm Bundsteg.
// Abweichungen sind deshalb nur nach ausdrücklicher Rücksprache mit den Betreuer:innen zulässig.
#let rand-oben = 3cm
#let rand-unten = 2cm
#let rand-innen = 2.5cm
#let rand-aussen = 2.5cm
#let bundsteg = 1.5cm

// ── Schriftgrößen ───────────────────────────────────────────────────────────
// Tabelle 2. Die Namen entsprechen den Zeilen der Tabelle.
#let groesse = (
  art: 18pt, // Art der Arbeit
  titel: 22pt, // Titel (fett)
  untertitel: 18pt, // Untertitel
  titelblatt: 12pt, // Referent:in, Korreferent:in, Vorgelegt am / von
  h1: 14pt, // Hauptkapitelüberschrift (Ebene 1, fett)
  h2: 12pt, // Unterkapitelüberschrift (Ebene 2, fett)
  h3: 12pt, // Unterkapitelüberschrift (Ebene 3, normal)
  text: 12pt, // Fließtext, Quellenverweis
  kopfzeile: 12pt, // Kopfzeile (fett)
  beschriftung: 12pt, // Beschriftung von Tabelle oder Abbildung
  fussnote: 10pt, // Fußnote
  tabelle: 10pt, // Tabelleninhalt
  quellcode: 10pt, // nicht in der Richtlinie geregelt; wie Tabelleninhalt
)

// ── Zeilenabstand ───────────────────────────────────────────────────────────
// §1.3.2: Fließtext und Verzeichnisse 1,5-zeilig.
//
// "1,5-zeilig" ist eine Word-Angabe.
// Im Referenz-PDF der Fakultät entspricht sie gemessen 20,7 pt Grundlinienabstand bei 12 pt Schrift und damit 1,725 em.
// `layout.typ` fixiert die Zeilenbox über `top-edge` und `bottom-edge` auf exakt 1 em.
// Dadurch gilt schriftunabhängig: Grundlinienabstand = 1 em + leading.
#let zeile = 1.725em // 1,5-zeilig  = 20,7 pt bei 12 pt
#let zeile-einfach = 1.15em // 1-zeilig    = 13,8 pt bei 12 pt

// §1.2.6: Absätze werden durch Abstand und nicht durch Einzug getrennt.
// Die zusätzliche halbe Leerzeile entspricht `parskip=half` aus der LaTeX-Vorlage.
#let absatzabstand = zeile - 1em + 0.5 * zeile

// §1.3.2 und die Tabellen 6 bis 8 widersprechen sich beim Zeilenabstand der Verzeichnisse.
// §1.3.2 verlangt 1,5-zeiligen Abstand, während die Tabellen einzeiligen Abstand nennen.
// Die Vorlage priorisiert die allgemeine Vorgabe aus §1.3.2.
// Abweichungen sollten nur nach Rücksprache mit den Betreuer:innen vorgenommen werden.
#let verzeichnis-zeile = zeile

// ── Satz ────────────────────────────────────────────────────────────────────
// §1.3.2: Linksbündiger Flattersatz oder Blocksatz sind zulässig; Blocksatz wird empfohlen.
// Dieser Wert ist die Voreinstellung für den öffentlichen Parameter in `thesis.typ`.
#let blocksatz = true

// Ausrichtung von Abbildungen, Tabellen und ihren Beschriftungen.
// Die Richtlinie legt keine allgemeine horizontale Ausrichtung fest; ihre Darstellungsbeispiele sind linksbündig.
#let figur-ausrichtung = left

// ── Verzeichnisse ───────────────────────────────────────────────────────────
// Tabelle 6: maximal drei Gliederungsebenen (z. B. 1.1.2).
#let verzeichnis-tiefe = 3

// §2.5 fordert "alle Überschriften ... jedoch nicht das Titelblatt".
// Wörtlich gelesen listet das Inhaltsverzeichnis deshalb auch sich selbst auf.
#let inhaltsverzeichnis-listet-sich-selbst = true

// ── Titelblatt ──────────────────────────────────────────────────────────────
// Abbildung 4 zeigt das HFU-Logo oben rechts.
// Auf `none` setzen, um es wegzulassen.
#let logo = "/bilder/hfu-logo.svg"
#let logo-hoehe = 2cm

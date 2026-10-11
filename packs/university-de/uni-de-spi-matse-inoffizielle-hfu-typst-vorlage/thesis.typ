// ═══════════════════════════════════════════════════════════════════════════
//  Wissenschaftliche Arbeit an der Fakultät Informatik der HFU
//
//  Hier werden nur die Angaben zur Arbeit gepflegt und die Kapitel eingebunden.
//  Das Layout steckt in hfu/ und muss nicht angefasst werden.
//
//  Kompilieren:   typst compile thesis.typ
//  Live-Vorschau: typst watch thesis.typ
// ═══════════════════════════════════════════════════════════════════════════

#import "hfu/lib.typ": *
#import "inhalt/abkuerzungen.typ": abkuerzungen

// ── Bewusste Wahlmöglichkeiten ─────────────────────────────────────────────
// Die Fakultät empfiehlt IEEE oder APA; die Wahl ist mit den Betreuer:innen abzusprechen (§2.9.4).
// Typst 0.15.1 setzt "ieee" nach dem IEEE Reference Guide vom 29.11.2023 und "apa" nach APA Style, 7. Auflage, um.
#let zitierstil = "ieee" // "ieee" oder "apa"
#if not zitierstil in ("ieee", "apa") {
  panic("`zitierstil` muss `ieee` oder `apa` sein.")
}

// §1.3 schreibt keine konkrete Schriftfamilie vor.
// Erlaubt ist eine einheitliche, gut lesbare Schrift ohne Zier- oder Schmuckcharakter.
// Die zweite Auswahl wird ausschließlich für Quellcode verwendet.
#let schrift = ("Arial", "Liberation Sans", "Nimbus Sans", "Helvetica")
#let schrift-mono = ("Liberation Mono", "DejaVu Sans Mono", "Consolas", "Menlo")

#show: hfu-thesis.with(
  // ── Titelblatt (Richtlinie Tabelle 5, Abbildung 4) ────────────────────────
  // Master-Seminararbeiten und Master-Berichte benötigen das separate IEEE-Conference-Layout.
  art: "Bachelorthesis",
  studiengang: "Allgemeine Informatik",
  titel: "Titel der Arbeit",
  untertitel: "Untertitel der Arbeit", // none, wenn es keinen gibt
  referent: "Prof. Dr. Vorname Nachname",
  korreferent: "Prof. Dr. Vorname Nachname",
  ersetztes-modul: none, // nur bei Projekt- und Studienarbeiten
  vorgelegt-am: datetime(year: 2026, month: 8, day: 15),
  autor: (
    name: "Vorname Nachname",
    matrikelnummer: "123456",
    strasse: "Musterstraße 1",
    ort: "78120 Furtwangen",
    email: "vorname.nachname@hs-furtwangen.de",
  ),
  schrift: schrift,
  schrift-mono: schrift-mono,
  // §1.3.2 erlaubt Blocksatz oder linksbündigen Flattersatz und empfiehlt Blocksatz.
  blocksatz: true,

  // ── Vorspann (Richtlinie Tabelle 3) ───────────────────────────────────────
  // Das Vorwort ist optional (§2.3). Zum Verwenden auskommentieren:
  // vorwort: include "inhalt/vorwort.typ",
  vorwort: none,

  // Optional bei vertraulichen Arbeiten.
  // Varianten sind "bericht" für Praxissemesterberichte und "bachelorarbeit" für Bachelorarbeiten.
  sperrvermerk: none,
  // sperrvermerk: (
  //   firma: "Musterunternehmen GmbH",
  //   variante: "bachelorarbeit",
  // ),

  // Der Abstract ist in beiden Sprachen verpflichtend und umfasst jeweils höchstens etwa 100 bis 120 Wörter (§2.4).
  abstract-en: include "inhalt/abstract-en.typ",
  abstract-de: include "inhalt/abstract-de.typ",

  // §2.8: Abkürzungen und Langformen stehen in inhalt/abkuerzungen.typ.
  // Im Text führt #ac("HFU") die Langform automatisch bei der ersten Verwendung ein.
  abkuerzungen: abkuerzungen,

  // ── Literaturverzeichnis ──────────────────────────────────────────────────
  // Nur zitierte Einträge werden ausgegeben (§2.9.5).
  // `zitierstil` wird oben zentral zwischen IEEE und APA gewählt.
  quellen: bibliography("literatur.bib", style: zitierstil, title: none),

  // ── Anhang (§2.13, optional) ──────────────────────────────────────────────
  // Je Eintrag wird ein Anhangsteil erzeugt; die Buchstaben A, B, C … vergibt die Vorlage.
  // Umfangreicher Quellcode und Monatsberichte gehören in den Anhang.
  anhang: (
    // Bei Bedarf aktivieren, nachdem eigene Monatsberichts-PDFs abgelegt sind:
    // ("Monatsberichte", include "anhang/a-monatsberichte.typ"),
    ("Quellcode des Beispielprogramms", include "anhang/b-quellcode.typ"),
  ),
)

// ═══════════════════════════════════════════════════════════════════════════
//  Ab hier folgt der inhaltliche Teil der Arbeit (§2.10).
//  Alles andere — Titelblatt, Verzeichnisse, Versicherung und Anhang — setzt die Vorlage in der von Tabelle 3 vorgeschriebenen Reihenfolge selbst.
// ═══════════════════════════════════════════════════════════════════════════

#include "inhalt/01-einleitung.typ"
#include "inhalt/02-grundlagen.typ"
#include "inhalt/03-fazit.typ"

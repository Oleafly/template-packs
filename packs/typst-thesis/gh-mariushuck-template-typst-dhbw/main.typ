// =====================================================================
// Vorlage für eine DHBW-Arbeit (Projekt- oder Bachelorarbeit) in Typst
//
// Diese Datei enthält bewusst KEINEN Inhalt, nur die Angaben zur Arbeit
// und die Reihenfolge der Bestandteile. Text steht in kapitel/,
// Layout in vorlage/dhbw.typ.
//
// Kompilieren:   typst compile main.typ WWI00X0_Nachname_Vorname_Art.pdf
//                NIE ohne Zieldatei — der Dateiname ist vorgeschrieben,
//                `typst compile main.typ` erzeugt sonst main.pdf.
// Live-Vorschau: typst watch main.typ WWI00X0_Nachname_Vorname_Art.pdf
//
// Alles Weitere steht in README.md.
// =====================================================================

#import "vorlage/dhbw.typ": *
#import "vorlage/vorspann.typ": erklaerungen, titelblatt

// ---------------------------------------------------------------------
// Angaben zur Arbeit — die einzige Stelle, die für eine neue Arbeit
// auszufüllen ist. Titelblatt, Erklärungen und PDF-Metadaten lesen alles
// von hier.
// ---------------------------------------------------------------------
#let angaben = (
  titel: "Titel der Arbeit in einem vollständigen Satzbogen",
  // Zeilenumbruch des Themas auf dem Titelblatt. Leere Liste = Typst
  // bricht selbst um. Von Hand setzen, sobald Typst an einer unschönen
  // Stelle trennt (etwa nach einer Präposition) — dann jede Zeile als
  // eigener Eintrag. `titel` bleibt einzeilig und geht so in die
  // PDF-Metadaten.
  titel-zeilen: (),
  art: "2. Projektarbeit",
  zweck: "Im Rahmen der Prüfung zum Bachelor of Science (B. Sc.)",
  fakultaet: "Fakultät Wirtschaft",
  studiengang: "Studiengang Wirtschaftsinformatik",
  verfasser: "Nachname, Vorname",
  kurs: "WWI00X0",
  partnerunternehmen: "Musterfirma GmbH",
  // Logo des Partnerunternehmens, Pfad relativ zu vorlage/.
  // none = nur das Hochschullogo auf dem Titelblatt.
  partner-logo: "logos/dmtech.png",
  betreuung-wiss: "Nachname, Vorname",
  // none = die Zeile entfällt auf dem Titelblatt
  betreuung-betrieb: "Nachname, Vorname",
  abgabedatum: "31.08.2026",
  ort: "Karlsruhe",
  // false = kein Hinweis auf dem Titelblatt und kein Sperrvermerkblatt.
  // Ob ein Sperrvermerk nötig ist, entscheidet der Duale Partner.
  sperrvermerk: true,
)

#show: arbeit.with(angaben)

// ---------------------------------------------------------------------
// Abschnitt 1 — Vorspann, ohne Seitenzahl, nicht im Inhaltsverzeichnis
// ---------------------------------------------------------------------
#set page(numbering: none, footer: none)

#titelblatt(angaben)
#erklaerungen(angaben)

// ---------------------------------------------------------------------
// Abschnitt 2 — Verzeichnisteil, römische Seitenzahlen ab I
// ---------------------------------------------------------------------
#set page(numbering: "I", footer: fusszeile)
#counter(page).update(1)

// Reihenfolge der Verzeichnisse laut DHBW-Hinweisen: Inhalts-,
// Abkürzungs-, Abbildungs-, Tabellenverzeichnis.
#inhaltsverzeichnis()

#include "verzeichnisse/abkuerzungen.typ"

// Erscheinen nur, wenn es Abbildungen bzw. Tabellen gibt.
#figurenverzeichnis([Abbildungsverzeichnis], image)
#figurenverzeichnis([Tabellenverzeichnis], table)

// ---------------------------------------------------------------------
// Abschnitt 3 — Textteil, Anhang, Literaturverzeichnis; arabisch ab 1
// ---------------------------------------------------------------------
#set page(numbering: "1", footer: fusszeile)
#counter(page).update(1)

#include "kapitel/01-einleitung.typ"
#include "kapitel/02-grundlagen.typ"
#include "kapitel/03-hauptteil.typ"
#include "kapitel/04-schlussbetrachtung.typ"

// Der Anhang zählt nicht als Inhaltskapitel und wird deshalb mit
// Buchstaben gegliedert (A, A.1, A.2 …) statt als weiteres Kapitel.
// Zähler auf 0, damit das erste Anhangkapitel "A" heißt und nicht "E".
#set heading(numbering: "A.1")
#counter(heading).update(0)

#include "verzeichnisse/anhang.typ"

// Literaturverzeichnis.
//
// Voreingestellt ist IEEE: numerisch, sortiert nach der Reihenfolge des
// ersten Auftretens im Text — das erledigt Typst. Eine Nummernliste von
// Hand zu pflegen ist damit nicht nötig.
//
// ACHTUNG, ABZUSTIMMEN: Die DHBW-Hinweise EMPFEHLEN das Autor-Jahr-System
// mit alphabetisch sortiertem Verzeichnis, stellen die Wahl der Zitierweise
// aber ausdrücklich frei ("evtl. in Absprache mit der Betreuerin oder dem
// Betreuer"). Wer bei IEEE bleibt, sollte die Zustimmung der Betreuung
// schriftlich haben. Umstellen ist eine Zeile — statt "ieee" etwa
// "chicago-author-date", "apa" oder "harvard-cite-them-right"; die
// Locatoren in den Zitaten (@quelle[S. 12]) bleiben unverändert gültig.
#bibliography(
  "references.bib",
  title: [Literaturverzeichnis],
  style: "ieee",
  full: false, // nur zitierte Quellen; die DHBW verlangt Deckungsgleichheit
)

// Beigabenverzeichnis. Laut DHBW-Reihenfolge steht es NACH dem
// Literaturverzeichnis, nicht im Anhang — anders als das
// Hilfsmittelverzeichnis, das ausdrücklich in den Anhang gehört.
#include "verzeichnisse/beigaben.typ"

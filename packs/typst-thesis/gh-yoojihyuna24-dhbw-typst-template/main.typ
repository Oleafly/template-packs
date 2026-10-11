// ═══════════════════════════════════════════════════════════════════════════
// main.typ — KOMMANDOZENTRALE
//
// ┌─────────────────────────────────────────────────────────────────────────┐
// │ SCHRITT FÜR SCHRITT: Das musst du selbst ausfüllen                      │
// ├─────────────────────────────────────────────────────────────────────────┤
// │  1. title              Thema exakt wie angemeldet                       │
// │  2. thesis_type        "1. Projektarbeit", "2. Projektarbeit",           │
// │                        "Bachelorarbeit", "Studienarbeit", …             │
// │  3. degree             angestrebter Grad, z. B.                         │
// │                        "Bachelor of Science (B. Sc.)",                   │
// │                        "Bachelor of Arts (B. A.)",                       │
// │                        "Bachelor of Engineering (B. Eng.)"               │
// │  4. faculty            deine Fakultät, z. B. "Wirtschaft", "Technik",    │
// │                        "Sozialwesen"                                     │
// │  5. course_of_studies  dein Studiengang, genau wie im Studienvertrag    │
// │  6. course             Kursbezeichnung, z. B. "WWI24B"                  │
// │  7. author             dein vollständiger Name                          │
// │  8. company            Name, Standort und (optional) Betreuung des      │
// │                        Dualen Partners                                   │
// │  9. university_advisor wissenschaftliche Betreuung an der DHBW          │
// │ 10. submission_date    Abgabedatum                                       │
// │ 11. declaration_location  Ort für die Erklärung (dein DHBW-Standort)    │
// │ 12. declaration_date   Datum der Erklärung                              │
// │ 13. dhbw_logo          Logo deines Standorts nach img/ legen            │
// │ 14. company_logo       Firmenlogo (optional) oder none                  │
// │ 15. signature          Scan deiner Unterschrift (bei elektronischer     │
// │                        Abgabe verlangt, H 3.3)                          │
// │                                                                          │
// │ Danach: Kapitel in chapters/ schreiben, Quellen in etc/bibliography.bib │
// │ pflegen, Hilfsmittelverzeichnis in etc/ai_usage.typ ausfüllen und vor   │
// │ der Abgabe CHECKLISTE.md durchgehen.                                    │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Kompilieren: VS Code + Tinymist-Plugin, `typst watch main.typ` oder typst.app
//
// Alle Formatvorgaben (Ränder, Zeilenabstand, Schriftgrößen, Seitenzahlen,
// Reihenfolge der Bestandteile) stecken in lib/template.typ und sind dort mit
// der jeweiligen Fundstelle in den DHBW-Hinweisen kommentiert.
// ═══════════════════════════════════════════════════════════════════════════

#import "lib/template.typ": dhbw_paper

#show: dhbw_paper.with(
  // ── 1. Deine Arbeit ─────────────────────────────────────────────────────
  title: "",
  thesis_type: "",
  degree: "",
  faculty: "",
  course_of_studies: "",
  course: "",
  author: "",
  company: (
    name: "",
    location: "",
    advisor: "",     // leer lassen, wenn nicht gewünscht → Zeile entfällt
  ),
  university_advisor: "",
  submission_date: none,   // z. B. datetime(year: 2026, month: 8, day: 31)

  // ── 2. Ehrenwörtliche Erklärung (H 3.3) ─────────────────────────────────
  // Der Wortlaut ist vorgeschrieben und steckt in etc/declaration.typ.
  declaration_location: "",
  declaration_date: none,  // z. B. datetime(year: 2026, month: 8, day: 31)
  // Bei elektronischer Abgabe ist eine eingescannte Unterschrift gefordert:
  // signature: "/img/unterschrift.png",

  // ── 3. Sperrvermerk (H 3.2) ─────────────────────────────────────────────
  // "Ein Sperrvermerk sollte vermieden werden." Nur bei Bedarf auf true setzen —
  // Wortlaut und eigenes Blatt erzeugt das Template dann automatisch.
  has_blocking_notice: false,

  // ── 4. Logos (H 3.1, beide optional) ────────────────────────────────────
  dhbw_logo: "/img/DHBW_logo.png",   // Logo deines Standorts
  company_logo: none,                // z. B. "/img/company_logo.png"

  // ── 5. Bestandteile der Arbeit (H 3) ────────────────────────────────────
  // Zeilen einkommentieren, sobald du den jeweiligen Teil brauchst.
  abstract_src: include "etc/abstract.typ",           // Kurzfassung (üblich, nicht Pflicht)
  // abbreviations_src: include "etc/abbreviations.typ",  // optional (H 3.5)
  // Abbildungs- und Tabellenverzeichnis erscheinen automatisch, sobald die
  // Arbeit Abbildungen bzw. Tabellen enthält (H 3.6/3.7).
  // glossary_src: include "etc/glossary.typ",        // optional (H 3.9)
  appendix_src: include "etc/appendix.typ",           // optional (H 3.10)
  bibliography_path: "/etc/bibliography.bib",         // H 3.11
  // attachments_src: include "etc/attachments.typ",  // optional (H 3.12)
  ai_usage_src: include "etc/ai_usage.typ",           // H 3.13, Pflicht bei KI-Nutzung
)

// ═══════════════════════════════════════════════════════════════════════════
// KAPITEL — Reihenfolge hier = Reihenfolge im Dokument
// ═══════════════════════════════════════════════════════════════════════════

// Kurzanleitung mit Beispielen für Zitate, Abbildungen, Tabellen und Verweise.
// → Diese Zeile und die Datei löschen, sobald du eigene Kapitel schreibst.
#include "chapters/00_beispiele.typ"

#include "chapters/01_einleitung.typ"
#include "chapters/02_grundlagen.typ"
#include "chapters/03_analyse.typ"
#include "chapters/04_konzeption.typ"
#include "chapters/05_umsetzung.typ"
#include "chapters/06_fazit.typ"

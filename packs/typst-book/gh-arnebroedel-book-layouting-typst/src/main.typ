// main.typ — Typst Showcase v2: Medizinische Didaktik
// Final assembly — all content lives in chapter files.

#import "styles/theme.typ": *
#import "styles/typography.typ": *
#import "styles/page.typ": *

// Document metadata
#set document(
  title: "Typst Showcase v2 — Medizinische Didaktik",
  author: "Showcase Project",
  date: auto,
)

// Apply typography
#show: setup-typography()

// ── Cover (before page setup — uses zero margins) ──────────────
#include "chapters/00-cover.typ"

// ── Restore normal page setup after cover ──────────────────────
#pagebreak()
#show: setup-pages()

// ── Table of Contents ──────────────────────────────────────────
#outline(title: [Inhaltsverzeichnis], depth: 3)
#pagebreak()

// ── Part I: Grundlagen ─────────────────────────────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil I", title: [Grundlagen])
}

#include "chapters/01-intro.typ"
#include "chapters/02-typography.typ"
#include "chapters/03-structure.typ"

// ── Part II: Praxis ────────────────────────────────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil II", title: [Komponenten & Layouts])
}

#include "chapters/04-components.typ"
#include "chapters/05-layout.typ"
#include "chapters/06-advanced.typ"

// ── Part III: Erweiterbarkeit ──────────────────────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil III", title: [Erweiterbarkeit])
}

#include "chapters/08-packages.typ"
#include "chapters/09-data-driven.typ"
#include "chapters/10-tooling.typ"

// ── Part IV: Community-Pakete ──────────────────────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil IV", title: [Community-Pakete])
}

#include "chapters/11-academic.typ"
#include "chapters/12-beyond-flow.typ"
#include "chapters/13-wasm-meta.typ"
#include "chapters/14-templates.typ"
#include "chapters/18-pinit-showcase.typ"

// ── Part V: Template-Muster und Architektur ───────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil V", title: [Template-Muster und Architektur])
}

#include "chapters/15-book-patterns.typ"
#include "chapters/16-margin-patterns.typ"
#include "chapters/17-visual-hierarchy.typ"

// ── Part VI: Medizinische Fachbuch-Fähigkeiten ────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil VI", title: [Medizinische Fachbuch-Fähigkeiten])
}

#include "chapters/19-didaktik.typ"
#include "chapters/20-datenvisualisierung.typ"
#include "chapters/21-diagramme.typ"
#include "chapters/22-bildintegration.typ"

// ── Part VII: Seitengestaltung, Hintergrund & Kunststücke ─────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil VII", title: [Seitengestaltung, Hintergrund & Kunststücke])
}

#include "chapters/23-seitengestaltung.typ"
#include "chapters/24-kunststuecke.typ"

// ── Part VIII: Berufs- und Rechtskunde ────────────────────────
#{
  import "components/spreads.typ": part-page
  part-page(number: "Teil VIII", title: [Berufs- und Rechtskunde])
}

#include "chapters/25-rechtskunde.typ"

// ── Back Matter ────────────────────────────────────────────────
#include "chapters/07-backmatter.typ"

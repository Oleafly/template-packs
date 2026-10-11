// =============================================================================
// EINSTIEGSPUNKT
//
// Hier stehen nur Reihenfolge und Einbindung. Inhaltliche Werte gehoeren in
// config.typ, Layout in lib/.
//
// Kompilieren:  typst compile main.typ    Live-Vorschau:  typst watch main.typ
// =============================================================================

// Glossarium muss die aeusserste Show-Rule sein -- vor dem Template-Wrapper.
// Andernfalls findet #gls() im Fliesstext die Eintraege nicht.
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, gls, glspl
#import "acronyms.typ": entry-list
#show: make-glossary
#register-glossary(entry-list)

#import "config.typ": cfg
#import "lib/i18n.typ": t
#import "lib/template.typ": project
#import "lib/frontmatter.typ": frontmatter

#show: doc => project(cfg, doc)
#show: doc => frontmatter(
  cfg,
  confidentiality: include "chapters/00-confidentiality.typ",
  abstract: include "chapters/00-abstract.typ",
  acknowledgements: include "chapters/00-acknowledgements.typ",
  doc,
)

// --- Textteil ----------------------------------------------------------------
#include "chapters/01-introduction.typ"
#include "chapters/02-foundations.typ"
#include "chapters/03-method.typ"
#include "chapters/04-concept.typ"
#include "chapters/05-implementation.typ"
#include "chapters/06-evaluation.typ"
#include "chapters/07-discussion.typ"
#include "chapters/08-conclusion.typ"

// --- Anhang ------------------------------------------------------------------
#pagebreak()
#include "chapters/99-appendix.typ"

// --- Literaturverzeichnis ----------------------------------------------------
#pagebreak()
#bibliography("literature.bib", title: t.bibliography, style: cfg.bib_style)

// --- Erklaerungen ------------------------------------------------------------
#if cfg.sections.ai_disclosure {
  pagebreak()
  include "chapters/97-ai-disclosure.typ"
}

#if cfg.sections.declaration {
  pagebreak()
  include "chapters/98-declaration.typ"
}

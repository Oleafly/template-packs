// =============================================================================
// Internationalization and shared configuration
// =============================================================================
//
// Usage: typst compile --input lang=fr main.typ   (default)
//        typst compile --input lang=en main.typ
//
// In template files:
//   #import "i18n.typ": lang, t, _is-html, _appendix-state, reset-chapter-counters
//
// In main.typ:
//   #import "templates/i18n.typ": lang, t
//   #if lang == "en" { include "chapters/ch1.en.typ" }
//   #else { include "chapters/ch1.typ" }
// =============================================================================

#let lang = sys.inputs.at("lang", default: "fr")

/// Pick the right value based on the current language.
/// t(french-value, english-value) → value for current lang
#let t(fr, en) = if lang == "en" { en } else { fr }

// -----------------------------------------------------------------------------
// Shared configuration (used by html-overrides.typ, environments.typ, etc.)
// -----------------------------------------------------------------------------

/// HTML mode detection (passed via --input html=true)
#let _is-html = sys.inputs.at("html", default: "false") == "true"

/// State to distinguish chapters from appendices (for numbering)
#let _appendix-state = state("appendix", false)

/// Reset counters at the beginning of each chapter/appendix.
/// In HTML mode, also reset theorem environment counters.
#let reset-chapter-counters(include-theorems: false) = {
  counter(footnote).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: "algorithm")).update(0)
  counter(math.equation).update(0)
  if include-theorems {
    // TODO: adapt — list all your theorem environment identifiers here
    for id in ("theoreme", "lemme", "proposition", "corollaire", "definition",
                "thdef", "conjecture", "invariant", "remarque", "qo") {
      counter(figure.where(kind: "thm-" + id)).update(0)
    }
  }
}

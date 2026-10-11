// CONFIG - Default configuration and labels
//
// This file centralizes ALL customizable text, icons, and defaults.
// Users can override any of these when calling functions.
//
// HOW TO CUSTOMIZE:
//   Option 1: Override in function calls
//     #question(title: "Exercice")[...]
//
//   Option 2: Edit this file directly for project-wide changes
//

// Import Font Awesome for elegant icons
#import "@preview/fontawesome:0.6.0": fa-icon

// ICONS

/// Default icons for each box type.
/// Set any value to `none` to hide that icon.
///
/// -> dictionary
#let icons = (
  question:    fa-icon("circle-question"),
  response:    fa-icon("circle-check"),
  command:     fa-icon("terminal"),
  important:   fa-icon("triangle-exclamation"),
  tip:         fa-icon("lightbulb"),
  requirement: fa-icon("list-check"),
  result:      fa-icon("arrow-right"),
  scope:       fa-icon("bullseye"),
  info:        fa-icon("circle-info"),
  example:     fa-icon("book"),
)

// BOX TITLES

/// Default titles for each box type (French).
/// All are overridable per-call via the `title` parameter.
///
/// -> dictionary
#let titles = (
  question:    "Question",
  response:    "Réponse",
  command:     "Commande",
  important:   "Important",
  tip:         "Astuce",
  info:        "Information",
  requirement: "Prérequis",
  result:      "Résultat",
  scope:       "Périmètre",
  example:     "Exemple",
)

// QUESTION NUMBERING

/// Format string for question numbering.
/// Use `{num}` as placeholder for the question number.
///
/// Examples:
/// - `"Question {num}"` -> "Question 1"
/// - `"Q{num}"`         -> "Q1"
/// - `"Exercice {num}"` -> "Exercice 1"
/// - `"{num}."`         -> "1."
///
/// -> str
#let question-format = "Question {num}"

// TITLE PAGE LABELS

/// Labels shown in the metadata card on the title page.
///
/// -> dictionary
#let titlepage-labels = (
  authors: "Auteur(s)",
  group:   "Groupe",
  date:    "Date",
)

// DATE FORMAT

/// How dates are displayed throughout the document.
/// Uses Typst datetime format strings.
/// See: https://typst.app/docs/reference/foundations/datetime/#format
///
/// Examples:
/// - `"[day]/[month]/[year]"`              -> "10/12/2025"
/// - `"[month repr:long] [day], [year]"`   -> "December 10, 2025"
/// - `"[day] [month repr:short] [year]"`   -> "10 Dec 2025"
///
/// -> str
#let date-format = "[day]/[month]/[year]"

// LANGUAGE PRESETS

/// Ready-to-use language presets.
/// Use these to quickly switch all labels to a different language.
///
/// Example usage:
/// ```typst
/// #import "src/config.typ": lang-presets
/// // Then use lang-presets.en.titles.question etc.
/// ```
///
/// -> dictionary
#let lang-presets = (
  fr: (
    titles: (
      question:    "Question",
      response:    "Réponse",
      command:     "Commande",
      important:   "Important",
      tip:         "Astuce",
      info:        "Information",
      requirement: "Prérequis",
      result:      "Résultat",
      scope:       "Périmètre",
      example:     "Exemple",
    ),
    question-format: "Question {num}",
    titlepage-labels: (
      authors: "Auteur(s)",
      group:   "Groupe",
      date:    "Date",
    ),
  ),
  en: (
    titles: (
      question:    "Question",
      response:    "Answer",
      command:     "Command",
      important:   "Important",
      tip:         "Tip",
      info:        "Information",
      requirement: "Prerequisites",
      result:      "Result",
      scope:       "Scope",
      example:     "Example",
    ),
    question-format: "Question {num}",
    titlepage-labels: (
      authors: "Author(s)",
      group:   "Group",
      date:    "Date",
    ),
  ),
)

// HELPER FUNCTIONS

/// Format a question number using the configured format string.
///
/// - num (int): The question number.
/// - format (str): Format string with `{num}` placeholder.
/// -> str
#let format-question-num(num, format: question-format) = {
  format.replace("{num}", str(num))
}

/// Format a datetime using the configured format string.
///
/// - dt (datetime, str): A datetime value or string.
/// - format (str): Typst datetime format string.
/// -> str
#let format-date(dt, format: date-format) = {
  if type(dt) == datetime {
    dt.display(format)
  } else {
    dt
  }
}

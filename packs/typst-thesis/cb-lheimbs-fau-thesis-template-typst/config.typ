// Thesis Configuration
// Edit this file to customize your thesis metadata

// Thesis Information
#let thesis-title = "Your Thesis Title"
#let thesis-author-surname = "Mustermann"
#let thesis-author-given-name = "Max"
#let thesis-submission-date = datetime(year: 2026, month: 5, day: 4)
#let thesis-submission-city = "Erlangen"
#let thesis-type = "Master thesis"
#let thesis-supervisors = "Supervisor PhD\nProf. Dr. Dirk Riehle, M.B.A."

// Language: "English" or "German"
#let thesis-language = "English"

// University Information
#let university = "Friedrich-Alexander-Universität Erlangen-Nürnberg"
#let faculty = if thesis-language == "German" [Technische Fakultät] else [Faculty of Engineering]
#let department = if thesis-language == "German" [Department Informatik] else [Department Computer Science]
#let professorship = if (
  thesis-language == "German"
) [Professur für Open Source Software] else [Professorship for Open Source Software]

// Logos
#let logo-sigil = "resources/Logo_FAU_Sigil.png"
#let logo-faculty = if thesis-language == "German" { "resources/Logo_FAU_TechFak_DE.png" } else {
  "resources/Logo_FAU_TechFak_EN.png"
}

// Text labels based on language
#let appendix-name-singular = if thesis-language == "German" [Anhang] else [Appendix]
#let appendix-name-plural = if thesis-language == "German" [Anhänge] else [Appendices]
#let references-name = if thesis-language == "German" [Literaturverzeichnis] else [References]
#let acronyms-name-plural = if thesis-language == "German" [Akronyme] else [Acronyms]
#let submitted-on = if thesis-language == "German" [Eingereicht am] else [Submitted on]
#let supervisor-label = if thesis-language == "German" [Betreuer] else [Supervisor]

// Glossary/Acronym entries for the glossarium package
// Each entry needs: key (identifier), short (abbreviation), long (full form)
// Optional: description, plural, longplural, group
#let glossary-entry-list = (
  (key: "FACR", short: "FACR", long: "First Acronym"),
  // Add more acronyms here, e.g.:
  // (key: "API", short: "API", long: "Application Programming Interface"),
)

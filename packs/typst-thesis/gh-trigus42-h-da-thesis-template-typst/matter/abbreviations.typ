#import "../template.typ": acronyms-used, translated

// Reference an acronym in the text with `#acronym("api")`; Glossarium expands
// the first use and includes only referenced entries below.
#let abbreviations = (
  (key: "api", short: "API", long: "Application Programming Interface"),
  (key: "uml", short: "UML", long: "Unified Modeling Language"),
)

#let abbreviations-list() = acronyms-used(translated("abbreviations"), abbreviations)

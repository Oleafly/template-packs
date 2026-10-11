// Imports
#import "content/template.typ": *

// Create objects
#let refs = bibliography("content/bibliography.bib")
#let abs = include "content/abstract.typ"

// Header
#show: template.with(
  title: "Titolo",
  subtitle: "Sottotitolo",
  author: "Autore",
  abstract: abs,
  bib: refs,
)

// Sections
#include "content/sections/01-section.typ"
#include "content/sections/02-section.typ"

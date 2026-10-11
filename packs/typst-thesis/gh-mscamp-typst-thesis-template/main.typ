#import "content/template.typ": *

// Create objects
#let refs = bibliography("content/bibliography.bib")
#let logo = image("content/figures/logo_unimib.png", width: 35%)
#let abs = include "content/abstract.typ"
#let ack = include "content/acknowledgements.typ"

// Header
#show: template.with(
  title: "Titolo della Tesi di Laurea",
  candidate: (
    name: "Studente",
    number: "123456",
  ),
  date: "202X/202X",
  university: "Università degli Studi di Milano-Bicocca",
  school: "Scuola di X",
  department: "Dipartimento di X",
  course: "Corso di Laurea X in X",
  logo: logo,
  supervisor: "Prof.",
  co-supervisor: ("Prof.", "Prof."),
  lang: "it",
  bib: refs,
  abstract: abs,
  acknowledgements: ack,
)

// Sections
#include "content/sections/01-section.typ"
#include "content/sections/02-section.typ"

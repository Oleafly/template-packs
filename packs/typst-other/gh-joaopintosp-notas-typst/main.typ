// Import the template
#import "template.typ": *

// Additional packages
// #import "@preview/chemformula:0.1.1": ch // For writing chemical equations with #ch()
// #import "@preview/note-me:0.6.0": * // For adding callouts GitHub style with #note[], #tip[], #warning[]...

#show: project.with(
  title: "Title",
  authors: (
    "author",
  ),
  // abstract: lorem(59),
  date: "date",
)

= Introduction

#lorem(300)

== Description

#lorem(100)

=== Motivations

#lorem(100)

= Related Work

#lorem(150)

== Inspiration

#lorem(50)

// Uncomment next line for bibliography
// #bibliography("references.bib", style: "american-psychological-association", full: true)

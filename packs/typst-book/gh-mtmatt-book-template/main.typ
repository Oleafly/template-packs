#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.3.4"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#show: codly-init.with()
#codly(languages: codly-languages)
#import "@preview/theorion:0.3.3": *
#import cosmos.clouds: *
#show: show-theorion
// #import cosmos.simple: *
// #show: show-theorion
#import "@preview/lilaq:0.6.0"
#import "@preview/gentle-clues:1.3.1": *
#import "@preview/fontawesome:0.6.0": *

#import "template.typ": *
#show: conf

// Title
#title()

#outline(depth: 2, title: auto)

#include "chapters/how-to-use/ch.typ"
#include "chapters/acknowledgement.typ"

#bibliography("ref.bib", style: "ieee", full: true)

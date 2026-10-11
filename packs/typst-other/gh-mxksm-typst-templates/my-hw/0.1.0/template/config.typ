#import "meta.typ": *

#let title = "Homework " + str(hw_num)
#let authors = ("Maksim Lavrenko",)
#let font = "Linux Libertine"
#let code-font = "CMU Typewriter Text"
#let font-size = 12pt

// questions to include (0 = false, 1 = true)
#let q = (
  1,
  1,
)

// manual numbering
#let q-t = (
  "1.1",
  "1.2",
)

// sequential numbering
//#let q-t = range(q.len()).map(i => str(i+1))

#let q-counter = counter("q-counter")
#let qg = range(q.len()).map(i => q.slice(i).sum())

// include self grading
#let grading = 0

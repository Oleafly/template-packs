#import "metatheorem.typ": *

#let counter-map(..identifiers) = {
  // Create a dictionary to hold the counters
  let map = (:)
  // Process each identifier
  for identifier in identifiers.pos() {
    map.insert(
      identifier, 
      rich-counter(
        identifier: identifier,
        inherited_levels: 1
      )
    )
  }
  map
}

#let counters = counter-map(
  "theorem",
  "example",
  "corollary",
  "note",
  "definition",
  "proposition",
  "question",
  "exercise",
  "hint",
  "lemma"
)

#let theorem = metamathbox("theorem", "Theorem", rgb(13, 71, 161), counter: counters.at("theorem")) // Material Blue 900
#let example = metamathbox("example", "Example", rgb(51, 105, 30), counter: counters.at("example")) // Material Light Green 900
#let corollary = metamathbox("corollary", "Corollary", rgb(26, 35, 126), counter: counters.at("corollary")) // Material Indigo 900
#let note = metamathbox("note", "Note", rgb(0, 77, 64)) // Material Teal 900
#let definition = metamathbox("definition", "Definition", rgb(38, 50, 56), counter: counters.at("definition")) // Material Blue Grey 900
#let proposition = metamathbox("proposition", "Proposition", rgb(230, 81, 0), counter: counters.at("proposition")) // Material Orange 900
#let question = metamathbox("question", "Question", rgb(26, 35, 126), counter: counters.at("question"))
#let exercise = metamathbox("exercise", "Exercise", rgb(26, 35, 126), counter: counters.at("exercise")) 
// #let exerciseb = metamathbox("exercise", "Exercise", rgb(26, 35, 126)).with(numbering: none)
#let hint = metamathbox("hint", "Hint", rgb(26, 35, 126))
#let lemma = metamathbox("lemma", "Lemma", rgb(51, 105, 30), counter: counters.at("lemma"))

#let proof = proofblock(breakable: true)
#let proofsk = proofblock(
  blocktitle: "Proof Sketch",
  prefix: [_Proof Sketch._],
  breakable: true
)
#let solution = proofblock(
  blocktitle: "Solution",
  prefix: [_Solution._],
  breakable: true
)

#let MetaNote(
  title: none,
  authors: (),
  doc,
  head_numbering: "1.1.1.",
  head_mode: "note",
  lang: none,
  font: "FZShuSong-Z01",
  print: false
) = {
  show: great-theorems-init
  // set text(font:("Charter"))

  let head_mode_func = (mode) => {
    if head_mode == "note" {
      return head_numbering
    } else if head_mode == "book" {
      return (..nums) => {
        if nums.pos().len() == 1 {
          return "Chapter " + nums.pos().map(str).join(".") + "" + math.quad
        } else if nums.pos().len() == 2 {
          return "Section " + nums.pos().map(str).join(".") + "" + math.quad
        } else {
          return nums.pos().map(str).join(".")
        }
      }
    }
  }

  set heading(numbering: head_mode_func(head_mode))

  // set par(first-line-indent: 1em, justify: true)

  set align(center)
  text(17pt, title)

  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #author.affiliation \
      #link("mailto:" + author.email)
    ]),
  )

  set align(left)

  doc
}

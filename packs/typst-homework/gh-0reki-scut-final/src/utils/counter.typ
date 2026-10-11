#let q-counter = counter("question")
#let sq-counter = counter("subquestion")
#let c-counter = counter("choices")

#let choices = state("choices", ())
#let current-type = state("current-type", "general")
#let current-points = state("current-points", none)
#let show-points = state("show-points", false)

#let reset-all() = {
  q-counter.update(0)
  sq-counter.update(0)
  c-counter.update(0)
  choices.update(())
  current-type.update("general")
  current-points.update(none)
  show-points.update(false)
}
#let reset-c() = {
  c-counter.update(0)
  choices.update(())
}
#let reset-sq() = {
  sq-counter.update(0)
}
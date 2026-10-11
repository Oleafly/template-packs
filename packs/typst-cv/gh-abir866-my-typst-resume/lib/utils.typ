// Utilities

#let space-between(..args) = {
  args.pos().join(h(1fr))
  linebreak()
}

#let window-xp(nw: "", ne: "", sw: "", se: "") = {
  space-between(strong(nw), strong(ne))
  space-between(emph(sw), emph(se))
}

#let window-pro(nw: "", ne: "", sw: "", se: "") = {
  space-between(strong(nw), link("https://" + ne, ne))
  space-between(emph(sw), emph(se))
}

#let section(head: "", ..parts) = {
  [
    == #head
    #parts.pos().join(linebreak())
  ]
}

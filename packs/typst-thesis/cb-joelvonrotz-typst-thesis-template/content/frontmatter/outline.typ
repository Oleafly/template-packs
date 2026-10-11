#{
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): block.with(above: 1.2em)
  
  outline(target: selector(heading).before(<thesis:sec:appendix>))
}
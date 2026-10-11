#let chapters = (
  "raw.typ",
  "code.typ",
)

#chapters.map(c => include "appendix/" + c).join()


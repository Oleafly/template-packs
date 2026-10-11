#let chapters = (
  "temp.typ",
)

#chapters.map(c => include "content/" + c).join()

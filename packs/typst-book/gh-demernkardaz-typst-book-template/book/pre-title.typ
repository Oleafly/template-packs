#import "./preamble.typ": *

#component.base.pre-title(entries: (
  ("text": (
    "size": 32pt,
    "content": meta.book("series", fallback: locale.get("fallback.series")),
    "if": meta.book-has("series")
  )),
  ("text": (
    "size": 24pt,
    "content": meta.book("cycle", fallback: locale.get("fallback.cycle")),
    "if": meta.book-has("cycle")
  )),
  ("text": (
    "size": 16pt,
    "content": meta.book("title", fallback: locale.get("fallback.title"))
  )),
  ("text": (
    "size": 12pt,
    "content": () => [Том #numbering("I", meta.book("volume"))],
    "if": meta.book-has("volume") and meta.book("volume") != none
  ))
))

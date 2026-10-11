#import "theme/book.typ": techbook

#let config = toml("book.toml")
#let profile = sys.inputs.at("profile", default: "preview")

#assert(
  profile in ("preview", "print"),
  message: "profile must be 'preview' or 'print'",
)

#show: techbook.with(
  config: config,
  profile: profile,
)

#include "chapters.typ"

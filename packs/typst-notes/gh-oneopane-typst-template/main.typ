#import "template.typ": notes-template
#import "macros.typ": *

#let notes-config = toml("notes.toml")
#let metadata = notes-config.at("metadata", default: (:))
#let metadata-value(key, default: none, omit_empty: true) = {
  let value = sys.inputs.at(key, default: metadata.at(key, default: default))
  if omit_empty and value == "" { none } else { value }
}

#show: notes-template.with(
  title: metadata-value("title", default: "Notes", omit_empty: false),
  author: metadata-value("author"),
  date: metadata-value("date"),
)

#include "src/00_intro.typ"
#include "src/01_notes.typ"
#include "src/90_appendix/index.typ"

#bibliography("refs.bib")

#import "./files/pages.typ"
#import "./files/heading.typ"
#import "./files/outline.typ"
#import "./files/cover.typ"

#let apply(doc, despair-mode: false) = {
  show: pages.apply.with(despair-mode: despair-mode)
  show:  heading.apply
  show: outline.apply
  doc
}
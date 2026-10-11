#import "../config/sections.typ": list_section

#let list_of_figures() = {
  list_section("Abbildungsverzeichnis", figure.where(kind: image))
}

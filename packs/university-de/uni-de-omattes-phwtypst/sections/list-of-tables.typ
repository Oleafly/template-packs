#import "../config/sections.typ": list_section

#let list_of_tables() = {
  list_section("Tabellenverzeichnis", figure.where(kind: table))
}

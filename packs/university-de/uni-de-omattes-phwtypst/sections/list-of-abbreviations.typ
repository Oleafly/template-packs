#import "../config/sections.typ": text_section
#import "../config/abbreviations.typ": abbreviations_entries
#import "../dependencies.typ": *

#let list_of_abbreviations() = {
  text_section(
    "Abkürzungsverzeichnis",
    [
      #print-glossary(
        abbreviations_entries,
        disable-back-references: true,
      )
    ],
  )
}

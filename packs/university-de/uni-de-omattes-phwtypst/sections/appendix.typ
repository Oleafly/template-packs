#import "../config/sections.typ": appendix_section

#let appendix() = {
  appendix_section(
    "Anhang",
    [
      #include "../appendix-content.typ"
    ],
  )
}

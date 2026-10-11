#import "../config/sections.typ": text_section

#let abstract_page(content: none) = {
  if content != none {
    text_section("Abstract", content)
  }
}

// Global visual tokens. Edit this file to change the whole resume style.

#let accent = rgb("#26267d")
#let text_color = rgb("#202124")
#let muted_color = rgb("#5f6368")
#let subtle_color = rgb("#8a8f98")
#let rule_color = rgb("#d8dbe5")

#let body_fonts = (
  // Optional local-only font list. It is not enabled by default in main.typ
  // because Typst Web may not have these fonts installed.
  "Songti SC",
  "PingFang SC",
  "Heiti SC",
  "Times New Roman",
)

#let mono_fonts = ("Menlo", "Consolas")

#let page_margin = (x: 1.12cm, y: 0.95cm)

// Typography scale.
// Change `base_size` first; the rest follows from readable ratios.
#let base_size = 8.4pt
#let small_ratio = 0.90
#let tiny_ratio = 0.84
#let section_ratio = 1.12
#let name_ratio = 2.05

#let small_size = base_size * small_ratio
#let tiny_size = base_size * tiny_ratio
#let section_size = base_size * section_ratio
#let name_size = base_size * name_ratio

// Vertical rhythm.
// `em` values scale with the surrounding text, which keeps spacing stable
// when you tune the base font size.
#let leading_ratio = 0.56
#let list_item_spacing_ratio = 0.34
#let section_before_ratio = 0.46
#let section_after_ratio = 0.24
#let entry_after_ratio = 0.34

#let line_leading = leading_ratio * 1em
#let list_item_spacing = list_item_spacing_ratio * 1em
#let section_before = section_before_ratio * 1em
#let section_after = section_after_ratio * 1em
#let entry_after = entry_after_ratio * 1em

// Rules should structure the page without becoming visual noise.
#let rule_base = 0.36pt
#let thin_rule = rule_base
#let header_rule = rule_base * 1.65

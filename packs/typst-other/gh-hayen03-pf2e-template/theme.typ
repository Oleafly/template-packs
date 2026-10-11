
#let DARK_GREEN = rgb("#044007")
#let TAG_BORDER_COLOR = rgb("#d8c384")
#let TAG_COLOR = rgb("#5d0000")
#let UNCOMMON_TAG_COLOR = rgb("#98503c")
#let RARE_TAG_COLOR = rgb("#002564")
#let UNIQUE_TAG_COLOR = rgb("#54166d")
#let SIZE_TAG_COLOR = rgb("#3a7a58")
#let ALIGNEMENT_TAG_COLOR = rgb("#566193")
#let TAG_TEXT_COLOR = rgb("#fff")
#let FIRST_LEVEL_HEADING_COLOR = DARK_GREEN
#let SECOND_LEVEL_HEADING_COLOR = rgb("#2e0e03")
#let NOTE_BACKGROUND_COLOR = rgb("#c9c8a3")
#let RULEBOX_BACKGROUND_COLOR = rgb("#c4c0c4")
#let FOURTH_LEVEL_HEADING_BACKGROUND_COLOR = rgb("#002564")
#let TABLE_FILL = (rgb("#cecfbe"), rgb("#eff0e4"))
#let INFOBOX_COLOR = DARK_GREEN
#let BLOCK_FONT = "Open Sans"
#let MAIN_TEXT_FONT = ("Sabon", "Libre Baskerville")
#let BIG_HEADING_FONT = ("Taroca", "Eagle Lake")
#let BLOCK_HEADING_FONT = "Bebas Neue"
#let SMALL_HEADING_FONT = ("Gin", "Roboto")
#let CENTER_CELL_PATTERN = regex("\A(?:(?:[+-−—]?\d+(?:(?:\s*(?i:gp|sp|cp|pp))?|L))+|(?:--)|–|−|—|L|(?:\d+-\d+)|\d+\+)\z")
#let NORMAL_FONT_SIZE = 9pt
#let BLOCK_FONT_SIZE = 9pt
#let TITLE_HEADING_FONT_SIZE = 23pt
#let TITLE_TEXT_FONT_SIZE = 12pt
#let SUBTITLE_HEADING_FONT_SIZE = 20pt
#let FIRST_LEVEL_HEADING_FONT_SIZE = 18pt
#let SECOND_LEVEL_HEADING_FONT_SIZE = 15pt
#let THIRD_LEVEL_HEADING_FONT_SIZE = 14pt
#let FOURTH_LEVEL_HEADING_FONT_SIZE = 15pt
#let FIFTH_LEVEL_HEADING_FONT_SIZE = 15pt
#let BLOC_HEADING_FONT_SIZE = 15pt
#let TRAIT_FONT_SIZE = 8pt

#let theme(
  accent: DARK_GREEN,
  tag_border_color: TAG_BORDER_COLOR,
  tag_color: TAG_COLOR,
  uncommon_tag_color: UNCOMMON_TAG_COLOR,
  rare_tag_color: RARE_TAG_COLOR,
  unique_tag_color: UNIQUE_TAG_COLOR,
  size_tag_color: SIZE_TAG_COLOR,
  alignement_tag_color: ALIGNEMENT_TAG_COLOR,
  tag_text_color: TAG_TEXT_COLOR,
  first_level_heading_color: FIRST_LEVEL_HEADING_COLOR,
  second_level_heading_color: SECOND_LEVEL_HEADING_COLOR,
  fourth_level_heading_background_color: FOURTH_LEVEL_HEADING_BACKGROUND_COLOR,
  notebox_background_color: NOTE_BACKGROUND_COLOR,
  rulebox_background_color: RULEBOX_BACKGROUND_COLOR,
  table_fill: TABLE_FILL,
  block_font: BLOCK_FONT,
  block_heading_font: BLOCK_HEADING_FONT,
  main_text_font: MAIN_TEXT_FONT,
  big_heading_font: BIG_HEADING_FONT,
  small_heading_font: SMALL_HEADING_FONT,
  center_cell_pattern: CENTER_CELL_PATTERN,
  normal_font_size: NORMAL_FONT_SIZE,
  block_font_size: BLOCK_FONT_SIZE,
  title_font_size: TITLE_HEADING_FONT_SIZE,
  subtitle_font_size: SUBTITLE_HEADING_FONT_SIZE,
  first_level_heading_font_size: FIRST_LEVEL_HEADING_FONT_SIZE,
  second_level_heading_font_size: SECOND_LEVEL_HEADING_FONT_SIZE,
  third_level_heading_font_size: THIRD_LEVEL_HEADING_FONT_SIZE,
  fourth_level_heading_font_size: FOURTH_LEVEL_HEADING_FONT_SIZE,
  fifth_level_heading_font_size: FIFTH_LEVEL_HEADING_FONT_SIZE,
  bloc_heading_font_size: BLOC_HEADING_FONT_SIZE,
  trait_font_size: TRAIT_FONT_SIZE,
  infobox_color: INFOBOX_COLOR,
  title_text_font_size: TITLE_TEXT_FONT_SIZE,
) = (
  accent: accent,
  tag_border_color: tag_border_color,
  tag_color: tag_color,
  uncommon_tag_color: uncommon_tag_color,
  rare_tag_color: rare_tag_color,
  unique_tag_color: unique_tag_color,
  size_tag_color: size_tag_color,
  alignement_tag_color: alignement_tag_color,
  tag_text_color: tag_text_color,
  first_level_heading_color: first_level_heading_color,
  second_level_heading_color: second_level_heading_color,
  fourth_level_heading_background_color: fourth_level_heading_background_color,
  notebox_background_color: notebox_background_color,
  rulebox_background_color: rulebox_background_color,
  table_fill: table_fill,
  block_font: block_font,
  main_text_font: main_text_font,
  big_heading_font: big_heading_font,
  small_heading_font: small_heading_font,
  center_cell_pattern: center_cell_pattern,
  normal_font_size: normal_font_size,
  block_font_size: block_font_size,
  block_heading_font: block_heading_font,
  title_font_size: title_font_size,
  subtitle_font_size: subtitle_font_size,
  first_level_heading_font_size: first_level_heading_font_size,
  second_level_heading_font_size: second_level_heading_font_size,
  third_level_heading_font_size: third_level_heading_font_size,
  fourth_level_heading_font_size: fourth_level_heading_font_size,
  fifth_level_heading_font_size: fifth_level_heading_font_size,
  bloc_heading_font_size: bloc_heading_font_size,
  trait_font_size: trait_font_size,
  infobox_color: infobox_color,
  title_text_font_size: title_text_font_size,
)
#let THEME = theme()

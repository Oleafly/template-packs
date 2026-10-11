#import "@preview/fontawesome:0.6.0": (
  fa-envelope,
  fa-github,
  fa-linkedin,
  fa-location-dot,
  fa-phone,
)

#let _cv-metadata = state("cv-metadata", none)

#let _len(value, default) = {
  if value == none {
    default
  } else if type(value) == str {
    eval(value)
  } else {
    value
  }
}

#let _layout(metadata) = metadata.at("layout", default: (:))

#let _fonts(layout) = layout.at("fonts", default: (:))

#let _header(layout) = layout.at("header", default: (:))

#let _entry(layout) = layout.at("entry", default: (:))

#let _section(layout) = layout.at("section", default: (:))

#let _footer(layout) = layout.at("footer", default: (:))

#let _accent(metadata) = {
  let color = _layout(metadata).at("awesome_color", default: "black")
  if color == "darknight" {
    rgb("#131A28")
  } else if color == "black" {
    black
  } else if color == "skyblue" {
    rgb("#0395DE")
  } else if color == "red" {
    rgb("#DC3522")
  } else if color == "nephritis" {
    rgb("#27AE60")
  } else if color == "concrete" {
    rgb("#95A5A6")
  } else if type(color) == str {
    rgb(color)
  } else {
    color
  }
}

#let _page-margin(layout) = {
  let margin = layout.at("page_margin", default: none)
  if margin != none {
    (
      top: _len(margin.at("top", default: "0.5cm"), 0.5cm),
      bottom: _len(margin.at("bottom", default: "1.5cm"), 1.5cm),
      left: _len(margin.at("left", default: "2cm"), 2cm),
      right: _len(margin.at("right", default: "2cm"), 2cm),
    )
  } else {
    (top: 0.5cm, bottom: 1.5cm, left: 2cm, right: 2cm)
  }
}

#let _contact-icon(key) = {
  if key == "email" {
    // fa-envelope()
  } else if key == "phone" {
    // fa-phone()
  } else if key == "linkedin" {
    fa-linkedin()
  } else if key == "github" {
    fa-github()
  } else if key == "location" {
    // fa-location-dot()
  }
}

#let _with-icon(key, body) = {
  let icon = _contact-icon(key)
  if icon == none {
    body
  } else {
    [#icon #h(3pt)#body]
  }
}

#let _header-info-row-has-icon(row) = {
  for (key, value) in row {
    if value != none and value != "" and _contact-icon(key) != none {
      return true
    }
  }
  false
}

#let _maybe-link(key, value) = {
  if key == "email" {
    _with-icon(key, link("mailto:" + value)[#value])
  } else if key == "phone" {
    _with-icon(key, link("tel:" + value.replace(" ", ""))[#value])
  } else if key == "linkedin" {
    _with-icon(key, link("https://www.linkedin.com/in/" + value)[LinkedIn])
  } else if key == "github" {
    _with-icon(key, link("https://github.com/" + value)[GitHub])
  } else if key == "homepage" {
    _with-icon(key, link("https://" + value)[#value])
  } else {
    _with-icon(key, value)
  }
}

#let h-bar() = [#h(5pt)|#h(5pt)]

#let _header-info-row(row) = {
  let first = true
  for (key, value) in row {
    if value == none or value == "" {
      continue
    }
    if not first {
      h-bar()
    }
    _maybe-link(key, value)
    first = false
  }
}

#let _header-info(info, icon-row-adjust: -1.5pt) = {
  for (idx, row) in info.enumerate() {
    if idx > 0 {
      linebreak()
      if _header-info-row-has-icon(row) {
        v(icon-row-adjust)
      }
    }
    _header-info-row(row)
  }
}

#let _cv-header(metadata) = {
  let layout = _layout(metadata)
  let fonts = _fonts(layout)
  let header = _header(layout)
  let personal = metadata.personal
  let header-font = fonts.at("header_font", default: fonts.at(
    "regular_fonts",
    default: ("Times New Roman",),
  ))
  let name-size = _len(header.at("name_font_size", default: "22pt"), 22pt)
  let info-size = _len(header.at("info_font_size", default: "9pt"), 9pt)
  let name-gap = _len(header.at("name_gap", default: "1mm"), 1mm)
  let icon-row-adjust = _len(header.at(
    "icon_row_spacing_adjust",
    default: "-1.5pt",
  ), -1.5pt)
  let after = _len(header.at("after_skip", default: "-4pt"), -4pt)
  let address = personal.at("address", default: none)

  align(center)[
    #text(
      font: header-font,
      size: name-size,
      weight: "bold",
      fill: black,
    )[#personal.first_name #personal.last_name]
    #if address != none and address != "" {
      v(name-gap)
      text(size: info-size, fill: black)[#address]
      linebreak()
    } else {
      v(name-gap)
    }
    #text(size: info-size, fill: black)[#_header-info(
      personal.info,
      icon-row-adjust: icon-row-adjust,
    )]
  ]
  v(after)
}

#let _cv-footer(metadata) = {
  let footer-text = metadata.at("cv_footer", default: "")
  let personal = metadata.personal
  text(size: 8pt, fill: gray)[
    #personal.first_name #personal.last_name
    #h(1fr)
    #footer-text
  ]
}

#let cv(metadata, body) = {
  _cv-metadata.update(metadata)

  let layout = _layout(metadata)
  let fonts = _fonts(layout)
  let footer = _footer(layout)
  let regular-fonts = fonts.at("regular_fonts", default: ("Times New Roman",))
  let font-size = _len(layout.at("font_size", default: "9pt"), 9pt)
  let leading = _len(layout.at("line_leading", default: "0.45em"), 0.45em)
  let list-spacing = _len(layout.at("list_spacing", default: "0pt"), 0pt)
  let paper-size = layout.at("paper_size", default: "a4")
  let display-footer = footer.at("display_footer", default: false)

  set page(
    paper: paper-size,
    margin: _page-margin(layout),
    footer: if display-footer { _cv-footer(metadata) } else { none },
  )
  set text(font: regular-fonts, size: font-size, fill: black)
  set par(leading: leading)
  set list(spacing: list-spacing)

  _cv-header(metadata)
  body
}

#let cv-section(
  title,
  highlight: none,
  highlight-letters: none,
  color: none,
  metadata: none,
  awesome-colors: (:),
) = context {
  let metadata = if metadata != none { metadata } else { _cv-metadata.get() }
  let layout = _layout(metadata)
  let section = _section(layout)
  let before = _len(layout.at("before_section_skip", default: "-2pt"), -2pt)
  let after = _len(section.at("after_skip", default: "-3pt"), -3pt)
  let title-size = _len(section.at("title_font_size", default: "13pt"), 13pt)
  let rule-stroke = _len(section.at("rule_stroke", default: "0.4pt"), 0.4pt)
  let rule-color = section.at("rule_color", default: gray)
  let title-color = if color != none { color } else { black }

  v(before)
  // Rule below the title keeps long localized section names from squeezing
  // the line in narrow layouts.
  block(sticky: true, width: 100%)[
    #text(size: title-size, weight: "bold", fill: title-color)[#title]
    #linebreak()
    #v(-6pt)
    #box(
      width: 100%,
      line(length: 100%, stroke: (paint: rule-color, thickness: rule-stroke)),
    )
  ]
  v(after)
}

#let _entry-primary(body, size) = text(size: size, weight: "bold", fill: black)[#body]

#let _entry-secondary(body, size) = text(size: size, style: "italic", fill: black)[#body]

#let _entry-right(body, size, strong: false) = align(right)[
  #text(size: size, weight: if strong { "bold" } else { "regular" }, fill: black)[#body]
]

#let cv-entry(
  title: "",
  society: "",
  date: "",
  location: "",
  description: none,
  logo: none,
  tags: (),
  color: none,
  metadata: none,
  awesome-colors: (:),
) = context {
  let metadata = if metadata != none { metadata } else { _cv-metadata.get() }
  let layout = _layout(metadata)
  let entry = _entry(layout)
  let society-first = entry.at("display_entry_society_first", default: true)
  let before = _len(layout.at("before_entry_skip", default: "2pt"), 2pt)
  let before-description = _len(layout.at(
    "before_entry_description_skip",
    default: "-2pt",
  ), -2pt)
  let date-width = _len(layout.at("date_width", default: "3.5cm"), 3.5cm)
  let primary-size = _len(entry.at("primary_font_size", default: "9.5pt"), 9.5pt)
  let secondary-size = _len(entry.at("secondary_font_size", default: "9pt"), 9pt)
  let row-gutter = _len(entry.at("row_gutter", default: "0pt"), 0pt)

  let first-left = if society-first { society } else { title }
  let second-left = if society-first { title } else { society }
  let first-right = if society-first { location } else { date }
  let second-right = if society-first { date } else { location }

  v(before)
  table(
    columns: (1fr, date-width),
    inset: 0pt,
    stroke: none,
    column-gutter: 6pt,
    row-gutter: row-gutter,
    align: (x, y) => if x == 1 { right } else { left },
    _entry-primary(first-left, primary-size),
    _entry-right(first-right, primary-size, strong: true),
    _entry-secondary(second-left, secondary-size),
    _entry-right(second-right, secondary-size),
  )
  if description != none and description != "" {
    v(before-description)
    block[
      #set list(spacing: _len(layout.at("list_spacing", default: "0pt"), 0pt))
      #description
    ]
  }
}

#let cv-skill(type: "", info: "", metadata: none, color: none) = context {
  let metadata = if metadata != none { metadata } else { _cv-metadata.get() }
  let layout = _layout(metadata)
  let entry = _entry(layout)
  let before = _len(layout.at("before_entry_skip", default: "2pt"), 2pt)
  let label-width = _len(entry.at("skill_label_width", default: "2.6cm"), 2.6cm)

  v(before)
  table(
    columns: (label-width, 1fr),
    inset: 0pt,
    stroke: none,
    column-gutter: 6pt,
    text(weight: "bold")[#type],
    info,
  )
}

#let cv-signoff(
  place-name: "Munich",
  date: datetime.today().display(),
  signature: none,
  signature-height: 1.5em,
  before: 1em,
  placement: "flow",
) = {
  let body = [
    #place-name, #date
    #if signature != none {
      h(0.8em)
      box(baseline: 25%, image(signature, height: signature-height))
    }
  ]

  if placement == "bottom" {
    // Old:
    // place(bottom + left, float: true, body)
    // Note: This can overlap content if the page is completely full, since it
    // is intentionally placed regardless of flow! New below.
    place(bottom + left, dy: 0.6cm, body)
  } else {
    v(before)
    body
  }
}

#let shared_type = (
  regular: (
    font: ("Bell MT", "SimSun", "Segoe UI Emoji"),
    weight: "regular",
    style: "normal",
  ),
  secondary: (
    font: ("Josefin Sans", "FangSong", "Segoe UI Emoji"),
    weight: "regular",
    style: "normal",
  ),
  code: (
    font: ("Fira Code", "SimSun"),
    weight: "medium",
    style: "normal",
  ),
  math: (
    font: "Latin Modern Math",
    weight: "regular",
    style: "normal",
  ),
  accent: (
    font: ("Arial", "Microsoft YaHei", "Segoe UI Emoji"),
    weight: "semibold",
    style: "normal",
    number: (
      font: "Arial",
      weight: "semibold",
      style: "normal",
    ),
  ),
  decorative: (
    font: ("Goud Ornate", "SimSun"),
    weight: "black",
    style: "normal",
  ),
)

#let shared_sizes = (
  small: 11pt,
  regular: 13pt,
  code: 11pt,
  math: 13pt,
  heading: 16pt,
  title: 30pt,
)

#let shared_page = (
  paper: "a4",
  margin: (
    top: 4cm,
    bottom: 2.5cm,
    x: 3cm,
  ),
)

#let shared_table = (
  divider: 0.05em + luma(75%),
  row_rule: 0.05em + luma(75%),
)

#let shared_title = (
  leading: 0.25em,
  spacing: 10pt,
  gutter: 1em,
  small-caps: true,
  layout: "side",
)

#let make_theme(
  text_leading,
  type: (:),
  sizes: (:),
  title: (:),
) = (
  type: shared_type + type,
  sizes: shared_sizes + sizes,
  page: shared_page,
  text: (
    leading: text_leading,
  ),
  title: shared_title + title,
  table: shared_table,
)

#let casual_theme = make_theme(
  0.65em,
)

#let formal_theme = make_theme(
  0.7em,
)

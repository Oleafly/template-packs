// ═══════════════════════════════════════════════════════════════════════════
// CHAPTER 3 — Results: figures and tables
// ═══════════════════════════════════════════════════════════════════════════

#import "../lib/blocks.typ": note

= Results <ch:results>

Figures and tables are both `#figure(...)`: you give it the content, a caption
and a label, and the template does the numbering, the caption style and the
entry in the List of Figures.

== Figures

#figure(
  image("../figures/example-plot.svg", width: 85%),
  caption: [
    Simulated sedimentation profiles at three times.
  ],
) <fig:profiles>

@fig:profiles was produced by `#figure(image("../figures/example-plot.svg"))`.
Paths are relative to the file they are written in, so a figure included from
`chapters/` reaches the shared `figures/` folder with `../figures/`.
Paths starting with `/` are relative to the project root.

Typst reads PNG, JPEG, GIF, SVG and PDF. Prefer a vector format (SVG or PDF)
for anything you plotted. It stays sharp at any zoom and usually produces a
smaller file. `width: 85%` is relative to the text width; use `width: 100%` for
a full-width figure.

To place two figures side by side, put them in a `grid` inside one `#figure`,
or give each its own `#figure` inside a `grid` if you want them numbered
separately:

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 10pt,
    image("../figures/example-plot.svg"),
    image("../figures/example-plot.svg"),
  ),
  caption: [Two panels in a single figure, laid out with a `grid`.],
) <fig:panels>

== Tables

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, right, right, right),
    table.header([Sample], [$s_(20,w)$ / S], [$M$ / kDa], [$f\/f_0$]),
    [Myoglobin], [1.97], [17.6], [1.19],
    [Serum albumin], [4.31], [66.5], [1.30],
    [Catalase], [11.20], [232.0], [1.25],
  ),
  caption: [
    A table is a `#figure` too, so it is numbered and captioned in the same
    way. The template puts table captions above the table.
  ],
) <tab:results>

@tab:results shows the layout. `columns:` gives the number and width of the
columns, `align:` their alignment, and `table.header(...)` marks the first row
as a header — it is set in bold and repeats if the table breaks across pages.

#note(title: "Tables from data files")[
  You do not have to type numbers in by hand. `#csv("data/results.csv")` reads
  a file into an array, which you can feed straight into a table:

  ```typ
  #let data = csv("../data/results.csv")
  #table(columns: 4, ..data.flatten())
  ```

  Re-run the compiler after regenerating the file and the table updates itself.
]

== Referring to figures and tables

`@fig:profiles` and `@tab:results` link to @fig:profiles and @tab:results. Use
a `fig:` / `tab:` / `eq:` / `ch:` prefix in your labels; nothing enforces it,
but it keeps them apart when the thesis gets long.

The List of Figures and the List of Tables in the appendix are generated from
these captions.

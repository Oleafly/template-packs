// Tenzir report template — Tenzir design system
//
// A reusable Typst template that realizes the Tenzir design system for
// long-form reports (light mode). Values are wired once here as tokens and
// referenced throughout, per the design-system invariant "reference tokens,
// not raw values".
//
// Usage:
//   #import "tenzir-report.typ": tenzir-report, kicker, callout, gradient-text
//   #show: tenzir-report.with(title: "…", subtitle: "…", authors: (…), date: …)

// ---------------------------------------------------------------------------
// Unit boundary — the design system defines lengths in CSS pixels; convert
// them to Typst points once here (1px = 1/96in, 1pt = 1/72in, so 1px = 0.75pt).
// Token tables below keep the raw px values so they stay faithful to the
// design system; `px()` realizes them as print lengths.
// ---------------------------------------------------------------------------

#let px = v => v * 0.75pt

// ---------------------------------------------------------------------------
// Tokens — from tenzir-design-system data/brand.yml and data/tokens.yml
// ---------------------------------------------------------------------------

#let tz = (
  color: (
    // Neutrals carry the layout.
    neutral-800: rgb("#0E1017"),
    neutral-700: rgb("#262E40"),
    neutral-600: rgb("#414B62"),
    neutral-500: rgb("#68738D"),
    neutral-400: rgb("#959DB1"),
    neutral-300: rgb("#CED3DE"),
    neutral-250: rgb("#E3E6ED"),
    neutral-200: rgb("#F0F1F5"),
    neutral-100: rgb("#F7F8FA"),
    neutral-50: rgb("#FDFDFE"),
    // Brand pair + status hues. 400-level hues step one level lighter to keep
    // contrast on dark surfaces (see tokens.yml `dark:`).
    blue-600: rgb("#0043E0"),
    blue-500: rgb("#0A54FF"),
    blue-400: rgb("#477EFF"),
    blue-300: rgb("#ADC6FF"),
    blue-200: rgb("#E0EAFF"),
    green-600: rgb("#1AB252"),
    green-500: rgb("#29E06C"),
    green-400: rgb("#5EE891"),
    green-300: rgb("#B8F5CE"),
    green-200: rgb("#E4FBEC"),
    lightblue-600: rgb("#0096E0"),
    lightblue-400: rgb("#47C2FF"),
    lightblue-200: rgb("#E0F5FF"),
    yellow-600: rgb("#D09611"),
    yellow-400: rgb("#F1C255"),
    yellow-300: rgb("#F9E4B4"),
    yellow-200: rgb("#FEF6E1"),
    red-500: rgb("#FF0A33"),
    red-400: rgb("#FF4766"),
    red-200: rgb("#FFE0E5"),
  ),
  // Type scale (design-system px, converted to pt), each with its paired
  // line height.
  size: (
    xxs: px(10),
    xs: px(12),
    sm: px(14),
    base: px(16),
    lg: px(18),
    xl: px(20),
    xxl: px(24),
    xxxl: px(30),
    xxxxl: px(36),
  ),
  weight: (
    regular: 400,
    medium: 500,
    semibold: 600,
  ),
  // 4px spacing scale (design-system px, converted to pt).
  space: (
    s0_5: px(2),
    s1: px(4),
    s2: px(8),
    s3: px(12),
    s4: px(16),
    s5: px(20),
    s6: px(24),
    s8: px(32),
    s10: px(40),
    s16: px(64),
  ),
  radius: (
    default: px(5),
    tight: px(3),
  ),
  font: (
    sans: "Inter",
    mono: "JetBrains Mono",
  ),
)

// The signature blue→green brand gradient (left to right).
#let tz-gradient = gradient.linear(
  tz.color.blue-500,
  tz.color.green-500,
  angle: 0deg,
)

// ---------------------------------------------------------------------------
// Themes — light and dark are both first-class modes that share the palette
// above and remap the semantic roles onto it (see tokens.yml `dark:`). Each
// theme resolves every mode-dependent decision the template and helpers need:
// page background, the text hierarchy, hairlines, the code/inline well, the
// quote rule, the cover logo, and the status-callout roles.
// ---------------------------------------------------------------------------

#let tz-themes = (
  light: (
    background: tz.color.neutral-50,
    // Text hierarchy: emphasis (headings/active) → body → secondary → tertiary.
    emphasis: tz.color.neutral-800,
    body: tz.color.neutral-700,
    secondary: tz.color.neutral-600,
    tertiary: tz.color.neutral-500,
    hairline: tz.color.neutral-200,   // footer/table/code borders
    well: tz.color.neutral-100,       // inline + block code background
    well-text: tz.color.neutral-700,
    quote-rule: tz.color.blue-300,
    logo: "../assets/logos/logo-dark.svg",  // dark artwork on light background
    // Soft 200-level fill, 600-level rule, neutral-800 text.
    callout: (
      info: (fill: tz.color.lightblue-200, rule: tz.color.lightblue-600),
      success: (fill: tz.color.green-200, rule: tz.color.green-600),
      warning: (fill: tz.color.yellow-200, rule: tz.color.yellow-600),
      danger: (fill: tz.color.red-200, rule: tz.color.red-500),
      note: (fill: tz.color.neutral-100, rule: tz.color.neutral-400),
    ),
    callout-text: tz.color.neutral-800,
  ),
  dark: (
    background: tz.color.neutral-800,
    emphasis: tz.color.neutral-50,
    body: tz.color.neutral-300,
    secondary: tz.color.neutral-400,  // neutral-400 is the minimum grey on dark
    tertiary: tz.color.neutral-400,
    hairline: tz.color.neutral-700,
    well: tz.color.neutral-700,
    well-text: tz.color.neutral-300,
    quote-rule: tz.color.blue-400,
    logo: "../assets/logos/logo-light.svg",  // light artwork on dark background
    // Flat neutral-700 well, status hue stepped to 400, neutral-50 text.
    callout: (
      info: (fill: tz.color.neutral-700, rule: tz.color.lightblue-400),
      success: (fill: tz.color.neutral-700, rule: tz.color.green-400),
      warning: (fill: tz.color.neutral-700, rule: tz.color.yellow-400),
      danger: (fill: tz.color.neutral-700, rule: tz.color.red-400),
      note: (fill: tz.color.neutral-700, rule: tz.color.neutral-400),
    ),
    callout-text: tz.color.neutral-50,
  ),
)

// The active theme, set by `tenzir-report`. Helpers read it via `context` so
// they adapt to the surrounding document without an explicit argument.
#let tz-active = state("tz-active-theme", tz-themes.light)

// ---------------------------------------------------------------------------
// Branded helpers
// ---------------------------------------------------------------------------

// Brand gradient text — display accent only (titles, stat figures, kickers).
// Sized to its content so each element runs the full ramp.
#let gradient-text(body) = text(fill: tz-gradient)[#body]

// Kicker (section eyebrow): monospaced, uppercase, letter-spaced technical
// label that introduces a heading.
#let kicker(body, fill: tz-gradient) = text(
  font: tz.font.mono,
  size: tz.size.xs,
  weight: tz.weight.semibold,
  fill: fill,
  tracking: 0.05em,
)[#upper(body)]

// Status callout — a soft status fill with a left accent rule, adapting to
// the active theme. `role` is one of: info, success, warning, danger, note.
#let callout(body, role: "info", title: none) = context {
  let th = tz-active.get()
  let r = th.callout.at(role, default: th.callout.info)
  block(
    width: 100%,
    fill: r.fill,
    inset: (x: tz.space.s4, y: tz.space.s3),
    radius: tz.radius.default,
    stroke: (left: 3pt + r.rule),
  )[
    #set text(fill: th.callout-text, size: tz.size.sm)
    #if title != none [
      #text(weight: tz.weight.semibold)[#title]
      #v(tz.space.s1)
    ]
    #body
  ]
}

// A key figure / stat with a gradient number and a muted label.
#let stat(figure, label) = context {
  block[
    #text(size: tz.size.xxxl, weight: tz.weight.semibold)[#gradient-text(figure)]
    #v(-tz.space.s1)
    #text(size: tz.size.xs, fill: tz-active.get().tertiary)[#label]
  ]
}

// ---------------------------------------------------------------------------
// Data tables from external files
// ---------------------------------------------------------------------------

// Parse a column-width string into a Typst track size. Accepts "auto", a
// fraction like "1.7fr", or an absolute length like "3.6cm"/"12pt"/"20mm".
#let parse-len(v) = {
  if type(v) == length or type(v) == fraction or v == auto { return v }
  let s = str(v)
  if s == "auto" { auto }
  else if s.ends-with("fr") { float(s.slice(0, -2)) * 1fr }
  else if s.ends-with("cm") { float(s.slice(0, -2)) * 1cm }
  else if s.ends-with("mm") { float(s.slice(0, -2)) * 1mm }
  else if s.ends-with("pt") { float(s.slice(0, -2)) * 1pt }
  else { auto }
}

// Render a cell string, turning `backtick`-delimited spans into inline code so
// data files can mix prose and identifiers (e.g. "`neo` (blocked)").
#let render-cell(s) = {
  let parts = str(s).split("`")
  parts.enumerate().map(((i, p)) => {
    if calc.rem(i, 2) == 1 { raw(p) } else { p }
  }).join()
}

// Build a table from external data (typically `json("…")`). The data is a
// dictionary:
//
//   {
//     "columns": [
//       {"header": "benchmark", "align": "left", "width": "3.6cm", "code": true},
//       {"header": "Δ time", "align": "right"}
//     ],
//     "rows": [["parallel_cpu_bound", "-2.5%"], …]
//   }
//
// Per-column options: `align` (left|center|right), `width` (see parse-len),
// `code` (render the whole cell as inline code), and `nowrap` (keep the cell
// on one line by using non-breaking spaces). Cell strings may also embed
// `backtick` code spans regardless of `code`.
#let data-table(data) = {
  let cols = data.columns
  let aligns = cols.map(c => {
    let a = c.at("align", default: "left")
    if a == "right" { right } else if a == "center" { center } else { left }
  })
  let widths = cols.map(c => parse-len(c.at("width", default: auto)))
  let cells = ()
  for row in data.rows {
    for (i, cell) in row.enumerate() {
      let c = cols.at(i)
      cells.push(
        if c.at("code", default: false) {
          raw(str(cell))
        } else if c.at("nowrap", default: false) {
          render-cell(str(cell).replace(" ", "\u{00A0}"))
        } else {
          render-cell(cell)
        }
      )
    }
  }
  table(
    columns: widths,
    align: (x, _) => aligns.at(x),
    table.header(..cols.map(c => [#c.header])),
    ..cells,
  )
}

// ---------------------------------------------------------------------------
// Template
// ---------------------------------------------------------------------------

#let tenzir-report(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
  kicker-text: "Technical Report",
  // "light" or "dark". Both are strict, first-class modes that share one
  // palette and remap the semantic roles (see tokens.yml `dark:`).
  theme: "light",
  // Paths resolve relative to this template file. The bundled logos live one
  // directory up, under assets/logos/. Defaults to the theme's cover logo
  // (dark artwork on light, light artwork on dark); override with your own.
  logo: auto,
  body,
) = {
  // Resolve the active theme and publish it so branded helpers adapt.
  let th = tz-themes.at(theme, default: tz-themes.light)
  tz-active.update(th)
  let logo = if logo == auto { th.logo } else { logo }

  // Page + base type.
  set document(title: title, author: authors)
  set page(
    paper: "a4",
    margin: (x: 2.4cm, top: 2.6cm, bottom: 2.4cm),
    fill: th.background,
    footer: context {
      set text(size: tz.size.xs, fill: th.tertiary, font: tz.font.sans)
      line(length: 100%, stroke: 0.5pt + th.hairline)
      v(tz.space.s2)
      grid(
        columns: (1fr, auto),
        align: (left, right),
        [Tenzir],
        [#counter(page).display("1")],
      )
    },
  )
  set text(
    font: tz.font.sans,
    size: tz.size.base,
    fill: th.body,
    weight: tz.weight.regular,
    lang: "en",
  )
  set par(justify: true, leading: 0.72em, spacing: 1.05em)

  // Headings: Inter semibold, neutral-800, with a kicker-like number.
  show heading: it => {
    set text(fill: th.emphasis, weight: tz.weight.semibold)
    set par(justify: false)
    let sizes = (tz.size.xxl, tz.size.xl, tz.size.lg, tz.size.base)
    let s = sizes.at(calc.min(it.level, sizes.len()) - 1)
    block(above: tz.space.s8, below: tz.space.s4)[
      #set text(size: s)
      #it.body
    ]
  }

  // Links: neutral body color with a persistent underline (print has no hover).
  show link: it => text(fill: th.body)[#underline(offset: 2pt, stroke: 0.5pt + th.secondary)[#it]]

  // Inline code: muted well, tight radius. `highlight` (unlike `box`) keeps
  // the background while allowing the text to break across lines; zero-width
  // breaks after `_` and `/` let long identifiers wrap inside table cells.
  show raw.where(block: false): it => highlight(
    fill: th.well,
    radius: tz.radius.tight,
    extent: 2pt,
    top-edge: "ascender",
    bottom-edge: "descender",
  )[#text(font: tz.font.mono, size: 0.9em, fill: th.well-text)[#it.text.replace("_", "_\u{200B}").replace("/", "/\u{200B}")]]

  // Code blocks: muted well with a hairline border.
  show raw.where(block: true): it => block(
    width: 100%,
    fill: th.well,
    inset: tz.space.s3,
    radius: tz.radius.default,
    stroke: 0.5pt + th.hairline,
  )[#text(font: tz.font.mono, size: tz.size.sm, fill: th.well-text)[#it]]

  // Tables: flat surfaces separated by hairline borders; header on a well.
  set table(
    stroke: (x, y) => (
      bottom: 0.5pt + th.hairline,
    ),
    inset: (x: tz.space.s3, y: tz.space.s2),
  )
  show table.cell.where(y: 0): it => text(
    weight: tz.weight.semibold,
    fill: th.emphasis,
    size: tz.size.sm,
  )[#it]
  show table: set text(size: tz.size.xs, hyphenate: false)

  // Block quotes: blue-300 inline-start rule, italic, muted.
  show quote.where(block: true): it => block(
    inset: (left: tz.space.s4),
    stroke: (left: 2pt + th.quote-rule),
  )[#set text(style: "italic", fill: th.secondary); #it.body]

  // --- Cover ---------------------------------------------------------------
  block[
    #image(logo, height: px(34))
  ]
  v(tz.space.s16)

  if kicker-text != none {
    kicker(kicker-text)
    v(tz.space.s3)
  }

  par(justify: false, leading: 0.3em)[
    #text(size: tz.size.xxxxl, weight: tz.weight.semibold, fill: th.emphasis)[#title]
  ]

  if subtitle != none {
    v(tz.space.s3)
    par(justify: false)[
      #text(size: tz.size.xl, fill: th.secondary, weight: tz.weight.regular)[#subtitle]
    ]
  }

  v(tz.space.s6)
  // Gradient rule under the title block.
  block(width: 100%, height: 3pt, fill: tz-gradient, radius: 2pt)
  v(tz.space.s4)

  grid(
    columns: (auto, 1fr),
    column-gutter: tz.space.s8,
    row-gutter: tz.space.s2,
    ..(
      if authors.len() > 0 {
        (
          text(size: tz.size.xs, fill: th.tertiary)[Authors],
          text(size: tz.size.sm, fill: th.body)[#authors.join(", ")],
        )
      } else { () }
    ),
    ..(
      if date != none {
        (
          text(size: tz.size.xs, fill: th.tertiary)[Date],
          text(size: tz.size.sm, fill: th.body)[#date],
        )
      } else { () }
    ),
  )

  v(tz.space.s10)

  // --- Body ----------------------------------------------------------------
  body
}

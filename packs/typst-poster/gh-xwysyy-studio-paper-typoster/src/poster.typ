// Poster mode — size presets and entry function.

#import "themes.typ": *
#import "elements.typ": *

#let paper-typoster-sizes = (
  "48x36": (width: 48in, height: 36in),
  "60x36": (width: 60in, height: 36in),
  "72x36": (width: 72in, height: 36in),
  "24x36": (width: 24in, height: 36in),
)

#let poster-title(
  title,
  subtitle: none,
  authors: none,
  affiliations: none,
  conference: none,
  left-logo: none,
  right-logo: none,
  logo: none,
) = context {
  let t = _theme-state.get()
  let title-block = {
    v(1.4em)
    if conference != none {
      text(size: 1.0em, weight: "bold", fill: t.sea, conference)
      v(0.12em)
    }
    text(size: 3.0em, weight: "extrabold", fill: black, title)
    if subtitle != none {
      v(0.16em)
      text(size: 0.85em, weight: "semibold", fill: black.lighten(30%), subtitle)
    }
    if authors != none {
      v(0.10em)
      text(size: 2.0em, weight: "regular", authors)
    }
    if affiliations != none {
      v(0.10em)
      text(size: 1.7em, fill: black.lighten(35%), affiliations)
    }
  }

  block(width: 100%, {
    set par(justify: false)
    let final-right-logo = if right-logo != none { right-logo } else { logo }
    if left-logo == none and final-right-logo == none {
      align(center, title-block)
    } else {
      grid(
        columns: (auto, 1fr, auto),
        column-gutter: 1.4em,
        align(left + horizon, left-logo),
        align(center + top, title-block),
        align(right + horizon, final-right-logo),
      )
    }
    v(0.85em)
  })
}

// Section header — reuses the slides title-bar look (header-fill block + header-text bold)
#let poster-section(title, body) = context {
  let t = _theme-state.get()
  let bar-fill = if t.header-fill != none { t.header-fill } else { t.sea }
  let bar-text = if t.header-text != none { t.header-text } else { t.paper }
  block(width: 100%, breakable: false, {
    block(
      width: 100%,
      height: 2.5em,
      fill: bar-fill,
      inset: (x: 1em),
      align(center + horizon, text(fill: bar-text, weight: "bold", size: 1.85em, title)),
    )
    v(0.45em)
    body
  })
}

#let _pt(x) = x.to-absolute().pt()

#let _segment-height(prefix, start, end, gap) = {
  let count = end - start
  if count <= 0 {
    0pt
  } else {
    prefix.at(end) - prefix.at(start) + (count - 1) * gap
  }
}

// Order-preserving K-partition: minimize max column height.
// dp[k][i] = min over k-1 ≤ j < i of max(dp[k-1][j], segment-height(j, i)).
// Returns (max-height: length, splits: (0, i_1, ..., i_{K-1}, N)) of length K+1.
#let _partition-sections(heights, K, gap: 0pt) = {
  let n = heights.len()

  if n == 0 {
    let splits = ()
    for idx in range(0, K + 1) { splits.push(0) }
    return (max-height: 0pt, splits: splits)
  }

  let prefix = (0pt,)
  for h in heights { prefix.push(prefix.at(prefix.len() - 1) + h) }
  let total = prefix.at(n)
  let total-with-gaps = _segment-height(prefix, 0, n, gap)

  if K == 1 { return (max-height: total-with-gaps, splits: (0, n)) }

  if K >= n {
    let splits = ()
    for idx in range(0, n + 1) { splits.push(idx) }
    for idx in range(n, K) { splits.push(n) }
    let maxh = 0pt
    for k in range(K) {
      let h = _segment-height(prefix, splits.at(k), splits.at(k + 1), gap)
      if h > maxh { maxh = h }
    }
    return (max-height: maxh, splits: splits)
  }

  let sentinel = total-with-gaps + 1pt
  let dp = ()
  let cut = ()
  for k in range(0, K + 1) {
    let row = ()
    let crow = ()
    for i in range(0, n + 1) { row.push(sentinel); crow.push(0) }
    dp.push(row)
    cut.push(crow)
  }
  dp.at(0).at(0) = 0pt

  for k in range(1, K + 1) {
    for i in range(k, n + 1) {
      let best = sentinel
      let bestj = k - 1
      for j in range(k - 1, i) {
        let left = dp.at(k - 1).at(j)
        let right = _segment-height(prefix, j, i, gap)
        let cost = if left > right { left } else { right }
        if cost < best { best = cost; bestj = j }
      }
      dp.at(k).at(i) = best
      cut.at(k).at(i) = bestj
    }
  }

  let splits = ()
  let i = n
  for k in range(K, 0, step: -1) {
    splits.push(i)
    i = cut.at(k).at(i)
  }
  splits.push(0)

  (max-height: dp.at(K).at(n), splits: splits.rev())
}

// Auto-balance K columns: measure each section's height at the per-column width,
// run order-preserving partition DP, then slice sections into K columns.
#let poster-grid(
  columns: 3,
  gutter: 0.55in,
  section-gap: 0.5em,
  id: "main",
  ..sections-args,
) = layout(size => {
  let sections = sections-args.pos()
  let K = columns
  let N = sections.len()

  if N == 0 { return }

  let total-gutter = (K - 1) * gutter
  let col-width = (size.width - total-gutter) / K
  let section-gap-abs = section-gap.to-absolute()
  let base-size = text.size.to-absolute()

  let heights = sections.map(s => measure(box(width: col-width, s)).height)
  let prefix = (0pt,)
  for h in heights { prefix.push(prefix.at(prefix.len() - 1) + h) }

  let part = _partition-sections(heights, K, gap: section-gap-abs)
  let splits = part.splits

  let column-bodies = ()
  let column-natural-heights = ()
  let column-rendered-heights = ()
  for k in range(K) {
    let start = splits.at(k)
    let end = splits.at(k + 1)
    let col-sections = sections.slice(start, end)
    let last = col-sections.len() - 1
    let column-body = {
      for (i, s) in col-sections.enumerate() {
        s
        if i < last { v(section-gap) }
      }
    }
    column-bodies.push(column-body)
    column-natural-heights.push(_segment-height(prefix, start, end, section-gap-abs))
    column-rendered-heights.push(measure(box(width: col-width, column-body)).height)
  }

  let max-natural-height = 0pt
  for h in column-natural-heights {
    if h > max-natural-height { max-natural-height = h }
  }

  let column-facts = ()
  for k in range(K) {
    let start = splits.at(k)
    let end = splits.at(k + 1)
    let natural-height = column-natural-heights.at(k)
    column-facts.push((
      index: k + 1,
      start: start,
      end: end,
      section_count: end - start,
      natural_height_pt: _pt(natural-height),
      rendered_height_pt: _pt(column-rendered-heights.at(k)),
      shortfall_vs_max_pt: _pt(max-natural-height - natural-height),
    ))
  }

  let layout-facts = (
    schema: "paper-typoster-layout/v1",
    id: id,
    column_count: K,
    section_count: N,
    col_width_pt: _pt(col-width),
    gutter_pt: _pt(gutter),
    section_gap_pt: _pt(section-gap-abs),
    base_size_pt: _pt(base-size),
    layout_container_height_pt: _pt(size.height),
    splits: splits,
    section_heights_pt: heights.map(h => _pt(h)),
    columns: column-facts,
  )

  let rendered-grid = grid(
    columns: (1fr,) * K,
    column-gutter: gutter,
    ..column-bodies,
  )
  [#metadata(layout-facts) <paper-typoster-layout>#rendered-grid]
})

#let paper-typoster(
  doc,
  title: none,
  subtitle: none,
  authors: none,
  affiliations: none,
  conference: none,
  left-logo: none,
  right-logo: none,
  logo: none,
  footer-left: none,
  footer-center: none,
  footer-right: none,
  footer: none,
  theme: "sky",
  size: "48x36",
  paper: auto,
  margin: (x: 0.72in, y: 0.55in),
  font: ("Times New Roman", "Noto Serif CJK SC"),
  code-font: "Maple Mono",
  base-size: 26pt,
  lang: "en",
) = {
  let t = themes.at(theme)
  let page-size = if paper == auto { paper-typoster-sizes.at(size) } else { paper }
  _theme-state.update(t)
  let has-footer = footer != none or footer-left != none or footer-center != none or footer-right != none
  let poster-footer = if has-footer {
    {
      set align(bottom)
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        text(size: 0.46em, fill: black.lighten(35%), if footer-left != none { footer-left } else { footer }),
        text(size: 0.46em, fill: black.lighten(35%), footer-center),
        text(size: 0.46em, fill: black.lighten(35%), footer-right),
      )
    }
  } else {
    none
  }

  set page(
    width: page-size.width,
    height: page-size.height,
    margin: margin,
    fill: t.page-fill,
    numbering: none,
    footer: poster-footer,
  )
  set text(
    font: font,
    lang: lang,
    size: base-size,
    weight: "regular",
    style: "normal",
  )
  set par(justify: true, leading: 0.58em)
  set heading(numbering: none)

  show: paper-typoster-elements.with(t-sea: t.sea, t-sky: t.sky, t-skyll: t.skyll, t-paper: t.paper, code-font: code-font)

  if title != none {
    poster-title(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      conference: conference,
      left-logo: left-logo,
      right-logo: right-logo,
      logo: logo,
    )
  }

  doc
}

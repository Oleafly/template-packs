// ===========================================================================
// viz.typ — visuals bound to the theme.
//
// Three routes in, deliberately:
//
//   asset(..)  a file exported from somewhere else. PDFs go through muchpdf so
//              they stay vector; everything else through `image`.
//   chart(..)  a gribouille (grammar-of-graphics) plot, pre-themed.
//   map(..)    a mercator GeoJSON map, with choropleth classing done here.
//
// mercator 0.1.2 has no scale or legend of its own — it interpolates
// `{property}` into the `fill` string. So `map` quantises the data into the
// theme's `sequential` ramp, writes the resulting colour back into each
// feature, and draws the legend itself.
// ===========================================================================

#import "@preview/gribouille:0.6.0" as gg
#import "@preview/mercator:0.1.2"
#import "@preview/muchpdf:0.1.2": muchpdf
#import "theme.typ": get-theme
#import "marks.typ": source-note

// --- assets ----------------------------------------------------------------

/// Place a file exported from other software.
///
/// `.pdf` is routed through `muchpdf`, which keeps Illustrator / R / Excel
/// exports as vectors instead of rasterising them; everything else goes to
/// `image`. Use this rather than `image` so that swapping a PNG for a vector
/// PDF later needs no edit at the call site.
#let asset(
  /// Path to the file.
  path,
  /// Width of the placed graphic.
  width: 100%,
  /// Height of the placed graphic.
  height: auto,
  /// Forwarded to `image` (ignored for PDFs).
  fit: "contain",
  /// Which page of a multi-page PDF to place.
  page-index: 0,
  ..rest
) = {
  if path.ends-with(".pdf") {
    muchpdf(read(path, encoding: none), width: width, height: height, pages: page-index, ..rest)
  } else {
    image(path, width: width, height: height, fit: fit, ..rest)
  }
}

// --- charts ----------------------------------------------------------------

/// A gribouille theme wired to the report palette. Requires context.
///
/// Exposed so that `gg.plot(.., theme: chart-theme())` works directly when you
/// need a gribouille feature `chart` does not forward.
#let chart-theme() = {
  let t = get-theme()
  gg.theme-minimal(
    ink: t.colors.ink,
    paper: t.colors.paper,
    accent: t.colors.primary,
    text: gg.element-text(font: t.fonts.body, size: t.scale.fine, colour: t.colors.ink),
    axis-text: gg.element-text(font: t.fonts.body, size: t.scale.micro, colour: t.colors.muted),
    axis-title: gg.element-text(font: t.fonts.body, size: t.scale.fine, colour: t.colors.muted),
    legend-text: gg.element-text(font: t.fonts.body, size: t.scale.micro, colour: t.colors.ink),
    legend-title: gg.element-text(font: t.fonts.body, size: t.scale.fine, colour: t.colors.muted),
    panel-grid: gg.element-line(colour: t.colors.rule, stroke: 0.4pt),
  )
}

/// Resolve a length-or-ratio against an available extent.
#let _resolve(v, avail) = if type(v) == length { v } else if type(v) == ratio {
  avail * (v / 100%)
} else if type(v) == relative {
  avail * (v.ratio / 100%) + v.length
} else {
  panic("chart: width/height must be a length or a ratio, got " + repr(v))
}

/// A gribouille colour scale from an explicit palette.
///
/// `chart` injects the theme's `categorical` palette for you whenever the
/// mapping carries a `colour` or `fill` channel, so this is only needed when
/// calling `gg.plot` directly:
/// `context gg.plot(.., scales: (colour: chart-colours(get-theme().colors.categorical)))`
#let chart-colours(palette) = gg.scale-manual(values: palette)

/// A pre-themed gribouille plot.
///
/// Everything gribouille accepts is forwarded. Only `theme`, `width`, `height`
/// and the qualitative colour scales get report-aware defaults, and any scale
/// you pass in `scales` wins over the injected one.
#let chart(
  /// Rows, as an array of dictionaries.
  data: none,
  /// `gg.aes(x: .., y: ..)`.
  mapping: none,
  /// Array of `gg.geom-*` layers.
  layers: (),
  /// Scale overrides as a plain dictionary keyed by aesthetic, e.g.
  /// `(y: gg.scale-continuous(limits: (0, 200)))`. Wins over the injected
  /// palette; wrapped in `gg.scales(..)` for you.
  scales: (:),
  /// Axis and legend titles.
  labels: none,
  /// Plot width. A ratio such as `100%` is resolved against the available
  /// space before handing it to gribouille, which requires concrete lengths.
  width: 100%,
  /// Plot height.
  height: 7cm,
  ..rest
) = context {
  let t = get-theme()
  let scales = scales

  // Bind the report palette to whichever qualitative channels are in use, so
  // a chart matches the rest of the document without per-chart styling.
  for channel in ("colour", "fill") {
    let mapped = if type(mapping) == dictionary {
      mapping.at(channel, default: none) != none
    } else { false }
    if mapped and channel not in scales {
      scales.insert(channel, chart-colours(t.colors.categorical))
    }
  }

  let draw(w, h) = gg.plot(
    data: data,
    mapping: mapping,
    layers: layers,
    // gribouille wants scales built by `gg.scales(..)`, not a bare dictionary.
    scales: if scales.len() == 0 { (:) } else { gg.scales(..scales) },
    labels: labels,
    theme: chart-theme(),
    width: w,
    height: h,
    ..rest,
  )

  if type(width) == length and type(height) == length {
    draw(width, height)
  } else {
    // gribouille refuses ratios, so measure the container first.
    layout(size => draw(_resolve(width, size.width), _resolve(height, size.height)))
  }
}

// --- maps ------------------------------------------------------------------

/// Equal-interval class breaks over `values`, as `n` upper bounds.
#let _equal-breaks(values, n) = {
  let lo = calc.min(..values)
  let hi = calc.max(..values)
  let span = hi - lo
  if span == 0 { span = 1 }
  range(1, n + 1).map(i => lo + span * i / n)
}

/// Index of the class `v` falls into, given ascending upper bounds.
#let _class-of(v, breaks) = {
  let i = 0
  while i < breaks.len() - 1 and v > breaks.at(i) { i += 1 }
  i
}

/// A discrete legend for a choropleth, drawn in Typst because mercator has none.
#let _map-legend(breaks, palette, title, t, fmt) = block(above: 0.7em)[
  #if title != none [
    #text(size: t.scale.fine, weight: 700, fill: t.colors.muted, tracking: 0.1em)[#upper(title)]
    #v(0.3em)
  ]
  // Each label sits at the *upper* edge of the class it bounds, so a reader
  // lines the number up with the break rather than the middle of a band.
  #grid(
    columns: palette.len(),
    column-gutter: 0pt,
    ..palette.map(c => box(width: 100%, height: 7pt, fill: c)),
    ..breaks.map(b => box(width: 100%)[
      #v(0.2em)
      #align(right, text(size: t.scale.micro, fill: t.colors.muted)[#fmt(b)])
    ]),
  )
]

/// Render a GeoJSON / TopoJSON map.
///
/// Flat:
/// ```typ
/// #map(read("assets/world.geojson", encoding: none), projection: "robinson")
/// ```
///
/// Choropleth — `property` names a numeric field on each feature, which is
/// classed into the theme's `sequential` ramp:
/// ```typ
/// #map(
///   read("assets/world.geojson", encoding: none),
///   property: "import_dependence",
///   legend-title: [% of calories imported],
/// )
/// ```
#let map(
  /// GeoJSON/TopoJSON as bytes (`read("assets/world.geojson", encoding: none)`)
  /// or a root-absolute path. A bare relative path would be resolved inside
  /// this package rather than next to your report — see `bleed`.
  src,
  /// Numeric feature property to colour by, or `none` for a flat map.
  property: none,
  /// Colour ramp. `auto` uses the theme's `sequential`.
  palette: auto,
  /// Number of classes, or an explicit ascending array of upper bounds.
  classes: 5,
  /// Fill for features with no value for `property`.
  missing: auto,
  /// Flat fill, used when `property` is `none`.
  fill: auto,
  /// Border colour.
  stroke: auto,
  /// Border width, in projected units.
  stroke-width: 0.06,
  /// Projection name — see the mercator README for the full list.
  projection: "natural_earth",
  /// Extra projection parameters, e.g. `(center_lat: 20)`.
  projection-args: (:),
  /// `(step: 15)` to draw a graticule, or `none`.
  graticule: none,
  /// Draw the class legend beneath the map.
  legend: true,
  /// Legend heading.
  legend-title: none,
  /// How class bounds are labelled.
  legend-format: n => [#calc.round(n, digits: 1)],
  /// Width of the rendered map.
  width: 100%,
  ..rest
) = context {
  let t = get-theme()
  let palette = if palette == auto { t.colors.sequential } else { palette }
  let stroke = if stroke == auto { t.colors.paper } else { stroke }
  let missing = if missing == auto { t.colors.surface-strong } else { missing }

  let config = (:)
  config.insert("stroke", stroke.to-hex())
  config.insert("stroke_width", stroke-width)
  config.insert(
    "projection",
    (("type": projection),) .first() + projection-args,
  )
  if graticule != none {
    config.insert("graticule", (("color": t.colors.rule.to-hex()),).first() + graticule)
  }

  let breaks = ()

  let raw = if type(src) == bytes { src } else { read(src, encoding: none) }

  let payload = if property == none {
    config.insert("fill", (if fill == auto { t.colors.surface-strong } else { fill }).to-hex())
    raw
  } else {
    // Class the data here and bake a colour into every feature, because
    // mercator can only interpolate a property into the fill string.
    let doc = json(raw)
    let values = doc
      .at("features", default: ())
      .map(f => f.at("properties", default: (:)).at(property, default: none))
      .filter(v => type(v) in (int, float))

    assert(
      values.len() > 0,
      message: "map: no numeric values found for property " + repr(property),
    )

    breaks = if type(classes) == array { classes } else { _equal-breaks(values, classes) }

    doc.features = doc.at("features", default: ()).map(f => {
      let props = f.at("properties", default: (:))
      let v = props.at(property, default: none)
      props.insert(
        "_dossier_fill",
        if type(v) in (int, float) {
          palette.at(calc.min(_class-of(v, breaks), palette.len() - 1)).to-hex()
        } else { missing.to-hex() },
      )
      f.insert("properties", props)
      f
    })

    config.insert("fill", "{_dossier_fill}")
    json.encode(doc)
  }

  mercator.render-map(payload, json.encode(config), width: width, ..rest)

  if property != none and legend {
    _map-legend(breaks, palette, legend-title, t, legend-format)
  }
}

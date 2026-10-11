// DeepLink Technical Brief theme.
// A reusable Touying deck system for technical briefings:
// dark section dividers, light card-first content pages, and configurable accent palettes.

#import "@preview/touying:0.7.3": *
#import themes.default: *
#import "config.typ": default-config, default-metadata

// Public runtime state. The legacy implementation below remains private to the
// package; lib.typ exports the normalized API defined at the end of this file.
#let public-theme-config = state("technical-brief-public-config", default-config)
#let public-theme-metadata = state("technical-brief-public-metadata", (
  title: [Technical Brief],
  subtitle: [],
  author: [],
  institution: [],
  date: datetime.today(),
))

// ---- Color Tokens -------------------------------------------------------

#let navy = rgb("#07152B")
#let blue = rgb("#174EA6")
#let blue2 = rgb("#5B8FE8")
#let gold = rgb("#B98A32")
#let teal = rgb("#2A8C7C")
#let paper = rgb("#FBFCFE")
#let ink = rgb("#162033")
#let muted-color = rgb("#667386")
#let border = rgb("#E0E7F0")
#let pale = rgb("#F5F8FD")
#let light = rgb("#DCEBFF")
#let rowalt = rgb("#F8FAFD")

// ---- Semantic Accent Tokens ----------------------------------------------
// Meaning-colors shared by component defaults (claim kinds, admonitions,
// quadrants, legends). Prefer these over raw rgb literals in decks.
// These are the single color source of the theme: the default accent cycling
// palette below is built from these same values, so auto-cycled accents and
// meaning-colors always belong to one family.
#let info-color = rgb("#2563EB")
#let ok-color = rgb("#16A34A")
#let warn-color = rgb("#B45309")
#let danger-color = rgb("#DC2626")
#let violet-color = rgb("#7C3AED")
#let cyan-color = rgb("#0891B2")
#let orange-color = rgb("#EA580C")
#let slate-color = rgb("#64748B")
// Ghost tone for connective tissue: arrows, muted edges, dividers.
#let ghost-color = rgb("#94A3B8")

// Default cycling palette, derived from the semantic tokens (ordered for
// pleasant adjacency when cards cycle). All values are 600/700-grade, so
// cycled accents stay readable as small text on white cards.
#let semantic-accent-palette = (
  info-color,
  danger-color,
  warn-color,
  ok-color,
  violet-color,
  cyan-color,
  orange-color,
  slate-color,
)

#let google-accent-palette = (
  rgb("#4285F4"),
  rgb("#DB4437"),
  rgb("#F4B400"),
  rgb("#0F9D58"),
)

// Material Design 500-series hues: intentionally brighter and more UI-like.
#let material-accent-palette = (
  rgb("#2196F3"), // Blue 500
  rgb("#F44336"), // Red 500
  rgb("#FFC107"), // Amber 500
  rgb("#4CAF50"), // Green 500
  rgb("#9C27B0"), // Purple 500
  rgb("#00BCD4"), // Cyan 500
  rgb("#FF5722"), // Deep Orange 500
  rgb("#607D8B"), // Blue Grey 500
)

// Classic Apple rainbow-inspired palette: warmer, retro, less Google-like.
#let classic-mac-accent-palette = (
  rgb("#009DDC"), // blue
  rgb("#963D97"), // purple
  rgb("#E03A3E"), // red
  rgb("#F5821F"), // orange
  rgb("#FDB827"), // yellow
  rgb("#61BB46"), // green
)

// The theme default: same source as the semantic tokens. Opting into
// google/material/classic-mac gives a different decorative cycle, but the
// meaning-colors (info/ok/warn/danger/...) stay fixed by design.
#let technical-brief-accent-palette = semantic-accent-palette

#let accent-palette-config = state("technical-brief-accent-palette-config", semantic-accent-palette)

#let set-accent-palette(palette) = {
  assert(palette.len() >= 1, message: "set-accent-palette requires at least one color")
  accent-palette-config.update(_ => palette)
}

#let palette-rule(palette, length: 100%, thickness: 0.85pt) = box(width: length)[
  #grid(
    columns: palette.map(_ => 1fr),
    column-gutter: 0pt,
    ..palette.map(color => rect(width: 100%, height: thickness, fill: color)),
  )
]

// Brand rule shared by title / section pages: the same accent parallelogram +
// palette hairline signature that every content page header carries. On dark
// ground the 600-grade accents disappear into navy, so `dark: true` lifts
// every segment toward its pastel register.
#let brand-rule(length: 100%, thickness: 0.66pt, dark: false) = context {
  let palette = accent-palette-config.get()
  let shown = if dark { palette.map(c => c.lighten(34%)) } else { palette }
  box(width: length)[
    #grid(
      columns: (0.72cm, 1fr),
      column-gutter: 0.08cm,
      align: horizon,
      polygon(
        fill: shown.at(0),
        stroke: none,
        (0cm, 0cm),
        (0.68cm, 0cm),
        (0.58cm, 0.13cm),
        (-0.10cm, 0.13cm),
      ),
      palette-rule(shown, length: 100%, thickness: thickness),
    )
  ]
}

// Category pill for dark divider pages, same shape language as component tags.
#let divider-category-color = rgb("#B7D4FF")
#let _divider-pill(label) = box(
  fill: white.transparentize(90%),
  stroke: 0.5pt + white.transparentize(72%),
  radius: 4pt,
  inset: (x: 6pt, y: 2.5pt),
)[
  #text(size: 7.3pt, weight: "bold", fill: divider-category-color)[#label]
]

// ---- Geometry Tokens ----------------------------------------------------

#let foreground-note-dx = 0.78cm
#let foreground-note-dy = -0.62cm
#let ending-strip-inset-y = 5pt
#let ending-strip-text-size = 8.1pt
// Body layout reserve for the foreground ending strip (offset + strip box).
#let ending-strip-reserve = calc.abs(foreground-note-dy) + 2 * ending-strip-inset-y + ending-strip-text-size * 1.32
#let divider-rule-length-default = 7.2cm
#let divider-title-size-default = 17.6pt
#let deck-width = 19.2cm
#let deck-height = 10.8cm
// Latin-first ordering so Western glyphs use Helvetica Neue and CJK falls back to
// PingFang SC. This keeps Chinese and English on separate, intentional typefaces
// instead of rendering English with PingFang's UI-oriented Latin forms.
#let deck-fonts = ("Source Han Sans SC VF", "Source Han Sans SC", "Noto Sans CJK SC", "PingFang SC", "Microsoft YaHei")
#let code-fonts = ("JetBrains Mono", "Noto Sans Mono CJK SC", "Menlo")
#let deck-font-size = 9.2pt
#let layout-gap = 0.30cm

// ---- Component Tokens -----------------------------------------------------
// One shared geometry/typography vocabulary for every card-like component,
// so the whole deck reads as a single system.
#let card-radius = 9pt        // primary cards
#let chip-radius = 6pt        // small cells / pills / captions
#let card-stroke = 0.5pt + border
#let card-accent-stroke = 2.8pt // width of the colored left bar on cards
#let card-inset = (x: 10pt, y: 9pt)
// Role-based type scale. Component implementations should use these tokens
// instead of accumulating unrelated 5–7pt literals.
#let fs-source = 5.2pt        // source / methodology notes only
#let fs-label = 5.6pt         // compact labels and tertiary metadata
#let fs-card-note = 5.8pt     // card footnote / meta
#let fs-tag = 6.2pt           // pill/badge label text
#let fs-compact-body = 6.4pt  // dense tables, legends, and comparison rows
#let fs-card-body = 6.6pt     // ordinary component body text
#let fs-card-title = 7.6pt    // card headline

#let page-number(fill: muted-color) = context {
  let current = utils.slide-counter.get().first()
  let total = utils.last-slide-counter.final().first()
  if current > 0 and total > 0 {
    place(bottom + right, dx: -0.58cm, dy: -0.42cm)[
      #text(size: 5.8pt, fill: fill)[#current / #total]
    ]
  }
}

// Touying-aware configs for slides that need explicit light/dark treatment.
#let light-slide-config = (
  config-page(fill: paper, margin: (top: 1.18cm, bottom: 0.95cm, x: 0.82cm), header: none, foreground: page-number())
    + config-colors(neutral-lightest: white)
)
#let dark-slide-config = (
  config-page(fill: navy, margin: (top: 0.72cm, bottom: 0.95cm, x: 1.05cm), foreground: page-number(fill: light.darken(12%)))
    + config-colors(neutral-lightest: white, neutral-dark: navy, neutral-darkest: white)
)

// Default layout used by heading-driven slides.
#let technical-brief-content-slide(body) = slide(
  config: light-slide-config,
)[
  #align(top)[#body]
]

#let technical-brief-section-slide(body) = slide(
  config: dark-slide-config,
)[
  #align(left + horizon)[
    // Brand line comes from the deck metadata registered in the show call,
    // so heading-driven dividers work for any deck, not just DeepLink.
    #context {
      let info = state("technical-brief-deck-info", (institution: [])).get()
      text(size: 7.8pt, weight: "bold", fill: divider-category-color)[#info.at("institution", default: [])]
    }
    #v(0.42cm)
    #text(size: divider-title-size-default, weight: "bold", fill: white)[
      #utils.display-current-heading(level: 1, numbered: false)
    ]
    #v(0.24cm)
    #brand-rule(length: divider-rule-length-default, thickness: 0.95pt, dark: true)
    #v(0.26cm)
    #text(size: 9.2pt, fill: light)[#body]
  ]
]

#let attractor-near-plane = 0.16
#let attractor-fog-near = 1.0
#let attractor-fog-far = 6.0

#let attractor-cameras = (
  (
    eye: (-1.60744, 1.47329, -2.62968),
    center: (0.141248, -0.0999439, 0.850354),
  ),
  (
    eye: (0.0631833, 1.28423, -0.827955),
    center: (0.0631833, 0.00244161, -0.827957),
  ),
  (
    eye: (-1.57788, 0.0300631, -1.48228),
    center: (0.0, 0.0, 0.0),
  ),
  (
    eye: (0.99935, 1.32445, -2.86713),
    center: (0.0188739, 0.194861, 0.105587),
  ),
  (
    eye: (-0.838463, 0.602458, -0.156669),
    center: (-1.45554, -0.346908, -2.54362),
  ),
)

// Immersive "from inside the vortex" framing used by the title slide:
// the eye sits just inside the swirl core and looks outward along the
// attractor's z-axis, so the spiral arms wrap around the viewer.
#let attractor-interior-camera = (
  eye: (0.6, 0.2, -1.15),
  center: (0.6, 0.2, 2.0),
)

// Precomputed lookAt camera basis. This is constant per camera, so it is
// hoisted out of the per-sample loop (it used to be recomputed for every
// projected point: one sqrt-normalize plus two cross products per sample).
#let attractor-camera-basis(eye, center) = {
  let (ex, ey, ez) = eye
  let (cx, cy, cz) = center
  let fx = cx - ex
  let fy = cy - ey
  let fz = cz - ez
  let flen = calc.sqrt(fx * fx + fy * fy + fz * fz)
  if flen < 1e-9 { return none }
  fx = fx / flen
  fy = fy / flen
  fz = fz / flen
  let wux = 0.0
  let wuy = 1.0
  let wuz = 0.0
  if calc.abs(fy) > 0.9999 {
    wux = 0.0
    wuy = 0.0
    wuz = 1.0
  }
  let rx = fy * wuz - fz * wuy
  let ry = fz * wux - fx * wuz
  let rz = fx * wuy - fy * wux
  let rlen = calc.sqrt(rx * rx + ry * ry + rz * rz)
  if rlen < 1e-9 { return none }
  rx = rx / rlen
  ry = ry / rlen
  rz = rz / rlen
  (
    ex: ex, ey: ey, ez: ez,
    rx: rx, ry: ry, rz: rz,
    ux: ry * fz - rz * fy,
    uy: rz * fx - rx * fz,
    uz: rx * fy - ry * fx,
    fx: fx, fy: fy, fz: fz,
  )
}

#let attractor-background(
  step: 0,
  dark: true,
  splines: 46,
  warmup: 520,
  tail-length: 1024,
  stride: 2,
  camera: none,
  width: deck-width,
  height: deck-height,
) = {
  let palette = if dark {
    (
      (paint: rgb("#F2F6FF").transparentize(62%), thickness: 0.42pt),
      (paint: blue2.transparentize(56%), thickness: 0.46pt),
      (paint: gold.lighten(18%).transparentize(58%), thickness: 0.42pt),
      (paint: teal.lighten(20%).transparentize(62%), thickness: 0.42pt),
    )
  } else {
    // Content pages: the vortex must stay a whisper — these lines run behind
    // body text and cards, so anything stronger reads as noise.
    (
      (paint: navy.transparentize(93%), thickness: 0.40pt),
      (paint: blue.transparentize(92%), thickness: 0.42pt),
      (paint: gold.transparentize(91%), thickness: 0.40pt),
      (paint: teal.transparentize(93%), thickness: 0.40pt),
    )
  }

  let camera = if camera != none {
    camera
  } else {
    attractor-cameras.at(calc.rem(step, attractor-cameras.len()))
  }
  let basis = attractor-camera-basis(camera.eye, camera.center)
  if basis == none { return }
  let (ex, ey, ez, rx, ry, rz, ux, uy, uz, fx, fy, fz) = basis
  let focal = (height / 2) / calc.tan(45deg)
  let half-w = width * 0.5
  let half-h = height * 0.5

  let drawings = ()
  // Static Typst version of the homepage attractor: deterministic warmup,
  // Euler integration, lookAt perspective projection, and sparse tails.
  // `step` is mixed into the seeds instead of being added to the warmup
  // iteration count: pages still get visibly different tails, but the cost
  // per page stays constant instead of growing with the page index.
  let ca = 4
  let oc = 0.05 / ca
  let eps = 0.25 / ca
  for si in range(splines) {
    let x = (calc.rem(si * 37 + 11 + step * 29, 100) / 100) - 0.5
    let y = (calc.rem(si * 53 + 23 + step * 17, 100) / 100) - 0.5
    let z = (calc.rem(si * 71 + 41 + step * 43, 100) / 100) - 0.5

    // Inlined Euler integration: no closure call or tuple allocation in the
    // hot loop (it runs warmup + tail-length times per spline).
    for _ in range(warmup + si * 9) {
      let dx = oc * ((z - 0.2) * x - 3.5 * y)
      let dy = oc * (3.5 * x + (z - 0.2) * y)
      let dz = oc * (0.7 + 0.95 * z - z * z * z / 3 - (x * x + y * y) * (1 + eps * z) + 0.1 * z * x * x * x)
      x = x + dx
      y = y + dy
      z = z + dz
    }

    // Tail: integrate and project in a single pass (no intermediate samples
    // array). Points behind the near plane or beyond the fog cutoff split
    // the polyline, matching the previous culling behaviour.
    let components = ()
    let drawing = false
    for pi in range(tail-length) {
      let dx = oc * ((z - 0.2) * x - 3.5 * y)
      let dy = oc * (3.5 * x + (z - 0.2) * y)
      let dz = oc * (0.7 + 0.95 * z - z * z * z / 3 - (x * x + y * y) * (1 + eps * z) + 0.1 * z * x * x * x)
      x = x + dx
      y = y + dy
      z = z + dz
      if calc.rem(pi, stride) == 0 {
        let vx = x - ex
        let vy = y - ey
        let vz = z - ez
        let zs = vx * fx + vy * fy + vz * fz
        if zs > attractor-near-plane and zs < attractor-fog-far {
          let inv = focal / zs
          let pt = (
            half-w + (vx * rx + vy * ry + vz * rz) * inv,
            half-h - (vx * ux + vy * uy + vz * uz) * inv,
          )
          if drawing {
            components.push(curve.line(pt))
          } else {
            components.push(curve.move(pt))
            drawing = true
          }
        } else {
          drawing = false
        }
      }
    }
    if components.len() > 0 {
      drawings.push(curve(stroke: palette.at(calc.rem(si, palette.len())), ..components))
    }
  }
  block(width: width, height: height, clip: true)[
    #for spline in drawings {
      place(top + left, spline)
    }
  ]
}

// Global auto-advancing step shared by every slide that shows the attractor.
// Each call jumps the counter by `attractor-step-stride`, so consecutive pages
// land on visibly different phases of the same vortex.
#let attractor-step-counter = counter("technical-brief-attractor-step")
// Pre-baked attractor assets used by `render: "cached"` (see justfile's
// `attractor-cache` recipe). Phases cycle per page.
#let attractor-cache-phases = 8
#let attractor-cache-dir = "../assets/attractor"
#let attractor-background-config = state(
  "technical-brief-attractor-background-config",
  (
    render: "off",
    cache-profile: "standard",
    splines: 46,
    content-splines: 30,
    warmup: 520,
    tail-length: 1024,
    stride: 2,
    step-stride: 620,
    step-offset: 0,
  ),
)

#let set-attractor-background(
  render: auto,
  cache-profile: auto,
  splines: auto,
  content-splines: auto,
  warmup: auto,
  tail-length: auto,
  stride: auto,
  step-stride: auto,
  step-offset: auto,
) = {
  attractor-background-config.update(config => (
    render: if render == auto { config.at("render", default: "off") } else { render },
    cache-profile: if cache-profile == auto { config.at("cache-profile", default: "standard") } else { cache-profile },
    splines: if splines == auto { config.splines } else { splines },
    content-splines: if content-splines == auto { config.at("content-splines") } else { content-splines },
    warmup: if warmup == auto { config.warmup } else { warmup },
    tail-length: if tail-length == auto { config.at("tail-length") } else { tail-length },
    stride: if stride == auto { config.stride } else { stride },
    step-stride: if step-stride == auto { config.at("step-stride") } else { step-stride },
    step-offset: if step-offset == auto { config.at("step-offset") } else { step-offset },
  ))
}

#let _input-int(name, default) = {
  let value = sys.inputs.at(name, default: none)
  if value == none {
    default
  } else {
    int(value)
  }
}

#let _input-attractor-preset() = {
  let mode = sys.inputs.at("mode", default: none)
  if mode != none {
    mode
  } else {
    // Default: pre-baked SVG vortex (fast enough for live preview). Pass
    // `--input mode=preview` for blank-background compiles, `mode=full` to
    // integrate the attractor from scratch.
    sys.inputs.at("attractor", default: "cached")
  }
}

#let set-attractor-background-from-inputs(
  preview-splines: 0,
  preview-content-splines: 0,
  preview-tail-length: 1,
  preview-step-stride: 1,
) = {
  let preset = _input-attractor-preset()
  if preset == "off" {
    set-attractor-background(
      render: "compute",
      splines: 0,
      content-splines: 0,
      tail-length: 1,
      step-stride: 1,
      step-offset: _input-int("attractor-step-offset", 0),
    )
  } else if preset == "cached" {
    // Real-time preview with the full-quality vortex: pages cycle through
    // pre-baked SVG phases instead of integrating the attractor per compile.
    // Generate the assets once with `just attractor-cache`.
    set-attractor-background(
      render: "cached",
      step-stride: 1,
      step-offset: _input-int("attractor-step-offset", 0),
    )
  } else if preset == "full" {
    set-attractor-background(
      render: "compute",
      splines: _input-int("attractor-splines", 46),
      content-splines: _input-int("attractor-content-splines", 30),
      warmup: _input-int("attractor-warmup", 520),
      tail-length: _input-int("attractor-tail-length", 1024),
      stride: _input-int("attractor-stride", 2),
      step-stride: _input-int("attractor-step-stride", 620),
      step-offset: _input-int("attractor-step-offset", 0),
    )
  } else {
    set-attractor-background(
      splines: _input-int("attractor-splines", preview-splines),
      content-splines: _input-int("attractor-content-splines", preview-content-splines),
      tail-length: _input-int("attractor-tail-length", preview-tail-length),
      step-stride: _input-int("attractor-step-stride", preview-step-stride),
      step-offset: _input-int("attractor-step-offset", 0),
    )
  }
}

// Resolve the background step and place the attractor layer in one call.
//   step: auto -> use (and advance) the global counter
//   step: none -> draw nothing
//   step: <int> -> use that fixed value
#let attractor-layer(
  step: auto,
  dark: true,
  splines: auto,
  dx: -1.05cm,
  dy: -0.72cm,
  width: deck-width,
  height: deck-height,
) = {
  let draw(s) = place(
    top + left,
    dx: dx,
    dy: dy,
    context {
      let config = attractor-background-config.get()
      let render = config.at("render", default: "off")
      if render == "off" {
        // Explicitly blank: the public theme is clean and deterministic by default.
      } else if render == "cached" {
        // Pre-baked SVG phase: constant-time per compile, so live preview
        // (typst watch / tinymist) stays responsive with the vortex visible.
        let variant = if dark { "dark" } else { "light" }
        let phase = calc.rem(calc.abs(s), attractor-cache-phases) + 1
        let profile = config.at("cache-profile", default: "standard")
        block(width: width, height: height, clip: true)[
          #image(attractor-cache-dir + "/" + profile + "/" + variant + "-" + str(phase) + ".svg", width: width, height: height)
        ]
      } else {
        let particle-count = if splines != auto {
          splines
        } else if dark {
          config.splines
        } else {
          config.at("content-splines")
        }
        attractor-background(
          step: s,
          dark: dark,
          splines: particle-count,
          warmup: config.warmup,
          tail-length: config.at("tail-length"),
          stride: config.stride,
          camera: attractor-interior-camera,
          width: width,
          height: height,
        )
      }
    },
  )
  if step == none {
    // no background
  } else if step == auto {
    context {
      let config = attractor-background-config.get()
      attractor-step-counter.update(n => n + config.at("step-stride"))
      context draw(config.at("step-offset") + attractor-step-counter.get().first())
    }
  } else {
    draw(step)
  }
}

// Deck metadata registered by `technical-brief-theme(...)`. `title-slide()`
// reads it so decks don't have to repeat title/author/institution twice.
#let deck-info = state("technical-brief-deck-info", (
  title: [],
  subtitle: [],
  author: [],
  institution: [],
  date: datetime.today(),
))

#let title-slide(
  title: auto,
  subtitle: auto,
  author: auto,
  date: auto,
  institution: auto,
  title-x: 1.12cm,
  title-y: 2.26cm,
  title-width: 12.7cm,
  title-subtitle-gap: -0.42cm,
  subtitle-rule-gap: 0.14cm,
  rule-meta-gap: 0.30cm,
  attractor-step: auto,
) = slide(
  config: config-page(fill: navy, margin: (top: 0.72cm, bottom: 0.72cm, x: 1.05cm), header: none, footer: none)
    + config-colors(neutral-lightest: white, neutral-dark: light, neutral-darkest: white)
    + config-common(freeze-slide-counter: true),
)[
  #align(top + left)[
    #attractor-layer(step: attractor-step, dark: true)
    #context {
      let info = deck-info.get()
      let v-title = if title == auto { info.title } else { title }
      let v-subtitle = if subtitle == auto { info.subtitle } else { subtitle }
      let v-author = if author == auto { info.author } else { author }
      let v-date = if date == auto { info.date } else { date }
      let v-institution = if institution == auto { info.institution } else { institution }
      place(top + left, dx: title-x, dy: title-y)[
        #box(width: title-width)[
          #text(size: 21.2pt, weight: "bold", fill: white)[
            #set par(leading: 0.82em)
            #v-title
          ]
          #v(title-subtitle-gap)
          #text(size: 10.1pt, weight: "medium", fill: light.darken(4%))[
            #v-subtitle
          ]
          #v(subtitle-rule-gap)
          #brand-rule(length: title-width - 0.72cm, dark: true)
          #v(rule-meta-gap)
          #text(size: 7.2pt, fill: light.darken(10%))[
            #text(weight: "semibold", fill: white)[#v-author]
            #h(0.24cm)
            #text(fill: light.darken(26%))[|]
            #h(0.24cm)
            #v-date.display("[year]-[month]-[day]")
            #h(0.24cm)
            #text(fill: light.darken(26%))[|]
            #h(0.24cm)
            #v-institution
          ]
        ]
      ]
    }
  ]
]

#let technical-brief-title-slide = title-slide

// ---- Deck Setup ---------------------------------------------------------

// One-stop deck setup: applies the Touying theme, registers deck metadata
// (consumed by `title-slide()`), and installs the document-wide text /
// heading / list defaults so decks don't need their own `#set` boilerplate.
#let technical-brief-theme(
  title: [DeepLink Technical Brief],
  subtitle: [Technical Brief],
  author: [DeepLink Technical Brief],
  institution: [DeepLink Technical Brief],
  date: datetime.today(),
) = body => {
  // Registered before the Touying show rule so the state update is plain
  // document content instead of loose slide content.
  deck-info.update((
    title: title,
    subtitle: subtitle,
    author: author,
    institution: institution,
    date: date,
  ))
  show: default-theme.with(
    aspect-ratio: "16-9",
    config-colors(
      primary: gold,
      primary-light: gold.lighten(38%),
      primary-lightest: rgb("#F6E9D2"),
      secondary: navy,
      secondary-light: blue,
      neutral-lightest: white,
      neutral-dark: ink,
      neutral-darkest: navy,
    ),
    config-page(width: deck-width, height: deck-height, margin: 0pt),
    config-common(
      slide-fn: technical-brief-content-slide,
      new-section-slide-fn: technical-brief-section-slide,
      receive-body-for-new-section-slide-fn: false,
    ),
  )
  set text(font: deck-fonts, lang: "zh", size: deck-font-size, fill: ink)
  set heading(numbering: none)
  set list(indent: 0.9em, body-indent: 0.35em)
  show raw: set text(font: code-fonts, size: 0.92em)
  body
}

// ---- Text Helpers -------------------------------------------------------

#let intro(body) = text(size: 7.8pt, fill: muted-color)[
  #set par(leading: 0.88em)
  #body
]
#let intro-block(body, gap: 0.28cm) = {
  v(0.18cm)
  intro(body)
  v(gap)
}

// ---- Panels / Callouts --------------------------------------------------

#let info-panel(
  body,
  height: auto,
  width: 100%,
  fill: pale,
  inset: (x: 0.9em, y: 0.7em),
  radius: 8pt,
  stroke: card-stroke,
) = rect(
  width: width,
  height: height,
  fill: fill,
  stroke: stroke,
  radius: radius,
  inset: inset,
  body,
)

#let callout(body, accent: info-color, fill: pale) = block(
  width: 100%,
  fill: fill,
  radius: 8pt,
  stroke: (left: card-accent-stroke + accent),
  inset: (x: 0.86em, y: 0.58em),
)[
  #text(size: 8.0pt, fill: ink)[
    #set par(leading: 0.88em)
    #body
  ]
]

// Framed figure with an optional caption. `height` caps the figure height.
// With `caption-gap: auto` (default) the image is drawn at its real fitted
// height (no letterbox) and the caption flows right below it, so decks don't
// need hand-tuned negative gaps. Pass an explicit length for the legacy
// fixed-box behavior.
#let image-card(src, caption: none, height: 4.20cm, inset: 8pt, stroke: card-stroke, caption-size: 6.6pt, caption-gap: auto) = rect(
  width: 100%,
  fill: white,
  stroke: stroke,
  radius: chip-radius,
  inset: inset,
)[
  #let caption-block = if caption != none {
    block(width: 100%)[
      #align(center)[#text(size: caption-size, fill: muted-color)[#caption]]
    ]
  }
  #if caption == none {
    image(src, width: 100%, height: height, fit: "contain")
  } else if caption-gap == auto {
    layout(size => {
      let natural = measure(image(src))
      let drawn = if natural.width > 0pt {
        calc.min(height, size.width * (natural.height / natural.width))
      } else {
        height
      }
      stack(
        dir: ttb,
        spacing: 0.06cm,
        image(src, width: 100%, height: drawn, fit: "contain"),
        caption-block,
      )
    })
  } else {
    image(src, width: 100%, height: height, fit: "contain")
    if caption-gap < 0pt {
      move(dy: caption-gap)[#caption-block]
    } else {
      v(caption-gap)
      caption-block
    }
  }
]

// ---- Card / Grid Layout --------------------------------------------------

#let _is-card-spec(item) = type(item) == dictionary and item.at("kind", default: none) == "card"

#let _auto-card-accent(palette, index) = palette.at(calc.rem(index, palette.len()))

// The single visual definition of the accent-bar card. `card(...)` specs in
// card-grid / vstack and direct `vcard(...)` calls all render through this.
#let vcard(
  name,
  body,
  footer: none,
  accent: info-color,
  width: 100%,
) = rect(
  width: width,
  fill: white,
  stroke: (rest: card-stroke, left: card-accent-stroke + accent),
  radius: card-radius,
  inset: card-inset,
)[
  #stack(
    dir: ttb,
    spacing: 6pt,
    text(size: fs-card-title, weight: "bold", fill: accent)[#name],
    text(size: fs-card-body, fill: ink)[
      #set par(leading: 0.88em)
      #body
    ],
    if footer != none {
      text(size: fs-card-note, fill: muted-color)[
        #set par(leading: 0.88em)
        #footer
      ]
    },
  )
]

#let _render-card-spec(item, index: 0) = {
  context {
    let palette = accent-palette-config.get()
    let accent = if item.at("accent") == auto { _auto-card-accent(palette, index) } else { item.at("accent") }
    vcard(item.at("title"), item.at("body"), footer: item.at("footer"), accent: accent)
  }
}

#let render-layout(item, index: 0) = if _is-card-spec(item) {
  _render-card-spec(item, index: index)
} else {
  item
}

#let _is-layout-space(item) = {
  if type(item) != content {
    false
  } else {
    let repr = repr(item)
    repr == "[ ]" or repr.starts-with("parbreak(")
  }
}

#let _layout-body-cells(body) = if type(body) == content and "children" in body.fields().keys() {
  let children = body.fields().children.filter(child => not _is-layout-space(child))
  let cells = ()
  for i in range(children.len()) {
    cells.push(render-layout(children.at(i), index: i))
  }
  cells
} else {
  (render-layout(body),)
}

// Content-block layout helpers for pages that should read more like Typst prose
// than raw grid calls. Use `rows` and `cols` inside `layout-slide`.
#let _layout-cells(children) = {
  let pos = children.pos()
  if pos.len() == 1 {
    _layout-body-cells(pos.at(0))
  } else {
    let cells = ()
    for i in range(pos.len()) {
      cells.push(render-layout(pos.at(i), index: i))
    }
    cells
  }
}

#let _content-items(body) = if type(body) == content and "children" in body.fields().keys() {
  body.fields().children.filter(child => not _is-layout-space(child))
} else {
  (body,)
}

#let _card-grid-cells(children) = {
  // Public cards are already rendered content. Treat every positional child as
  // one grid cell; inspecting its content children would split a card's own
  // title/body structure into unrelated cells.
  let raw = children.pos()
  let cells = ()
  for i in range(raw.len()) {
    cells.push(render-layout(raw.at(i), index: i))
  }
  cells
}

#let card-grid(columns, ..children, rows: auto, gap: layout-gap) = grid(
  columns: columns,
  rows: rows,
  gutter: gap,
  .._card-grid-cells(children),
)

#let rows(ratio, ..children, gap: layout-gap) = grid(
  columns: 100%,
  rows: ratio,
  gutter: gap,
  .._layout-cells(children),
)

#let cols(ratio, ..children, gap: layout-gap, height: auto) = grid(
  columns: ratio,
  rows: height,
  gutter: gap,
  .._layout-cells(children),
)

// Fixed-height box that vertically centers its content. Replaces the common
// `box(width: 100%, height: X)[#align(horizon)[...]]` pattern in decks.
// Vertically center `body` inside `height`. If the content is taller than
// the requested box, fall back to natural flow: squeezing it into the fixed
// box makes the overflow paint over whatever follows.
#let vcenter(body, height: 100%, alignment: horizon) = layout(size => {
  let target = if type(height) == ratio {
    height * size.height
  } else if type(height) == relative {
    height.ratio * size.height + height.length
  } else {
    height
  }
  let natural = measure(block(width: size.width, body)).height
  if natural >= target {
    block(width: 100%, body)
  } else {
    box(width: 100%, height: target)[#align(alignment)[#body]]
  }
})

// Numeric weight of a column spec (fraction like 1fr, or a plain number).
#let _frac-amount(f) = {
  if type(f) == fraction {
    let s = repr(f)
    float(s.slice(0, s.len() - 2))
  } else if type(f) == int or type(f) == float {
    float(f)
  } else {
    1.0
  }
}

// Equal-height columns: measure each column's natural height at its own width,
// then stretch every card to the tallest one via a scoped `set rect(height: ...)`.
// Cards must leave `height` unset (the default) for the set rule to apply.
#let equal-cols(ratio, ..children, gap: layout-gap) = {
  let cells = _layout-cells(children)
  layout(size => {
    let n = cells.len()
    let total-gap = if n > 1 { gap * (n - 1) } else { 0pt }
    let avail = size.width - total-gap
    let amounts = ratio.map(_frac-amount)
    let fsum = amounts.fold(0.0, (a, b) => a + b)
    let widths = amounts.map(a => avail * a / fsum)
    let maxh = calc.max(
      ..cells
        .enumerate()
        .map(((i, c)) => measure(box(width: widths.at(i))[#c]).height),
    )
    grid(
      columns: ratio,
      column-gutter: gap,
      ..cells.map(c => {
        set rect(height: maxh)
        c
      }),
    )
  })
}

// Page takeaway strip: a flat solid navy bar, same visual family as
// banner-strip (solid rounded bar + white text). No outline — a stroke on the
// dark fill reads muddy on light pages.
#let ending-strip(body) = block(
  width: 100%,
  fill: navy,
  radius: chip-radius,
  inset: (x: 11pt, y: ending-strip-inset-y),
)[
  #text(size: ending-strip-text-size, weight: "semibold", fill: white)[
    #set par(leading: 0.86em)
    #body
  ]
]

#let page-header-accent-counter = counter("technical-brief-page-header-accent")

#let page-header(title) = {
  page-header-accent-counter.update(n => n + 1)
  context {
    let palette = accent-palette-config.get()
    let accent = _auto-card-accent(palette, page-header-accent-counter.get().first() - 1)
    [
      #place(top + left, dx: 0.82cm, dy: 0.42cm)[
        #text(size: 12.25pt, weight: "bold", fill: navy)[#title]
      ]
      #place(top + left, dx: 0.82cm, dy: 0.90cm)[
        #grid(
          columns: (0.72cm, 1fr),
          column-gutter: 0.08cm,
          align: horizon,
          polygon(
            fill: accent,
            stroke: none,
            (0cm, 0cm),
            (0.68cm, 0cm),
            (0.58cm, 0.13cm),
            (-0.10cm, 0.13cm),
          ),
          palette-rule(palette, length: deck-width - 2.52cm, thickness: 0.58pt),
        )
      ]
    ]
  }
}

#let _layout-slide-foreground(title, ending) = [
  #page-header(title)
  #if ending != none [
    #place(bottom + left, dx: foreground-note-dx, dy: foreground-note-dy)[
      #box(width: deck-width - 2 * foreground-note-dx)[
        #ending-strip(render-layout(ending))
      ]
    ]
  ]
  #page-number()
]

#let _layout-slide-config(title, ending) = {
  utils.merge-dicts(
    light-slide-config,
    config-page(
      footer: none,
      foreground: _layout-slide-foreground(title, ending),
    ),
  )
}

#let _layout-slide-body-area(ending, height, body) = block(
  width: 100%,
  height: 100%,
  inset: (bottom: if ending != none { ending-strip-reserve } else { 0pt }),
)[
  #if height == auto {
    block(width: 100%, height: 100%)[
      #render-layout(body)
    ]
  } else {
    block(width: 100%, height: height)[#render-layout(body)]
  }
]

#let layout-slide(title, height: auto, intro: none, ending: none, attractor-step: auto, body) = slide(
  config: _layout-slide-config(title, ending),
)[
  #block(width: 100%, height: 100%)[
    #attractor-layer(step: attractor-step, dark: false, dx: -0.70cm, dy: -1.08cm)
    #if intro != none {
      block(width: 100%, height: 100%)[
        #grid(
          rows: (auto, 1fr),
          row-gutter: 0pt,
          intro-block(intro),
          _layout-slide-body-area(ending, height, body),
        )
      ]
    } else {
      _layout-slide-body-area(ending, height, body)
    }
  ]
]

// ---- Card Layouts -------------------------------------------------------

#let auto-accent-counter = counter("technical-brief-auto-accent")

#let _with-auto-accent(accent, render) = {
  if accent == auto {
    auto-accent-counter.update(n => n + 1)
    context {
      let palette = accent-palette-config.get()
      render(_auto-card-accent(palette, auto-accent-counter.get().first() - 1))
    }
  } else {
    render(accent)
  }
}

// Primary brief card: scalable, roomy variant used by Technical Brief decks.
#let kpi(label, value, note, accent: auto) = _with-auto-accent(accent, accent => rect(
  width: 100%,
  fill: white,
  stroke: (rest: card-stroke, left: 0.26em + accent),
  radius: card-radius,
  inset: (left: 0.72em, right: 0.72em, top: 0.62em, bottom: 0.62em),
)[
  #text(size: 0.68em, fill: muted-color)[#label] \
  #text(size: 1.34em, fill: accent, weight: "bold")[#value] \
  #text(size: 0.82em, fill: muted-color)[#note]
])

#let card(title, ..args, footer: none, accent: auto, body) = {
  let pos = args.pos()
  assert(pos.len() <= 1, message: "card(title, footer)[body] accepts at most one positional value after title")
  let card-footer = if pos.len() == 1 { pos.at(0) } else { footer }
  (kind: "card", title: title, body: body, footer: card-footer, accent: accent)
}


#let _stack-item(item, index: 0) = if _is-card-spec(item) {
  context {
    let palette = accent-palette-config.get()
    let accent = if item.at("accent") == auto { _auto-card-accent(palette, index) } else { item.at("accent") }
    vcard(
      item.at("title"),
      item.at("body"),
      footer: item.at("footer"),
      accent: accent,
    )
  }
} else {
  item
}

#let vstack(..children, gap: layout-gap, item-align: left) = {
  let pos = children.pos()
  let items = ()
  for i in range(pos.len()) {
    items.push(align(item-align, _stack-item(pos.at(i), index: i)))
  }
  stack(
    dir: ttb,
    spacing: gap,
    ..items,
  )
}

#let kpi-row(..items, gap: 0.16cm) = {
  let pos = items.pos()
  let ratio = ()
  for _ in range(pos.len()) {
    ratio.push(1fr)
  }
  grid(
    columns: ratio,
    gutter: gap,
    ..pos,
  )
}

// ---- Semantic Mini-Cards -------------------------------------------------
// Small reusable cards promoted from deck-local helpers so every deck shares
// one visual language for "phase / badge / formula / tinted note / milestone".

// 阶段卡：左侧标签药丸 + 标题 + 正文；emphasized 高亮当前阶段。
// 适合“部署时 / 跑任务时”这类两阶段并列叙事。
#let phase-card(tag, head, body, accent: info-color, emphasized: false) = block(
  width: 100%,
  fill: if emphasized { accent.lighten(93%) } else { white },
  radius: card-radius,
  stroke: if emphasized { 0.9pt + accent } else { card-stroke },
  inset: (x: 9pt, y: 6pt),
)[
  #grid(columns: (auto, 1fr), column-gutter: 8pt, align: (top, top),
    box(fill: accent, inset: (x: 5pt, y: 2pt), radius: 4pt)[#text(size: fs-tag, weight: "bold", fill: white)[#tag]],
    stack(dir: ttb, spacing: 2pt,
      text(size: fs-card-title, weight: "bold", fill: navy)[#head],
      text(size: fs-card-body, fill: ink)[#set par(leading: 0.88em); #body],
    ),
  )
]

// 徽章卡：圆形徽章 + 标题（含右对齐小注）+ 正文。适合“前提 / 共识”条目。
#let badge-card(badge, head, sub, body, accent: info-color) = block(
  width: 100%, fill: white, radius: card-radius, stroke: card-stroke, inset: (x: 9pt, y: 6.5pt),
)[
  #grid(columns: (auto, 1fr), column-gutter: 9pt, align: (top, top),
    box(circle(fill: accent.lighten(88%), radius: 8.5pt, stroke: 1pt + accent.lighten(40%))[
      #align(center + horizon, text(size: 8.5pt, weight: "bold", fill: accent)[#badge])
    ]),
    stack(dir: ttb, spacing: 2.5pt,
      grid(columns: (auto, 1fr), column-gutter: 6pt, align: (left + horizon, right + horizon),
        text(size: fs-card-title + 0.35pt, weight: "bold", fill: accent)[#head],
        text(size: fs-card-note, fill: muted-color)[#sub],
      ),
      text(size: fs-card-body, fill: ink)[#set par(leading: 0.9em); #body],
    ),
  )
]

// 公式卡：标题 + 白底公式框 + 一句解释。
#let formula-card(
  title,
  formula,
  body,
  accent: info-color,
  title-size: fs-card-title,
  formula-size: 8pt,
  body-size: fs-compact-body,
) = block(
  width: 100%,
  fill: accent.lighten(94%),
  radius: card-radius,
  stroke: 0.65pt + accent.lighten(45%),
  inset: (x: 8pt, y: 6pt),
)[
  #stack(dir: ttb, spacing: 3pt,
    text(size: title-size, weight: "bold", fill: accent.darken(18%))[#title],
    block(width: 100%, fill: white, radius: 5pt, inset: (x: 6pt, y: 4pt), stroke: 0.4pt + accent.lighten(55%))[
      #set text(size: formula-size, fill: navy)
      #formula
    ],
    text(size: body-size, fill: ink)[#set par(leading: 0.9em); #body],
  )
]

// 色底小格：浅色底 + 细边框的极简注释单元（如两种语义的并排对照）。
#let tint-cell(title, body, accent: info-color) = block(
  width: 100%, fill: accent.lighten(93%), radius: chip-radius,
  stroke: 0.5pt + accent.lighten(45%), inset: (x: 7pt, y: 5pt),
)[
  #stack(dir: ttb, spacing: 2pt,
    text(size: fs-compact-body, weight: "bold", fill: accent)[#title],
    text(size: fs-card-body, fill: ink)[#set par(leading: 0.90em); #body],
  )
]

// 里程碑条目：编号圆点 + 名称 + 状态注；emphasized 高亮进行中的阶段。
#let stage-item(marker, name, sub, accent: info-color, sub-color: muted-color, emphasized: false, height: auto) = block(
  width: 100%,
  height: height,
  fill: if emphasized { accent.lighten(93%) } else { white },
  radius: card-radius,
  stroke: if emphasized { 0.9pt + accent } else { card-stroke },
  inset: (x: 9pt, y: 7pt),
)[
  #grid(columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
    box(circle(fill: accent, radius: 7.5pt, stroke: 2pt + white)[
      #align(center + horizon, text(size: 7.5pt, weight: "bold", fill: white)[#marker])
    ]),
    stack(dir: ttb, spacing: 2.5pt,
      text(size: fs-card-title, weight: "bold", fill: navy)[#name],
      text(size: fs-compact-body, weight: if emphasized { "bold" } else { "regular" }, fill: sub-color)[#sub],
    ),
  )
]

// 垂直流转提示：竖排 stack 中的居中衔接箭头，可带一句过渡文字。
#let step-hint(label: none, accent: muted-color, size: 6.6pt) = align(center)[
  #if label == none {
    text(size: size + 0.4pt, fill: ghost-color)[#sym.arrow.b]
  } else {
    text(size: size, weight: "bold", fill: accent)[#label #sym.arrow.b]
  }
]

// 结论横幅：实心色底 + 药丸标签 + 一句白字结论（claim-block 的单行变体）。
#let banner-strip(tag, body, accent: ok-color) = block(width: 100%, fill: accent, radius: card-radius, inset: (x: 10pt, y: 7.5pt))[
  #grid(columns: (auto, 1fr), column-gutter: 9pt, align: (left + horizon, left + horizon),
    box(fill: white.transparentize(80%), inset: (x: 5pt, y: 2pt), radius: 4pt)[#text(size: fs-tag, weight: "bold", fill: white)[#tag]],
    text(size: 6.8pt, weight: "semibold", fill: white)[#set par(leading: 0.92em); #body],
  )
]

// ---- Consumer-proven content controls ---------------------------------
// These components generalize repeated local helpers found across real
// technical decks. They deliberately accept content slots rather than
// consumer-specific assets or product vocabulary.

// Fixed-height flat card with an inset semantic rail. Unlike rail-card, the
// accent stays inside the card border so dense, aligned grids retain a softer
// outer silhouette.
#let flat-card(title, body, accent: info-color, height: 2.05cm, note: none) = rect(
  width: 100%,
  height: height,
  fill: white,
  stroke: 0.55pt + border,
  radius: 8pt,
  inset: (x: 9pt, y: 8pt),
)[
  #grid(
    columns: (0.09cm, 1fr),
    rows: (1fr,),
    column-gutter: 0.18cm,
    rect(width: 0.09cm, height: 100%, fill: accent, radius: 3pt),
    stack(
      dir: ttb,
      spacing: 4pt,
      text(size: fs-card-title, weight: "bold", fill: navy)[#title],
      text(size: fs-card-body, fill: ink)[#set par(leading: 0.90em); #body],
      if note == none { [] } else { text(size: fs-card-note, fill: muted-color)[#note] },
    ),
  )
]

// Flat evidence card with a narrow semantic rail and optional note.
#let rail-card(title, body, note: none, accent: auto, height: auto) = _with-auto-accent(accent, accent => block(
  width: 100%,
  height: height,
  fill: white,
  stroke: card-stroke,
  radius: card-radius,
  clip: true,
  inset: 0pt,
)[
  #grid(
    columns: (0.10cm, 1fr),
    rows: if height == auto { auto } else { (1fr,) },
    grid.cell(fill: accent)[],
    grid.cell(inset: (x: 9pt, y: 8pt))[
      #stack(
        dir: ttb,
        spacing: 4pt,
        text(size: fs-card-title, weight: "bold", fill: navy)[#title],
        text(size: fs-card-body, fill: ink)[#set par(leading: 0.90em); #body],
        if note == none { [] } else { text(size: fs-card-note, fill: muted-color)[#note] },
      )
    ],
  )
])

// One-line labelled band for references, constraints, or summary metadata.
#let label-band(label, body, accent: auto, label-width: 2.45cm) = _with-auto-accent(accent, accent => block(
  width: 100%,
  fill: accent.lighten(92%),
  stroke: 0.55pt + accent.lighten(60%),
  radius: chip-radius,
  inset: (x: 9pt, y: 7pt),
)[
  #grid(
    columns: (label-width, 1fr),
    column-gutter: 0.18cm,
    align: horizon,
    text(size: 6.8pt, weight: "bold", fill: accent)[#label],
    text(size: fs-compact-body, fill: ink)[#body],
  )
])

// Small source or methodology line intended to sit below evidence.
#let source-note(body, label: none, size: fs-source, fill: muted-color) = block(width: 100%)[
  #set text(size: size, fill: fill)
  #if label != none {
    text(weight: "bold")[#label]
    h(3pt)
  }
  #body
]

// Lightweight section marker that can live inside a content-slide lead.
#let section-chip(label, subtitle: none, accent: navy) = block(width: 100%)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 5pt,
    align: horizon,
    box(fill: accent, radius: 3pt, inset: (x: 5pt, y: 1.8pt))[
      #text(size: fs-tag, weight: "bold", fill: white)[#label]
    ],
    if subtitle == none { [] } else { text(size: 7.4pt, weight: "bold", fill: navy)[#subtitle] },
  )
]

// A denser labelled step than flow-node: tag + title + explanatory body.
#let flow-card(tag, title, body, accent: auto, height: auto) = _with-auto-accent(accent, accent => block(
  width: 100%,
  height: height,
  fill: white,
  radius: card-radius,
  stroke: 0.65pt + accent.lighten(35%),
  inset: (x: 8pt, y: 6pt),
)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    align: (top, top),
    box(fill: accent, inset: (x: 5pt, y: 2pt), radius: 4pt)[
      #text(size: fs-tag, weight: "bold", fill: white)[#tag]
    ],
    stack(
      dir: ttb,
      spacing: 3.2pt,
      text(size: fs-card-title, weight: "bold", fill: navy)[#title],
      text(size: fs-card-body, fill: ink)[#set par(leading: 0.90em); #body],
    ),
  )
])

// General compact chip. Explicit accents encode status; auto accents support
// neutral lists that should follow the configured palette.
#let chip(label, accent: auto, size: fs-tag, prominent: false) = _with-auto-accent(accent, accent => box(
  fill: accent.lighten(if prominent { 86% } else { 92% }),
  stroke: 0.65pt + accent.lighten(40%),
  radius: 3pt,
  inset: (x: 5pt, y: 2.4pt),
)[
  #text(size: size, weight: "bold", fill: accent)[#label]
])

// Chart or diagram legend entry with a consumer-provided swatch.
#let legend-item(swatch, label, size: fs-card-note, gap: 4pt) = grid(
  columns: (auto, 1fr),
  column-gutter: gap,
  align: horizon,
  swatch,
  text(size: size, fill: ink)[#label],
)

// Rich comparison list: arbitrary cells plus a textual verdict. This fills
// the gap between data-table (exact values) and compare-matrix (simple marks).
#let comparison-row(
  tag,
  title,
  subtitle,
  cells,
  verdict,
  accent: auto,
  emphasized: false,
) = (
  tag: tag,
  title: title,
  subtitle: subtitle,
  cells: cells,
  verdict: verdict,
  accent: accent,
  emphasized: emphasized,
)

#let _render-comparison-row(row, columns) = _with-auto-accent(row.accent, accent => block(
  width: 100%,
  fill: if row.emphasized { accent.lighten(93%) } else { white },
  radius: 5pt,
  stroke: if row.emphasized { 0.85pt + accent.lighten(25%) } else { card-stroke },
  inset: (x: 8pt, y: 5pt),
)[
  #let first = stack(
    dir: ttb,
    spacing: 1.5pt,
    box(fill: accent, inset: (x: 4pt, y: 1pt), radius: 3pt)[
      #text(size: fs-label, weight: "bold", fill: white)[#row.tag]
    ],
    text(size: 7.4pt, weight: "bold", fill: if row.emphasized { accent } else { navy })[#row.title],
    text(size: fs-label, fill: muted-color)[#row.subtitle],
  )
  #grid(
    columns: columns,
    column-gutter: 5pt,
    align: (x, y) => if x == 0 or x == columns.len() - 1 { left + horizon } else { center + horizon },
    first,
    ..row.cells,
    text(size: fs-compact-body, weight: "bold", fill: accent)[#row.verdict],
  )
])

#let comparison-list(headers, ..rows, columns: auto, gap: 4pt) = {
  let items = rows.pos()
  assert(headers.len() >= 3, message: "comparison-list requires at least three headers")
  for item in items {
    assert(item.cells.len() == headers.len() - 2, message: "comparison-row cell count must match comparison-list headers")
  }
  let resolved-columns = if columns == auto {
    (2.40cm,) + range(headers.len() - 2).map(_ => 1fr) + (1.70fr,)
  } else {
    columns
  }
  assert(resolved-columns.len() == headers.len(), message: "comparison-list columns must match headers")
  stack(
    dir: ttb,
    spacing: gap,
    grid(
      columns: resolved-columns,
      column-gutter: 5pt,
      align: (x, y) => if x == 0 or x == resolved-columns.len() - 1 { left + horizon } else { center + horizon },
      ..headers.map(header => text(size: fs-card-note, weight: "bold", fill: muted-color)[#header]),
    ),
    ..items.map(item => _render-comparison-row(item, resolved-columns)),
  )
}

// Argument builder for media-card key/value details.
#let spec-row(key, value) = (key: key, value: value)

#let _media-content(media) = if type(media) == str {
  image(media, width: 100%, height: 100%, fit: "contain")
} else {
  media
}

// Annotated visual card. Optional tag, badge, specs, and footer subsume the
// repeated workload/topology/pose/panel helpers found in consumer decks.
#let media-card(
  title,
  media,
  subtitle: none,
  tag: none,
  badge: none,
  specs: (),
  footer: none,
  accent: auto,
  height: 4.10cm,
) = _with-auto-accent(accent, accent => {
  let details = specs.map(spec => grid(
    columns: (auto, 1fr),
    column-gutter: 5pt,
    align: (left + horizon, left + horizon),
    text(size: fs-label, weight: "bold", fill: accent)[#spec.key],
    text(size: fs-label, fill: ink)[#spec.value],
  ))
  if footer != none {
    details.push(text(size: 5.9pt, weight: "bold", fill: accent)[#footer])
  }
  block(
    width: 100%,
    height: height,
    fill: white,
    radius: 5pt,
    stroke: (left: 2.2pt + accent, rest: 0.55pt + accent.lighten(40%)),
    clip: true,
    inset: 0pt,
  )[
    #grid(
      columns: 1fr,
      rows: (auto, 1fr, auto),
      block(width: 100%, fill: accent.lighten(93%), inset: (x: 7pt, y: 5pt))[
        #grid(
          columns: (auto, 1fr, auto),
          column-gutter: 5pt,
          align: horizon,
          if tag == none { [] } else {
            box(fill: accent, inset: (x: 4pt, y: 1pt), radius: 3pt)[
              #text(size: fs-label, weight: "bold", fill: white)[#tag]
            ]
          },
          stack(
            dir: ttb,
            spacing: 1.5pt,
            text(size: 7.4pt, weight: "bold", fill: navy)[#title],
            if subtitle == none { [] } else { text(size: fs-label, fill: muted-color)[#subtitle] },
          ),
          if badge == none { [] } else { chip(badge, accent: accent, size: fs-card-note) },
        )
      ],
      block(width: 100%, height: 100%, inset: (x: 5pt, y: 3pt))[
        #align(center + horizon)[#_media-content(media)]
      ],
      if details.len() == 0 { [] } else {
        block(width: 100%, fill: accent.lighten(94%), stroke: (top: 0.5pt + accent.lighten(55%)), inset: (x: 7pt, y: 4pt))[
          #stack(dir: ttb, spacing: 2.2pt, ..details)
        ]
      },
    )
  ]
})

// Builder and renderer for responsibility or architecture layers.
#let layer(title, body, accent: auto) = (title: title, body: body, accent: accent)

#let _render-layer(item) = _with-auto-accent(item.accent, accent => block(
  width: 100%,
  fill: accent.lighten(93%),
  stroke: 0.6pt + accent.lighten(42%),
  radius: 4pt,
  inset: (x: 7pt, y: 5pt),
)[
  #stack(
    dir: ttb,
    spacing: 2.5pt,
    text(size: 7.2pt, weight: "bold", fill: accent)[#item.title],
    text(size: fs-compact-body, fill: ink)[#set par(leading: 0.90em); #item.body],
  )
])

#let layer-stack(..layers, gap: 0.10cm) = stack(
  dir: ttb,
  spacing: gap,
  ..layers.pos().map(_render-layer),
)

// Builder and renderer for a vertical ladder with optional visual evidence.
#let ladder-step(marker, title, metric, body, media: none, accent: auto, height: auto) = (
  marker: marker,
  title: title,
  metric: metric,
  body: body,
  media: media,
  accent: accent,
  height: height,
)

#let _ladder-media-content(media, media-width) = if type(media) == str {
  image(media, width: media-width, height: 0.72cm, fit: "contain")
} else {
  media
}

#let _render-ladder-step(item, media-width) = _with-auto-accent(item.accent, accent => {
  let columns = if item.media == none { (auto, 1fr) } else { (auto, media-width, 1fr) }
  let cells = (
    circle(radius: 5.5pt, fill: accent)[
      #align(center + horizon)[#text(size: fs-tag, weight: "bold", fill: white)[#item.marker]]
    ],
  )
  if item.media != none {
    cells.push(align(center + horizon)[#_ladder-media-content(item.media, media-width)])
  }
  cells.push(stack(
    dir: ttb,
    spacing: 1.5pt,
    text(size: 7.4pt, weight: "bold", fill: accent)[#item.title],
    text(size: fs-card-note, weight: "bold", fill: muted-color)[#item.metric],
    text(size: fs-compact-body, fill: ink)[#set par(leading: 0.90em); #item.body],
  ))
  block(
    width: 100%,
    height: item.height,
    fill: accent.lighten(94%),
    stroke: 0.7pt + accent.lighten(42%),
    radius: 4pt,
    inset: (x: 6pt, y: 4pt),
  )[
    #grid(
      columns: columns,
      column-gutter: 6pt,
      align: (x, y) => if x < columns.len() - 1 { center + horizon } else { left + horizon },
      ..cells,
    )
  ]
})

#let ladder(..steps, gap: 3pt, connectors: true, media-width: 1.60cm) = {
  let source = steps.pos()
  let items = ()
  for i in range(source.len()) {
    items.push(_render-ladder-step(source.at(i), media-width))
    if connectors and i < source.len() - 1 {
      items.push(step-hint())
    }
  }
  stack(dir: ttb, spacing: gap, ..items)
}

// Header metadata plus a concise referenced claim or evidence statement.
#let reference-card(kind, title, reference, body, accent: auto, height: auto) = _with-auto-accent(accent, accent => block(
  width: 100%,
  height: height,
  fill: white,
  radius: card-radius,
  stroke: card-stroke,
  clip: true,
  inset: 0pt,
)[
  #grid(
    columns: 1fr,
    rows: if height == auto { (auto, auto) } else { (auto, 1fr) },
    block(width: 100%, fill: accent, inset: (x: 7pt, y: 3pt))[
      #grid(
        columns: (auto, 1fr, auto),
        column-gutter: 6pt,
        align: horizon,
        box(fill: white.transparentize(82%), inset: (x: 4pt, y: 1pt), radius: 3pt)[
          #text(size: fs-card-note, weight: "bold", fill: white)[#kind]
        ],
        text(size: 7.2pt, weight: "bold", fill: white)[#title],
        text(size: fs-card-note, weight: "bold", fill: white.transparentize(10%))[#reference],
      )
    ],
    block(width: 100%, height: if height == auto { auto } else { 100% }, inset: (x: 7pt, y: 5pt))[
      #if height == auto {
        text(size: fs-compact-body, fill: ink)[#set par(leading: 0.90em); #body]
      } else {
        align(horizon)[#text(size: fs-compact-body, fill: ink)[#set par(leading: 0.90em); #body]]
      }
    ],
  )
])

// ---- Dense Slide Utilities ---------------------------------------------

#let clean-item(it) = if type(it) == str { it.replace("•", "").trim() } else { it }

// Optically align a bullet dot with the first line of adjacent text.
#let bullet-dot(accent, size: 7pt) = box(width: 6pt, inset: (top: size * 0.34, left: 0pt))[
  #circle(fill: accent, radius: 1.15pt)
]

#let bullet-row(it, accent, fill: ink, size: 7pt, dot-col: 6pt, col-gutter: 3.2pt) = grid(
  columns: (dot-col, 1fr),
  column-gutter: col-gutter,
  align: top,
  bullet-dot(accent, size: size),
  text(size: size, fill: fill)[
    #set par(leading: 0.88em)
    #clean-item(it)
  ],
)

#let bullets(items, fill: ink, size: 8.8pt, accent: auto) = _with-auto-accent(accent, accent => stack(
  dir: ttb,
  spacing: 6pt,
  ..items.map(it => bullet-row(it, accent, fill: fill, size: size)),
))

#let flow-node(name, detail, fill: pale, accent: auto, text-color: ink, height: 0.90cm) = _with-auto-accent(
  accent,
  accent => rect(
    width: 100%,
    height: height,
    fill: fill,
    stroke: (paint: accent, thickness: 0.7pt),
    radius: 5pt,
    inset: (x: 6pt, y: 5pt),
  )[
    #align(center + horizon)[
      #stack(
        dir: ttb,
        spacing: 2pt,
        align(center, text(size: 6.6pt, weight: "bold", fill: text-color)[#name]),
        align(center, text(size: fs-label, fill: text-color)[#detail]),
      )
    ]
  ],
)

#let flow-arrow(label, accent: info-color) = align(center + horizon)[
  #stack(
    dir: ttb,
    spacing: 2pt,
    align(center, text(size: 9pt, fill: accent)[→]),
    align(center, text(size: fs-label, fill: muted-color)[#label]),
  )
]

#let process-flow(..nodes, labels: (), gap: 0.08cm, arrow-width: 0.54cm) = {
  let pos = nodes.pos()
  let columns = ()
  let items = ()
  for i in range(pos.len()) {
    columns.push(1fr)
    items.push(pos.at(i))
    if i < pos.len() - 1 {
      columns.push(arrow-width)
      let label = if i < labels.len() { labels.at(i) } else { [] }
      items.push(flow-arrow(label))
    }
  }
  grid(
    columns: columns,
    gutter: gap,
    ..items,
  )
}

#let loss-card(
  name,
  reason,
  impact,
  reason-label: [关键问题],
  impact-label: [失效表现],
  accent: auto,
  height: 1.30cm,
) = _with-auto-accent(accent, accent => rect(
  width: 100%,
  height: height,
  fill: white,
  stroke: card-stroke,
  radius: chip-radius,
  inset: 0pt,
)[
  #grid(
    columns: (0.16cm, 1fr),
    rect(width: 0.16cm, height: 100%, fill: accent, radius: (top-left: chip-radius, bottom-left: chip-radius)),
    box(inset: (x: 7pt, y: 5pt))[
      #stack(
        dir: ttb,
        spacing: 3.8pt,
        text(size: 6.6pt, weight: "bold", fill: accent)[#name],
        grid(
          columns: (0.86cm, 1fr),
          column-gutter: 3pt,
          text(size: fs-label, fill: muted-color)[#reason-label], text(size: fs-card-note, fill: ink)[#reason],
        ),
        grid(
          columns: (0.86cm, 1fr),
          column-gutter: 3pt,
          text(size: fs-label, fill: muted-color)[#impact-label], text(size: fs-card-note, fill: ink)[#impact],
        ),
      )
    ],
  )
])

#let loss-grid(..items, columns: (1fr, 1fr), rows: auto, gap: 0.18cm) = grid(
  columns: columns,
  rows: rows,
  gutter: gap,
  ..items.pos(),
)

#let ribbon-row(
  title,
  subtitle,
  labels,
  values,
  accent: auto,
  height: 1.15cm,
  left-width: 3.00cm,
  label-width: 1.45cm,
) = _with-auto-accent(accent, accent => rect(
  width: 100%,
  height: height,
  fill: white,
  stroke: card-stroke,
  radius: chip-radius,
  inset: 0pt,
)[
  #grid(
    columns: (left-width, label-width, 1fr),
    rect(width: 100%, height: 100%, fill: accent, radius: (top-left: chip-radius, bottom-left: chip-radius), inset: (x: 6pt, y: 6pt))[
      #align(left + horizon)[
        #stack(
          dir: ttb,
          spacing: 2pt,
          text(size: 8.1pt, weight: "bold", fill: white)[#title],
          text(size: fs-card-note, weight: "bold", fill: white)[#subtitle],
        )
      ]
    ],
    box(inset: (x: 5pt, y: 6pt))[
      #stack(
        dir: ttb,
        spacing: 4pt,
        ..labels.map(label => text(size: fs-card-note, weight: "bold", fill: muted-color)[#label]),
      )
    ],
    box(inset: (x: 6pt, y: 6pt))[
      #stack(
        dir: ttb,
        spacing: 4pt,
        ..values.map(value => text(size: 6.2pt, fill: ink)[#value]),
      )
    ],
  )
])

#let ribbon-list(..rows, gap: 0.10cm) = stack(
  dir: ttb,
  spacing: gap,
  ..rows.pos(),
)

// Note: the outer rect intentionally omits an explicit `height` so that a
// scoped `set rect(height: ...)` (used by `equal-cols`) can stretch the card
// to a shared height. Passing height explicitly would override that set rule.
#let evidence-card(title, items, size: 7.0pt, accent: auto) = _with-auto-accent(accent, accent => {
  let row-gutter = 5.6pt
  rect(
    width: 100%,
    fill: white,
    stroke: (rest: card-stroke, left: card-accent-stroke + accent),
    radius: card-radius,
    inset: card-inset,
  )[
    #stack(
      dir: ttb,
      spacing: 6.1pt,
      text(size: size, weight: "bold", fill: accent)[#title],
      stack(
        dir: ttb,
        spacing: row-gutter,
        ..items.map(it => bullet-row(it, accent, size: size)),
      ),
    )
  ]
})

#let closing-banner(body, accent: teal, fill: pale) = block(
  width: 100%,
  fill: fill,
  radius: 9pt,
  stroke: none,
  clip: true,
)[
  #grid(
    columns: (3.2pt, 1fr),
    grid.cell(fill: accent)[],
    grid.cell(inset: (x: 0.30cm, y: 0.20cm))[
      #block(width: 100%)[
        #text(size: 9.5pt, weight: "semibold", fill: navy)[
          #set par(leading: 0.88em)
          #body
        ]
      ]
    ],
  )
]

// ---- Logic component: contrast-pair（旧 ⇒ 新 ⇒ 结论） ------------------
// Encodes a before/after argument: a muted "old" side, an accented "new" side,
// connected by ⇒, optionally closed by a conclusion strip. Each side is a dict
// with keys: title, tag, body.
#let _contrast-side(title, tag, body, accent: info-color, muted: false, fill-height: true) = {
  let bar = if muted { ghost-color } else { accent }
  let bg = if muted { rgb("#f1f5f9") } else { white }
  let title-color = if muted { muted-color } else { accent }
  block(width: 100%, height: if fill-height { 100% } else { auto }, fill: bg, radius: card-radius, clip: true, stroke: card-stroke)[
    #grid(columns: (3pt, 1fr), rows: if fill-height { 100% } else { auto },
      grid.cell(fill: bar)[],
      grid.cell(inset: (x: 10pt, y: 8.5pt))[
        #stack(dir: ttb, spacing: 5pt,
          grid(columns: (1fr, auto), align: (left + horizon, right + horizon),
            text(size: 8pt, weight: "bold", fill: title-color)[#title],
            text(size: fs-label, fill: muted-color)[#tag],
          ),
          text(size: fs-card-body, fill: ink)[#set par(leading: 0.9em); #body],
        )
      ],
    )
  ]
}

#let _contrast-verdict(verdict, accent) = block(
  width: 100%, fill: pale, radius: 9pt,
  stroke: (left: card-accent-stroke + accent),
  inset: (x: 0.30cm, y: 0.18cm),
)[
  #grid(columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
    text(size: 6.4pt, weight: "bold", fill: accent)[结论],
    text(size: 8pt, weight: "semibold", fill: navy)[#set par(leading: 0.9em); #verdict],
  )
]

#let contrast-pair(left, right, verdict: none, accent: info-color, height: 3.0cm, dir: ltr) = {
  if dir == ttb {
    // Vertical layout: old above, new below, joined by ⇓, then verdict —
    // fits narrow columns and reads as 过去 ⇒ 现在 ⇒ 结论.
    stack(dir: ttb, spacing: 0.14cm,
      _contrast-side(left.title, left.tag, left.body, muted: true, fill-height: false),
      align(center, text(size: 12pt, weight: "bold", fill: accent)[#sym.arrow.b]),
      _contrast-side(right.title, right.tag, right.body, accent: accent, fill-height: false),
      if verdict != none { _contrast-verdict(verdict, accent) },
    )
  } else {
    stack(dir: ttb, spacing: 0.16cm,
      box(width: 100%, height: height)[
        #grid(columns: (1fr, 0.72cm, 1fr), align: horizon, rows: 100%,
          _contrast-side(left.title, left.tag, left.body, muted: true),
          align(center + horizon, text(size: 15pt, weight: "bold", fill: accent)[#sym.arrow.r]),
          _contrast-side(right.title, right.tag, right.body, accent: accent),
        )
      ],
      if verdict != none { _contrast-verdict(verdict, accent) },
    )
  }
}

// ---- Logic component: timeline（里程碑沿时间轴） ----------------------
// Each milestone is a dict with keys: time, title, body.
#let milestone(time, title, body) = (time: time, title: title, body: body)
#let timeline(..ms, accent: info-color) = {
  let xs = ms.pos()
  let n = xs.len()
  stack(dir: ttb, spacing: 7pt,
    grid(columns: range(n).map(_ => 1fr),
      ..xs.map(m => align(center, text(size: 7pt, weight: "bold", fill: accent)[#m.time]))),
    box(width: 100%, height: 13pt)[
      #place(left + horizon, line(length: 100%, stroke: 1.4pt + accent.lighten(48%)))
      #grid(columns: range(n).map(_ => 1fr),
        ..range(n).map(_ => align(center + horizon, circle(fill: accent, radius: 4pt, stroke: 2.2pt + white))))
    ],
    grid(columns: range(n).map(_ => 1fr), column-gutter: 0.18cm,
      ..xs.map(m => block(inset: (x: 7pt))[
        #stack(dir: ttb, spacing: 4pt,
          align(center, text(size: 7.4pt, weight: "bold", fill: navy)[#m.title]),
          text(size: fs-compact-body, fill: ink)[#set par(leading: 0.92em); #m.body],
        )
      ])),
  )
}

// ---- Logic component: claim-block（命题块，beamer block / theorem 思路） -
// Tags a statement with its role via a colored header bar: 定义 / 命题 /
// 结论 / 方法 / 反例 / 观察（其它取值用默认蓝）。
#let _claim-kind-color(kind) = if kind == [命题] { violet-color } else if kind == [结论] { ok-color } else if kind == [方法] { warn-color } else if kind == [反例] { danger-color } else if kind == [观察] { cyan-color } else if kind == [前提] { cyan-color } else { info-color }

#let claim-block(kind, title, body, accent: auto, compact: false, height: auto) = {
  let ac = if accent == auto { _claim-kind-color(kind) } else { accent }
  let body-pad = if compact { (x: 9pt, y: 5pt) } else { (x: 10pt, y: 8pt) }
  let head-pad = if compact { (x: 9pt, y: 3pt) } else { (x: 9pt, y: 4.5pt) }
  let head = block(width: 100%, fill: ac, inset: head-pad)[
    #grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
      box(fill: white.transparentize(80%), inset: (x: 5pt, y: 1.5pt), radius: 4pt, text(size: fs-tag, weight: "bold", fill: white)[#kind]),
      text(size: fs-card-title, weight: "bold", fill: white)[#title],
    )
  ]
  let body-block = block(width: 100%, inset: body-pad)[
    #text(size: fs-compact-body, fill: ink)[#set par(leading: 0.90em); #body]
  ]
  block(width: 100%, height: height, fill: white, radius: card-radius, stroke: card-stroke, clip: true, inset: 0pt)[
    #if height == auto {
      // Zero-spacing stack avoids a paragraph gap between header and body.
      stack(dir: ttb, spacing: 0pt, head, body-block)
    } else {
      grid(
        columns: 1fr,
        rows: (auto, 1fr),
        head,
        block(width: 100%, height: 100%, inset: body-pad)[
          #align(horizon)[#text(size: fs-compact-body, fill: ink)[#set par(leading: 0.90em); #body]]
        ],
      )
    }
  ]
}

// ---- Logic component: framework-triad（共享标题的一体多面框架） -------
// 一个整体（共享标题栏）拆成 N 个并列面，用 ①②③ 编号、竖线分栏。适合反复
// 回扣的“母题型”框架（如 描述·调度·评价 / 阶段一二三）。facet 是其条目。
#let facet(title, body) = (title: title, body: body)
#let framework-triad(label, ..facets, accent: violet-color) = {
  let fs = facets.pos()
  block(width: 100%, fill: white, radius: card-radius, stroke: card-stroke, clip: true, inset: 0pt)[
    #stack(dir: ttb, spacing: 0pt,
      block(width: 100%, fill: accent, inset: (x: 10pt, y: 5pt))[
        #text(size: 7pt, weight: "bold", fill: white)[#label]
      ],
      grid(
        columns: fs.map(_ => 1fr),
        inset: (x: 10pt, y: 8.5pt),
        stroke: (x, y) => if x > 0 { (left: 0.5pt + border) } else { none },
        ..fs.enumerate().map(((i, f)) => [
          #stack(dir: ttb, spacing: 4.5pt,
            grid(columns: (auto, 1fr), column-gutter: 6pt, align: horizon,
              text(size: 9pt, weight: "bold", fill: accent)[#numbering("①", i + 1)],
            text(size: 7.4pt, weight: "bold", fill: navy)[#f.title],
          ),
            text(size: fs-compact-body, fill: ink)[#set par(leading: 0.9em); #f.body],
          )
        ]),
      ),
    )
  ]
}

// ---- Logic component: admonition（语义提示 / callout） ----------------
// 标注一句话的“认知状态”：注意 / 风险 / 经验 / 前提（其它取值用默认蓝）。
// 左侧色条 + 标签药丸 + 浅底，区别于 claim-block 的实心标题栏。
#let _admonition-color(kind) = if kind == [注意] { warn-color } else if kind == [风险] { danger-color } else if kind == [经验] { ok-color } else if kind == [前提] { violet-color } else { info-color }

#let admonition(kind, body, accent: auto, pad: (x: 9pt, y: 6.5pt), height: auto) = {
  let ac = if accent == auto { _admonition-color(kind) } else { accent }
  // The accent bar is a left stroke (like vcard), not a clipped filled cell:
  // a 3pt cell inside an 8pt-radius clip degenerates into a sliver on
  // single-line admonitions.
  block(
    width: 100%, height: height, fill: ac.lighten(92%), radius: 8pt,
    stroke: (left: card-accent-stroke + ac, rest: 0.5pt + ac.lighten(45%)),
    inset: pad,
  )[
    #align(horizon)[
      #grid(columns: (auto, 1fr), column-gutter: 8pt, align: (left + horizon, left + horizon),
        box(fill: ac, inset: (x: 5pt, y: 1.5pt), radius: 4pt)[#text(size: fs-tag, weight: "bold", fill: white)[#kind]],
        text(size: fs-card-body, fill: ink)[#set par(leading: 0.92em); #body],
      )
    ]
  ]
}

// ---- Logic component: quadrant（2×2 象限：两条正交判据轴） -------------
// 适合“两个二元判据交叉”的分类。tl/tr/bl/br 各传 (title:, body:)。
#let _qcell(title, body, accent) = block(
  width: 100%, height: 100%, fill: accent.lighten(91%),
  radius: 7pt, stroke: 0.6pt + accent.lighten(35%), inset: (x: 8pt, y: 7pt),
)[
  #stack(dir: ttb, spacing: 4pt,
    text(size: 7.4pt, weight: "bold", fill: accent)[#title],
    text(size: fs-compact-body, fill: ink)[#set par(leading: 0.9em); #body],
  )
]
#let quadrant(
  x-axis: [], y-axis: [], tl: none, tr: none, bl: none, br: none,
  accents: (orange-color, info-color, ok-color, violet-color), height: 5.2cm,
) = stack(dir: ttb, spacing: 4pt,
  box(width: 100%, height: height)[
    #let cell(c, accent) = if c == none { block() } else { _qcell(c.title, c.body, accent) }
    #grid(columns: (0.46cm, 1fr), column-gutter: 5pt, rows: 100%,
      grid.cell(align: center + horizon, rotate(-90deg, reflow: true, text(size: fs-tag, weight: "bold", fill: muted-color)[#y-axis #sym.arrow.t])),
      grid.cell(grid(columns: (1fr, 1fr), rows: (1fr, 1fr), column-gutter: 0.16cm, row-gutter: 0.16cm,
        cell(tl, accents.at(0)),
        cell(tr, accents.at(1)),
        cell(bl, accents.at(2)),
        cell(br, accents.at(3)),
      )),
    )
  ],
  grid(columns: (0.46cm, 1fr),
    grid.cell[],
    grid.cell(align: center, text(size: fs-tag, weight: "bold", fill: muted-color)[#x-axis #sym.arrow.r]),
  ),
)

// ---- Logic component: compare-matrix（特性矩阵：行=候选，列=判据） -----
// 格子标记：'y' = ✓、'n' = ✗、'p' = ◐（勉强），其余字符串原样渲染。
#let _mk(m) = if m == "y" { text(size: 7pt, weight: "bold", fill: ok-color)[#sym.checkmark] } else if m == "n" { text(size: 7pt, weight: "bold", fill: danger-color)[#sym.times] } else if m == "p" { text(size: 7.5pt, fill: warn-color)[◐] } else { text(size: fs-card-note, fill: muted-color)[#m] }
#let mrow(name, ..marks) = (name: name, marks: marks.pos())
#let compare-matrix(criteria, ..rows, name-width: 3.0cm, accent: info-color, corner: []) = {
  let rs = rows.pos()
  let cells = ()
  cells.push(grid.cell(fill: accent, inset: (x: 7pt, y: 5pt))[#text(size: fs-tag, weight: "bold", fill: white)[#corner]])
  for c in criteria { cells.push(grid.cell(fill: accent, inset: (x: 4pt, y: 5pt))[#align(center, text(size: fs-tag, weight: "bold", fill: white)[#c])]) }
  for (ri, r) in rs.enumerate() {
    let bg = if calc.even(ri) { white } else { rowalt }
    cells.push(grid.cell(fill: bg, inset: (x: 7pt, y: 5pt))[#text(size: fs-compact-body, weight: "bold", fill: navy)[#r.name]])
    for m in r.marks { cells.push(grid.cell(fill: bg, inset: (x: 4pt, y: 5pt))[#align(center + horizon, _mk(m))]) }
  }
  block(width: 100%, radius: 8pt, clip: true, stroke: 0.4pt + border, inset: 0pt)[
    #grid(columns: (name-width,) + criteria.map(_ => 1fr), stroke: 0.4pt + border, ..cells)
  ]
}

// Legend line matching compare-matrix marks. Pass label overrides per deck,
// e.g. matrix-legend(yes: [满足], no: [结构性短板]).
#let matrix-legend(yes: [契合], partial: [勉强], no: [不适], size: fs-card-note) = text(size: size, fill: muted-color)[
  #text(fill: ok-color, weight: "bold")[#sym.checkmark] #yes#h(4pt)·#h(4pt)#text(fill: warn-color)[◐] #partial#h(4pt)·#h(4pt)#text(fill: danger-color, weight: "bold")[#sym.times] #no
]

// ---- Logic component: causal-chain（因果链：编号节点 + 带标签因果箭头） --
// 纵向因果链：每步 cstep(accent, title, body, then: [边标签])。then 是“通往
// 下一步的因果机制”，显示在两步之间的 ↓ 旁；最后一步不需要 then。
#let cstep(accent, title, body, then: none) = (accent: accent, title: title, body: body, then: then)
#let _cnode(i, s) = grid(
  columns: (auto, 1fr), column-gutter: 9pt, align: (top, top),
  box(circle(fill: s.accent, radius: 8pt, stroke: 2pt + white)[
    #align(center + horizon, text(size: 8pt, weight: "bold", fill: white)[#(i + 1)])
  ]),
  stack(dir: ttb, spacing: 2.5pt,
    text(size: 7.6pt, weight: "bold", fill: navy)[#s.title],
    text(size: fs-compact-body, fill: ink)[#set par(leading: 0.9em); #s.body],
  ),
)
#let _cedge(label) = grid(
  columns: (16pt, 1fr), column-gutter: 9pt, align: (center + horizon, left + horizon),
  text(size: 9pt, fill: ghost-color)[#sym.arrow.b],
  if label == none { [] } else { text(size: fs-tag, weight: "bold", fill: muted-color)[#label] },
)
#let causal-chain(..steps, spacing: 4.5pt) = {
  let ss = steps.pos()
  let items = ()
  for (i, s) in ss.enumerate() {
    items.push(_cnode(i, s))
    // A `then` on the last step is the hand-off into whatever follows the
    // chain (e.g. a pair of cells below); render it instead of dropping it.
    if i < ss.len() - 1 or s.then != none { items.push(_cedge(s.then)) }
  }
  stack(dir: ttb, spacing: spacing, ..items)
}

// ---- Logic component: phase-track（流程阶段：同一对象沿时间推进） ------
// 横向阶段轨道：每格 phase(name, tag, body)，编号即顺序。适合“部署时 →
// 跑任务时 → 扩容时”这类时间推进叙事。
#let phase(name, tag, body) = (name: name, tag: tag, body: body)
#let phase-track(..phases, accent: info-color, height: 3.3cm) = {
  let ps = phases.pos()
  box(width: 100%, height: height)[
    #grid(columns: ps.map(_ => 1fr), column-gutter: 0.18cm, rows: 100%,
      ..ps.enumerate().map(((i, p)) => block(
        width: 100%, height: 100%, fill: white, radius: card-radius, stroke: card-stroke, clip: true, inset: 0pt,
      )[
        #grid(rows: (auto, 1fr),
          block(width: 100%, fill: accent, inset: (x: 8pt, y: 4.5pt))[
            #grid(columns: (auto, 1fr), column-gutter: 6pt, align: horizon,
              box(circle(fill: white, radius: 5.5pt)[#align(center + horizon, text(size: fs-tag, weight: "bold", fill: accent)[#(i + 1)])]),
              text(size: 7pt, weight: "bold", fill: white)[#p.name],
            )
          ],
          block(width: 100%, height: 100%, inset: (x: 8pt, y: 6pt))[
            #stack(dir: ttb, spacing: 3.5pt,
              text(size: fs-card-note, weight: "bold", fill: muted-color)[#p.tag],
              text(size: fs-card-body, fill: ink)[#set par(leading: 0.9em); #p.body],
            )
          ],
        )
      ]),
    )
  ]
}

// ---- Logic component: tradeoff-ledger（取舍账：收益 ✓ vs 代价 ✗） ------
// pro / con T-account：左右两栏对账，避免只讲好处。gains / costs 各传一组
// 条目数组。
#let _ledger-col(title, items, accent, mark) = block(
  width: 100%, height: 100%, fill: accent.lighten(93%),
  radius: card-radius, stroke: 0.5pt + accent.lighten(40%), inset: (x: 9pt, y: 8pt),
)[
  #stack(dir: ttb, spacing: 5.5pt,
    text(size: 7pt, weight: "bold", fill: accent)[#title],
    ..items.map(it => grid(columns: (auto, 1fr), column-gutter: 5pt, align: (center + top, left),
      text(size: 7pt, weight: "bold", fill: accent)[#mark],
      text(size: fs-card-body, fill: ink)[#set par(leading: 0.9em); #it],
    )),
  )
]

#let tradeoff-ledger(
  gains, costs, gain-title: [收益], cost-title: [代价],
  height: 3.8cm, gain-accent: ok-color, cost-accent: warn-color,
) = box(width: 100%, height: height)[
  #grid(columns: (1fr, 1fr), column-gutter: 0.18cm, rows: 100%,
    _ledger-col(gain-title, gains, gain-accent, sym.checkmark),
    _ledger-col(cost-title, costs, cost-accent, sym.times),
  )
]

// ---- Logic component: pyramid-claim（Minto 金字塔：结论先行 + 支撑） ----
// 顶部一句“主张”，下面 N 根并列支撑柱（用 facet(title, body) 传）。适合每幕
// 首页 / 概览页：先抛结论，再用 MECE 的几点支撑它。
#let pyramid-claim(claim, ..supports, accent: info-color, support-height: 2.7cm) = stack(dir: ttb, spacing: 0.16cm,
  block(width: 100%, fill: accent, radius: 9pt, inset: (x: 0.32cm, y: 0.2cm))[
    #grid(columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
      text(size: fs-compact-body, weight: "bold", fill: white.transparentize(12%))[主张],
      text(size: 9pt, weight: "bold", fill: white)[#set par(leading: 0.9em); #claim],
    )
  ],
  box(width: 100%, height: support-height)[
    #grid(columns: supports.pos().map(_ => 1fr), column-gutter: 0.16cm, rows: 100%,
      ..supports.pos().enumerate().map(((i, s)) => block(
        width: 100%, height: 100%, fill: white, radius: 8pt, stroke: 0.5pt + border, inset: (x: 9pt, y: 8pt),
      )[
        #stack(dir: ttb, spacing: 4pt,
          grid(columns: (auto, 1fr), column-gutter: 6pt, align: horizon,
            box(circle(fill: accent, radius: 5.5pt)[#align(center + horizon, text(size: fs-tag, weight: "bold", fill: white)[#(i + 1)])]),
            text(size: 7.2pt, weight: "bold", fill: navy)[#s.title],
          ),
          text(size: fs-compact-body, fill: ink)[#set par(leading: 0.9em); #s.body],
        )
      ]),
    )
  ],
)

// ---- Logic component: rating-list（程度评级 / Harvey balls） ----------
// 用填充圆点表达“程度/成熟度/强弱”。每行 mlevel(dim, level, note)。
#let mlevel(dim, level, note) = (dim: dim, level: level, note: note)
#let rating-list(..rows, accent: info-color, levels: 4, dim-width: 3.0cm, gap: 6pt) = stack(dir: ttb, spacing: gap,
  ..rows.pos().map(r => grid(columns: (dim-width, auto, 1fr), column-gutter: 10pt, align: (left + horizon, left + horizon, left + horizon),
    text(size: 6.6pt, weight: "bold", fill: navy)[#r.dim],
    box[#range(levels).map(k => text(size: 8.5pt, fill: if k < r.level { accent } else { accent.lighten(78%) })[#sym.circle.filled]).join(h(2pt))],
    text(size: 6.2pt, fill: muted-color)[#r.note],
  )),
)

#let section-divider(
  category: [],
  title: [],
  hint: [],
  tags: none,
  body: none,
  attractor-step: auto,
  rule-length: divider-rule-length-default,
  title-size: divider-title-size-default,
) = slide(
  config: config-page(
    fill: navy,
    margin: (top: 0.72cm, bottom: 0.72cm, x: 1.05cm),
    header: none,
    footer: none,
    foreground: page-number(fill: light.darken(12%)),
  )
    + config-colors(neutral-lightest: white, neutral-dark: light, neutral-darkest: white),
)[
  #align(left + horizon)[
    #attractor-layer(step: attractor-step, dark: true)
    #box(width: 12.4cm)[
      #if category != none and category != [] [
        #_divider-pill(category)
        #v(0.30cm)
      ]
      #text(size: title-size, weight: "bold", fill: white)[#title]
      #v(-0.20cm)
      #brand-rule(length: rule-length, thickness: 0.74pt, dark: true)
      #if hint != none and hint != [] [
        #v(0.30cm)
        #text(size: 8.8pt, fill: light.darken(6%))[
          #set par(leading: 0.90em)
          #hint
        ]
      ]
      #if tags != none [
        #v(0.24cm)
        #text(size: 6.8pt, fill: light.darken(18%))[#tags]
      ]
    ]
    #if body != none [
      #v(0.28cm)
      #text(size: 8.8pt, fill: light.darken(6%))[#body]
    ]
  ]
]

#let data-table(rows, columns: auto, highlight-last: true, size: auto, outer-stroke: none, row-height: auto) = {
  context {
    let palette = accent-palette-config.get()
    let cols = rows.at(0).len()
    let column-spec = if columns != auto {
      columns
    } else if cols == 6 {
      (0.62fr, 1.72fr, 1.12fr, 1.02fr, 1.18fr, 1.62fr)
    } else if cols == 3 {
      (1.35fr, 1.55fr, 3.10fr)
    } else {
      range(cols).map(_ => 1fr)
    }
    let header-size = if size != auto { size } else { 7.25pt }
    let body-size = if size != auto { size * 0.95 } else { 6.82pt }
    let table-column-spec = (0.045cm,) + column-spec
    // clip: true keeps header / accent-column fills inside the rounded corners.
    block(
      width: 100%,
      fill: white,
      stroke: outer-stroke,
      radius: card-radius,
      clip: true,
      inset: 0pt,
    )[
      #table(
        columns: table-column-spec,
        rows: if row-height == auto { auto } else { row-height },
        stroke: white,
        inset: (x: 7.4pt, y: 6.2pt),
        align: (x, y) => if x == 1 { center + horizon } else { left + horizon },
        fill: (x, y) => if x == 0 {
          _auto-card-accent(palette, y)
        } else if y == 0 {
          navy
        } else if highlight-last and y == rows.len() - 1 {
          pale
        } else if calc.odd(y) {
          rowalt
        } else {
          white
        },
        ..rows
          .enumerate()
          .map(((y, r)) => {
            let accent-cell = table.cell(fill: _auto-card-accent(palette, y), inset: 0pt)[]
            (
              (accent-cell,)
                + r.map(cell => if y == 0 {
                  text(fill: white, weight: "bold", size: header-size)[#cell]
                } else if highlight-last and y == rows.len() - 1 {
                  text(fill: navy, weight: "bold", size: body-size)[#cell]
                } else {
                  text(fill: ink, size: body-size)[#cell]
                })
            )
          })
          .flatten(),
      )
    ]
  }
}

// ---- Public runtime ------------------------------------------------------
// The implementation above is intentionally kept private. `lib.typ` exposes
// this small, configuration-driven surface plus the stable content components.

#let public-card(title, ..args, footer: none, accent: auto, body) = {
  let pos = args.pos()
  assert(pos.len() <= 1, message: "card(title, footer)[body] accepts at most one positional value after title")
  let card-footer = if pos.len() == 1 { pos.first() } else { footer }
  _with-auto-accent(accent, chosen => vcard(title, body, footer: card-footer, accent: chosen))
}

#let _public-profile(config) = if config.canvas.profile == "wide" {
  (
    margin-x: 1.15cm,
    margin-top: 1.32cm,
    margin-bottom: 0.78cm,
    header-top: 0.26cm,
    header-rule-gap: 0.10cm,
    title-x: 1.50cm,
    title-y: 2.20cm,
    title-width: 19.2cm,
    section-width: 17.0cm,
  )
} else {
  (
    margin-x: 0.82cm,
    margin-top: 1.40cm,
    margin-bottom: 0.96cm,
    header-top: 0.28cm,
    header-rule-gap: 0.10cm,
    title-x: 1.12cm,
    title-y: 2.10cm,
    title-width: 12.8cm,
    section-width: 12.4cm,
  )
}

#let _public-fill(config, kind) = {
  let configured = config.brand.at(kind + "-fill", default: none)
  if configured != none {
    configured
  } else if kind == "content" {
    config.palette.paper
  } else {
    config.palette.navy
  }
}

#let _public-foreground-color(config, kind) = {
  let configured = config.brand.at(kind + "-foreground", default: none)
  if configured != none { configured } else { white }
}

#let _public-brand-rule(config, length: 100%, thickness: 0.75pt, dark: false) = {
  let shown = if dark {
    config.palette.accents.map(color => color.lighten(34%))
  } else {
    config.palette.accents
  }
  box(width: length)[
    #grid(
      columns: (0.72cm, 1fr),
      column-gutter: 0.08cm,
      align: horizon,
      polygon(
        fill: shown.first(),
        stroke: none,
        (0cm, 0cm),
        (0.68cm, 0cm),
        (0.58cm, 0.13cm),
        (-0.10cm, 0.13cm),
      ),
      palette-rule(shown, length: 100%, thickness: thickness),
    )
  ]
}

#let _public-background(config, kind) = {
  let brand-background = config.brand.at(kind + "-background", default: none)
  let provider = config.background
  block(width: config.canvas.width, height: config.canvas.height, clip: true)[
    #if brand-background != none {
      place(top + left, brand-background)
    }
    #if provider.at("kind", default: "none") == "attractor" and provider.at("mode", default: "off") != "off" {
      attractor-layer(
        step: auto,
        dark: kind != "content",
        dx: 0pt,
        dy: 0pt,
        width: config.canvas.width,
        height: config.canvas.height,
      )
    }
  ]
}

#let _public-page-number(config, fill: auto) = context {
  let current = utils.slide-counter.get().first()
  let total = utils.last-slide-counter.final().first()
  if current > 0 and total > 0 {
    place(bottom + right, dx: -0.52cm, dy: -0.34cm)[
      #text(
        size: 5.9pt,
        fill: if fill == auto { config.palette.muted } else { fill },
      )[#current / #total]
    ]
  }
}

#let _public-content-foreground(config, title, takeaway) = {
  let profile = _public-profile(config)
  let mark-reserve = config.brand.header-reserve
  let rule-width = config.canvas.width - 2 * profile.margin-x - mark-reserve
  [
    // Keep the title and separator in one flow-based header. Independent
    // absolute placements made the rule cut through 18–20pt mixed-script
    // titles and left no stable optical gap before the lead.
    #place(top + left, dx: profile.margin-x, dy: profile.header-top)[
      #box(width: rule-width)[
        #stack(
          dir: ttb,
          spacing: profile.header-rule-gap,
          text(size: config.typography.slide-title-size, weight: "bold", fill: config.palette.navy)[
            #set par(leading: 0.86em)
            #title
          ],
          _public-brand-rule(config, length: rule-width, thickness: 0.58pt),
        )
      ]
    ]
    #if config.brand.header-mark != none {
      place(top + right, dx: -profile.margin-x, dy: 0.22cm, config.brand.header-mark)
    }
    #if takeaway != none {
      place(bottom + left, dx: profile.margin-x, dy: -0.48cm)[
        #box(width: config.canvas.width - 2 * profile.margin-x)[
          #block(
            width: 100%,
            fill: config.palette.navy,
            radius: chip-radius,
            inset: (x: 11pt, y: 5pt),
          )[
            #text(size: 8.1pt, weight: "semibold", fill: white)[#render-layout(takeaway)]
          ]
        ]
      ]
    }
    #if config.brand.footer-left != none {
      place(bottom + left, dx: profile.margin-x, dy: -0.22cm)[
        #text(size: 5.8pt, fill: config.palette.muted)[#config.brand.footer-left]
      ]
    }
    #_public-page-number(config)
  ]
}

#let _public-content-config(config, title, takeaway) = config-page(
  fill: _public-fill(config, "content"),
  margin: (
    top: _public-profile(config).margin-top,
    bottom: if takeaway == none { _public-profile(config).margin-bottom } else { 1.42cm },
    x: _public-profile(config).margin-x,
  ),
  header: none,
  footer: none,
  background: _public-background(config, "content"),
  foreground: _public-content-foreground(config, title, takeaway),
) + config-colors(neutral-lightest: white)

#let _public-content-body(config, body, lead: none, height: auto) = {
  let items = _content-items(body)
  let rendered = if items.len() == 1 and _is-card-spec(items.first()) {
    render-layout(items.first())
  } else {
    render-layout(body)
  }
  if height == auto {
    block(width: 100%, height: 100%)[
      #if lead != none {
        text(size: 7.8pt, fill: config.palette.muted)[#lead]
        v(0.22cm)
      }
      #rendered
    ]
  } else {
    block(width: 100%, height: height)[#rendered]
  }
}

#let public-content-slide(title, lead: none, takeaway: none, height: auto, body) = touying-slide-wrapper(self => context {
  let config = public-theme-config.get()
  let page-body = [
    #align(top)[#_public-content-body(config, body, lead: lead, height: height)]
  ]
  touying-slide(
    self: self,
    config: _public-content-config(config, title, takeaway),
    ..(page-body,),
  )
})

#let _public-heading-slide(body) = touying-slide-wrapper(self => context {
  let config = public-theme-config.get()
  let title = utils.display-current-heading(level: 2, numbered: false)
  let page-body = [#align(top)[#body]]
  touying-slide(
    self: self,
    config: _public-content-config(config, title, none),
    ..(page-body,),
  )
})

#let _public-resolve(value, fallback) = if value == auto { fallback } else { value }

#let _public-date(value) = if type(value) == datetime {
  value.display("[year]-[month]-[day]")
} else {
  value
}

#let public-title-slide(
  title: auto,
  subtitle: auto,
  author: auto,
  institution: auto,
  date: auto,
) = touying-slide-wrapper(self => context {
  let config = public-theme-config.get()
  let info = public-theme-metadata.get()
  let profile = _public-profile(config)
  let resolved-title = _public-resolve(title, info.title)
  let resolved-subtitle = _public-resolve(subtitle, info.subtitle)
  let resolved-author = _public-resolve(author, info.author)
  let resolved-institution = _public-resolve(institution, info.institution)
  let resolved-date = _public-date(_public-resolve(date, info.date))
  let foreground = _public-foreground-color(config, "title")
  let page-body = [
    #if config.brand.title-mark != none {
      place(top + right, dx: -profile.margin-x, dy: 0.44cm, config.brand.title-mark)
    }
    #place(top + left, dx: profile.title-x, dy: profile.title-y)[
      #box(width: profile.title-width)[
        #text(size: config.typography.deck-title-size, weight: "bold", fill: foreground)[
          #set par(leading: 0.84em)
          #resolved-title
        ]
        #v(0.22cm)
        #text(size: 10.5pt, weight: "medium", fill: foreground.transparentize(18%))[
          #resolved-subtitle
        ]
        #v(0.24cm)
        #_public-brand-rule(config, length: profile.title-width, thickness: 0.82pt, dark: true)
        #v(0.30cm)
        #text(size: 7.2pt, fill: foreground.transparentize(24%))[
          #if resolved-author != [] and resolved-author != none {
            text(weight: "semibold", fill: foreground)[#resolved-author]
            h(0.22cm)
            [·]
            h(0.22cm)
          }
          #resolved-date
          #if resolved-institution != [] and resolved-institution != none {
            h(0.22cm)
            [·]
            h(0.22cm)
            resolved-institution
          }
        ]
      ]
    ]
  ]
  touying-slide(
    self: self,
    config: config-page(
      fill: _public-fill(config, "title"),
      margin: 0pt,
      header: none,
      footer: none,
      background: _public-background(config, "title"),
    )
      + config-colors(neutral-lightest: white, neutral-dark: foreground, neutral-darkest: foreground)
      + config-common(freeze-slide-counter: true),
    ..(page-body,),
  )
})

#let public-section-slide(title: auto, label: auto, body: []) = touying-slide-wrapper(self => context {
  let config = public-theme-config.get()
  let info = public-theme-metadata.get()
  let profile = _public-profile(config)
  let resolved-title = if title == auto {
    utils.display-current-heading(level: 1, numbered: false)
  } else {
    title
  }
  let resolved-label = if label == auto { info.institution } else { label }
  let foreground = _public-foreground-color(config, "section")
  let page-body = [
    #if config.brand.header-mark != none {
      place(top + right, dx: -profile.margin-x, dy: 0.42cm, config.brand.header-mark)
    }
    #place(left + horizon, dx: profile.margin-x)[
      #box(width: profile.section-width)[
        #text(size: 7.8pt, weight: "bold", fill: foreground.transparentize(24%))[
          #resolved-label
        ]
        #v(0.30cm)
        #text(size: config.typography.deck-title-size * 0.75, weight: "bold", fill: foreground)[
          #set par(leading: 0.86em)
          #resolved-title
        ]
        #v(0.20cm)
        #_public-brand-rule(config, length: profile.section-width, thickness: 0.86pt, dark: true)
        #if body != [] {
          v(0.28cm)
          text(size: 9.3pt, fill: foreground.transparentize(18%))[#body]
        }
      ]
    ]
  ]
  touying-slide(
    self: self,
    config: config-page(
      fill: _public-fill(config, "section"),
      margin: 0pt,
      header: none,
      footer: none,
      background: _public-background(config, "section"),
      foreground: _public-page-number(config, fill: foreground.transparentize(34%)),
    ) + config-colors(neutral-lightest: white, neutral-dark: foreground, neutral-darkest: foreground),
    ..(page-body,),
  )
})

#let _public-section-from-heading(body) = public-section-slide(body: body)

#let _public-configure-background(config) = {
  let provider = config.background
  let enabled = provider.at("kind", default: "none") == "attractor"
  set-attractor-background(
    render: if enabled { provider.at("mode", default: "off") } else { "off" },
    cache-profile: config.canvas.profile,
    splines: provider.at("splines", default: 46),
    content-splines: provider.at("content-splines", default: 30),
    warmup: provider.at("warmup", default: 520),
    tail-length: provider.at("tail-length", default: 1024),
    stride: provider.at("stride", default: 2),
    step-stride: provider.at("step-stride", default: 620),
    step-offset: provider.at("step-offset", default: 0),
  )
}

#let theme(config: default-config, metadata: default-metadata, body) = {
  public-theme-config.update(config)
  public-theme-metadata.update(metadata)
  deck-info.update(metadata)
  accent-palette-config.update(_ => config.palette.accents)
  _public-configure-background(config)
  show: default-theme.with(
    aspect-ratio: if config.canvas.profile == "wide" { "3-1" } else { "16-9" },
    config-info(
      title: metadata.title,
      subtitle: metadata.subtitle,
      author: if metadata.author == [] or metadata.author == none { () } else { metadata.author },
      institution: metadata.institution,
      date: metadata.date,
    ),
    config-colors(
      primary: config.palette.accents.first(),
      primary-light: config.palette.accents.first().lighten(36%),
      primary-lightest: config.palette.pale,
      secondary: config.palette.navy,
      secondary-light: config.palette.accents.first(),
      neutral-lightest: white,
      neutral-dark: config.palette.ink,
      neutral-darkest: config.palette.navy,
    ),
    config-page(width: config.canvas.width, height: config.canvas.height, margin: 0pt),
    config-common(
      slide-fn: _public-heading-slide,
      new-section-slide-fn: _public-section-from-heading,
      receive-body-for-new-section-slide-fn: false,
    ),
  )
  set text(
    font: config.typography.body-fonts,
    lang: "zh",
    size: config.typography.body-size,
    fill: config.palette.ink,
  )
  set heading(numbering: none)
  set list(indent: 0.9em, body-indent: 0.35em)
  show raw: set text(font: config.typography.code-fonts, size: 0.92em)
  body
}

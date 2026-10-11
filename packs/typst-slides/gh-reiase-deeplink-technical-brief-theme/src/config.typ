// Runtime configuration for the public Technical Brief theme.

#let standard-canvas = (width: 19.2cm, height: 10.8cm)
#let wide-canvas = (width: 30cm, height: 10cm)

#let _assert-length(name, value) = {
  assert(type(value) == length and value > 0pt, message: name + " must be a positive length")
}

#let canvas(width: standard-canvas.width, height: standard-canvas.height, profile: "auto") = {
  _assert-length("canvas.width", width)
  _assert-length("canvas.height", height)
  assert(profile in ("auto", "standard", "wide"), message: "canvas.profile must be auto, standard, or wide")
  let resolved = if profile == "auto" {
    if width / height >= 2.25 { "wide" } else { "standard" }
  } else {
    profile
  }
  (width: width, height: height, profile: resolved)
}

#let palette(
  navy: rgb("#07152B"),
  paper: rgb("#FBFCFE"),
  ink: rgb("#162033"),
  muted: rgb("#667386"),
  border: rgb("#E0E7F0"),
  pale: rgb("#F5F8FD"),
  accents: (
    rgb("#2563EB"), rgb("#DC2626"), rgb("#B45309"), rgb("#16A34A"),
    rgb("#7C3AED"), rgb("#0891B2"), rgb("#EA580C"), rgb("#64748B"),
  ),
) = {
  assert(accents.len() >= 1, message: "palette.accents must contain at least one color")
  (navy: navy, paper: paper, ink: ink, muted: muted, border: border, pale: pale, accents: accents)
}

#let typography(
  body-fonts: ("Source Han Sans SC", "Noto Sans CJK SC", "PingFang SC"),
  code-fonts: ("JetBrains Mono",),
  body-size: 9.2pt,
  slide-title-size: 18pt,
  deck-title-size: 28pt,
) = {
  assert(body-fonts.len() >= 1, message: "typography.body-fonts must not be empty")
  assert(code-fonts.len() >= 1, message: "typography.code-fonts must not be empty")
  _assert-length("typography.body-size", body-size)
  _assert-length("typography.slide-title-size", slide-title-size)
  _assert-length("typography.deck-title-size", deck-title-size)
  (
    body-fonts: body-fonts,
    code-fonts: code-fonts,
    body-size: body-size,
    slide-title-size: slide-title-size,
    deck-title-size: deck-title-size,
  )
}

// Slots accept content, not paths. This keeps consumer-owned assets outside the
// public package and lets Typst resolve images relative to the consuming deck.
#let brand(
  title-background: none,
  section-background: none,
  content-background: none,
  title-fill: none,
  section-fill: none,
  content-fill: none,
  title-foreground: none,
  section-foreground: none,
  title-mark: none,
  header-mark: none,
  header-reserve: 0cm,
  footer-left: none,
) = {
  assert(type(header-reserve) == length and header-reserve >= 0pt, message: "brand.header-reserve must be a non-negative length")
  (
    title-background: title-background,
    section-background: section-background,
    content-background: content-background,
    title-fill: title-fill,
    section-fill: section-fill,
    content-fill: content-fill,
    title-foreground: title-foreground,
    section-foreground: section-foreground,
    title-mark: title-mark,
    header-mark: header-mark,
    header-reserve: header-reserve,
    footer-left: footer-left,
  )
}

#let metadata(
  title: [Technical Brief],
  subtitle: [],
  author: [],
  institution: [],
  date: datetime.today(),
) = (title: title, subtitle: subtitle, author: author, institution: institution, date: date)

#let default-metadata = metadata()

#let theme-config(
  canvas: canvas(),
  palette: palette(),
  typography: typography(),
  brand: brand(),
  background: (kind: "none", mode: "off"),
) = {
  assert(type(canvas) == dictionary, message: "theme-config.canvas must come from canvas()")
  assert(type(palette) == dictionary, message: "theme-config.palette must come from palette()")
  assert(type(typography) == dictionary, message: "theme-config.typography must come from typography()")
  assert(type(brand) == dictionary, message: "theme-config.brand must come from brand()")
  assert(type(background) == dictionary, message: "theme-config.background must be a background provider")
  (canvas: canvas, palette: palette, typography: typography, brand: brand, background: background)
}

#let default-config = theme-config()

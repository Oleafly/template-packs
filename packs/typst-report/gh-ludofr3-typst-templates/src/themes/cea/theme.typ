// ==========================================
// CEA Visual Identity - Unified Dictionary
// ==========================================

#let cea-red = rgb("#E50019")
#let cea-black = rgb("#000000")
#let cea-white = rgb("#FFFFFF")
#let cea-blue = (
  "dark": rgb("#3E4A83"),
  "light": rgb("#7E9CBB"),
)
#let cea-yellow = rgb("#FFCD31")
#let cea-gray = rgb("#1E1E1E")
#let cea-macaron = rgb("#DA837B")
#let cea-archipel = rgb("#00939D")
#let cea-opera = rgb("#BD987A")
#let cea-glycine = rgb("#A72587")

#let cv-blue = rgb("#2b3e50")
#let cv-blue-light = rgb("#B0C4DE")
#let cv-text-dark = rgb("#2B2B2B")
#let cv-subtext-dark = rgb("#55606E")

#let color-palette = (
  red: cea-red,
  black: cea-black,
  white: cea-white,

  // Secondary colors
  dblue: cea-blue.dark,
  lblue: cea-blue.light,
  yellow: cea-yellow,
  gray: cea-gray,

  // Tertiary colors
  macaron: cea-macaron,
  archipel: cea-archipel,
  opera: cea-opera,
  glycine: cea-glycine,

  // Logical Shortcuts mappings
  text: cea-gray,
  primary: cea-red,
  complementary-dark: cea-blue.dark,
  complementary-light: cea-blue.light,
  secondary: cea-yellow,
)

// -----------------------------------------------------------------------------
// Component Dependencies
// -----------------------------------------------------------------------------

// Geometric patterns for Reports
#import "../../components/cube_position.typ": cover-cube-positions, standard-cube-positions, toc-cube-positions
#import "cubes.typ": render-bg, render-slide-bg


// -----------------------------------------------------------------------------
// Standardized Theme Export Dictionary
// -----------------------------------------------------------------------------

// Reads raw SVG assets for generating customized logos dynamically
#let raw-data = read("../../../assets/images/Lorem_ipsum.png", encoding: none)

#let cea-logo(background, text) = {
  bytes(
    raw-data.slice(0, 383) + bytes(background.to-hex()) + raw-data.slice(390, 404) + bytes(text.to-hex()) + raw-data.slice(411),
  )
}

#let cea-theme = (
  name: "cea",
  colors: color-palette,
  fonts: (
    main: "Poppins",
    code: "Geist Mono",
  ),

  graphics: (
    // Backgrounds & graphics reserved for the Report Document Architecture
    cover-bg: () => render-bg(cover-cube-positions, 10cm, 0cm, color-palette.primary),
    page-bg: () => render-bg(standard-cube-positions, 10cm, 0cm, color-palette.primary),
    toc-bg: () => render-bg(toc-cube-positions, 18cm, 0cm, color-palette.primary),
    logo: none,

    // Backgrounds & graphics reserved for the Slide Presentation Architecture
    logo-header: () => image(cea-logo(color-palette.primary, color-palette.white), height: 24pt),
    logo-slide: () => image(cea-logo(color-palette.primary, color-palette.white), height: 40%),

    slide-header-bg: () => render-slide-bg(standard-cube-positions, 9cm, 0cm, color-palette.primary),

    // slide-header-bg: () => render-bg(standard-cube-positions, 0cm, 1cm, color-palette.primary, img-width: 70%),

    title-slide-bg: () => render-bg(cover-cube-positions, 10cm, 0cm, color-palette.primary),
    end-slide-bg: () => render-bg(cover-cube-positions, 10cm, 0cm, color-palette.primary),
    section-slide-bg: () => render-bg(toc-cube-positions, 10cm, 0cm, color-palette.primary),
  ),
)

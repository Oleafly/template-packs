// Design tokens for the CV. Edit values here to restyle without touching layout.

#let accent  = rgb("#3B7CB8")  // blue used for section headers and rules
#let muted   = rgb("#6B7280")  // company / date column
#let ink     = rgb("#1F2937")  // body text
#let subtle  = rgb("#9CA3AF")  // very light text (e.g. icon background)

// Font stacks. Carlito and Noto Naskh Arabic are bundled in src/fonts/ and
// found by Typst via the --font-path flag (see build.sh). Don't add fallbacks
// here — bundled fonts make the build reproducible on any machine.
#let body-font    = ("Carlito",)
#let heading-font = ("Carlito",)
#let arabic-font  = ("Noto Naskh Arabic",)

// Arabic version (cv-ar.typ). IBM Plex Sans Arabic pairs visually with Carlito
// (both modern sans-serif). Used for the full Arabic CV body + headings.
// English fragments (company names, tech) inside Arabic flow render in Carlito
// via the fallback chain.
#let arabic-body-font    = ("IBM Plex Sans Arabic", "Carlito")
#let arabic-heading-font = ("IBM Plex Sans Arabic", "Carlito")

#let body-size    = 10.5pt
#let small-size   = 9pt
#let h1-size      = 24pt   // name
#let h2-size      = 14pt   // section headers (About me, Work Experience...)
#let company-size = 12.5pt // company name (the primary "new entry" anchor)
#let h3-size      = 11.5pt // role title (subordinate to company name)

#let page-margin  = (top: 0.9cm, bottom: 1.0cm, left: 1.5cm, right: 1.5cm)

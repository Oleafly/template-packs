// Body line leading, calibrated to 2.0x the native single advance (Task 3).
// = native-single-advance + 0.65em, expressed in em (size-independent).
// Measured: native single = 16.55pt, recommended-double-em = 2.029 at 12pt.
#let body-leading = 2.029em

#let dissertation(
  title: none,
  author: none,
  degree: none,
  year: none,
  body,
) = {
  // State-driven footer: reads "ucsd-matter" (same cross-module contract as
  // floats.typ — Typst state is global, keyed by string, no import needed) to
  // choose roman or arabic display.  This is the only place the footer can live:
  // dissertation() is applied via #show, so its set rules propagate to the whole
  // document; front-matter()/main-matter() cannot do this because set rules inside
  // function bodies do not propagate beyond the function call.
  set page(
    paper: "us-letter",
    margin: 1in,
    footer: context {
      let m = state("ucsd-matter", "main").get()
      let pat = if m == "front" { "i" } else { "1" }
      align(center, counter(page).display(pat))
    },
    footer-descent: 0.5in,
  )
  set text(font: "TeX Gyre Heros", size: 12pt, fill: black, lang: "en")
  set par(
    leading: body-leading,
    spacing: body-leading,
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
  )
  // Footnotes: >=10pt, single-spaced (overrides body spacing).
  show footnote.entry: it => {
    set text(size: 10pt)
    set par(leading: 0.65em, spacing: 0.65em)
    it
  }
  body
}

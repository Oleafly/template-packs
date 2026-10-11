// styles/page.typ — Page geometry, margins, running headers/footers

#import "theme.typ": fonts, palette, space, type-scale
#import "print.typ": page-bleed, print-foreground
#import "@preview/hydra:0.6.3": hydra

#let setup-pages() = body => {
  set page(
    paper: "a4",
    // Print builds (`--input print=true`) add 3 mm bleed + crop marks;
    // screen/UA builds keep bleed 0 and no marks. See print.typ / prepress-pdfx.
    bleed: page-bleed,
    foreground: print-foreground,
    margin: (
      inside: 25mm, // Binding gutter — generous
      outside: 20mm, // Outer edge
      top: 25mm, // Running header space
      bottom: 25mm, // Footer + page number space
    ),

    // ── Running header ───────────────────────────────────────
    // @preview/hydra liefert den aktuellen Level-1-Kapiteltitel robust gegen
    // nummerierte/verschachtelte Headings und Seitenränder; das `display`-Callback
    // zeigt nur den Heading-Body (ohne Nummer). Im Front-Matter (vor dem ersten
    // Kapitel) gibt hydra `none` zurück.
    // Kapitel-Startseiten werden zusätzlich explizit unterdrückt: Der
    // `chapter-opener` setzt die große Kapitelnummer ÜBER das Heading, daher
    // greift hydras `skip-starting` hier nicht (an der Header-Position ist das
    // vorige Kapitel noch „aktuell"). Diese Designregel bleibt projektseitig.
    header: context {
      let current-page = here().page()
      let starts-here = query(heading.where(level: 1)).any(h => (
        h.location().page() == current-page
      ))
      if starts-here { return } // Kapitel-Startseite — kein Header

      // Teil-Trennseiten (part-page) tragen keinen Kolumnentitel
      let on-part-page = query(<part-page>).any(m => m.location().page() == current-page)
      if on-part-page { return }

      let chapter-title = hydra(1, display: (ctx, candidate) => candidate.body)
      if chapter-title == none { return } // Front-Matter

      let is-even = calc.even(current-page)

      set text(size: type-scale.small, fill: palette.text-muted, font: fonts.sans)

      if is-even {
        chapter-title
        h(1fr)
      } else {
        h(1fr)
        chapter-title
      }
      v(-4pt)
      line(length: 100%, stroke: 0.4pt + palette.border-light)
    },

    // ── Running footer ───────────────────────────────────────
    footer: context {
      let current-page = here().page()
      let is-even = calc.even(current-page)

      set text(size: type-scale.small, fill: palette.text-muted, font: fonts.sans)

      if is-even {
        counter(page).display()
        h(1fr)
      } else {
        h(1fr)
        counter(page).display()
      }
    },
  )

  body
}

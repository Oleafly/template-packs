// components/page-design.typ — Seitengestaltung & Hintergrund
//
// Bausteine für die *Seite selbst* (nicht den Inhalt): Hintergründe,
// Wasserzeichen, über Seitenumbrüche durchlaufende Abschnittsflächen,
// Rand-Farbbänder, ein Daumenregister/Griffregister, dekorative Rahmen,
// Eck-Verzierungen sowie Verlaufs- und Tiling-Flächen.
//
// Grundtechniken (Typst 0.15, größtenteils nativ):
//   · page(background:)/page(foreground:) — Inhalt hinter/über dem Satzspiegel
//   · gradient.linear/radial/conic, tiling(..) — als beliebige `fill`
//   · block(breakable: true, fill: ..) — Fläche, die über Umbrüche durchläuft
//   · place(.. + outside) ist KEINE Alignment-Option → Außenrand via
//     context + calc.even(here().page()) (verso = links, recto = rechts)
//
// Bindungsbewusst: gerade Seite (verso) → Außenrand links, ungerade
// (recto) → rechts. Alle Stilkonstanten kommen aus theme.typ.
//
// HINWEIS Scoping: `set page(..)` wirkt ab der aktuellen Seite bis zum Ende
// des umschließenden Content-Blocks und fällt danach zurück. Die page-weiten
// Helfer (watermark, full-bleed, margin-band, thumb-index, page-frame,
// corner-ornament) deshalb je auf einer eigenen Seite aufrufen
// (pagebreak davor), damit sich nicht zwei Hintergründe dieselbe physische
// Seite teilen.

#import "../styles/theme.typ": fonts, gradients, palette, part-colors, space, type-scale
#import "../styles/print.typ": page-bleed, print-foreground

// ── Intern: Außenrand-Ausrichtung der aktuellen Seite ──────────
// Im aufgeschlagenen Buch liegt der Außenschnitt bei geraden Seiten
// (verso) links, bei ungeraden (recto) rechts.
#let _outer-align() = if calc.even(here().page()) { left } else { right }

// ── Wasserzeichen ──────────────────────────────────────────────
// Halbtransparenter, rotierter Schriftzug hinter (Standard) oder über
// (`fg: true`) dem Satzspiegel. Auf einer eigenen Seite aufrufen.
#let watermark(
  body,
  mark: [ENTWURF],
  fg: false,
  angle: -45deg,
  size: 96pt,
  fill: auto,
) = {
  let f = if fill == auto { palette.text-light.transparentize(80%) } else { fill }
  let stamp = align(
    center + horizon,
    rotate(angle, reflow: false, text(size: size, weight: "bold", font: fonts.sans, fill: f, mark)),
  )
  if fg {
    set page(foreground: stamp)
    body
  } else {
    set page(background: stamp)
    body
  }
}

// ── Vollflächiger Seitenhintergrund (Full-Bleed) ───────────────
// Randlose Seite mit Farbe, Verlauf oder Bild von Kante zu Kante.
// `bg` ist beliebiger Content (z. B. image(.., fit: "cover")) ODER auto
// (dann wird `fill` als Vollfläche genutzt).
// Print mode (`--input print=true`): page.bleed + Schnittmarken; background
// percentages resolve against page+bleed so fills truly leave the press.
#let full-bleed(
  body,
  fill: none,
  bg: auto,
  header: none,
  footer: none,
) = {
  let background = if bg != auto { bg } else if fill != none {
    rect(width: 100%, height: 100%, fill: fill, stroke: none)
  } else { none }
  set page(
    margin: 0pt,
    header: header,
    footer: footer,
    background: background,
    bleed: page-bleed,
    foreground: print-foreground,
  )
  body
}

// ── Abschnitts-Hintergrund (läuft über Seitenumbrüche) ─────────
// Farbige/verlaufende Fläche HINTER fließendem Text; dank
// `breakable: true` setzt sich der Hintergrund auf der Folgeseite fort.
#let section-background(
  body,
  fill: palette.bg-subtle,
  stroke: none,
  inset: space.md,
  radius: 4pt,
) = block(
  width: 100%,
  breakable: true,
  fill: fill,
  stroke: stroke,
  inset: inset,
  radius: radius,
  body,
)

// ── Rand-Farbband (vollhohe Sidebar) ───────────────────────────
// Durchgehendes Farbband am Außenrand der Seite — markiert z. B. einen
// Teil über alle seine Seiten hinweg. Bindungsbewusst (verso links /
// recto rechts).
#let margin-band(
  body,
  color: palette.primary,
  width: 10mm,
) = {
  set page(background: context {
    place(
      top + _outer-align(),
      rect(width: width, height: 100%, fill: color, stroke: none),
    )
  })
  body
}

// ── Daumenregister / Griffregister ─────────────────────────────
// Farbige Randmarken am Außenschnitt: eine Stufe pro Teil, nach unten
// wandernd, sodass man Kapitel-/Teilübergänge am geschlossenen Buch
// „wie in einem Ordner" sieht. Die aktive Marke ist breit und gefüllt,
// die übrigen schmal und blass — zusammen bilden sie die „Leiter".
//
// `active` (1-basiert) wählt die hervorgehobene Marke. Im Showcase wird
// `active` explizit gesetzt, damit das Register aufs Kapitel begrenzt
// bleibt. Für ein BUCHWEITES Register den aktiven Teil aus dem Heading-
// Zähler ableiten (siehe `register-active-from-headings` unten) — wichtig:
// `counter(heading).at(loc)` nutzen, NICHT einen eigenen `.where()`-Zähler
// (der wird nicht automatisch hochgezählt).
// Derived from theme.part-colors so the register cannot drift from the token list.
#let _part-roman = ("I", "II", "III", "IV", "V", "VI", "VII", "VIII")
#let book-parts = part-colors.enumerate().map(((i, c)) => (
  label: _part-roman.at(i, default: str(i + 1)),
  color: c,
))

#let thumb-index(
  body,
  active: 1,
  parts: book-parts,
  tab-height: 2.2cm,
  tab-width: 13mm,
  top-offset: 3cm,
  label: true,
) = {
  set page(background: context {
    let outer = _outer-align()
    let on-left = outer == left
    for (i, p) in parts.enumerate() {
      let is-active = (i + 1) == active
      let w = if is-active { tab-width } else { tab-width * 0.5 }
      place(
        top + outer,
        dy: top-offset + i * tab-height,
        rect(
          width: w,
          height: tab-height,
          fill: if is-active { p.color } else { p.color.transparentize(55%) },
          radius: if on-left { (right: 5pt) } else { (left: 5pt) },
          stroke: none,
          inset: 0pt,
          if is-active and label {
            align(
              center + horizon,
              rotate(
                if on-left { -90deg } else { 90deg },
                text(fill: white, size: type-scale.tiny, weight: "bold", font: fonts.sans, p.label),
              ),
            )
          },
        ),
      )
    }
  })
  body
}

// Buchweite Variante (nicht im Showcase aktiv, als Referenz dokumentiert):
// Leitet den aktiven Teil aus dem aktuellen Level-1-Heading-Stand ab.
// Voraussetzung: Parts erhöhen einen eigenen `state`/`counter`, oder man
// mappt Kapitelnummern → Teil. Beispielhaft über counter(heading):
#let register-active-from-headings(chapter-to-part) = context {
  let ch = counter(heading).get().first()
  chapter-to-part.at(str(ch), default: 1)
}

// ── Dekorativer Seitenrahmen ───────────────────────────────────
// Linienrahmen im Vordergrund, vom Seitenrand um `inset` eingerückt.
#let page-frame(
  body,
  stroke: 0.8pt + palette.primary,
  inset: 10mm,
  radius: 0pt,
) = {
  set page(foreground: place(
    top + left,
    dx: inset,
    dy: inset,
    rect(
      width: 100% - 2 * inset,
      height: 100% - 2 * inset,
      stroke: stroke,
      radius: radius,
      fill: none,
    ),
  ))
  body
}

// ── Eck-Verzierungen ───────────────────────────────────────────
// Winkel-Klammern („L"-Ecken) in den vier Seitenecken.
#let _corner-bracket(ax, ay, len, stroke) = {
  let x0 = if ax == left { 0% } else { 100% }
  let x1 = if ax == left { 100% } else { 0% }
  let y0 = if ay == top { 0% } else { 100% }
  let y1 = if ay == top { 100% } else { 0% }
  box(width: len, height: len, {
    place(top + left, line(start: (x0, y0), end: (x1, y0), stroke: stroke))
    place(top + left, line(start: (x0, y0), end: (x0, y1), stroke: stroke))
  })
}

#let corner-ornament(
  body,
  len: 14mm,
  inset: 9mm,
  stroke: 1pt + palette.accent,
) = {
  set page(foreground: {
    place(top + left, dx: inset, dy: inset, _corner-bracket(left, top, len, stroke))
    place(top + right, dx: -inset, dy: inset, _corner-bracket(right, top, len, stroke))
    place(bottom + left, dx: inset, dy: -inset, _corner-bracket(left, bottom, len, stroke))
    place(bottom + right, dx: -inset, dy: -inset, _corner-bracket(right, bottom, len, stroke))
  })
  body
}

// ── Verlaufs-Panel und Verlaufstext ────────────────────────────
// Block mit Verlaufsfüllung (Text standardmäßig weiß für Kontrast).
#let gradient-panel(
  body,
  fill: gradients.chapter,
  inset: space.lg,
  radius: 6pt,
  text-fill: white,
) = block(
  width: 100%,
  fill: fill,
  inset: inset,
  radius: radius,
  {
    set text(fill: text-fill)
    body
  },
)

// Schrift mit Verlaufsfüllung (Verlauf relativ zur Textbox).
#let gradient-text(
  body,
  fill: gradients.accent,
  size: type-scale.h1,
  weight: "bold",
) = text(fill: fill, size: size, weight: weight, font: fonts.sans, body)

// ── Tiling-/Mustertextur ───────────────────────────────────────
// Subtile, sich wiederholende Texturfläche als Hintergrund.
#let dot-tiling(color: auto, step: 10pt, dot: 1.1pt) = {
  let c = if color == auto { palette.primary.transparentize(85%) } else { color }
  tiling(size: (step, step), place(center + horizon, circle(radius: dot, fill: c)))
}

#let tiling-background(
  body,
  fill: auto,
  inset: space.md,
  radius: 4pt,
  stroke: none,
) = {
  let f = if fill == auto { dot-tiling() } else { fill }
  block(width: 100%, fill: f, inset: inset, radius: radius, stroke: stroke, body)
}

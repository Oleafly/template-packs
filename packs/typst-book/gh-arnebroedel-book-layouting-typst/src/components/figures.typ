// components/figures.typ — Bildintegration & Text-Bild-Fluss
//
// Sauberes Platzieren von Bilddateien (z. B. Anatomie-Schemata) und das
// Verzahnen von Bild und Fließtext. Drei Flussstufen, von einfach zu mächtig:
//   1. plate()         — gleitende Vollbreiten-/Spalten-Abbildung (nativ, Floats)
//   2. wrap-figure()   — Text läuft seitlich am Bild vorbei (@preview/wrap-it)
//   3. kontur-figur()  — Text umfließt beliebige Konturen (@preview/meander)
// Ergänzend:
//   bildtafel()        — mehrteilige Tafel mit (a)(b)(c)-Teilbildern (@preview/subpar)
//   anatomie-figur()   — Bild + nummerierte Marker + Legende (Atlas-Stil)
//   bild-detail()      — selbstgebaute Lupe auf einen Bildausschnitt
//   setup-figure-numbering() — Abbildungsnummern pro Kapitel (nativ)
//
// Alle Stilkonstanten stammen aus theme.typ; Bildpfade liegen unter src/assets/.

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "@preview/wrap-it:0.1.1": wrap-content, wrap-top-bottom
#import "@preview/meander:0.4.4"
#import "@preview/subpar:0.2.2"

// ── Intern: Bildquelle auflösen ────────────────────────────────
// `src` darf ein Dateipfad (str) ODER fertiger Content (z. B. CeTZ) sein.
// `frame` legt einen dezenten Rahmen mit abgerundeten Ecken an.
#let _resolve-img(src, width: 100%, height: auto, fit: "contain", frame: true, radius: 4pt) = {
  let pic = if type(src) == str {
    image(src, width: width, height: height, fit: fit)
  } else {
    box(width: width, src)
  }
  if frame {
    box(stroke: 0.5pt + palette.border-light, radius: radius, clip: true, pic)
  } else {
    pic
  }
}

// ── Intern: Figure mit optionalem Alt-Text bauen ───────────────
// Wird `alt` nicht gesetzt (auto), greift der globale UA-Fallback aus
// typography.typ; ein expliziter String überschreibt ihn.
#let _fig(body, caption: none, alt: auto, placement: none, scope: "column") = {
  let args = (caption: caption, kind: image, placement: placement, scope: scope)
  if alt != auto { args.insert("alt", alt) }
  figure(body, ..args)
}

// ── plate — gleitende Abbildung (native Floats) ────────────────
// Ohne Zusatzpaket. `placement: top|bottom|auto` lässt das Bild an den
// Seiten-/Spaltenrand „schwimmen", der Text füllt automatisch nach.
// `scope: "parent"` spannt über alle Spalten eines mehrspaltigen Satzes.
#let plate(
  src,
  caption: none,
  alt: auto,
  width: 100%,
  height: auto,
  placement: none,
  scope: "column",
  frame: true,
  fit: "contain",
) = _fig(
  _resolve-img(src, width: width, height: height, fit: fit, frame: frame),
  caption: caption,
  alt: alt,
  placement: placement,
  scope: scope,
)

// ── wrap-figure — Text läuft seitlich vorbei ───────────────────
// Der 80-%-Standardfall: kleines Bild links/rechts, Fließtext daneben.
// `side: left|right`, `width` = Bildspaltenbreite (Anteil der Textbreite).
// `width` darf ein Anteil (z. B. 46%) ODER eine feste Länge sein. Ein
// Anteil wird via `layout` gegen die TATSÄCHLICHE Textbreite in eine
// absolute Länge aufgelöst und direkt dem Bild gegeben — sonst fällt
// `image(width: 100%)` in der rahmenlosen Box auf die natürliche Bildgröße
// zurück und der Anteil bliebe wirkungslos.
#let wrap-figure(
  src,
  body,
  caption: none,
  alt: auto,
  side: right,
  width: 46%,
  gutter: space.lg,
  frame: true,
  fit: "contain",
) = layout(size => {
  let w = if type(width) == ratio { width * size.width } else { width }
  let fig = _fig(_resolve-img(src, width: w, fit: fit, frame: frame), caption: caption, alt: alt)
  wrap-content(
    fig,
    body,
    align: top + side,
    column-gutter: gutter,
  )
})

// ── kontur-figur — Text umfließt das Bild (auch rund) ──────────
// Mächtigste Stufe via meander. Innerhalb eines höhenbegrenzten Blocks,
// damit die Engine nur den reservierten Bereich segmentiert (nicht die
// ganze Seite). `round: true` schneidet eine kreisförmige Kontur aus.
// `side`: `left`/`right` lassen den Text einseitig vorbeilaufen;
// `center` platziert das Bild horizontal mittig und führt den Text in
// zwei Spalten BEIDSEITIG um die Kontur (klassischer „circle-hole").
// `frame: auto` blendet den (rechteckigen) Rahmen bei `round` aus, damit
// keine Quadratkante um die runde Form sichtbar bleibt — das Bild sollte
// dafür einen transparenten Hintergrund haben.
#let kontur-figur(
  src,
  body,
  caption: none,
  alt: auto,
  side: right,
  width: 6cm,
  height: 7cm,
  round: false,
  margin: 4mm,
  frame: auto,
  fit: "contain",
) = {
  let use-frame = if frame == auto { not round } else { frame }
  let img = _resolve-img(src, width: width, fit: fit, frame: use-frame)
  let boundary = if round {
    meander.contour.margin(margin) + meander.contour.grid(
      div: 24,
      (x, y) => calc.pow(2 * x - 1, 2) + calc.pow(2 * y - 1, 2) <= 1,
    )
  } else {
    meander.contour.margin(margin)
  }
  // Das Bild ist das Hindernis (ohne Caption — sonst flösse Text in den
  // Caption-Bereich der ausgeschnittenen Kontur). Die Unterschrift sitzt
  // als reguläre Figure unter dem gesamten Fließbereich.
  let flow = block(width: 100%, height: height, breakable: false, meander.reflow({
    import meander: *
    if side == center {
      placed(center + horizon, boundary: boundary, img)
      container(width: 48%)
      container(align: right, width: 48%)
    } else {
      placed(top + side, boundary: boundary, img)
      container()
    }
    content({
      set par(justify: true)
      body
    })
  }))
  if caption != none or alt != auto {
    _fig(flow, caption: caption, alt: alt)
  } else {
    flow
  }
}

// ── bildtafel — mehrteilige Tafel mit Teilbildern ──────────────
// `items`: Array aus (src: <pfad|content>, caption: <content>, alt: <str>).
// Erzeugt eine (a)(b)(c)-nummerierte Tafel unter einer Gesamtunterschrift.
// Die Gesamtnummer folgt dem Kapitelschema (z. B. „Abb. 22.4"), da subpar
// die Nummerierung der Überfigur selbst setzt und die globale `set
// figure(numbering: …)`-Regel nicht erbt.
#let _chapter-fig-number(n) = {
  let h = counter(heading).get()
  if h.len() > 0 { numbering("1.1", h.first(), n) } else { numbering("1", n) }
}

#let bildtafel(
  items,
  columns: 2,
  caption: none,
  label: none,
  numbering: _chapter-fig-number,
  frame: true,
  fit: "contain",
) = {
  let figs = items.map(it => figure(
    _resolve-img(it.src, fit: fit, frame: frame),
    caption: it.at("caption", default: none),
  ))
  let cols = range(columns).map(_ => 1fr)
  let args = (columns: cols, caption: caption, gutter: space.md, numbering: numbering)
  if label != none { args.insert("label", label) }
  subpar.grid(..figs, ..args)
}

// ── anatomie-figur — Bild + nummerierte Marker + Legende ───────
// Atlas-Stil: über das Bild gelegte Ziffern-Marker (Position als
// Bruchteil 0..1 der Bildbox) plus erläuternde Legende. Robust und
// druck-/übersetzungsfreundlich, da die Beschriftung im Typst-Text lebt.
//   marker: (x: 0..1, y: 0..1, n: <ziffer/zeichen>)
//   legend: Array aus content (Reihenfolge = Markernummer) ODER (n, content)
#let _marker(n, color: palette.primary) = box(
  width: 15pt,
  height: 15pt,
  radius: 50%,
  fill: white,
  stroke: 1.4pt + color,
  inset: 0pt,
  align(center + horizon, text(size: 8.5pt, weight: "bold", fill: color, font: fonts.sans, [#n])),
)

#let anatomie-figur(
  src,
  marker: (),
  legend: (),
  caption: none,
  alt: auto,
  width: 70%,
  legend-side: bottom,
  marker-color: palette.primary,
  frame: true,
  fit: "contain",
) = {
  let overlay = box(width: width, {
    _resolve-img(src, width: 100%, fit: fit, frame: frame)
    for m in marker {
      place(
        top + left,
        dx: m.x * 100%,
        dy: m.y * 100%,
        move(dx: -7.5pt, dy: -7.5pt, _marker(m.n, color: marker-color)),
      )
    }
  })

  // Legende: Ziffer + Text, kompakt gesetzt.
  let legend-body = {
    set text(size: type-scale.small)
    for (i, entry) in legend.enumerate() {
      let (num, txt) = if type(entry) == array { entry } else { (i + 1, entry) }
      grid(
        columns: (auto, 1fr),
        column-gutter: space.sm,
        row-gutter: space.xs,
        align: (right, left),
        text(weight: "bold", fill: marker-color, font: fonts.sans, [#num]), txt,
      )
    }
  }

  let composed = if legend-side == right {
    grid(
      columns: (auto, 1fr),
      column-gutter: space.lg,
      align: (center + horizon, top),
      overlay,
      block(legend-body),
    )
  } else {
    align(center, overlay)
    v(space.sm)
    block(width: 100%, legend-body)
  }

  _fig(composed, caption: caption, alt: alt)
}

// ── bild-detail — selbstgebaute Lupe auf einen Bildausschnitt ──
// Vergrößert eine Stelle des Bildes (z. B. Synapse, Glomerulus) als
// kreisförmige Lupe mit Verbindungslinie — eigenständige Umsetzung über
// `box(radius: 50%, clip: true)` (das @preview-Lupenpaket ist mit der
// scale()-API von Typst 0.15 inkompatibel). Positionen als Bruchteil
// 0..1 der angezeigten Bildbox.
//   focus:    Stelle im Bild, die vergrößert wird
//   lens-at:  Mittelpunkt der abgelegten Lupe
#let bild-detail(
  src,
  focus: (0.3, 0.4),
  lens-at: (0.82, 0.28),
  zoom: 2.4,
  lens-radius: 1.5cm,
  caption: none,
  alt: auto,
  width: 9cm,
  frame: true,
  fit: "contain",
) = context {
  let base = _resolve-img(src, width: width, fit: fit, frame: frame)
  let sz = measure(base)
  let (w, h) = (sz.width, sz.height)
  let (fx, fy) = focus
  let (lx, ly) = lens-at
  let r = lens-radius
  let s = zoom
  let composed = box(width: w, height: h, {
    base
    // Verbindungslinie Fokus → Lupe
    place(line(
      start: (fx * w, fy * h),
      end: (lx * w, ly * h),
      stroke: (paint: palette.accent-dark, dash: "dashed", thickness: 0.8pt),
    ))
    // Fokus-Ring
    place(
      top + left,
      dx: fx * w - r / s,
      dy: fy * h - r / s,
      circle(radius: r / s, stroke: 0.8pt + palette.primary),
    )
    // Lupe: zirkulär beschnittene, vergrößerte Bildkopie
    place(
      top + left,
      dx: lx * w - r,
      dy: ly * h - r,
      box(
        width: 2 * r,
        height: 2 * r,
        radius: 50%,
        clip: true,
        fill: white,
        stroke: 1.4pt + palette.primary,
        move(
          dx: r - fx * w * s,
          dy: r - fy * h * s,
          if type(src) == str { image(src, width: w * s, height: h * s, fit: fit) } else { box(width: w * s, src) },
        ),
      ),
    )
  })
  _fig(composed, caption: caption, alt: alt)
}

// ── setup-figure-numbering — Abbildungsnummern pro Kapitel ──────
// Opt-in-Show-Rule: ersetzt die fortlaufende Nummerierung durch das
// lehrbuchübliche Schema „Kapitel.lfd" (z. B. Abb. 22.3) und setzt den
// Abbildungszähler zu Kapitelbeginn zurück. Bewusst nativ gehalten
// (statt @preview/i-figured), damit es nicht mit subpar-Teilbildern
// kollidiert. In einem Kapitel via `#show: setup-figure-numbering()`.
#let setup-figure-numbering() = body => {
  set figure(numbering: n => numbering("1.1", counter(heading).get().first(), n))
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    it
  }
  body
}

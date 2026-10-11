// components/art.typ — Generative & experimentelle Seitenkunst
//
// Voll-Seiten-Kunstwerke, rein aus Typst-Primitiven (place, shapes,
// gradients, native curve, math) plus CeTZ für parametrische Kurven.
// Jede Funktion füllt die volle Seite (box 100%×100% + layout(size)),
// damit absolute Koordinaten aus der echten Seitengröße entstehen.
//
// Bewusst NICHT an die medizinische Token-Palette gebunden: hier regiert
// eine eigene, knallige Künstler-Palette. Das ist der Spielplatz.

#import "../styles/theme.typ": fonts, space, type-scale
#import "../styles/print.typ": page-bleed, print-foreground
#import "@preview/cetz:0.5.2": canvas, draw

// ── Künstler-Palette (vivid) ───────────────────────────────────
#let art-colors = (
  magenta: rgb("#ff2e93"),
  pink: rgb("#ff6ec7"),
  violet: rgb("#7b2ff7"),
  indigo: rgb("#3a0ca3"),
  blue: rgb("#1e6cff"),
  cyan: rgb("#13e3e3"),
  teal: rgb("#0d7377"),
  lime: rgb("#9ef01a"),
  yellow: rgb("#ffd60a"),
  orange: rgb("#ff7b00"),
  red: rgb("#ef233c"),
  ink: rgb("#0b0b16"),
  paper: rgb("#fdf6e3"),
)

#let spectrum = gradient.linear(
  art-colors.magenta,
  art-colors.violet,
  art-colors.blue,
  art-colors.cyan,
  art-colors.lime,
  art-colors.yellow,
  art-colors.orange,
  art-colors.red,
)

// ── Voll-Seiten-Rahmen ─────────────────────────────────────────
// Randlose Kunstseite mit optionaler Mini-Signatur unten.
// Print mode: bleed + crop marks so full-page art survives the trim.
#let art-page(body, label: none, note: none, label-fill: white, fill: none) = {
  set page(
    margin: 0pt,
    header: none,
    footer: none,
    fill: fill,
    bleed: page-bleed,
    foreground: print-foreground,
  )
  block(width: 100%, height: 100%, clip: true, {
    body
    if label != none or note != none {
      place(
        bottom + left,
        dx: 13mm,
        dy: -13mm,
        block(width: 60%, {
          if label != none {
            text(size: 8.5pt, fill: label-fill, font: fonts.sans, weight: "bold", tracking: 2pt, upper(label))
          }
          if note != none {
            linebreak()
            text(size: 7.5pt, fill: label-fill.transparentize(25%), font: fonts.sans, note)
          }
        }),
      )
    }
  })
}

// ── 1. Aurora — weiches Farbnebel-Mesh ─────────────────────────
#let aurora(base: rgb("#070713"), blobs: auto) = box(width: 100%, height: 100%, layout(size => {
  let W = size.width
  let H = size.height
  place(top + left, rect(width: 100%, height: 100%, fill: base))
  let bs = if blobs == auto {
    (
      (0.18, 0.20, 0.42, art-colors.magenta),
      (0.78, 0.18, 0.46, art-colors.blue),
      (0.30, 0.70, 0.50, art-colors.violet),
      (0.85, 0.72, 0.40, art-colors.cyan),
      (0.55, 0.42, 0.38, art-colors.pink),
      (0.10, 0.92, 0.34, art-colors.indigo),
      (0.62, 0.95, 0.30, art-colors.teal),
      (0.95, 0.45, 0.30, art-colors.orange),
    )
  } else { blobs }
  for (fx, fy, fr, col) in bs {
    let r = fr * W
    place(
      top + left,
      dx: fx * W - r,
      dy: fy * H - r,
      circle(
        radius: r,
        fill: gradient.radial(col.transparentize(25%), col.transparentize(100%)),
        stroke: none,
      ),
    )
  }
}))

// ── 2. Phyllotaxis — Sonnenblumen-Spirale (goldener Winkel) ─────
#let phyllotaxis(n: 1100, spread: auto, dot: 2.4pt, base: rgb("#0b0b16")) = box(
  width: 100%,
  height: 100%,
  layout(size => {
    let W = size.width
    let H = size.height
    let cx = W / 2
    let cy = H / 2
    let s = if spread == auto { 0.40 * calc.min(W, H) / calc.sqrt(n) } else { spread }
    place(top + left, rect(width: 100%, height: 100%, fill: base))
    let golden = 137.50776deg
    for i in range(n) {
      let r = s * calc.sqrt(i)
      let a = golden * i
      let x = cx + r * calc.cos(a)
      let y = cy + r * calc.sin(a)
      let t = i / n
      let rad = dot * (0.5 + 1.4 * t)
      place(
        top + left,
        dx: x - rad,
        dy: y - rad,
        circle(radius: rad, fill: spectrum.sample(t * 100%), stroke: none),
      )
    }
  }),
)

// ── 3. Moiré — konzentrische Interferenz (Op-Art) ──────────────
#let moire(rings: 130, step: auto, base: white, ink: black, offset: 0.05) = box(
  width: 100%,
  height: 100%,
  layout(size => {
    let W = size.width
    let H = size.height
    let st = if step == auto { calc.max(W, H) / rings } else { step }
    place(top + left, rect(width: 100%, height: 100%, fill: base))
    let draw-set(cx, cy, col) = {
      for i in range(rings) {
        let r = st * (i + 1)
        place(top + left, dx: cx - r, dy: cy - r, circle(radius: r, stroke: 0.9pt + col, fill: none))
      }
    }
    draw-set(W * (0.5 - offset), H / 2, ink)
    draw-set(W * (0.5 + offset), H / 2, art-colors.magenta)
  }),
)

// ── 4. Wellenfeld — Interferenz aus Sinuskurven (native curve) ─
#let wave-field(lines: 34, samples: 90, base: rgb("#04141b")) = box(
  width: 100%,
  height: 100%,
  layout(size => {
    let W = size.width
    let H = size.height
    place(top + left, rect(width: 100%, height: 100%, fill: base))
    for li in range(lines) {
      let lt = li / (lines - 1)
      let y0 = H * (0.08 + 0.84 * lt)
      let amp = H * (0.015 + 0.05 * calc.sin(lt * 3.14159 * 1rad))
      let freq = 2 + 4 * lt
      let phase = lt * 6.5
      let pts = ()
      for s in range(samples + 1) {
        let fx = s / samples
        let x = fx * W
        let y = y0 + amp * calc.sin((fx * freq * 360deg) + phase * 1rad)
        pts.push((x, y))
      }
      let segs = (curve.move(pts.first()),)
      for p in pts.slice(1) { segs.push(curve.line(p)) }
      place(top + left, curve(stroke: 0.8pt + spectrum.sample(lt * 100%), ..segs))
    }
  }),
)

// ── 5. Mandala — radiale Blütensymmetrie ───────────────────────
#let mandala(
  petals: 24,
  layers: 5,
  base: rgb("#160d20"),
) = box(width: 100%, height: 100%, layout(size => {
  let W = size.width
  let H = size.height
  let cx = W / 2
  let cy = H / 2
  place(top + left, rect(width: 100%, height: 100%, fill: base))
  for layer in range(layers) {
    let lt = layer / (layers - 1)
    let reach = (0.10 + 0.34 * lt) * calc.min(W, H)
    let pw = (0.018 + 0.05 * (1 - lt)) * W
    let col = spectrum.sample(lt * 100%)
    for i in range(petals) {
      let ang = (360deg / petals) * i + 90deg * lt
      place(
        top + left,
        dx: cx,
        dy: cy,
        rotate(
          ang,
          origin: top + left,
          move(
            dx: -pw / 2,
            dy: -reach,
            ellipse(
              width: pw,
              height: reach,
              fill: col.transparentize(70%),
              stroke: 0.5pt + col.transparentize(20%),
            ),
          ),
        ),
      )
    }
  }
  // Kern
  place(top + left, dx: cx - 0.04 * W, dy: cy - 0.04 * W, circle(radius: 0.04 * W, fill: art-colors.yellow))
}))

// ── 6. Neo-Plastizismus — kühne Farbfelder (Mondrian-Hommage) ──
#let mondrian(base: rgb("#f7f4ec"), ink: rgb("#0b0b16")) = box(
  width: 100%,
  height: 100%,
  {
    let W = 100%
    place(top + left, rect(width: 100%, height: 100%, fill: base))
    // Farbblöcke (relative Rechtecke via place + Prozentmaße)
    let block(x, y, w, h, col) = place(
      top + left,
      dx: x,
      dy: y,
      rect(width: w, height: h, fill: col, stroke: none),
    )
    block(0%, 0%, 38%, 46%, art-colors.red)
    block(72%, 0%, 28%, 30%, art-colors.yellow)
    block(0%, 74%, 24%, 26%, art-colors.blue)
    block(80%, 64%, 20%, 36%, art-colors.cyan)
    block(46%, 52%, 22%, 22%, art-colors.magenta)
    // Schwarze Gitterlinien
    let vline(x) = place(top + left, dx: x, rect(width: 7pt, height: 100%, fill: ink))
    let hline(y) = place(top + left, dy: y, rect(width: 100%, height: 7pt, fill: ink))
    vline(38%)
    vline(72%)
    vline(80%)
    hline(46%)
    hline(74%)
    hline(30%)
  },
)

// ── 7. Typo-Poster — riesige, überlagerte Verlaufstypografie ───
#let type-poster(
  word: [FLUSS],
  ghosts: ([form], [farbe], [frei], [wild], [fluss], [puls]),
  base: rgb("#0b0b16"),
) = box(width: 100%, height: 100%, layout(size => {
  let W = size.width
  let H = size.height
  place(top + left, rect(width: 100%, height: 100%, fill: base))
  // Geister-Wörter, rotiert verstreut
  let positions = (
    (0.12, 0.16, -18deg, 0.30),
    (0.66, 0.10, 12deg, 0.26),
    (0.74, 0.82, -8deg, 0.32),
    (0.10, 0.84, 22deg, 0.24),
    (0.40, 0.30, -30deg, 0.22),
    (0.55, 0.66, 16deg, 0.28),
  )
  for (i, g) in ghosts.enumerate() {
    let (fx, fy, rot, op) = positions.at(calc.rem(i, positions.len()))
    place(
      top + left,
      dx: fx * W,
      dy: fy * H,
      rotate(rot, text(
        size: 0.13 * W,
        weight: "bold",
        font: fonts.sans,
        fill: spectrum.sample((i / ghosts.len()) * 100%).transparentize(60%),
        upper(g),
      )),
    )
  }
  // Hauptwort, groß, Verlaufsschrift, exakt zentriert
  place(top + left, box(
    width: 100%,
    height: 100%,
    align(
      center + horizon,
      text(size: 0.23 * W, weight: "bold", font: fonts.sans, fill: spectrum, tracking: -1pt, upper(word)),
    ),
  ))
}))

// ── 8. Guilloché — parametrische Rosette (native curve) ────────
// Klassisches Banknoten-Ornament: r(θ) = R + a·cos(kθ), mehrlagig,
// pro Lage leicht phasenverschoben → Gewebe-Effekt.
#let guilloche(
  layers: 8,
  k-base: 7,
  samples: 480,
  base: rgb("#070d12"),
) = box(width: 100%, height: 100%, layout(size => {
  let W = size.width
  let H = size.height
  let cx = W / 2
  let cy = H / 2
  let R = 0.34 * calc.min(W, H)
  place(top + left, rect(width: 100%, height: 100%, fill: base))
  for L in range(layers) {
    let lt = L / (layers - 1)
    let k = k-base + L * 3
    let a = (0.06 + 0.12 * (1 - lt)) * R
    let phase = L * 11deg
    let col = spectrum.sample(lt * 100%)
    let pts = ()
    for s in range(samples + 1) {
      let th = (s / samples) * 360deg + phase
      let rr = R + a * calc.cos(k * th)
      pts.push((cx + rr * calc.cos(th), cy + rr * calc.sin(th)))
    }
    let segs = (curve.move(pts.first()),)
    for p in pts.slice(1) { segs.push(curve.line(p)) }
    segs.push(curve.close())
    place(top + left, curve(stroke: 0.45pt + col, fill: none, ..segs))
  }
}))

// ── 9. Kaleidoskop — radial gespiegelte Anatomie ───────────────
// Ein Ring aus rotierten, abwechselnd gespiegelten SVG-Kopien bildet
// eine kaleidoskopische Blüte; darüber ein Riso-Farbschleier.
#let kaleidoscope(
  src: "/src/assets/anatomy/cell.svg",
  segments: 12,
  base: rgb("#0b0b16"),
) = box(width: 100%, height: 100%, layout(size => {
  let W = size.width
  let H = size.height
  let cx = W / 2
  let cy = H / 2
  let reach = 0.20 * calc.min(W, H)
  let tw = 0.42 * W
  place(top + left, rect(width: 100%, height: 100%, fill: base))
  for i in range(segments) {
    let ang = (360deg / segments) * i
    // jede zweite Kopie gespiegelt → echte Reflexionssymmetrie
    let mirror = if calc.even(i) { 100% } else { -100% }
    place(
      top + left,
      dx: cx,
      dy: cy,
      rotate(
        ang,
        origin: top + left,
        move(
          dx: -tw / 2,
          dy: -reach - tw / 2,
          scale(x: mirror, origin: center, reflow: true, image(
            src,
            width: tw,
            fit: "contain",
            alt: "Kaleidoskopisch rotierte und gespiegelte Kopie eines Zellschemas.",
          )),
        ),
      ),
    )
  }
  // zentrale Blüte
  place(top + left, dx: cx - 0.18 * W, dy: cy - 0.18 * W, image(
    src,
    width: 0.36 * W,
    fit: "contain",
    alt: "Zentrales Zellschema der kaleidoskopischen Komposition.",
  ))
  // Riso-Farbschleier
  place(top + left, rect(
    width: 100%,
    height: 100%,
    fill: gradient.conic(
      art-colors.magenta.transparentize(62%),
      art-colors.cyan.transparentize(62%),
      art-colors.yellow.transparentize(62%),
      art-colors.magenta.transparentize(62%),
    ),
  ))
}))

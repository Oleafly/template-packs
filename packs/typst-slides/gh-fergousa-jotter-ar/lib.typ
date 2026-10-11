// jotter-ar — Arabic-localized "Jotter" template for Polylux.
// All design elements of the original `lib.typ` are preserved; the only
// changes are direction-aware layout so the notebook reads right-to-left
// (RTL) and the spiral binding moves to the right edge, as is conventional
// for Arabic documents.

#import "@preview/polylux:0.4.0": *
#import "@preview/suiji:0.4.0"
#import "@preview/colorful-boxes:1.4.3": stickybox

#let highlight-color-state = state("jotter-highlight-color", red)

#let setup(
  header: none,
  highlight-color: red,
  binding: true,
  dots: true,
  // `dir` drives the whole document direction. For the Arabic edition the
  // default is `rtl`; set it to `ltr` to get the original left-bound layout.
  dir: rtl,
  body,
) = {
  highlight-color-state.update(highlight-color)
  // `set text(dir: ..)` also sets the paragraph / page direction in Typst.
  set text(dir: dir)
  let binding-on-right = dir == rtl

  set page(
    paper: "presentation-16-9",
    // Leave room for the spiral binding on whichever side it lives.
    margin: if binding-on-right {
      (right: 3cm, top: 2cm, rest: 1cm)
    } else {
      (left: 3cm, top: 2cm, rest: 1cm)
    },
    fill: if dots {
      tiling(
        spacing: (5mm, 5mm),
        {
          place(square(width: 6mm, stroke: none, fill: white))
          circle(radius: 1pt, fill: white.darken(10%))
        },
      )
    },
    background: if binding {
      if binding-on-right {
        set align(top + right)
        let gap = 1.5cm
        let color = rgb("8aa")
        place(rect(height: 100%, width: 5mm, stroke: none, fill: black))
        place(dx: -5mm, rect(height: 100%, width: 5mm, stroke: none, fill: white))
        for offset in range(20) {
          let spiral(t, p) = curve(
            stroke: (thickness: t, paint: p),
            curve.move((-.5cm, 1cm)),
            curve.quad((.5cm, 1.1cm), (-1cm, 1.2cm)),
          )
          place(dy: offset * gap, spiral(2pt, color))
          place(
            dy: offset * gap - .2mm,
            dx: .2mm,
            spiral(.5pt, color.darken(50%)),
          )
          place(
            dx: -(1cm - .5mm),
            dy: offset * gap + 1.2cm - 1.5mm,
            circle(radius: 1.5mm, stroke: color + .3mm, fill: color.darken(70%)),
          )
        }
      } else {
        set align(top + left)
        let gap = 1.5cm
        let color = rgb("8aa")
        place(rect(height: 100%, width: 5mm, stroke: none, fill: black))
        place(dx: 5mm, rect(height: 100%, width: 5mm, stroke: none, fill: white))
        for offset in range(20) {
          let spiral(t, p) = curve(
            stroke: (thickness: t, paint: p),
            curve.move((.5cm, 1cm)),
            curve.quad((-.5cm, 1.1cm), (1cm, 1.2cm)),
          )
          place(dy: offset * gap, spiral(2pt, color))
          place(
            dy: offset * gap - .2mm,
            dx: -.2mm,
            spiral(.5pt, color.darken(50%)),
          )
          place(
            dx: 1cm - .5mm,
            dy: offset * gap + 1.2cm - 1.5mm,
            circle(radius: 1.5mm, stroke: color + .3mm, fill: color.darken(70%)),
          )
        }
      }
    },
    // Footer line + slide number. For RTL the small line is mirrored to go
    // up-left (matching the heading underlines) and sits to the right of the
    // number with a gap, so they only meet at the line's high tip.
    footer: context {
      set text(size: .6em, fill: text.fill.transparentize(30%))
      if binding-on-right {
        set align(left)
        context box(
          curve(
            stroke: (thickness: .05em, cap: "round", paint: text.fill),
            curve.quad((-.8em, -.9em), (-1em, -2em)),
          ),
        )
        h(1em)
        toolbox.slide-number
      } else {
        set align(right)
        context box(
          curve(
            stroke: (thickness: .05em, cap: "round", paint: text.fill),
            curve.quad((.8em, -.9em), (1em, -2em)),
          ),
        )
        toolbox.slide-number
      }
    },
    header: context if header != none {
      set align(if binding-on-right { left } else { right })
      set text(size: .6em, fill: text.fill.transparentize(30%))
      set par(spacing: .5em)
      // Header text sits at the left edge (~x=28), exactly as in the original
      // (beginning) layout. The swoosh stays in its own `context` block so it
      // doesn't shove the text; it sweeps to the *right* under the header text
      // (the approved direction, replacing the old broken left-off-page stroke)
      // and `dy` lifts it a little toward the top of the text.
      header
      context {
        let w = measure(header).width
        move(
          dy: .55em,
          curve(
            stroke: (thickness: .05em, cap: "round", paint: text.fill),
            curve.quad((.25 * w, -.3em), (w, 0em)),
          ),
        )
      }
    },
  )
  show emph: it => underline(
    stroke: stroke(
      thickness: .3em,
      paint: highlight-color.transparentize(50%),
      cap: "round",
    ),
    offset: -.1em,
    extent: .1em,
    evade: false,
    background: true,
    it.body,
  )
  show heading.where(level: 1): it => layout(sz => {
    let w = measure(..sz, it).width
    it
    move(
      dy: -.8em,
      curve(
        stroke: (thickness: .04em, cap: "round", paint: text.fill),
        fill: text.fill,
        curve.quad((.75 * w, -.5em), (w, 0em)),
        curve.quad((w + .05em, .03em), (w, .06em)),
        curve.quad((.75 * w, -.495em), (0em, 0em)),
      ),
    )
  })
  set list(marker: text(fill: highlight-color.lighten(10%), sym.bullet))
  set enum(
    numbering: (..n) => text(
      fill: highlight-color.lighten(10%),
      numbering("1.", ..n),
    ),
  )
  body
}

#let title-slide(title, extra) = slide({
  set align(center + horizon)
  set page(footer: none, header: none)

  if title != none {
    set text(1.5em)
    title
    context {
      let w = measure(title).width
      // Same hand-drawn underline as the (perfect) small headings: it extends
      // to the right of the title, which reads correctly for RTL too.
      let c(p) = curve(
        stroke: (paint: p, thickness: .1em, cap: "round"),
        curve.cubic((.2 * w, -.4em), (.95 * w, -.5em), (w + 1em, 0em)),
        curve.cubic(auto, (w + .5em, .1em), (w, .3em)),
      )
      v(-.5em)
      let hc = highlight-color-state.get()
      place(center, c(hc.transparentize(20%)))
      place(center, dx: .1em, dy: .1em, c(hc.transparentize(50%)))
    }
  }
  par(hide[42])

  extra
})

#let len2int(l) = int.from-bytes(l.pt().to-bytes())
#let hasher(acc, val) = acc.bit-xor(val)
#let hashed-position() = {
  let (x, y) = here().position()
  let n = counter("logical-slide").get()
  (len2int(x), len2int(y), ..n).reduce(hasher)
}

#let framed-block(
  body,
  sloppiness: .05,
  inset: .5em,
  width: auto,
  height: auto,
) = layout(sz => {
  let blocked-body = block(
    inset: inset,
    width: width,
    height: height,
    fill: none,
    stroke: none,
    body,
  )
  let (width: w, height: h) = measure(..sz, blocked-body)
  let deflect = sloppiness * (w + h) / 2

  let hash = (hashed-position(), len2int(w), len2int(h)).reduce(hasher)
  let rng = suiji.gen-rng-f(hash)
  let (rng, c1) = suiji.random-f(rng)
  let (rng, c2) = suiji.random-f(rng)
  let (rng, c3) = suiji.random-f(rng)
  let (rng, c4) = suiji.random-f(rng)
  let (rng, s1) = suiji.choice-f(rng, (-1, 1))
  let (rng, s2) = suiji.choice-f(rng, (-1, 1))
  let (rng, s3) = suiji.choice-f(rng, (-1, 1))
  let (rng, s4) = suiji.choice-f(rng, (-1, 1))

  let c(p) = curve(
    stroke: stroke(thickness: .1em, cap: "round", paint: p),
    curve.quad((c1 * w, s1 * deflect), (w + deflect / 3, 0pt)),
    curve.move((w - deflect / 3, -deflect / 3)),
    curve.quad((w + s2 * deflect, c2 * h), (w - deflect / 3, h + deflect / 3)),
    curve.move((w + deflect / 3, h - deflect / 3)),
    curve.quad((c3 * w, h + s3 * deflect), (0pt, h)),
    curve.quad((s4 * deflect, c4 * h), (0pt, 0pt)),
  )
  place(dx: .2em, dy: .15em, c(text.fill.transparentize(50%)))
  place(c(text.fill.transparentize(20%)))
  blocked-body
})

#let post-it(
  body,width: 5cm,
  fill: rgb("#FDE85F"),
  angle: -10deg,
  sloppiness: .2,
) = context {
  let hash = hashed-position()
  let rng = suiji.gen-rng-f(hash)
  let (rng, angle-deviation) = suiji.uniform-f(rng, low: -1, high: 1)
  let angle = (1 + sloppiness * angle-deviation) * angle
  let (rng, color-deviation) = suiji.uniform-f(rng, low: -1, high: 1)
  let fill = fill.darken(sloppiness * color-deviation * 40%)

  // The post-it is now a `stickybox` from the `typst-boxes` package (published
  // on the Typst registry as `colorful-boxes`), replacing the old `umbra` shadow
  // path. We keep the randomized slight tilt and subtle fill variation, and let
  // stickybox draw its own paper background + tape.
  rotate(
    angle,
    reflow: false,
    stickybox(
      body,
      rotation: 0deg,
      width: width,
      fill: fill,
      tape: true,
    ),
  )
}

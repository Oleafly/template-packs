// components/charts.typ — Medical data-visualization charts
//
// Built on CeTZ (already a core dependency) for a visual language
// consistent with the hand-rolled charts elsewhere in the book. Each
// function returns a `canvas` — wrap it in `#figure(..., caption: …)`.
//
// Provided: bar-chart, box-plot, km-curve (Kaplan-Meier), roc-curve,
// percentile-chart, forest-plot.

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "@preview/cetz:0.5.2": canvas, draw

// ── Tick helpers ───────────────────────────────────────────────
#let _round(v, digits: 0) = calc.round(v, digits: digits)

// Linear ticks from lo..hi (n intervals). `fmt` maps value → label.
#let _lin-ticks(lo, hi, n, fmt: v => str(_round(v))) = {
  let step = (hi - lo) / n
  range(n + 1).map(i => {
    let v = lo + i * step
    (v, fmt(v))
  })
}

// ── Axis frame ─────────────────────────────────────────────────
// Draws axes, ticks, optional gridlines and axis labels into a
// `w × h` (cm) canvas mapping `xlim`→[0,w], `ylim`→[0,h].
#let _frame(
  w,
  h,
  xlim,
  ylim,
  xticks: (),
  yticks: (),
  xlabel: none,
  ylabel: none,
  grid: true,
) = {
  let (x0, x1) = xlim
  let (y0, y1) = ylim
  let sx = w / (x1 - x0)
  let sy = h / (y1 - y0)
  let fx = x => (x - x0) * sx
  let fy = y => (y - y0) * sy

  for (val, lab) in yticks {
    let yy = fy(val)
    if grid { draw.line((0, yy), (w, yy), stroke: 0.4pt + palette.border-light) }
    draw.line((-0.12, yy), (0, yy), stroke: 0.6pt + palette.text-muted)
    draw.content((-0.25, yy), anchor: "east", text(size: type-scale.micro, fill: palette.text-muted, lab))
  }
  for (val, lab) in xticks {
    let xx = fx(val)
    draw.line((xx, 0), (xx, -0.12), stroke: 0.6pt + palette.text-muted)
    draw.content((xx, -0.32), anchor: "north", text(size: type-scale.micro, fill: palette.text-muted, lab))
  }
  draw.line((0, 0), (w, 0), stroke: 0.6pt + palette.text-muted)
  draw.line((0, 0), (0, h), stroke: 0.6pt + palette.text-muted)
  if xlabel != none {
    draw.content((w / 2, -0.85), text(size: type-scale.small, fill: palette.text-muted, xlabel))
  }
  if ylabel != none {
    draw.content((-1.05, h / 2), angle: 90deg, text(size: type-scale.small, fill: palette.text-muted, ylabel))
  }
}

// Scaler matching `_frame` for plotting data inside the same canvas.
#let _scale(w, h, xlim, ylim) = {
  let (x0, x1) = xlim
  let (y0, y1) = ylim
  (x => (x - x0) * w / (x1 - x0), y => (y - y0) * h / (y1 - y0))
}

// ── Bar chart ──────────────────────────────────────────────────
#let bar-chart(
  labels,
  values,
  color: palette.primary,
  ymax: auto,
  ylabel: none,
  xlabel: none,
  width: 7,
  height: 4.2,
) = {
  let n = values.len()
  let top = if ymax == auto { calc.max(..values) * 1.15 } else { ymax }
  let (fx, fy) = _scale(width, height, (0, n), (0, top))
  canvas(length: 1cm, {
    _frame(
      width,
      height,
      (0, n),
      (0, top),
      yticks: _lin-ticks(0, top, 4),
      xticks: labels.enumerate().map(((i, l)) => (i + 0.5, l)),
      ylabel: ylabel,
      xlabel: xlabel,
    )
    for (i, v) in values.enumerate() {
      draw.rect(
        (fx(i + 0.18), 0),
        (fx(i + 0.82), fy(v)),
        fill: color.lighten(15%),
        stroke: 0.6pt + color.darken(10%),
      )
      draw.content((fx(i + 0.5), fy(v) + 0.18), text(size: type-scale.micro, fill: palette.text-muted, [#v]))
    }
  })
}

// ── Box plot ───────────────────────────────────────────────────
// groups: array of (label, (min, q1, median, q3, max)).
#let box-plot(
  groups,
  color: palette.primary,
  ymax: auto,
  ymin: 0,
  ylabel: none,
  width: 7,
  height: 4.2,
) = {
  let n = groups.len()
  let all = groups.map(g => g.at(1)).flatten()
  let top = if ymax == auto { calc.max(..all) * 1.1 } else { ymax }
  let (fx, fy) = _scale(width, height, (0, n), (ymin, top))
  canvas(length: 1cm, {
    _frame(
      width,
      height,
      (0, n),
      (ymin, top),
      yticks: _lin-ticks(ymin, top, 4),
      xticks: groups.enumerate().map(((i, g)) => (i + 0.5, g.at(0))),
      ylabel: ylabel,
    )
    for (i, g) in groups.enumerate() {
      let (mn, q1, med, q3, mx) = g.at(1)
      let cx = i + 0.5
      // whiskers
      draw.line((fx(cx), fy(mn)), (fx(cx), fy(q1)), stroke: 0.6pt + color.darken(10%))
      draw.line((fx(cx), fy(q3)), (fx(cx), fy(mx)), stroke: 0.6pt + color.darken(10%))
      draw.line((fx(i + 0.32), fy(mn)), (fx(i + 0.68), fy(mn)), stroke: 0.6pt + color.darken(10%))
      draw.line((fx(i + 0.32), fy(mx)), (fx(i + 0.68), fy(mx)), stroke: 0.6pt + color.darken(10%))
      // box
      draw.rect((fx(i + 0.25), fy(q1)), (fx(i + 0.75), fy(q3)), fill: color.lighten(70%), stroke: 0.6pt + color.darken(10%))
      // median
      draw.line((fx(i + 0.25), fy(med)), (fx(i + 0.75), fy(med)), stroke: 1.2pt + color.darken(20%))
    }
  })
}

// ── Kaplan-Meier survival curve ────────────────────────────────
// curves: array of (label, color, data) where data is ((t, survival%), …)
// sorted by time. Draws right-continuous step functions.
#let km-curve(
  curves,
  tmax: auto,
  xlabel: [Zeit (Monate)],
  ylabel: [Überleben (%)],
  width: 7.5,
  height: 4.5,
) = {
  let max-t = if tmax == auto {
    calc.max(..curves.map(c => c.at(2).map(p => p.at(0))).flatten())
  } else { tmax }
  let (fx, fy) = _scale(width, height, (0, max-t), (0, 100))
  canvas(length: 1cm, {
    _frame(
      width,
      height,
      (0, max-t),
      (0, 100),
      yticks: _lin-ticks(0, 100, 4),
      xticks: _lin-ticks(0, max-t, 4),
      xlabel: xlabel,
      ylabel: ylabel,
    )
    for (label, col, data) in curves {
      for i in range(data.len() - 1) {
        let (t0, s0) = data.at(i)
        let (t1, s1) = data.at(i + 1)
        draw.line((fx(t0), fy(s0)), (fx(t1), fy(s0)), stroke: 1.6pt + col)
        draw.line((fx(t1), fy(s0)), (fx(t1), fy(s1)), stroke: 1.6pt + col)
      }
    }
    // legend
    let ly = height - 0.3
    for (i, (label, col, data)) in curves.enumerate() {
      let yy = ly - i * 0.45
      draw.line((width - 2.2, yy), (width - 1.7, yy), stroke: 1.6pt + col)
      draw.content((width - 1.6, yy), anchor: "west", text(size: type-scale.micro, fill: palette.text-body, label))
    }
  })
}

// ── ROC curve ──────────────────────────────────────────────────
// points: ((fpr, tpr), …) in [0,1]. Optional AUC annotation.
#let roc-curve(
  points,
  auc: none,
  color: palette.primary,
  width: 5.5,
  height: 5.5,
) = {
  let (fx, fy) = _scale(width, height, (0, 1), (0, 1))
  canvas(length: 1cm, {
    _frame(
      width,
      height,
      (0, 1),
      (0, 1),
      yticks: _lin-ticks(0, 1, 4, fmt: v => str(_round(v, digits: 2))),
      xticks: _lin-ticks(0, 1, 4, fmt: v => str(_round(v, digits: 2))),
      xlabel: [1 − Spezifität],
      ylabel: [Sensitivität],
    )
    // reference diagonal
    draw.line((0, 0), (width, height), stroke: (dash: "dashed", paint: palette.text-light, thickness: 0.5pt))
    // curve
    for i in range(points.len() - 1) {
      let (a, b) = (points.at(i), points.at(i + 1))
      draw.line((fx(a.at(0)), fy(a.at(1))), (fx(b.at(0)), fy(b.at(1))), stroke: 1.8pt + color)
    }
    if auc != none {
      draw.content(
        (width - 0.2, 0.4),
        anchor: "east",
        text(size: type-scale.small, weight: "bold", fill: color.darken(10%))[AUC = #auc],
      )
    }
  })
}

// ── Percentile / growth chart ──────────────────────────────────
// x: array of x-values (e.g. age). curves: array of (label, color, ys).
#let percentile-chart(
  x,
  curves,
  xlabel: [Alter (Jahre)],
  ylabel: none,
  ymin: auto,
  ymax: auto,
  width: 7.5,
  height: 5,
) = {
  let all-y = curves.map(c => c.at(2)).flatten()
  let lo = if ymin == auto { calc.min(..all-y) * 0.95 } else { ymin }
  let hi = if ymax == auto { calc.max(..all-y) * 1.05 } else { ymax }
  let (fx, fy) = _scale(width, height, (calc.min(..x), calc.max(..x)), (lo, hi))
  canvas(length: 1cm, {
    _frame(
      width,
      height,
      (calc.min(..x), calc.max(..x)),
      (lo, hi),
      yticks: _lin-ticks(lo, hi, 4, fmt: v => str(_round(v))),
      xticks: _lin-ticks(calc.min(..x), calc.max(..x), 4),
      xlabel: xlabel,
      ylabel: ylabel,
    )
    for (label, col, ys) in curves {
      for i in range(x.len() - 1) {
        draw.line((fx(x.at(i)), fy(ys.at(i))), (fx(x.at(i + 1)), fy(ys.at(i + 1))), stroke: 1.4pt + col)
      }
      draw.content(
        (fx(x.last()) + 0.1, fy(ys.last())),
        anchor: "west",
        text(size: type-scale.micro, fill: col.darken(10%), label),
      )
    }
  })
}

// ── Forest plot ────────────────────────────────────────────────
// rows: array of (label, estimate, lo, hi). `null` is the no-effect
// reference (1 for ratios, 0 for differences). Labels sit left of the
// axis; estimates [CI] on the right.
#let forest-plot(
  rows,
  null: 1,
  xlim: auto,
  xlabel: [Odds Ratio (95 %-KI)],
  color: palette.primary,
  width: 6,
  row-height: 0.6,
) = {
  let los = rows.map(r => r.at(2))
  let his = rows.map(r => r.at(3))
  let lim = if xlim == auto { (calc.min(..los) * 0.8, calc.max(..his) * 1.1) } else { xlim }
  let h = rows.len() * row-height
  let (fx, fy) = _scale(width, h, lim, (0, rows.len()))
  canvas(length: 1cm, {
    // null reference line
    draw.line((fx(null), 0), (fx(null), h), stroke: (dash: "dashed", paint: palette.text-light, thickness: 0.6pt))
    // x axis
    draw.line((0, 0), (width, 0), stroke: 0.6pt + palette.text-muted)
    for (v, lab) in _lin-ticks(lim.at(0), lim.at(1), 4, fmt: v => str(_round(v, digits: 1))) {
      let xx = fx(v)
      draw.line((xx, 0), (xx, -0.12), stroke: 0.6pt + palette.text-muted)
      draw.content((xx, -0.3), anchor: "north", text(size: type-scale.micro, fill: palette.text-muted, lab))
    }
    draw.content((width / 2, -0.78), text(size: type-scale.small, fill: palette.text-muted, xlabel))
    // rows (top to bottom)
    for (i, r) in rows.enumerate() {
      let (label, est, lo, hi) = r
      let yy = fy(rows.len() - i - 0.5)
      draw.content((-0.3, yy), anchor: "east", text(size: type-scale.micro, fill: palette.text-body, label))
      draw.line((fx(lo), yy), (fx(hi), yy), stroke: 1pt + color.darken(5%))
      draw.line((fx(lo), yy - 0.08), (fx(lo), yy + 0.08), stroke: 1pt + color.darken(5%))
      draw.line((fx(hi), yy - 0.08), (fx(hi), yy + 0.08), stroke: 1pt + color.darken(5%))
      draw.rect((fx(est) - 0.07, yy - 0.07), (fx(est) + 0.07, yy + 0.07), fill: color, stroke: none)
      draw.content(
        (width + 0.25, yy),
        anchor: "west",
        text(size: type-scale.micro, fill: palette.text-muted)[#est (#lo–#hi)],
      )
    }
  })
}

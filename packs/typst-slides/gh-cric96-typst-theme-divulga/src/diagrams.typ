// Native diagrams, drawn with plain Typst so they stay crisp and on-palette.
#import "theme.typ": palette, fonts, accent

/// Horizontal timeline. Each event is `(year, label)`, `(year, label, color)`
/// or a dictionary `(year: .., label: .., color: .., hollow: true)`; hollow events
/// are drawn as empty circles (e.g. "winters").
#let timeline(events, height: 6.2em) = context {
  let c = accent.get()
  let norm(ev) = if type(ev) == dictionary {
    (ev.year, ev.label, ev.at("color", default: c), ev.at("hollow", default: false))
  } else if ev.len() == 2 {
    (ev.at(0), ev.at(1), c, false)
  } else {
    (ev.at(0), ev.at(1), ev.at(2), false)
  }
  let n = events.len()
  block(width: 100%, height: height, {
    place(horizon + left, line(length: 100%, stroke: 3pt + palette.line))
    for (i, ev) in events.enumerate() {
      let (year, label, col, hollow) = norm(ev)
      let x = (i + 0.5) / n * 100%
      let up = calc.rem(i, 2) == 0
      place(horizon + left, dx: x - 0.45em, circle(radius: 0.45em, fill: if hollow { palette.paper } else { col }, stroke: 2.5pt + col))
      place(
        if up { top + left } else { bottom + left },
        dx: x - 3.5em,
        box(width: 7em, align(center, {
          if not up { v(0.2em) }
          text(font: fonts.display, weight: "bold", size: 0.95em, fill: col, year)
          linebreak()
          text(size: 0.62em, fill: palette.ink-soft, label)
        })),
      )
    }
  })
}

/// A sentence whose words are linked by attention arcs to one focus word.
/// `words`: array of strings; `focus`: index; `weights`: array (same length) in [0,1].
#let attention(words, focus, weights, size: 1.2em) = context {
  let c = accent.get()
  let n = words.len()
  set text(size: size)
  layout(sz => {
    let w = sz.width
    let slot = w / n
    let base = 3.2em
    block(width: 100%, height: base + 1.6em, {
      for (i, word) in words.enumerate() {
        let cx = slot * (i + 0.5)
        let wgt = weights.at(i)
        if i != focus and wgt > 0.05 {
          let fx = slot * (focus + 0.5)
          let mid = (cx + fx) / 2
          let hgt = calc.min(base - 0.4em, 0.6em + calc.abs(i - focus) * 0.55em)
          place(top + left, curve(
            stroke: (paint: c.transparentize(100% - wgt * 100%), thickness: 1pt + 5pt * wgt, cap: "round"),
            curve.move((cx, base - 0.2em)),
            curve.quad((mid, base - 0.2em - hgt * 2), (fx, base - 0.2em)),
          ))
        }
        place(top + left, dx: cx - slot / 2, dy: base, box(width: slot, align(center, {
          let f = i == focus
          box(
            fill: if f { c } else { c.transparentize(100% - wgt * 35%) },
            inset: (x: 0.3em, y: 0.25em),
            text(font: fonts.display, weight: if f { "bold" } else { "medium" }, fill: if f { white } else { palette.ink }, word),
          )
        })))
      }
    })
  })
}

/// Row of boxes joined by arrows.
#let flow(steps, colors: none, size: 1em) = context {
  let c = accent.get()
  let n = steps.len()
  let cells = ()
  for (i, st) in steps.enumerate() {
    let col = if colors != none { colors.at(i) } else { c }
    cells.push(block(
      width: 100%,
      stroke: (top: 4pt + col),
      inset: (top: 0.6em),
      align(left, text(size: size, st)),
    ))
    if i < n - 1 {
      // arrow drawn on the same line as the top rules, so the steps read as one pipeline
      cells.push(box(width: 100%, height: 4pt, {
        place(top + left, dy: 2pt, line(start: (0.3em, 0pt), end: (100% - 0.5em, 0pt), stroke: 2pt + palette.muted))
        place(top + left, dx: 100% - 0.75em, dy: 2pt - 0.32em, polygon(fill: palette.muted, (0pt, 0pt), (0.55em, 0.32em), (0pt, 0.64em)))
      }))
    }
  }
  grid(columns: range(2 * n - 1).map(i => if calc.even(i) { 1fr } else { 2.6em }), align: top, ..cells)
}

/// The agent loop: think → act → observe, around a goal.
#let agent-loop(
  size: 1em,
  think: [Think],
  act: [Act],
  observe: [Observe],
  goal: [goal \ + tools],
) = context {
  let c = accent.get()
  let node(label, col) = box(
    fill: col,
    inset: (x: 1em, y: 0.55em),
    text(font: fonts.display, weight: "bold", fill: white, size: size, label),
  )
  block(width: 100%, height: 9.5em, {
    place(center + horizon, circle(radius: 3.8em, stroke: (paint: palette.line, thickness: 3pt, dash: "dashed")))
    place(center + horizon, text(font: fonts.mono, size: 0.7em, fill: palette.muted, align(center, goal)))
    place(center + top, node(think, c))
    place(center + bottom, dx: -4.6em, node(act, palette.coral))
    place(center + bottom, dx: 4.6em, node(observe, palette.green))
  })
}

/// A single artificial neuron (perceptron): labelled inputs with weights → Σ → output.
#let perceptron(inputs, weights, output, size: 1em) = context {
  let c = accent.get()
  set text(size: size)
  let n = inputs.len()
  let w = 13em
  let h = 7.5em
  let in-x = 4.2em
  let sum = (8.2em, h / 2)
  let r = 1.1em
  block(width: w, height: h, {
    for (i, (label, wt)) in inputs.zip(weights).enumerate() {
      let y = h * (i + 0.5) / n
      place(top + left, line(
        start: (in-x, y),
        end: (sum.at(0) - r, sum.at(1)),
        stroke: (paint: c, thickness: 0.8pt + 3pt * wt, cap: "round"),
      ))
      place(top + left, dx: 0em, dy: y - 0.6em, box(width: in-x - 0.5em, align(right, text(size: 0.8em, label))))
      let mx = in-x + (sum.at(0) - r - in-x) * 0.22
      let my = y + (sum.at(1) - y) * 0.22
      place(top + left, dx: mx - 0.9em, dy: my - 1.05em, box(
        fill: palette.paper, inset: 0.12em,
        text(font: fonts.mono, size: 0.55em, fill: palette.muted, "w=" + str(wt)),
      ))
    }
    place(top + left, dx: sum.at(0) - r, dy: sum.at(1) - r, circle(
      radius: r, fill: c,
      align(center + horizon, text(font: fonts.display, weight: "bold", fill: white, size: 1.1em, $Sigma$)),
    ))
    place(top + left, line(
      start: (sum.at(0) + r, sum.at(1)),
      end: (sum.at(0) + r + 1.4em, sum.at(1)),
      stroke: 2.5pt + palette.ink,
    ))
    place(top + left, dx: sum.at(0) + r + 1.5em, dy: sum.at(1) - 0.65em, text(font: fonts.display, weight: "bold", output))
  })
}

/// A layered neural network: `layers` is the number of neurons per layer.
#let network(layers, width: 12em, height: 7.5em, r: 0.42em) = context {
  let c = accent.get()
  let L = layers.len()
  let pos(l, i) = {
    let n = layers.at(l)
    (width * (l + 0.5) / L, height * (i + 0.5) / n)
  }
  block(width: width, height: height, {
    for l in range(L - 1) {
      for i in range(layers.at(l)) {
        for j in range(layers.at(l + 1)) {
          place(top + left, line(start: pos(l, i), end: pos(l + 1, j), stroke: 0.6pt + c.transparentize(65%)))
        }
      }
    }
    for l in range(L) {
      for i in range(layers.at(l)) {
        let (x, y) = pos(l, i)
        let col = if l == 0 { palette.muted } else if l == L - 1 { palette.coral } else { c }
        place(top + left, dx: x - r, dy: y - r, circle(radius: r, fill: col, stroke: 1.5pt + palette.paper))
      }
    }
  })
}

/// Scatter of dots. `points`: array of (x, y) in [0, 1]; `colors`: one per point.
#let scatter(points, colors, width: 7.6em, height: 3.6em, r: 0.26em) = box(
  width: width,
  height: height,
  {
    for ((x, y), col) in points.zip(colors) {
      place(top + left, dx: 0.4em + (width - 0.8em) * x - r, dy: 0.4em + (height - 0.8em) * y - r, circle(radius: r, fill: col))
    }
  },
)

/// Frameless panel for the learning flows.
#let panel(body, width: 7.6em, height: 3.6em) = box(
  width: width,
  height: height,
  inset: 0.35em,
  align(center + horizon, body),
)

/// One learning flow: label | input → network → output.
#let learning-flow(tag, caption, input, output, color: auto) = context {
  let c = if color == auto { accent.get() } else { color }
  let arrow = text(font: fonts.display, size: 1.3em, weight: "bold", fill: palette.muted, sym.arrow.r)
  grid(
    columns: (8em, auto, 1.5em, auto, 1.5em, auto),
    align: horizon + center,
    align(left, {
      box(fill: c, inset: (x: 0.5em, y: 0.3em), text(font: fonts.mono, size: 0.55em, weight: "medium", fill: white, tracking: 0.05em, upper(tag)))
      linebreak()
      text(size: 0.72em, fill: palette.ink-soft, caption)
    }),
    input,
    arrow,
    network((3, 4, 3), width: 3.8em, height: 3.4em, r: 0.24em),
    arrow,
    output,
  )
}

/// Straight arrow with a numbered badge and a short label at its midpoint.
#let _arrow(a, b, col, num, label, label-dy: -0.9em) = {
  let (x1, y1) = a
  let (x2, y2) = b
  let ang = calc.atan2((x2 - x1).to-absolute().pt(), (y2 - y1).to-absolute().pt())
  let h = 0.45em
  place(top + left, line(start: a, end: b, stroke: (paint: col, thickness: 2.5pt, cap: "round")))
  place(top + left, polygon(
    fill: col,
    (x2, y2),
    (x2 - h * calc.cos(ang) + h * 0.6 * calc.sin(ang), y2 - h * calc.sin(ang) - h * 0.6 * calc.cos(ang)),
    (x2 - h * calc.cos(ang) - h * 0.6 * calc.sin(ang), y2 - h * calc.sin(ang) + h * 0.6 * calc.cos(ang)),
  ))
  let mx = (x1 + x2) / 2
  let my = (y1 + y2) / 2
  place(top + left, dx: mx - 0.42em, dy: my - 0.42em, circle(radius: 0.42em, fill: col,
    align(center + horizon, text(font: fonts.mono, size: 0.55em, weight: "bold", fill: white, str(num)))))
  place(top + left, dx: mx - 3em, dy: my + label-dy, box(width: 6em, align(center,
    text(font: fonts.mono, size: 0.62em, weight: "medium", fill: col, label))))
}

/// An agent at work: user ↔ LLM ↔ three tools, revealed in `stage` steps (1–4):
/// 1 request · 2-3 first tool and its result · 4-5 the other two tools · 6 answer.
///
/// - user, llm (content): icons (≈ 2.6em).
/// - tools (array): three `(icon: active => content, label: content)`.
/// - labels (dictionary): texts for the six arrows and the nodes.
#let agent-diagram(
  stage,
  user,
  llm,
  tools,
  labels: (
    user: [You], llm: [LLM], agent: "AGENT",
    request: [request], call: [search], result: [results],
    second: [buy], third: [schedule], answer: [done!],
  ),
) = context {
  let c = accent.get()
  let (ux, ax, tx) = (2.6em, 15.5em, 29em)
  let node(x, y, icon, label, active: true) = {
    place(top + left, dx: x - 1.3em, dy: y - 1.3em, icon)
    place(top + left, dx: x - 3.5em, dy: y + 1.35em, box(width: 7em, align(center,
      text(font: fonts.display, size: 0.7em, weight: "bold", fill: if active { palette.ink } else { palette.muted }, label))))
  }
  let (t1, t2, t3) = tools
  block(width: 100%, height: 10.8em, {
    place(top + left, dx: ax - 2.7em, dy: 5em - 2.7em, circle(radius: 2.7em, stroke: (paint: c, thickness: 1.5pt, dash: "dashed")))
    place(top + left, dx: ax - 2em, dy: 5em - 3.4em, box(width: 4em, align(center, text(font: fonts.mono, size: 0.55em, weight: "bold", fill: c, labels.agent))))
    node(ux, 5em, user, labels.user)
    node(ax, 5em, llm, labels.llm)
    node(tx, 1.4em, (t1.icon)(stage >= 2), t1.label, active: stage >= 2)
    node(tx, 5em, (t2.icon)(stage >= 3), t2.label, active: stage >= 3)
    node(tx, 8.6em, (t3.icon)(stage >= 3), t3.label, active: stage >= 3)
    if stage >= 1 { _arrow((ux + 1.8em, 4.4em), (ax - 3.1em, 4.4em), palette.ink, 1, labels.request) }
    if stage >= 2 {
      _arrow((ax + 2.6em, 3.5em), (tx - 1.8em, 1em), palette.coral, 2, labels.call)
      _arrow((tx - 1.8em, 2.1em), (ax + 2.9em, 4.3em), palette.green, 3, labels.result, label-dy: 0.55em)
    }
    if stage >= 3 {
      _arrow((ax + 3em, 5.2em), (tx - 1.8em, 5.2em), palette.coral, 4, labels.second, label-dy: 0.55em)
      _arrow((ax + 2.6em, 6.6em), (tx - 1.8em, 8.6em), palette.coral, 5, labels.third, label-dy: 0.55em)
    }
    if stage >= 4 { _arrow((ax - 3.1em, 5.8em), (ux + 1.8em, 5.8em), palette.green, 6, labels.answer, label-dy: 0.55em) }
  })
}

/// Row of chevron arrows with the text inside, and an optional caption under each.
/// `steps`: array of (inside, below) contents.
#let chevrons(steps, colors: none, height: 3em, notch: 1em, gap: 0.25em) = context {
  let c = accent.get()
  let n = steps.len()
  layout(sz => {
    let w = (sz.width - gap * (n - 1)) / n
    let row = for (i, (inside, _)) in steps.enumerate() {
      let col = if colors != none { colors.at(i) } else { c }
      let first = i == 0
      let pts = (
        (0pt, 0pt), (w - notch, 0pt), (w, height / 2), (w - notch, height), (0pt, height),
      )
      if not first { pts.push((notch, height / 2)) }
      let x = i * (w + gap)
      place(top + left, dx: x, polygon(fill: col, ..pts))
      place(top + left, dx: x + if first { 0.7em } else { notch + 0.3em }, box(
        width: w - notch - if first { 0.9em } else { notch + 0.4em },
        height: height,
        align(left + horizon, text(fill: white, inside)),
      ))
    }
    block(width: 100%, height: height, row)
    if steps.all(((_, b)) => b == none) { return }
    v(0.5em)
    grid(
      columns: (w,) * n,
      column-gutter: gap,
      align: top + left,
      ..steps.enumerate().map(((i, (_, below))) => pad(left: if i == 0 { 0.7em } else { notch + 0.3em }, right: notch, if below == none { [] } else { below })),
    )
  })
}

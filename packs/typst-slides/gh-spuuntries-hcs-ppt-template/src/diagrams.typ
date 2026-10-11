#import "@preview/cetz:0.3.4": *
#import "colors.typ": *

/// Draws a CeTZ diagram of a Perceptron / MLP building block
#let cetz-perceptron(
  length: 1cm,
  scale: auto,
) = {
  let user-scale = scale
  let user-length = length
  import draw: *
  group({
    let factor = if user-scale != auto {
      float(user-scale)
    } else if type(user-length) == type(1cm) {
      float(user-length / 1cm)
    } else if type(user-length) in (type(1), type(1.0)) {
      float(user-length)
    } else {
      1.0
    }

    // Explicit bounding box to guarantee identical card heights across the grid
    rect((-2.3, -2.1), (2.3, 1.3), stroke: none)

    // Center Node (Split Sum & Non-linear activation)
    circle((0, 0), radius: 0.62, fill: hcs-surface, stroke: 1.8pt + hcs-blue, name: "node")
    line((0, -0.62), (0, 0.62), stroke: (dash: "densely-dashed", paint: hcs-slate, thickness: 0.8pt))
    content((-0.28, 0), text(size: 11pt * factor, weight: "bold", fill: hcs-navy)[$sum$])
    content((0.28, 0), text(size: 11pt * factor, weight: "bold", fill: hcs-blue)[$sigma$])

    // Weighted Edges (from input perimeter at x = -1.75 to node perimeter)
    line((-1.75, 0.85), (-0.62, 0.1), stroke: 1.5pt + hcs-navy-light, mark: (end: ">", size: 0.13))
    line((-1.75, -0.85), (-0.62, -0.1), stroke: 1.5pt + hcs-navy-light, mark: (end: ">", size: 0.13))
    content((-1.15, 0.65), text(size: 8.5pt * factor, fill: hcs-navy, weight: "bold")[$w_1$])
    content((-1.15, -0.65), text(size: 8.5pt * factor, fill: hcs-navy, weight: "bold")[$w_2$])

    // Inputs (drawn over edges for clean z-ordering)
    circle((-2.0, 0.85), radius: 0.25, fill: hcs-slate-light, stroke: 1.2pt + hcs-slate-dark, name: "x1")
    circle((-2.0, -0.85), radius: 0.25, fill: hcs-slate-light, stroke: 1.2pt + hcs-slate-dark, name: "x2")
    content("x1", text(size: 8.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$x_1$])
    content("x2", text(size: 8.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$x_2$])

    // Output
    line("node.east", (1.5, 0), stroke: 1.5pt + hcs-navy, mark: (end: ">", size: 0.13))
    content((1.85, 0), text(size: 9.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$y$])

    // Math & label footer
    content((0, -1.28), text(size: 9pt * factor, weight: "bold", fill: hcs-navy)[Ridge / Hyperplane])
    content((0, -1.58), text(size: 7.5pt * factor, fill: hcs-text-muted)[$y = sigma(sum w_i x_i + b)$])
    content((0, -1.88), text(size: 6.8pt * factor, fill: hcs-slate-dark)[dot product \u{2022} global half-spaces])
  })
}

/// Standalone canvas wrapper for cetz-perceptron
#let cetz-perceptron-canvas(length: 1cm, scale: auto, ..args) = {
  canvas(length: length, {
    cetz-perceptron(length: length, scale: scale, ..args)
  })
}

/// Draws a CeTZ diagram of a KAN (Kolmogorov-Arnold Network) building block
#let cetz-kan(
  length: 1cm,
  scale: auto,
) = {
  let user-scale = scale
  let user-length = length
  import draw: *
  group({
    let factor = if user-scale != auto {
      float(user-scale)
    } else if type(user-length) == type(1cm) {
      float(user-length / 1cm)
    } else if type(user-length) in (type(1), type(1.0)) {
      float(user-length)
    } else {
      1.0
    }

    // Explicit bounding box to guarantee identical card heights across the grid
    rect((-2.3, -2.1), (2.3, 1.3), stroke: none)

    // Center Node (Pure sum only)
    circle((0, 0), radius: 0.62, fill: rgb("#ECFDF5"), stroke: 1.8pt + rgb("#059669"), name: "node")
    content((0, 0), text(size: 13pt * factor, weight: "bold", fill: rgb("#047857"))[$sum$])

    // Spline Edges (Starting from perimeter x = -1.75 to node perimeter)
    bezier((-1.75, 0.85), (-0.62, 0.12), (-1.35, 1.15), (-0.85, 0.45), stroke: 1.5pt + rgb("#059669"), mark: (
      end: ">",
      size: 0.13,
    ))
    bezier((-1.75, -0.85), (-0.62, -0.12), (-1.35, -1.15), (-0.85, -0.45), stroke: 1.5pt + rgb("#059669"), mark: (
      end: ">",
      size: 0.13,
    ))

    // Inputs (drawn on top with opaque fill)
    circle((-2.0, 0.85), radius: 0.25, fill: hcs-slate-light, stroke: 1.2pt + hcs-slate-dark, name: "x1")
    circle((-2.0, -0.85), radius: 0.25, fill: hcs-slate-light, stroke: 1.2pt + hcs-slate-dark, name: "x2")
    content("x1", text(size: 8.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$x_1$])
    content("x2", text(size: 8.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$x_2$])

    // 1D Spline badges with extra bottom padding for the phi descender
    content((-1.15, 0.85), box(
      fill: hcs-surface,
      inset: (x: 4.5pt * factor, top: 2.5pt * factor, bottom: 4.5pt * factor),
      radius: 3pt * factor,
      stroke: 0.8pt + rgb("#A7F3D0"),
      text(size: 7.8pt * factor, weight: "bold", fill: rgb("#047857"))[$phi_1(x)$],
    ))
    content((-1.15, -0.85), box(
      fill: hcs-surface,
      inset: (x: 4.5pt * factor, top: 2.5pt * factor, bottom: 4.5pt * factor),
      radius: 3pt * factor,
      stroke: 0.8pt + rgb("#A7F3D0"),
      text(size: 7.8pt * factor, weight: "bold", fill: rgb("#047857"))[$phi_2(x)$],
    ))

    // Output
    line("node.east", (1.5, 0), stroke: 1.5pt + rgb("#059669"), mark: (end: ">", size: 0.13))
    content((1.85, 0), text(size: 9.5pt * factor, weight: "bold", fill: rgb("#047857"))[$y$])

    // Math & label footer
    content((0, -1.28), text(size: 9pt * factor, weight: "bold", fill: rgb("#047857"))[1D Superposition])
    content((0, -1.58), text(size: 7.5pt * factor, fill: hcs-text-muted)[$y = sum phi_i (x_i)$])
    content((0, -1.88), text(size: 6.8pt * factor, fill: hcs-slate-dark)[1D splines \u{2022} coordinate curves])
  })
}

/// Standalone canvas wrapper for cetz-kan
#let cetz-kan-canvas(length: 1cm, scale: auto, ..args) = {
  canvas(length: length, {
    cetz-kan(length: length, scale: scale, ..args)
  })
}

/// Draws a CeTZ diagram of a Radial Basis Function (RBF) unit
#let cetz-rbf(
  length: 1cm,
  scale: auto,
) = {
  let user-scale = scale
  let user-length = length
  import draw: *
  group({
    let factor = if user-scale != auto {
      float(user-scale)
    } else if type(user-length) == type(1cm) {
      float(user-length / 1cm)
    } else if type(user-length) in (type(1), type(1.0)) {
      float(user-length)
    } else {
      1.0
    }

    // Explicit bounding box to guarantee identical card heights across the grid
    rect((-2.3, -2.1), (2.3, 1.3), stroke: none)

    // Center Node (Gaussian radial kernel with prototype center)
    circle((0, 0), radius: 0.62, fill: rgb("#FFFBEB"), stroke: 1.8pt + rgb("#D97706"), name: "node")
    content((0, 0.1), text(size: 9.5pt * factor, weight: "bold", fill: rgb("#B45309"))[$e^(-gamma d^2)$])
    content((0, -0.26), text(size: 7pt * factor, fill: rgb("#D97706"))[center $bold(c)$])

    // Distance metric edges from perimeter x = -1.75 to circle perimeter
    line((-1.75, 0.85), (-0.62, 0.1), stroke: 1.5pt + rgb("#D97706"), mark: (end: ">", size: 0.13))
    line((-1.75, -0.85), (-0.62, -0.1), stroke: 1.5pt + rgb("#D97706"), mark: (end: ">", size: 0.13))

    // Inputs (drawn on top with opaque fill)
    circle((-2.0, 0.85), radius: 0.25, fill: hcs-slate-light, stroke: 1.2pt + hcs-slate-dark, name: "x1")
    circle((-2.0, -0.85), radius: 0.25, fill: hcs-slate-light, stroke: 1.2pt + hcs-slate-dark, name: "x2")
    content("x1", text(size: 8.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$x_1$])
    content("x2", text(size: 8.5pt * factor, weight: "bold", fill: hcs-navy-dark)[$x_2$])

    // Distance badges with generous top/bottom padding for the tall absolute value bars
    content((-0.92, 0.68), box(
      fill: hcs-surface,
      inset: (x: 3.5pt * factor, y: 2.5pt * factor),
      radius: 3pt * factor,
      stroke: 0.8pt + rgb("#FDE68A"),
      text(size: 6.8pt * factor, weight: "bold", fill: rgb("#B45309"))[$|x_1 - c_1|$],
    ))
    content((-0.92, -0.68), box(
      fill: hcs-surface,
      inset: (x: 3.5pt * factor, y: 2.5pt * factor),
      radius: 3pt * factor,
      stroke: 0.8pt + rgb("#FDE68A"),
      text(size: 6.8pt * factor, weight: "bold", fill: rgb("#B45309"))[$|x_2 - c_2|$],
    ))

    // Output
    line("node.east", (1.5, 0), stroke: 1.5pt + rgb("#D97706"), mark: (end: ">", size: 0.13))
    content((1.85, 0), text(size: 9.5pt * factor, weight: "bold", fill: rgb("#B45309"))[$y$])

    // Math & label footer
    content((0, -1.28), text(size: 9pt * factor, weight: "bold", fill: rgb("#B45309"))[Metric / Kernel])
    content((0, -1.58), text(size: 7.5pt * factor, fill: hcs-text-muted)[$y = exp(-gamma norm(bold(x) - bold(c))^2)$])
    content((0, -1.88), text(size: 6.8pt * factor, fill: hcs-slate-dark)[euclidean metric \u{2022} hyperspheres])
  })
}

/// Standalone canvas wrapper for cetz-rbf
#let cetz-rbf-canvas(length: 1cm, scale: auto, ..args) = {
  canvas(length: length, {
    cetz-rbf(length: length, scale: scale, ..args)
  })
}

/// Draws a CeTZ diagram of a model flow: [Input Head] -> [Processing Layer] -> [Output Layer]
#let cetz-pipeline(
  input-title: [Input Head],
  input-desc: [tokens / sensors / features],
  process-title: [Processing Layer],
  process-desc: [backbone / hidden states $bold(h)$],
  output-title: [Output Layer],
  output-desc: [logits / learning signal],
  input-arrow: [$bold(x)$],
  output-arrow: [$bold(z)$ / floats],
  highlight-output: true,
  length: 1cm,
  scale: auto,
  title-size: auto,
  desc-size: auto,
  arrow-size: auto,
) = {
  let user-scale = scale
  let user-length = length
  import draw: *
  group({
    let factor = if user-scale != auto {
      float(user-scale)
    } else if type(user-length) == type(1cm) {
      float(user-length / 1cm)
    } else if type(user-length) in (type(1), type(1.0)) {
      float(user-length)
    } else {
      1.0
    }

    let t-size = if title-size != auto { title-size } else { 11.5pt * factor }
    let d-size = if desc-size != auto { desc-size } else { 8pt * factor }
    let a-size = if arrow-size != auto { arrow-size } else { 7.5pt * factor }

    let w = 3.6
    let h = 1.35
    let gap = 1.3

    // 1. Input Head
    let x1 = 0
    rect(
      (x1 - w/2, -h/2),
      (x1 + w/2, h/2),
      radius: 0.16,
      fill: hcs-surface,
      stroke: 1.5pt + hcs-slate-dark,
      name: "in-box",
    )
    let y1 = if input-desc != none { 0.18 } else { 0 }
    content((x1, y1), text(size: t-size, weight: "bold", fill: hcs-navy)[#input-title])
    if input-desc != none {
      content((x1, -0.22), text(size: d-size, fill: hcs-text-muted)[#input-desc])
    }

    // 2. Processing Layer (Backbone with stacked card effect)
    let x2 = x1 + w + gap
    rect(
      (x2 - w/2 + 0.1, -h/2 - 0.1),
      (x2 + w/2 + 0.1, h/2 - 0.1),
      radius: 0.16,
      fill: hcs-slate-light,
      stroke: 1pt + hcs-slate,
    )
    rect(
      (x2 - w/2, -h/2),
      (x2 + w/2, h/2),
      radius: 0.16,
      fill: hcs-surface,
      stroke: 1.5pt + hcs-blue,
      name: "proc-box",
    )
    let y2 = if process-desc != none { 0.18 } else { 0 }
    content((x2, y2), text(size: t-size, weight: "bold", fill: hcs-navy)[#process-title])
    if process-desc != none {
      content((x2, -0.22), text(size: d-size, fill: hcs-text-muted)[#process-desc])
    }

    // 3. Output Layer (Highlighted)
    let x3 = x2 + w + gap
    let out-stroke = if highlight-output { 1.8pt + hcs-cyan-deep } else { 1.5pt + hcs-navy }
    let out-fill = if highlight-output { rgb("#F0FDFA") } else { hcs-surface }
    rect(
      (x3 - w/2, -h/2),
      (x3 + w/2, h/2),
      radius: 0.16,
      fill: out-fill,
      stroke: out-stroke,
      name: "out-box",
    )
    let y3 = if output-desc != none { 0.18 } else { 0 }
    content((x3, y3), text(size: t-size, weight: "bold", fill: hcs-navy)[#output-title])
    if output-desc != none {
      content(
        (x3, -0.22),
        text(size: d-size, fill: if highlight-output { hcs-cyan-deep.darken(20%) } else { hcs-text-muted })[#output-desc],
      )
    }

    // Connecting arrows
    line("in-box.east", "proc-box.west", stroke: 1.5pt + hcs-navy, mark: (end: ">", size: 0.16, fill: hcs-navy))
    if input-arrow != none {
      content(((x1 + w/2 + x2 - w/2) / 2, 0.30), text(size: a-size, weight: "bold", fill: hcs-slate-dark)[#input-arrow])
    }

    line("proc-box.east", "out-box.west", stroke: 1.5pt + hcs-navy, mark: (end: ">", size: 0.16, fill: hcs-navy))
    if output-arrow != none {
      content(((x2 + w/2 + x3 - w/2) / 2, 0.30), text(size: a-size, weight: "bold", fill: hcs-slate-dark)[#output-arrow])
    }
  })
}

/// Standalone canvas wrapper for cetz-pipeline
#let cetz-pipeline-canvas(length: 1cm, scale: auto, ..args) = {
  canvas(length: length, {
    cetz-pipeline(length: length, scale: scale, ..args)
  })
}


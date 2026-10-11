#import "../template.typ": subfigure, subfigure-ref, prose-cite
#import "../figures/fractal.typ": fractal

= Methods

== Tables

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. (#prose-cite(<wasserman2004>)).

$
  op("Var")(hat(p)_n) = (p(1-p))/n,
  quad op("SE")(hat(p)_n) = sqrt((p(1-p))/n).
$ <eq:bernoulli-uncertainty>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. (@eq:bernoulli-uncertainty; @tab:bernoulli).

#figure(
  table(
    columns: 3,
    align: right,
    inset: (x: 12pt, y: 5pt),
    stroke: none,
    table.hline(stroke: 0.8pt),
    table.header([$n$], [Variance], [Standard error]),
    table.hline(stroke: 0.5pt),
    [25], [0.010000], [0.100],
    [100], [0.002500], [0.050],
    [400], [0.000625], [0.025],
    table.hline(stroke: 0.8pt),
  ),
  caption: [Example table.],
) <tab:bernoulli>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

#page(flipped: true, margin: (x: 37.125mm, y: 26.25mm))[
  == Figures

  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
  incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

  $
    lambda(inter.big_(k=0)^infinity S_k)
      = lim_(k arrow infinity) lambda(S_k) = 0.
  $ <eq:fractal-measure>

  Lorem ipsum dolor sit amet (@fig:examples; Fig.~#subfigure-ref(<fig:fractal-medium>),
  Fig.~#subfigure-ref(<fig:fractal-fine>)).

  #v(1fr)
  #figure(
    grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 8mm,
      align: bottom,
      subfigure(box(height: 75mm, align(horizon, fractal(width: 60mm, depth: 1))), [First panel], "a", <fig:fractal-coarse>),
      subfigure(box(height: 75mm, align(horizon, fractal(width: 60mm, depth: 3))), [Second panel], "b", <fig:fractal-medium>),
      subfigure(box(height: 75mm, align(horizon, fractal(width: 60mm, depth: 5))), [Third panel], "c", <fig:fractal-fine>),
    ),
    kind: image,
    caption: [Example figure.],
  ) <fig:examples>
  #v(1fr)
]

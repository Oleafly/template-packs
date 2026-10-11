#import "@preview/fletcher:0.5.8": diagram, node, edge

= Method <sec:method>

#lorem(50)

== System Overview

#lorem(40)

@fig:diagram shows the overall architecture of the proposed system as a block
diagram drawn directly in Typst with the fletcher package — no external
drawing tool is required.

#figure(
  kind: image, // required so the diagram is listed in the List of Figures
  diagram(
    node-stroke: 0.5pt,
    node-corner-radius: 3pt,
    spacing: 2em,
    node((0, 0), [Input]),
    edge("-|>"),
    node((1, 0), [Analysis]),
    edge("-|>"),
    node((2, 0), [Mapping]),
    edge("-|>"),
    node((3, 0), [Output]),
    edge((1, 0), (1, 1), "-|>"),
    node((1, 1), [Features]),
    edge((1, 1), (2, 0), "-|>"),
  ),
  caption: [A block diagram drawn directly in Typst with the fletcher package.],
) <fig:diagram>

Display equations are numbered automatically and can be referenced. The
root-mean-square level of a block of $N$ samples is

$ x_"rms" = sqrt(1 / N sum_(n = 1)^N x[n]^2) $ <eq:rms>

and the corresponding level in decibels follows as

$ L = 20 dot log_10 (x_"rms" / x_"ref") $ <eq:db>

where @eq:db builds on the quantity defined in @eq:rms.

== Implementation

#lorem(35)

Inline code is written with backticks, e.g. `typst compile thesis.typ`.
Longer listings use fenced code blocks with syntax highlighting:

```python
import numpy as np

def rms(signal: np.ndarray) -> float:
    """Root mean square of a signal block."""
    return float(np.sqrt(np.mean(np.square(signal))))
```

#figure(
  image("../figures/placeholder-wide.png", width: 100%),
  caption: [A wide placeholder figure with a deliberately long caption to show
    that multi-line entries in the List of Figures wrap gracefully, e.g. for
    screenshots or signal plots.],
) <fig:wide>

== Evaluation

#lorem(35)

#figure(
  image("../figures/placeholder.png", width: 70%),
  caption: [An example figure using a placeholder image. Replace it with your
    own graphics in the `figures/` directory.],
) <fig:placeholder>

As shown in @fig:placeholder, #lorem(20)

#figure(
  table(
    columns: 4,
    table.header([*Condition*], [*Mean*], [*SD*], [*N*]),
    [Condition A], [3.8], [0.6], [12],
    [Condition B], [4.2], [0.5], [12],
    [Condition C], [3.5], [0.8], [12],
    table.cell(colspan: 3)[*Overall*], [36],
  ),
  caption: [An example results table using Typst's native table function.],
) <tab:results>

As summarized in @tab:results, #lorem(25)

#import "../theme.typ": chapter-kicker

#let method = json("/data/method.json")

= Architecture and Method <sec:method>

#figure(
  image("/figures/pipeline.svg", width: 100%),
  caption: [High-level EtabExtension reporting pipeline.],
) <fig:pipeline>

Figure @fig:pipeline captures the core workflow: keep the binary `.edb` as the working file, export `.e2k` for traceable comparison, validate intermediate state, and then build a report layer from structured outputs.

#figure(
  image("/figures/architecture.svg", width: 100%),
  caption: [One possible architecture split for the toolchain.],
) <fig:arch>

The architecture in Figure @fig:arch separates concerns cleanly: ETABS interaction can live in a sidecar, computational and versioning logic can live in a core engine, and the desktop interface can focus on user workflows. This aligns well with modular thinking from software architecture @martin.

#chapter-kicker([Pipeline rendered as a list], [The steps below come from a JSON file, not from hard-coded prose in the middle of the document.])

#for step in method.pipeline [
- #step
]

A simple analytical abstraction for report generation can be written as:

$
  R = f(M, A, V)
$ <eq:report>

where $M$ is the model state, $A$ is the analysis output, and $V$ is version metadata. Equation @eq:report is intentionally simple, but it demonstrates numbered math and stable cross-references.

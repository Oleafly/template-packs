#import "../theme.typ": result-card, csv-results-table

= Sample Results <sec:results>

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  [#result-card([Tracked versions], [4], [Baseline plus three design iterations.])],
  [#result-card([Typical analysis time], [18--20 min], [Kept roughly stable across the sample revisions.])],
  [#result-card([Report turnaround], [8--9 min], [Reduced after automation of repeated tables.])],
)

The cards above are not built-in thesis elements. They are small custom functions from `theme.typ`, which is where Typst starts to feel powerful: you can create your own document vocabulary.

#csv-results-table(
  "/data/drift.csv",
  [Interstory drift summary for a selected load combination.],
) <tab:drift>

Table @tab:drift is loaded directly from CSV data. This is useful when your analysis pipeline already exports tabular results and you want the thesis or report to consume them directly.

#csv-results-table(
  "/data/versions.csv",
  [Version history and turnaround comparison across alternatives.],
) <tab:versions>

The same pattern can be extended to reactions, member-force summaries, design checks, or comparison tables between branches. For a computational thesis, this is one of Typst's strongest advantages over manual table editing.

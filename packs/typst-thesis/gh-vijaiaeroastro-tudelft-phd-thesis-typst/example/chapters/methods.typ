#import "../../src/tudelft-phd-thesis.typ": styled-table, algorithm, listing

This chapter contains compact examples of a table, an algorithm, and a code listing. The scientific procedure is illustrative; the document components are fully reusable.

== Structured presentation

#figure(
  styled-table(
    columns: (1fr, 1fr),
    header: ([Measurement stage], [Purpose]),
    [Background acquisition], [Estimate ambient counts],
    [Sample exposure], [Acquire the candidate signal],
    [Normalization], [Compare observations across durations],
  ),
  caption: [Illustrative acquisition stages.],
  kind: table,
  supplement: "Table",
) <tab:components>

#algorithm(
  title: [Illustrative measurement procedure],
  input: [A sample, background measurement, and exposure duration],
  output: [A normalized count rate],
  caption: [A lightweight algorithm block.],
)[
  1. Measure background counts. \
  2. Measure sample counts over the same duration. \
  3. Subtract the background estimate and normalize by time.
]

#listing(caption: [A minimal Typst code listing.])[
```typst
#chapter(title: "Results", body: include "chapters/results.typ")
```
]

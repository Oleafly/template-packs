#set page(paper: "a4", margin: 22mm, numbering: "1")
#set text(size: 10.5pt)
#set par(justify: true)
#set heading(numbering: "1.")
#let accent = rgb("245b63")
#show heading: set text(fill: accent)

#text(size: 24pt, weight: "bold")[Data analysis report]
#v(4pt)
#text(size: 14pt)[A first look at document retrieval quality]
#v(5pt)
#text(fill: luma(100))[Example engineering group · Evaluation draft]
#line(length: 100%, stroke: 1pt + accent)

#block(fill: rgb("edf5f4"), inset: 12pt, radius: 4pt)[
  *Decision.* Expand the evaluation before choosing a pipeline. The candidate
  found more target documents in this small demonstration, but the sample
  does not establish performance on other collections.
]

= Data and method
Compare both pipelines on the same forty queries and document snapshot.
Save the returned ranks and elapsed time for each query. Keep failures in the
results and record any exclusions before calculating summary statistics.

All values below are illustrative. Replace them with your own measurements
and keep the scripts that produced the table.

= Results
#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    inset: 8pt,
    stroke: 0.5pt + luma(200),
    fill: (x, y) => if y == 0 { rgb("edf5f4") } else { none },
    table.header([*Measure*], [*Baseline*], [*Candidate*]),
    [Target found in first five results], [32 / 40], [35 / 40],
    [Median query latency], [84 ms], [91 ms],
    [Failed queries], [0], [0],
  ),
  caption: [Illustrative retrieval results on a shared query set.],
)

Review the three additional successful queries individually. They may share
terms or document types that are uncommon in the wider collection. Retain
per-query results so that others can inspect this possibility.

= Limits and next checks
- Use a larger query set with independently chosen target documents.
- Include queries with no relevant answer in the collection.
- Measure cold-start latency and concurrent requests separately.
- State the acceptance criteria before running the next comparison.

= Reproduction record
#table(
  columns: (1fr, 3fr), stroke: none, inset: (y: 5pt, x: 0pt),
  [*Data*], [Snapshot identifier and query-set version],
  [*Code*], [Commit identifier and configuration file],
  [*Environment*], [Runtime versions, hardware, and exact command],
  [*Outputs*], [Raw query log, cleaned table, and this report],
)

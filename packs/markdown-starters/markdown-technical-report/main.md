---
title: "Technical report"
subtitle: "Checking a small document search pipeline"
fontsize: 11pt
papersize: a4
geometry: margin=0.8in
---

# Decision summary

The candidate pipeline is ready for a larger evaluation, but the current
sample is too small to support a release decision. It retrieved more target
documents than the baseline in this demonstration, with slightly higher
query latency.

All values in this template are illustrative. Replace them with measured
results and retain the scripts needed to reproduce the tables.

# Method

Compare the baseline and candidate using the same document snapshot and query
set. Run each query after a warm-up request. Record the top results, elapsed
time, software revision, and configuration. Keep failed queries in the log.

# Results

| Measure | Baseline | Candidate |
|:--------------------------------------------------|-------------:|-------------:|
| Queries with the target in the first five results | 32 of 40 | 35 of 40 |
| Median latency | 84 ms | 91 ms |
| Failed queries | 0 | 0 |

The three additional successful queries are worth examining individually.
Check whether they reflect a general improvement or a small set of closely
related documents. Report uncertainty once the evaluation set is large
enough to support it.

# Limitations

The demonstration covers one corpus and a small query set. The evaluation
does not measure cold-start latency, concurrent users, or performance after
an index update. The target documents were chosen by the project team.

# Next decision

1. Expand the query set before adjusting the pipeline again.
2. Add queries with no relevant document in the corpus.
3. Repeat the timing measurements under the expected workload.
4. Record the dataset version, code revision, environment, and exact command.
   Keep the raw measurements with the report.

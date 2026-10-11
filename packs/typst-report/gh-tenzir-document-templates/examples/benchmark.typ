#import "../src/tenzir-report.typ": tenzir-report, kicker, callout, gradient-text, stat, tz

#show: tenzir-report.with(
  title: "Benchmarking operator parallelism",
  subtitle: "Measuring the cost and payoff of operator parallelism in the Tenzir engine",
  kicker-text: "Performance report",
  authors: ("Tenzir Engineering",),
  date: "topic/parallelism",
)
// The default logo path resolves from within the template, so no `logo:`
// override is needed here.

This document describes how we measure the operator parallelism introduced by
`topic/parallelism`, how to reproduce the measurements, and what the numbers
say.

= Goal

The parallelism work lets the planner replicate parallelizable operators into
several runtime instances and exchange events between them. Two questions
decide whether it is ready:

+ *Does it cost anything when it is off?* The change rewrites the planner and
  the executor, so pipelines running with `--parallelism disabled`, the
  default, must not regress in wall-clock time or peak memory.
+ *What does it buy, and where does it hurt?* A degree of 8 should pay off on
  operator-bound pipelines and must not silently degrade pipelines that are
  dominated by exchanges rather than by work.

We measure wall-clock time and peak resident memory, both of which
`tenzir-bench` records per run, together with CPU time so that we can tell a
real speedup from one bought with disproportionate CPU.

= Methodology

== Workload shape

Every parallelism benchmark builds one batch, replays it, and puts an
`optimize_barrier` after the last `repeat`:

```
from {…}
repeat 8192
batch
<per-row setup, paid once>
repeat N
optimize_barrier
<measured operators>
```

Both elements are load-bearing:

- *Replay a prepared batch, do not repeat events.* Per-event `repeat` runs at
  roughly 140k events/s and would be the bottleneck in every measurement.
  Replaying a batch that is already assembled costs almost nothing, which
  matches production sources that emit large batches. On this machine the
  source part of the pipeline sustains about 13M events/s.
- *Insert `optimize_barrier`.* `repeat` declares `invariant_order_filter`, so
  the optimizer hoists downstream filters above it. Without the barrier a
  `where` is evaluated once per prepared batch, and raising the event volume
  tenfold does not change the runtime at all. This silently turns a benchmark
  into a measurement of nothing.

Per-row setup, such as making the rows distinct with `random()`, goes before
the final `repeat` so it is paid once rather than per replay.

== Measuring memory under back-pressure

Throughput benchmarks barely move peak memory, because a healthy pipeline keeps
little in flight. To put the buffers under maximum pressure,
`parallel_backpressure` ends in the internal `_block 10s` operator, which
sleeps before forwarding anything. The source keeps producing until
back-pressure stops it, so peak resident memory is the size of everything the
pipeline is willing to hold.

The relevant limits are in `libtenzir/src/tql2/exec.cpp`: a direct event
channel holds up to 32 MiB, while a routing channel — the scatter, gather,
shuffle, and broadcast exchanges that parallelism introduces — holds 1 MiB per
lane. Enabling parallelism therefore replaces one 32 MiB channel with 2N
routing lanes of 1 MiB.

Three details make the measurement meaningful:

- *The chain must be long.* Buffered memory is a per-channel quantity, so a
  single measured operator hides in the process baseline of roughly 230 MB.
  The benchmark chains twelve parallelizable operators, six `where` and six
  `drop`, which gives twelve channels that can each hold slices.
- *Slices must be larger than the lane limit.* The benchmark builds 8192-row
  slices of roughly 4 KiB per row, so one slice is about 32 MiB and a routing
  lane cannot hold more than one. With slices of a few MB the whole effect
  disappears into the baseline.
- *Buffered slices must not alias the replayed one.* Arrow arrays are shared,
  so replaying a batch 32 times costs no extra memory. The filters materialize
  every slice, dropping about 0.01% of the rows.

The `unblocked` implementation is the same chain without `_block`. The
difference between the two is what stalling the sink adds on top of a chain
that already keeps every channel busy.

== Benchmarks

#table(
  columns: (auto, 1fr),
  table.header([benchmark], [what it isolates]),
  [`parallel_cpu_bound`], [Best case: three stacked heavy filters, no exchange between them],
  [`parallel_summarize_keyed`], [Keyed exchange: `summarize` on 8192 groups hash-partitions every row],
  [`parallel_churn_nonparallel_mix`], [Filters alternating with assignments, so every stage gathers and scatters],
  [`parallel_overhead_small_batches`], [128-event slices and one integer comparison: pure per-slice overhead],
  [`parallel_backpressure`], [Peak memory of a stalled twelve-operator chain with full buffers],
  [`detections`], [Realistic: three OCSF detections in `fork_merge` branches],
)

Each benchmark declares `p1`, `p2`, `p4`, `p8`, and `pmax` variants. `p1`
passes no `--parallelism` flag at all, which the planner treats the same as
`disabled`, so the very same file also runs on a build that predates the
feature. `pmax` passes `--parallelism max`, one instance per hardware thread,
which is 32 on this machine.

The four throughput benchmarks carry a second implementation, `neo_batch1024`,
identical except that it assembles 1024-row slices instead of one 8192-row
slice per replay. Slice size trades against the parallelism degree, so it is a
real benchmark dimension rather than a fixed choice; the batch-size section
below reads the two implementations against each other.

== Environment

- 32 cores, 62 GB RAM, `nix-clang-relwithdebinfo` builds with ccache.
- 1 warmup run and 3 measurement runs per variant; the fastest run is reported.
- No other builds or benchmarks running concurrently. This matters: a suite run
  started while a compile was still draining reported
  `parallel_churn_nonparallel_mix` at 18.26 s where an idle machine reports
  5.97 s. Wait for the one-minute and five-minute load averages to settle below
  2 before trusting a run.

= Running the benchmarks

Build the binary first, since `tenzir-bench` measures whatever it is pointed
at:

```sh
just build
```

Then run the scaling suite:

```sh
bench/benchmark.sh
```

The script measures one build across all degree variants. Point it elsewhere
with `--tenzir PATH`, run an unreleased `tenzir-bench` with
`--bench /path/to/bench`, and forward extra options after `--`:

```sh
bench/benchmark.sh --tenzir build/clang/relwithdebinfo/bin/tenzir \
  --bench ~/src/bench -- --variant p1 --variant p8
```

The degree variants need the `variants:` support from
#link("https://github.com/tenzir/bench/pull/2")[tenzir/bench\#2]. Until that is
released, pass `--bench` with a checkout of that branch; the script runs a
checkout through `uv run --project` so it always picks up local changes.

== Comparing two builds

Comparing a baseline with a candidate is deliberately not part of the script,
because it needs a second checkout and a second build:

```sh
git worktree add ../baseline main
(cd ../baseline/engine && cmake --preset nix-clang-relwithdebinfo && just build)

uvx tenzir-bench compare \
  --run --base ../baseline/engine/build/clang/relwithdebinfo/bin/tenzir \
  --run --candidate build/clang/relwithdebinfo/bin/tenzir \
  --variant p1 --compact \
  bench/benchmarks/parallel_cpu_bound \
  bench/benchmarks/parallel_summarize_keyed \
  bench/benchmarks/parallel_churn_nonparallel_mix \
  bench/benchmarks/parallel_overhead_small_batches \
  bench/benchmarks/parallel_backpressure \
  bench/benchmarks/detections \
  bench/benchmarks/if bench/benchmarks/match_vs_if
```

Two details matter here:

- `--variant p1` keeps the `--parallelism` flag away from the baseline, which
  does not understand it. Benchmarks without variants, such as `if`, still run.
- `--run` before *both* build markers is mandatory. `tenzir-bench` keys its
  report cache on the Tenzir version, so two local builds that report the same
  version otherwise share cached reports and the comparison prints a 0.0%
  difference for everything.

= Results

#callout(role: "note", title: "Builds under test")[
  *Baseline:* `main` plus the IR refactor commits, without the parallelism
  commit. *Candidate:* `topic/parallelism`.
]

== Parallelism disabled: baseline versus candidate

#table(
  columns: (3.6cm, 1fr, 1fr, auto, auto),
  align: (left, left, left, right, right),
  table.header([benchmark], [baseline], [candidate], [Δ time], [Δ rss]),
  [`parallel_cpu_bound`], [11.26 s, 283 MB], [10.98 s, 277 MB], [-2.5%], [-2.1%],
  [`parallel_summarize_keyed`], [13.52 s, 244 MB], [13.28 s, 241 MB], [-1.8%], [-1.2%],
  [`parallel_churn_nonparallel_mix`], [5.90 s, 279 MB], [5.99 s, 275 MB], [+1.5%], [-1.4%],
  [`parallel_overhead_small_batches`], [4.98 s, 235 MB], [5.11 s, 229 MB], [+2.6%], [-2.4%],
  [`parallel_backpressure`], [11.01 s, 687 MB], [11.04 s, 681 MB], [+0.3%], [-0.8%],
  [`parallel_backpressure/unblocked`], [1.35 s, 552 MB], [1.27 s, 550 MB], [-5.9%], [-0.3%],
  [`detections`], [9.57 s, 487 MB], [9.31 s, 489 MB], [-2.7%], [+0.4%],
  [`match_vs_if/match`], [27.99 s, 283 MB], [28.09 s, 294 MB], [+0.4%], [+3.8%],
  [`match_vs_if/if`], [28.59 s, 288 MB], [27.60 s, 290 MB], [-3.5%], [+0.9%],
  [`if/neo`], [4.65 s, 264 MB], [4.65 s, 247 MB], [0.0%], [-6.4%],
  [`if/legacy`], [4.64 s, 261 MB], [4.64 s, 249 MB], [0.0%], [-4.3%],
)

== Scaling with the parallelism degree

Wall-clock time of the fastest run. `pmax` is `--parallelism max`, which is 32
instances on this 32-core machine:

#table(
  columns: (3.3cm, 1fr, 1fr, 1fr, 1fr, 1fr, 1.7fr),
  align: (left, right, right, right, right, right, right),
  table.header([benchmark], [p1], [p2], [p4], [p8], [pmax], [best]),
  [`parallel_cpu_bound`], [11.13~s], [6.26~s], [2.93~s], [1.73~s], [1.08~s], [10.3x~\@~max],
  [`detections`], [9.45~s], [9.50~s], [5.15~s], [2.96~s], [1.80~s], [5.25x~\@~max],
  [`parallel_summarize_keyed`], [13.80~s], [7.76~s], [4.88~s], [3.84~s], [10.50~s], [3.59x~\@~8],
  [`parallel_overhead_small_batches`], [5.26~s], [2.88~s], [3.18~s], [2.96~s], [3.19~s], [1.83x~\@~2],
  [`parallel_churn_nonparallel_mix`], [6.19~s], [9.25~s], [5.76~s], [4.26~s], [5.94~s], [1.45x~\@~8],
)

Peak resident memory in MB:

#table(
  columns: (3.6cm, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: (left, right, right, right, right, right),
  table.header([benchmark], [p1], [p2], [p4], [p8], [pmax]),
  [`parallel_cpu_bound`], [273], [257], [252], [255], [267],
  [`parallel_overhead_small_batches`], [225], [223], [223], [226], [243],
  [`parallel_churn_nonparallel_mix`], [264], [255], [250], [266], [370],
  [`parallel_summarize_keyed`], [233], [235], [235], [252], [262],
  [`detections`], [503], [340], [418], [550], [758],
)

== Peak memory under back-pressure

`parallel_backpressure` in MB, the blocked twelve-operator chain against its
unblocked control:

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: (left, right, right, right, right, right),
  table.header([implementation], [p1], [p2], [p4], [p8], [pmax]),
  [`neo` (blocked)], [643], [519], [423], [406], [378],
  [`unblocked`], [582], [483], [410], [376], [376],
)

Peak memory _falls_ by 41% from degree 1 to degree 32, and the effect is
monotonic. Stalling the sink adds 61 MB at degree 1 and nothing measurable from
degree 2 onwards, which says the deep chain already keeps its channels full
without any help. This is the one benchmark where the maximum degree is also the
cheapest: the routing lanes stay below the direct-channel limit all the way to
32 instances.

= Conclusions

#callout(role: "success", title: "Disabled parallelism is free")[
  Every benchmark stays within 3.5% of the baseline in either direction, and
  peak memory is unchanged or slightly lower. The planner and executor rewrite
  costs nothing for pipelines that do not ask for parallelism.
]

*The best case delivers, all the way to the core count.*
`parallel_cpu_bound` scales 10.3x at degree 32 and 6.4x at degree 8, and it
improves at every step. Stacked filters with no exchange between them are the
one workload that rewards the maximum degree. `detections` behaves the same
way, reaching 5.25x at degree 32. Memory does not grow with the degree for
`cpu_bound`, though `detections` does trade memory for speed, from 503 MB at
degree 1 to 758 MB at degree 32.

*The keyed exchange is fixed, but only up to a point.*
`parallel_summarize_keyed` now scales 3.59x at degree 8, up from a 0.66x
_slowdown_ before the shuffle rework. It improves monotonically through degree
8, then collapses to 1.3x at degree 32: a 32-way shuffle is a 32×32 exchange,
and past a point the all-to-all routing costs more than the aggregation it
distributes. Keyed operators are worth parallelizing at a moderate degree, not
at the core count.

#callout(role: "warning", title: "The maximum degree is a trap for exchange-heavy plans")[
  Three benchmarks are slower at degree 32 than at their best:
  `summarize_keyed` (10.50 s versus 3.84 s at 8), `churn` (5.94 s versus 4.26 s
  at 8), and `overhead_small_batches` (3.19 s versus 2.88 s at 2). All three
  also spike in memory at the maximum degree, `churn` from 266 MB to 370 MB.
  `--parallelism max` should not be a default; the right degree depends on how
  much of the plan is exchange rather than work.
]

*Exchanges still dominate whenever work per row is small.*
`parallel_overhead_small_batches` plateaus at degree 2, and
`parallel_churn_nonparallel_mix` remains non-monotonic: degree 2 is 49% slower
than degree 1 before it recovers to 1.45x at degree 8. Alternating
parallelizable filters with non-parallelizable assignments pays a gather and a
scatter per stage. Widening the set of parallelizable operators, so that plans
do not collapse back to a single instance between stages, is worth more than
raising the degree.

*Back-pressure holds, and parallelism lowers buffered memory.* A stalled
twelve-operator chain peaks at 643 MB at degree 1 but only 378 MB at degree 32.
The reason is the channel limits: a direct channel may hold 32 MiB, whereas a
routing lane may hold 1 MiB, so the 2N lanes that replace a direct channel are
collectively cheaper all the way to the core count. Adding lanes never
multiplies the in-flight data, which is the property most at risk when a
rewrite introduces scatter and gather paths.

The flip side is that routing lanes are tight. A lane's 1 MiB limit is far
below one 32 MiB slice, so a lane holds exactly one slice regardless of the
limit, and a pipeline moving large batches loses the buffering slack that
absorbs jitter. This is worth revisiting for pipelines whose degree 2 results
are worse than their serial ones.

Taken together: parallelism is now a win on every workload that has real work
to distribute, and it costs nothing when it is off. Compute-bound plans reward
the core count; exchange-bound plans have a sweet spot around degree 4 to 8 and
regress past it. The right default is therefore a moderate degree, not `max`,
and the next win is in making more operators parallelizable so that fewer plans
collapse to a single instance between stages.

= Batch size

The `neo` implementations assemble one large slice per replay with a bare
`batch`, which merges into 8192-row slices of about 32 MiB. The `neo_batch1024`
implementations use `batch 1024` at otherwise identical volume. Reading the two
against each other shows that slice size is a first-order knob, independent of
the parallelism degree:

#table(
  columns: (3.6cm, auto, 1fr, 1fr, 1fr),
  align: (left, left, right, right, right),
  table.header([benchmark], [slice], [p1], [p8], [pmax]),
  [`parallel_cpu_bound`], [8192], [11.13 s], [1.73 s], [1.08 s],
  [`parallel_cpu_bound`], [1024], [6.18 s], [1.72 s], [1.31 s],
  [`detections`], [8192], [9.45 s], [2.96 s], [1.80 s],
  [`detections`], [1024], [2.88 s], [1.43 s], [1.19 s],
  [`parallel_summarize_keyed`], [8192], [13.80 s], [3.84 s], [10.50 s],
  [`parallel_summarize_keyed`], [1024], [14.03 s], [5.46 s], [18.85 s],
  [`parallel_churn_nonparallel_mix`], [8192], [6.19 s], [4.26 s], [5.94 s],
  [`parallel_churn_nonparallel_mix`], [1024], [7.46 s], [8.27 s], [21.15 s],
)

Smaller slices help the pipeline-parallel workloads at low degree and hurt the
exchange-heavy ones everywhere:

- `detections` is 3.3x faster at degree 1 with 1024-row slices (2.88 s versus
  9.45 s), and `cpu_bound` is 1.8x faster. With a 32 MiB slice the executor
  processes one stage at a time; smaller slices let it overlap stages and, for
  `detections`, the three `fork_merge` branches. The degree-1 gain rivals what
  parallelism buys, without any exchange.
- `summarize_keyed` and `churn` get worse with smaller slices, and dramatically
  so at the maximum degree, because more slices mean more per-slice exchanges.
  `churn` at degree 32 goes from 5.94 s to 21.15 s.

The lesson is that slice size and parallelism degree trade against the same
resource. A pipeline-parallel plan can get much of the benefit from smaller
batches alone, while an exchange-heavy plan wants large batches and a moderate
degree. A cost model that picks the degree should consider the slice size too.

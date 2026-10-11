// example.typ, using the Lokta Typst theme. Compile: typst compile example.typ
#import "lokta.typ": *

#show: lokta-tech.with(
  title: "Ingestion Pipeline",
  subtitle: "Design & Operations",
  org: "Folio Analytics · Platform Engineering",
  doc-id: "Report · FA-2041",
  meta: (
    "Author": "K. Adeyemi",
    "Date": "1 April 2026",
    "Version": "1.0.0",
    "Status": "Approved",
    "Classification": "Internal",
    "Owner": "Platform Eng",
  ),
)

= Overview
This document describes the design and operation of the ingestion pipeline that
backs Folio Analytics. It covers the intake path, the processing stages, and the
operational guarantees the service is expected to meet under load.

== Scope
The scope is limited to the server-side pipeline from the public intake endpoint
to the durable event store.

#lk-note(title: "Note")[
  Throughput figures assume the default batch size of 500 events. Tuning guidance
  is given in #ref(<config>) below.
]

= Architecture
The pipeline is a sequence of four stages, each independently scalable.

#table(
  columns: (1fr, 2fr, auto),
  stroke: none,
  table.hline(stroke: 2pt + lk-indigo),
  table.header([*Stage*], [*Responsibility*], [*p99*]),
  table.hline(stroke: 0.5pt + lk-hair),
  [Gateway], [Auth, rate-limit, enqueue], [20 ms],
  [Validate], [Schema + dedupe], [40 ms],
  [Enrich], [Geo, session stitch], [60 ms],
  [Commit], [Durable write + ack], [30 ms],
)

== Configuration <config>
```yaml
ingest:
  batch_size: 500        # events per flush
  flush_interval: 200ms  # max wait before commit
```

// For a diagram, pre-render with mermaid-cli using lokta-mermaid.json, then:
//   #figure(image("pipeline.svg", width: 90%), caption: [Pipeline stages.])

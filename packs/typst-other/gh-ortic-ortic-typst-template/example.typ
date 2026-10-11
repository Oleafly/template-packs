#import "template.typ": ortic-spec, callout, req, kv-list, ortic-blue, ortic-muted

#show: ortic-spec.with(
  title: "Inventory Sync Service",
  subtitle: "Real-time stock reconciliation between ERP and e-commerce platform",
  project: "Project Polaris",
  client: "Acme Manufacturing AG",
  document-id: "TSP-2026-014",
  version: "1.2",
  status: "Released",
  date: datetime(year: 2026, month: 5, day: 20),
  classification: "Confidential",
  authors: (
    (name: "Remo Laubacher", role: "Lead Architect"),
    (name: "Jane Doe", role: "Backend Engineer"),
  ),
  reviewers: (
    (name: "John Smith", role: "CTO, Acme Manufacturing"),
    (name: "Sara Müller", role: "QA Lead"),
  ),
  abstract: [
    This document specifies the architecture, interfaces and operational
    requirements of the Inventory Sync Service that bridges the existing
    ERP system with the customer-facing e-commerce platform. It covers
    data models, integration contracts, non-functional requirements and
    a phased rollout plan.
  ],
  revisions: (
    (version: "0.1", date: "2026-04-02", description: "Initial draft", author: "R. Laubacher"),
    (version: "1.0", date: "2026-04-28", description: "Approved for development", author: "R. Laubacher"),
    (version: "1.1", date: "2026-05-12", description: "Updated SLA targets after stakeholder review", author: "J. Doe"),
    (version: "1.2", date: "2026-05-20", description: "Added rollback procedure and observability section", author: "R. Laubacher"),
  ),
)

= Introduction

== Purpose

This specification describes the design and behavior of the *Inventory
Sync Service* (ISS), a middleware component that keeps stock levels
consistent between the ERP system of record and the public e-commerce
storefront. It defines the architecture, the public interfaces, the
operational constraints, and the acceptance criteria.

== Scope

The system is responsible for:

- Receiving stock change events from the ERP through a message queue.
- Normalising and validating those events.
- Propagating the resulting state to the e-commerce platform via REST.
- Providing observability, retry semantics and an audit log.

Out of scope are pricing updates, product master data synchronisation
and order fulfillment — these are handled by separate services.

== Stakeholders

#kv-list(
  ("Business owner", "Acme Manufacturing AG, Sales Operations"),
  ("Technical owner", "Ortic Solutions GmbH"),
  ("End users", "Online shoppers (indirectly), warehouse operators"),
  ("Operations", "Acme IT Operations team"),
)

== Definitions

/ ERP: Enterprise Resource Planning system — in this case Microsoft Dynamics 365 Business Central.
/ SKU: Stock Keeping Unit, the smallest identifiable inventory item.
/ ISS: Inventory Sync Service, the subject of this specification.
/ ATP: Available-to-Promise quantity, i.e. on-hand minus reservations.

#callout(kind: "info", title: "Reference architecture")[
  This service follows the integration patterns described in the
  internal _Ortic Reference Architecture v3_, particularly the
  "outbox + idempotent consumer" pattern.
]

= Requirements

== Functional Requirements

The following are the binding functional requirements. The keywords
*MUST*, *SHOULD* and *MAY* are interpreted as in #link("https://www.rfc-editor.org/rfc/rfc2119")[RFC 2119].

#req("FR-01", priority: "MUST")[
  The system must consume `StockChanged` events from the ERP outbox topic
  and propagate the resulting ATP quantity to the e-commerce platform
  within 30 seconds (95th percentile).
]

#req("FR-02", priority: "MUST")[
  The system must be idempotent with respect to event re-delivery: receiving
  the same event ID twice must not produce a duplicate update.
]

#req("FR-03", priority: "SHOULD")[
  The system should batch updates per SKU within a 2-second window to reduce
  load on the downstream API while still meeting FR-01.
]

#req("FR-04", priority: "MAY")[
  The system may surface a manual replay endpoint, secured by an internal
  API key, to re-emit events for a given time window.
]

== Non-Functional Requirements

#table(
  columns: (auto, 1fr, auto),
  table.header[ID][Requirement][Target],
  [NFR-01], [End-to-end latency (event → storefront visible)], [≤ 30 s (p95)],
  [NFR-02], [Throughput], [≥ 200 events/s sustained],
  [NFR-03], [Availability], [99.9 % monthly],
  [NFR-04], [Recovery point objective (RPO)], [≤ 1 minute],
  [NFR-05], [Recovery time objective (RTO)], [≤ 15 minutes],
  [NFR-06], [Audit retention], [13 months],
)

#callout(kind: "warning", title: "Capacity planning")[
  The 200 events/s target reflects the *peak* observed during the
  Black-Friday 2025 promotion. Provision for at least 2× headroom.
]

= Architecture

== System Context

The ISS sits between the ERP and the e-commerce platform. It does not
expose any direct interface to end users.

== Components

=== Event Ingestor
Subscribes to the ERP outbox topic on the message broker. It validates
each event against the schema registry and writes accepted events to
the local inbox table for processing.

=== Transformer
Reads from the inbox, computes ATP from on-hand and reservations, and
applies SKU mapping rules between the ERP and the storefront catalogue.

=== Publisher
Holds a small batched window per SKU (see FR-03) and pushes the latest
state via the e-commerce REST API. Failed pushes are retried with
exponential backoff up to one hour, after which they are moved to a
dead-letter queue.

=== Audit Store
A separate append-only table that records every accepted event and
every successful publish, used for compliance and incident response.

== Data Model

```sql
CREATE TABLE inbox (
  event_id     UUID PRIMARY KEY,
  sku          TEXT NOT NULL,
  on_hand      INTEGER NOT NULL,
  reserved     INTEGER NOT NULL,
  occurred_at  TIMESTAMPTZ NOT NULL,
  received_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  status       TEXT NOT NULL DEFAULT 'PENDING'
);

CREATE INDEX idx_inbox_pending ON inbox (status, received_at)
  WHERE status = 'PENDING';
```

== Sequence

+ ERP commits a transaction and writes a `StockChanged` event to its outbox.
+ The broker delivers the event to the ISS Ingestor.
+ The Ingestor validates and persists it to `inbox` with status `PENDING`.
+ The Transformer picks it up, computes ATP, and marks it `READY`.
+ The Publisher pushes the update to the storefront and marks it `DONE`.
+ The Audit Store records the full lifecycle.

= Interfaces

== Inbound: ERP Outbox

The ISS consumes events of the following shape:

```json
{
  "eventId": "8e3c…",
  "type": "StockChanged",
  "sku": "WIDGET-42",
  "onHand": 120,
  "reserved": 14,
  "occurredAt": "2026-05-20T08:14:03Z"
}
```

== Outbound: Storefront API

Updates are pushed via `PUT /v1/inventory/{sku}` with the body:

```json
{
  "available": 106,
  "lastUpdated": "2026-05-20T08:14:05Z"
}
```

Authentication uses a service account with a rotating bearer token
sourced from the secrets vault.

= Operations

== Deployment

The service is deployed as three independent containers behind a shared
PostgreSQL instance, orchestrated by Kubernetes. Each component scales
horizontally; the publisher is rate-limited to honour the storefront
API quota.

== Observability

#kv-list(
  ("Metrics", "Prometheus — see dashboard `iss-overview`"),
  ("Tracing", "OpenTelemetry, sampled at 10 %"),
  ("Logs", "Structured JSON, shipped to the central log store"),
  ("Alerts", "Inbox lag > 60 s, DLQ growth > 0, publish error rate > 1 %"),
)

== Rollback Procedure

#callout(kind: "important", title: "Before rolling back")[
  Verify that no events are mid-flight (Inbox = empty AND Publisher
  in-flight = 0) before deploying a previous version. Failing to do so
  may cause duplicate updates.
]

+ Pause the Ingestor by scaling its deployment to zero.
+ Wait until the inbox is fully drained (typically < 60 s).
+ Deploy the previous container image of all three components.
+ Resume the Ingestor.

= Acceptance Criteria

A release is considered acceptable when:

#callout(kind: "success", title: "Definition of done")[
  - All requirements with priority MUST are met (see section 2.1).
  - Non-functional targets are demonstrated under load test (see section 2.2).
  - Observability dashboards and alerts are green for 72 consecutive hours.
  - Rollback procedure has been exercised at least once in staging.
]

= References

- RFC 2119 — Key words for use in RFCs to Indicate Requirement Levels.
- Ortic Reference Architecture v3 — internal document.
- Acme Manufacturing — Integration Master Plan, 2026.

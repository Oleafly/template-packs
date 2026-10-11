#import "report-template.typ": report-template
#import "octoco-report-brand.typ": octoco-brand

#let template = report-template(octoco-brand)
#let (
  report,
  cover-page,
  title-page,
  notice,
  report-outline,
  h1,
  report-figure,
  X,
  O,
  callout,
  cite,
  reference,
) = template

#set page(numbering: "1")

#show: report.with(
  document-title: "Generic Technical Project Report",
  document-author: "Octoco",
  confidential: false,
)

#cover-page(
  title: "Technical Project Report",
  subtitle: "A generic example",
  classification: "CONFIDENTIAL",
)

#title-page(
  title-lines: ("Technical Project", "Implementation Report"),
  prepared: "Prepared by Octoco for [REDACTED CLIENT]",
  version: "1.0 — 27 August 2026",
  author: "Octoco Engineering Team",
)

// Reusable notices accept an optional title followed by their body content.
#notice(title: [Redaction notice.])[
  This demonstrator contains fictional systems, synthetic metrics, and generic
  recommendations. All client names, people, credentials, commercial terms, and identifying project
  details are shown as *[REDACTED]* or have been replaced with illustrative content.
]

#report-outline(depth: 3)
#pagebreak()

// Use the template helper for an unnumbered top-level heading.
#h1("Executive Summary", numbered: false) <executive-summary>

This report records the design and delivery status of a fictional workflow platform, _Acme Flow_. It
demonstrates the Octoco report template while remaining suitable for public examples. The illustrative
release is assessed as *conditionally ready*: core processing meets its target, while recovery testing
and operational handover remain open.

The intended outcomes and delivery boundaries are detailed in @scope (see
#ref(<scope>, form: "page")).

// Wrap tables in figures to add captions, labels, and cross-references.
#figure(
  table(
    columns: (2.2fr, 1fr, 1.3fr),
    inset: 6pt,
    stroke: 0.5pt + luma(180),
    align: (left, center, left),
    table.header([*Measure*], [*Result*], [*Target*]),
    [Availability in test window], [99.95%], [≥ 99.9%],
    [95th percentile latency], [180 ms], [≤ 250 ms],
    [Automated checks passing], [248 / 250], [250 / 250],
  ),
  caption: [Illustrative delivery scorecard; values are synthetic.],
) <tbl-scorecard>

As shown in @tbl-scorecard, performance goals were met. Two quarantined tests concern a simulated
third-party outage and must pass before production approval.

// Native Typst heading syntax supplies numbering; the attached label enables section and page references.
= Purpose and Scope <scope>

This section defines the intended outcomes, delivery boundaries, and assumptions that frame the
report.

== Objectives

The project demonstrates a bounded technical delivery with explicit assumptions, evidence, and
decisions. Its objectives are to:

- provide a secure web workflow for authenticated users;
- integrate asynchronously with generic enterprise systems;
- make failures visible and recoverable; and
- leave reproducible build, test, and operating instructions.

The following are deliberately out of scope: migration of historic client records, procurement,
production credentials, and legal or regulatory advice. Any apparent identifiers are placeholders.

== Assumptions and Constraints

The following assumptions define the boundaries for this illustrative delivery. They should be
validated with the relevant technical and operational stakeholders before a real project begins.

+ Deployment uses a managed container runtime in one region.
+ Identity is delegated to an OpenID Connect provider.
+ Payloads contain synthetic data only during this demonstration.
  + Files are generated from fixtures.
  + Secrets are injected at runtime and never embedded in source.
+ Recovery objectives are illustrative: RTO = 60 min and RPO = 15 min.

These constraints keep the example focused on the delivery approach while making its dependencies and
trade-offs explicit. Any production implementation would require documented ownership and review.

// Block quotes support an attribution and inherit the template's quote styling.
#quote(block: true, attribution: [Project principle])[
  Prefer a small, observable change that can be reversed over a large change that can only be hoped
  to work. Make the intended outcome measurable, record the assumptions that support it, and retain a
  clear path to recovery when conditions change. Sustainable delivery is built from evidence and
  feedback, not from irreversible leaps of faith.
]

= Solution Design <solution-design>

This section summarises the solution structure, component boundaries, and principal design choices.

== Architecture

The reference architecture separates user-facing, workflow, integration, and data concerns so each
can be governed and operated independently.

// The template helper places an image with a caption and a reusable figure label.
#report-figure(
  "assets/sample-report/acme-flow-architecture.svg",
  [Fictional reference architecture and integration boundaries.],
  width: 100%,
) <fig-architecture>

Requests cross the web/API boundary, are authorised in tenant context, and then invoke the workflow
core (@fig-architecture). Persistent state, binary objects, and queued work use separate stores so
that access and retention policies can be applied independently.

=== Component Responsibilities

The following table assigns each logical component a primary responsibility and control.

#figure(
  table(
    columns: (1.2fr, 2.5fr, 1.4fr),
    inset: 6pt,
    stroke: 0.5pt + luma(180),
    table.header([*Component*], [*Responsibility*], [*Primary control*]),
    [Web/API], [Validate requests and enforce tenant scope.], [`aud` and role checks],
    [Workflow core], [Apply deterministic state transitions.], [Idempotency key],
    [Worker], [Deliver queued integration events.], [Retry budget],
    [Data platform], [Persist records, objects, and audit events.], [Encryption and backup],
  ),
  caption: [Logical component responsibilities.],
) <tbl-components>

==== Design Detail

The transition function can be expressed as $s_(n+1) = f(s_n, e_n)$, where $s$ is workflow state and
$e$ is a validated event. For an observed sample $x_1, dots, x_n$, mean latency is
$bar(x) = 1/n sum_(i=1)^n x_i$. Percentiles, rather than the mean alone, drive the service objective.

An illustrative API response is:

```json
{
  "workflow_id": "demo-00042",
  "status": "accepted",
  "correlation_id": "redacted-example"
}
```

Inline code such as `Idempotency-Key` is used for protocol names. A simplified worker loop shows
syntax-highlighted source code:

```python
for event in queue.receive(batch_size=20):
    if audit_store.seen(event.id):
        continue
    integration.publish(event.redacted())
    audit_store.mark_complete(event.id)
```

== Data Flow and Trust Boundaries

The data flow highlights where information crosses trust boundaries and where controls are applied.

#report-figure(
  "assets/sample-report/acme-flow-data-flow.svg",
  [Synthetic data flow with control points and operational feedback.],
  width: 100%,
) <fig-data-flow>

The trust boundary is crossed at authentication and at each external integration. Data is minimised
before publication, and a correlation identifier—not personal data—is used for troubleshooting.
@fig-data-flow illustrates this sequence.

= Delivery Approach <delivery>

This section describes how the work is divided, sequenced, and assured through delivery.

== Work Packages

The delivery was organised into four incremental packages:

1. *Foundation:* repository checks, threat model, deployment skeleton, and decision log.
2. *Vertical slice:* one workflow from browser to durable storage.
3. *Integration:* queued delivery, retry handling, and reconciliation.
4. *Readiness:* load tests, recovery rehearsal, documentation, and handover.

=== Example Schedule

The indicative schedule maps each delivery period to a milestone and its expected evidence.

#figure(
  table(
    columns: (1.1fr, 1.5fr, 2.4fr),
    inset: 6pt,
    stroke: 0.5pt + luma(180),
    table.header([*Period*], [*Milestone*], [*Exit evidence*]),
    [Week 1], [Foundation], [Approved boundaries and automated build],
    [Weeks 2–3], [Vertical slice], [Demonstration and contract tests],
    [Week 4], [Integration], [Replay and duplicate-event tests],
    [Week 5], [Readiness], [Runbook rehearsal and release record],
  ),
  caption: [Illustrative milestone plan.],
) <tbl-schedule>

== Quality Strategy

Checks are layered to provide fast feedback and realistic assurance:

- formatting, static analysis, and secret scanning on each change;
- unit and property tests for state transitions;
- contract tests at service boundaries;
- integration tests using disposable infrastructure; and
- load, backup-restore, and failure-injection exercises before release.

The probability of observing at least one failure in $n$ independent requests, each with failure
probability $p$, is $P(F) = 1 - (1-p)^n$. This simple model is illustrative, not a reliability claim.

= Findings and Risk Register <findings>

This section records representative findings, risks, and the evidence or actions needed to address
them.

#figure(
  table(
    columns: (0.6fr, 2.4fr, 0.9fr, 2.2fr),
    inset: 5pt,
    stroke: 0.5pt + luma(180),
    align: (center, left, center, left),
    table.header([*ID*], [*Risk or finding*], [*Rating*], [*Treatment / evidence*]),
    [R1], [External endpoint may be unavailable.], [Medium], [Queued retry, dead-letter alert, replay drill.],
    [R2], [Restore timing has not been measured at target volume.], [High], [Run timed restore before approval.],
    [R3], [Support ownership outside office hours is unclear.], [Medium], [Approve escalation roster.],
    [F1], [Tenant-isolation tests pass for synthetic fixtures.], [Positive], [Retain CI evidence with release.],
  ),
  caption: [Illustrative risk register; no client findings are represented.],
) <tbl-risks>

The register uses qualitative ratings. Acceptance must be explicit, dated, and owned; silence does
not constitute acceptance. Security guidance should be checked against an authoritative baseline
#cite(<ref-nist-ssdf>), while architecture decisions should remain traceable to quality attributes
#cite(<ref-iso-architecture>).

== Decision Record Example

The following example captures a design decision together with its status, drivers, and trade-off.

#grid(
  columns: (1fr, 2.5fr),
  gutter: 8pt,
  [*Decision*], [Use asynchronous integration events.],
  [*Status*], [Accepted for the fictional reference design.],
  [*Drivers*], [Failure isolation, replay, and independent scaling.],
  [*Trade-off*], [Eventual consistency and additional operational tooling.],
)

= Operations and Handover <operations>

This section outlines the readiness evidence and operating guidance required for a controlled
handover.

== Readiness Checklist

The checklist summarises completed controls and the remaining actions before approval.

// Hide the list marker and use the compact #X and #O checkbox helpers.
#list(
  marker: none,
  [#X Build is reproducible from a clean checkout.],
  [#X Dashboards use synthetic examples and correlation identifiers.],
  [#X Backup creation is automated.],
  [#O Timed restore meets the stated recovery objective.],
  [#O On-call ownership is approved by *[REDACTED ROLE]*.],
)

Alerts should describe user impact, threshold, and immediate action. For example, “queue age exceeds
five minutes for ten minutes” is actionable; “worker warning” is not. The runbook links every alert
to diagnosis, mitigation, escalation, and recovery verification.

== Example Callout

The following callout illustrates how a critical operational constraint can be made prominent.

#callout[
  *Operational rule:* never replay a dead-letter event until its idempotency behaviour and downstream
  side effects have been checked.
]

= Recommendations <recommendations>

Recommendations are ordered by dependency rather than ambition:

1. Close the restore-test and support-ownership actions.
2. Capture release evidence and obtain an explicit go/no-go decision.
3. Run a limited synthetic-data pilot with rollback criteria.
4. Review service objectives after collecting representative telemetry.
5. Add regions or integrations only after the first operating cycle is stable.

Further implementation guidance is available from the public
#link("https://typst.app/docs/")[Typst documentation].#footnote[External links are examples and require
network access only when opened; the report build itself is local.]

= Conclusion <conclusion>

This generic report demonstrates how Octoco can communicate architecture, delivery evidence,
technical notation, code, tables, figures, risks, and recommendations without exposing confidential
information. The fictional project is ready for approval only after the two open readiness actions
are evidenced.

#pagebreak()
#h1("References", numbered: false) <references>

The following public sources provide general context for the illustrative guidance in this report.

// The template's reference helper supplies citation targets used by #cite above.
#block[
#set enum(numbering: "[1] ", start: 1)
+ #reference(<ref-nist-ssdf>)[
  National Institute of Standards and Technology, _Secure Software Development Framework (SSDF)
  Version 1.1_, NIST SP 800-218, 2022. #link("https://doi.org/10.6028/NIST.SP.800-218")[DOI].
]
+ #reference(<ref-iso-architecture>)[
  ISO/IEC/IEEE, _Systems and software engineering—Architecture description_, ISO/IEC/IEEE 42010:2022,
  published 2022.
]
]

#h1("Appendix A: Demonstrated Features", numbered: false) <feature-index>

This sample exercises document metadata, branded cover and footer, title page, outline, numbered and
unnumbered headings, labels and cross-references, page breaks, styled blocks, links, a footnote,
quotation, nested lists, task lists, numbered lists, grids, tables and captions, SVG figures, inline
and block raw code, mathematical notation, custom citations, and references.

#h1("Appendix B: Approval Record", numbered: false)

This generic record provides placeholders for the roles responsible for formal approval.

#figure(
  table(
    columns: (1.4fr, 2fr, 1.2fr),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    table.header([*Role*], [*Name / signature*], [*Date*]),
    [Project sponsor], [[REDACTED]], [#line(length: 100%)],
    [Technical owner], [[REDACTED]], [#line(length: 100%)],
    [Operations owner], [[REDACTED]], [#line(length: 100%)],
  ),
  caption: [Generic approval record.],
)

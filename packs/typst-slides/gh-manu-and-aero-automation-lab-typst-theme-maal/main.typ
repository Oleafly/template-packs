#import "@preview/touying:0.7.4": config-info, pause, speaker-note
#import "research-theme.typ": *

#show: research-theme.with(
  config-info(
    title: [Theme Example],
    subtitle: [Presenter: Your Name\
      Supervisor: Prof. Your Supervisor],
    date: [9 September 2026],
    institution: [The Hong Kong University of Science and Technology],
  ),
)

#research-title-slide()

== Standard content

- First-level body text uses the same restrained Arial-style hierarchy.
  - Second-level points are smaller and indented.
  - Keep important evidence close to the point it supports.
- Use #research-highlight[red emphasis] sparingly.

#v(.35in)

#research-callout[
  *Important formula*\
  $q_k = (phi_k^T F) / (phi_k^T K phi_k)$
]

== Hardware – Sensor

#research-table(
  ([IMU], [Category], [Frequency], [Price]),
  (
    ([HWU0703], [HWU1703 (RS485)], [100 Hz], [2,371]),
    ([IMU5731], [—], [500 Hz], [4,500]),
    ([IMU5735], [—], [400 Hz], [4,800]),
    ([AHRS731], [—], [100 Hz], [5,800]),
  ),
  columns: (1.7fr, 2.2fr, 1.3fr, 1fr),
)

== Two-column layout

#research-columns(
  [
    *Research question*

    - What is the dominant mechanism?
    - Which evidence supports the claim?
    - What remains uncertain?
  ],
  [
    #research-callout(width: 100%)[
      *Key takeaway*\
      State the result directly, then show the evidence beneath it.
    ]

    #v(.3in)
    #research-caption[Need to improve quality, flexibility, and productivity]
  ],
  ratio: (1.1fr, .9fr),
)



== Process and relation illustration

#align(center)[
  #research-process([Phase A], [Phase B], [Phase C])
]

#v(.75in)

#research-columns(
  [
    *Input*\
    Experimental data and physical constraints
  ],
  [
    *Output*\
    Validated model and actionable conclusion
  ],
)

== References with pictures

#research-columns(
  [
    #rect(
      width: 100%,
      height: 2.55in,
      fill: research-paler-blue,
      stroke: .8pt + research-blue,
      align(center + horizon)[Replace with figure 1],
    )
    #align(center)[#research-caption[Method or platform name]]
    #align(center)[#research-source[(Author et al., Year)]]
  ],
  [
    #rect(
      width: 100%,
      height: 2.55in,
      fill: research-paler-blue,
      stroke: .8pt + research-blue,
      align(center + horizon)[Replace with figure 2],
    )
    #align(center)[#research-caption[Block diagram or result]]
    #align(center)[#research-source[(Author et al., Year)]]
  ],
)

== Summary slide example

- Energy-efficient machining achieved via hybrid feed drive and control allocation

- Combining *mechatronics* and *optimal control allocation* improves energy efficiency without sacrificing accuracy
  - About 80% energy reduction from LMD to HFD
  - A further 50% reduction with optimal allocation

- Smart control uses process data to improve quality and sustainability

- Key techniques
  - Reconfigurable mechanisms
  - Input redundancy and control allocation
  - Intelligent control informed by process data

#speaker-note[
  This is a Touying speaker note. Replace the sample content with your own material.
]

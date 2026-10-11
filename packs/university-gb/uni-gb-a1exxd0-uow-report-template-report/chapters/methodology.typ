= Methodology <ch:methodology>

This chapter describes the proposed interactive proof protocol for verifying quantum learning under resource constraints.

== Protocol Overview <sec:protocol>

The protocol proceeds in three phases: the quantum learner trains on quantum examples, commits to a hypothesis via a binding scheme, and then engages in a $k$-round interactive proof with the classical verifier.

The communication cost of the protocol is bounded by:
$ C(k) = O(k dot n dot log(1 / delta)) $ <eq:comm-cost>
where $n$ is the input dimension and $delta$ the soundness error.

The three-phase protocol is illustrated in @fig:protocol.

#figure(
  block(width: 85%, inset: 12pt, stroke: 0.5pt + luma(120), radius: 4pt)[
    #set text(size: 10pt)
    #let phase-box(label, body) = rect(
      width: 100%, inset: 8pt, radius: 3pt,
      fill: luma(240), stroke: 0.5pt + luma(160),
    )[*#label.* #body]

    #grid(
      columns: (1fr, auto, 1fr),
      align: center + horizon,
      gutter: 8pt,
      [*Quantum Learner*], [], [*Classical Verifier*],
      grid.hline(stroke: 0.5pt),
      phase-box("Phase 1")[Train on quantum examples $arrow.r$ produce hypothesis $h$], [], [],
      [], [$arrow.r$ commit to $h$], [],
      [], [], phase-box("Phase 2")[Receive commitment; prepare challenges],
      [], [$arrow.l$ challenge $c_i$], [],
      phase-box("Phase 3")[Compute response $r_i$ from $h$ and $c_i$], [], [],
      [], [$arrow.r$ response $r_i$], [],
      [], [repeat $k$ rounds], [],
      [], [], phase-box("Output")[Accept / Reject],
    )
  ],
  caption: [Three-phase interactive proof protocol between the quantum learner and classical verifier.],
) <fig:protocol>

#lorem(200)

== Soundness Analysis <sec:soundness>

Soundness requires that no computationally bounded dishonest prover can convince the verifier to accept an inaccurate hypothesis with probability exceeding $delta$; this is established via a reduction to the Learning With Errors (LWE) hardness assumption @regev2024latticeslearningerrorsrandom.

#import "../template.typ": theorem

#theorem(name: "Soundness")[
  Under the LWE assumption with modulus $q = "poly"(n)$, the protocol achieves soundness error $delta <= 2^(-Omega(k))$ against any polynomial-time dishonest prover.
]

== Implementation Considerations <sec:implementation>

The protocol is designed to remain practical on near-term quantum hardware by restricting the learner to circuits of depth at most $O(log n)$ and tolerating depolarising noise up to the threshold given in @eq:depolarising.

#lorem(300)

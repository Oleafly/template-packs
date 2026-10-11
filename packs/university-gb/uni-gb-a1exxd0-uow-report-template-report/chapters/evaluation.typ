= Evaluation <ch:evaluation>

This chapter presents the experimental setup and preliminary results of the verification protocol.

== Experimental Setup <sec:setup>

Experiments are conducted using the Qiskit framework @qiskit2024 on both a noise-free statevector simulator and a depolarising noise model calibrated to IBM Quantum hardware @Georgopoulos_2021.

#lorem(200)

== Results <sec:results>

Initial simulations confirm that the verifier's acceptance probability tracks the learner's true generalisation error, and that the soundness bound decays exponentially with round count $k$, consistent with the theoretical prediction:
$ Pr["accept" | cal(L)(h) > epsilon] <= 2^(-Omega(k)) $

A summary of acceptance rates across varying noise levels is presented in @tab:results.

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    table.header[*Noise rate $p$*][*Rounds $k$*][*Accept rate*][*True error*],
    [$0.00$], [$8$],  [$0.98$], [$0.02$],
    [$0.01$], [$8$],  [$0.95$], [$0.04$],
    [$0.05$], [$8$],  [$0.87$], [$0.09$],
    [$0.10$], [$16$], [$0.82$], [$0.12$],
  ),
  caption: [Verifier acceptance rate under varying depolarising noise.],
) <tab:results>

The relationship between noise rate and acceptance probability is visualised in @fig:acceptance.

#figure(
  block(width: 80%, inset: 12pt)[
    #let bar(value) = {
      rect(
        width: value * 1%,
        height: 14pt,
        fill: luma(80),
        radius: 2pt,
      )
    }
    #set text(size: 9pt)
    #grid(
      columns: (auto, 1fr, auto),
      align: (right + horizon, left + horizon, left + horizon),
      row-gutter: 6pt,
      column-gutter: 8pt,
      [$p = 0.00$], bar(98), [0.98],
      [$p = 0.01$], bar(95), [0.95],
      [$p = 0.05$], bar(87), [0.87],
      [$p = 0.10$], bar(82), [0.82],
    )
  ],
  caption: [Verifier acceptance rate as a function of depolarising noise parameter $p$.],
) <fig:acceptance>

== Discussion <sec:discussion>

The results suggest that the protocol is robust to moderate levels of depolarising noise, though higher noise rates necessitate additional interaction rounds to maintain the target soundness error.

#lorem(250)

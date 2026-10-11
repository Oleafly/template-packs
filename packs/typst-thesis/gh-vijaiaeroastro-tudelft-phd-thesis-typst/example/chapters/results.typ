#import "../../src/tudelft-phd-thesis.typ": styled-table

The illustrative data indicate a higher normalized count rate for the sample than for the background condition. This result is not experimental evidence; it exists to demonstrate a result table, a multi-paragraph discussion, and a cross-reference to the experimental setup in @fig:apparatus.

#figure(
  styled-table(
    columns: (1fr, 1fr, 1fr),
    header: ([Condition], [Count], [Normalized rate]),
    [Background], [18], [0.18],
    [Reference], [44], [0.44],
    [Sample], [96], [0.96],
  ),
  caption: [Illustrative normalized measurements.],
  kind: table,
  supplement: "Table",
) <tab:results>

The values in @tab:results would normally be accompanied by uncertainty bounds and a transparent discussion of the method's sensitivity. A useful dissertation does not only present favourable outcomes; it also states where the method is expected to fail, how that failure was detected, and which assumptions constrain the conclusion.

== Interpretation

The example distinguishes document machinery from scientific content. The template supplies a consistent layout, while the author remains responsible for claims, data, analysis, and citations. This matters particularly in technical fields, where a polished document must not make weak evidence look stronger than it is.

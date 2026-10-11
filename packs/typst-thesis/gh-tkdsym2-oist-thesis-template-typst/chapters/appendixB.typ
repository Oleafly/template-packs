#import "../oist_thesis.typ": appendix, custom_figure

#appendix("B")[
#heading(level: 1, numbering: none, "Appendix B: Second Appendix") <appendix-b>

The second appendix restarts every counter, which is why the section below is
B.1 and the table below is Table B.1 — neither continues from Appendix A.

== Another Section

#custom_figure(
  table(
    columns: 3,
    align: (left, center, center),
    [*Condition*], [*Mean*], [*SD*],
    [Baseline], [0.42], [0.11],
    [Treatment], [0.68], [0.09],
  ),
  short: [Appendix table.],
  caption: [Tables inside an appendix are numbered with the appendix letter, and
    the counter restarts for every appendix.],
) <tab-appendix-b>

See @tab-appendix-b for an example.
]

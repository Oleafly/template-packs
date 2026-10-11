#import "../metadata.typ": body-font, sans-font

// Example appendix. Duplicate this file (e.g. appendix_b.typ) and pass it to
// the `appendices` argument in thesis.typ to add further appendices.
#align(left, text(font: sans-font, 2em, weight: 700, [Appendix A: \ Example Materials]))
#v(10mm)

#lorem(50)

#figure(
  image("../figures/placeholder.png", width: 60%),
  caption: [An example appendix figure.],
) <fig:appendix-example>

#lorem(30)

#figure(
  table(
    columns: 3,
    table.header([*Item*], [*Description*], [*Value*]),
    [A], [#lorem(4)], [1.00],
    [B], [#lorem(4)], [2.00],
    [C], [#lorem(4)], [3.00],
  ),
  caption: [An example appendix table.],
) <tab:appendix-example>

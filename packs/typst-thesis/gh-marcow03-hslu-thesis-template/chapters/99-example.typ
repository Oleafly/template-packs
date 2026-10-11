#import "../template/utils.typ": flex-caption, qr-code-link

= Example

#lorem(50)

== Subheading Example

#lorem(50)

=== Subsubheading Example

#lorem(50)

==== Subsubsubheading Example

#lorem(50)

== Table Example

Here is a simple table:

#figure(
  caption: [Example Table],
  kind: table,
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header([*Column 1*], [*Column 2*], [*Column 3*]),
    [Row 1], [Data A], [Value 1],
    [Row 2], [Data B], [Value 2],
    [Row 3], [Data C], [Value 3],
  ),
)

== Image Example

Here is an Example on how to include an image which is also listed in the image outline.

#align(center)[
  #figure(
    kind: image,
    caption: flex-caption(
      [Example Image],
      [This image is an example for displaying images],
    ),
    image("../assets/images/hslu-logo.svg", width: 50%),
  )
]

== Source Example

This is based on @someExampleSource. Sources will automatically appear if they are cited. Add them to
`bibliography.yaml`

== Link Example

This is a normal link:

#link("https://www.youtube.com/watch?v=xvFZjo5PgG0")

This is the same link but hidden behind a QR code:

#qr-code-link(
  "https://www.youtube.com/watch?v=xvFZjo5PgG0",
)[
  Check this out!
]

== Code Example

See @fig-code-rm for details. This is a code block:

#figure(
  caption: [This is some code],
  ```sh
    sudo rm -rf / --no-preserve-root
  ```,
) <fig-code-rm>

== Cetz Diagram Example

This is an example of a diagram created with Cetz. It is also listed in the figure outline.

#figure(
  caption: [Attention Diagram],
  include "../assets/diagrams/attention.typ",
) <fig-attention>


== Drawio Diagram Example

#figure(
  caption: [Test Diagram],
  image("../assets/diagrams/test.drawio.svg"),
) <fig-test>

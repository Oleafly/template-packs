#import "@preview/shadowed:0.2.0": shadowed
#import "sleek-math.typ": *

#show: sleek-math

// Document starts here //

#title(
    author: "Dennis Chunikhin",
    date: "April 4, 2025",
    padding-top: 10em,
)[Sleek Math Typst Template]
#pagebreak()

#outline()
#pagebreak()

= Features

*Convenience*
 - Equations are numbered by default 
  - `<nonum>` label can be added to equations or headers to make them not numbered (the label is set via `NO_NUM_LABEL`). This also updates the appearance of headers in `outline`.
 - Automatic section-by-section numbering scheme (see @numbering_scheme)
  - `counter-heading-display`: takes a counter and optionally a location (`loc`) and displays the counter following the numbering scheme
 - `title`: makes a title, has optional `author`, `date`, `padding-top`, and `spacing` arguments

#linepad
*Proof boxes*
 - `referenceable-box`: makes a proof box referenceable and automatically adds numbering
 - `side-box`: creates a box with line on the left
  - `example`: example box, numbered and referenceable
  - `proof`: proof box, ends with qed symbol (`qed` optional argument)
  - `remark`: remark box
 - `thm-box`: theorem box with a title
  - `definition`
  - `theorem`
  - `proposition`
 - `slanted-thm-box`: theorem box with slanted title box
  - `corollary`
 - `curved-thm-box`: theorem box with curved title box
  - `lemma`
 - `outline-box`: a simple outline box
 - `shadow-box`: creates a box distinguished by a drop shadow, uses the shadowed package

#linepad
*Drop shadow*
 - `box-shadow`: simble block shadow
 - `shadow`: a more general blurry shadow, uses the shadowed package

#linepad
*TODO*
 - Show numbers typed in body as math numbers (make sure this only applies to body text)
 - Make a separate counter for unnumbered sections (so that numbering does not repeat for different unnumbered sections)
 - Customize how proof boxes with references appear in figure list
 - Make general links colored?

#linepad
*Noteworthy limitations*
 - No user defined element functions (https://github.com/typst/typst/issues/147)
  - Particularly this makes referencing less convenient--you cannot easily reference an arbitrary element
  - Workaround for referencing elements: make the element a figure
 - Gradients with alpha do not work (https://github.com/typst/typst/issues/2546)
 - No simple/default numbering-by-section, though it should be easy to extend (https://github.com/typst/typst/issues/1896)


#pagebreak()
= Showcase

== Theorem Boxes
=== Pre-Defined Boxes
#definition("Definition Box")[
#lorem(20)
] <def1>

#corollary("Corollary Box")[
#lorem(20)
] <coro1>

#lemma("Lemma Box")[
#lorem(20)
] <lemma1>

#theorem("Theorem Box")[
#lorem(20)
] <thm1>

#proposition("Proposition Box")[
#lorem(20)
] <prop1>

#outline-box(title: "Outline Box")[
#lorem(20)
]

You can reference any numbered element: @def1, @coro1, @lemma1, @thm1, @prop1, and @example1.

=== Custom Box Examples
#shadow(
    shadow: 4pt,
    color: color.hsv(0deg, 0%, 0%, 50%),
thm-box(
    title: "Title",
    color: gradient.linear(..color.map.turbo),
    stroke: gradient.linear(..color.map.turbo)+1.5pt,
    fill: color.hsv(190deg, 70%, 90%, 5%),
    radius: 4pt,
)[
#lorem(20)
])

#outline-box(
    title: "Title",
    stroke: gradient.linear(..color.map.turbo)+1.5pt
)[
#lorem(20)
]


== Shadow Boxes
#shadow-box[
#lorem(20)
]

#shadow-box(width: auto, position: center)[
#lorem(20)
]

== Side Boxes
=== Pre-Defined Boxes
#example[
#lorem(20)
] <example1>

#proof[
#lorem(20)
]

#remark[
#lorem(20)
]

=== Custom Box Examples
#side-box(title: emoji.warning, color: red)[
#lorem(20)
]


#pagebreak()
= Numbering Scheme <numbering_scheme>

Note that the table of contents drops numbers for unnumbered headers.
#example[
Most significant number matches the current section.
]

#example[
Numbers automatically update with each element.
]

== Sub-Section
#example[
Subsections do not affect the element numbering scheme regardless of whether they are numbered.
]

= Numbering for Unnumbered Sections <nonum>
A section can be marked as unnumbered using the `<nonum>` label.

#example[
In an unnumbered section the most significant number (section number) is automatically dropped.
]

#example[
Only the element number is shown. The number updates automatically as before.
]

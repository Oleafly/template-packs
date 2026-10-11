#import "../template.typ": *

= Template Features and Examples

This chapter demonstrates all custom elements available in the template.

== Colored Math Text <colored-text>

The template provides functions to color mathematical text:

- `mg()`: $mg(1+2 -> "olive green")$
- `mm()`: $mm(1+2 -> "maroon")$
- `mo()`: $mo(1+2 -> "orange")$
- `mr()`: $mr(1+2 -> "red")$
- `mp()`: $mp(1+2 -> "purple")$
- `mb()`: $mb(1+2 -> "blue")$

#example[
  Using colors in equations:

  $ f(n) = mg(O(n^2)) + mm(Omega(n log n)) + mo(Theta(n)) $

  $ mr(x^2) + mp(y^2) = mb(r^2) $
]

== Colored Info Boxes

The template provides different types of boxes to highlight specific content.

=== Nota (Note)

#note[
  This is a "note" box, useful for adding supplementary information or important observations.
]

=== Attenzione (Warning)

#warning[
  This is a "warning" box, used for alerts or critical information not to be forgotten.
]

=== Informalmente (Informally)

#informally[
  This box is used for informal or intuitive explanations of complex concepts, before presenting formal definitions.
]

=== Esempio (Example)

#example[
  "Example" boxes contain practical applications or concrete cases to illustrate theoretical concepts.

  For instance, given the set $A = {1, 2, 3}$, its cardinality is $|A| = 3$.
]

=== Dimostrazione (Proof)

#proof[
  "Proof" boxes contain formal proofs of theorems.

  Let's prove that $1 + 1 = 2$:
  - Start from $1$
  - Add $1$
  - Get $2$

  Therefore $1 + 1 = 2$, $qed$.
]

=== Teorema (Theorem)

#theorem[
  This is an example theorem. Each theorem is numbered automatically.

  $ forall n in bb(N), quad n^2 >= 0 $
] <example-theorem>

#theorem(title: "Another Theorem")[
  A second theorem to show progressive numbering.

  $ sum_(i=1)^n i = (n(n+1))/2 $
] <gauss-sum>

== Numbered Equations <numbered-equations>

Equations are numbered automatically only inside `teorema` and `dimostrazione` boxes:

#theorem(title: "Einstein's Relativity")[
  The mass-energy relation is expressed by:
  $ E = m c^2 $ <einstein>

  #proof[
    $ E/m = c^2 $ <einstein2>
  ]
] <einstein-theorem>

Equations outside boxes are not numbered:

$ x + y = z $

$ integral_0^infinity e^(-x) dif x = 1 $

== Links and References

=== Section Links

We can create links to sections using `link-section()`. For example, back to #link-section(<colored-text>) or #link-section(<numbered-equations>).

=== Theorem Links

We can reference theorems using `link-teorema()`. See #link-theorem(<einstein-theorem>).

=== Equation Links

Numbered equations in theorems can be referenced with `link-equation()`: #link-equation(<einstein>) and #link-equation(<einstein2>).

== Definition Lists

The template supports definition lists with the `:` separator:

/ Term 1: Definition of the first term, which can be very long and span multiple lines without issues.

/ Term 2: Definition of the second term.

/ $f: A -> B$: A function that maps elements from set $A$ to set $B$.

/ Complexity: Measure of resources (time, space) needed to solve a problem.

== Pseudocode <pseudocode>

The template supports pseudocode using the `lovelace` package:

#pseudocode(
  [*Input*: array $A[1...n]$],
  [*Output*: sum of elements],
  [$"sum" <- 0$],
  [*For* $i <- 1$ *to* $n$ *do*],
  indent(
    [$"sum" <- "sum" + A[i]$],
  ),
  [*End For*],
  [*Return* $"sum"$],
)

#example[
  A more complex example with conditions:

  #pseudocode(
    [*Input*: number $n$],
    [*Output*: $"true"$ if $n$ is prime, $"false"$ otherwise],
    [*If* $n <= 1$ *then*],
    indent(
      [*Return* $"false"$],
    ),
    [*End If*],
    [*For* $i <- 2$ *to* $sqrt(n)$ *do*],
    indent(
      [*If* $n mod i = 0$ *then*],
      indent(
        [*Return* $"false"$],
      ),
      [*End If*],
    ),
    [*End For*],
    [*Return* $"true"$],
  )
]

== Diagrams with Fletcher

The `fletcher` package allows creating graph diagrams:

#align(center)[
  #import fletcher: *
  #diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), $A$, name: <a>),
    node((1, 0), $B$, name: <b>),
    node((0, 1), $C$, name: <c>),
    node((1, 1), $D$, name: <d>),
    edge(<a>, <b>, "->", label: $f$),
    edge(<a>, <c>, "->", label: $g$),
    edge(<b>, <d>, "->", label: $h$),
    edge(<c>, <d>, "->", label: $k$),
  )
]

#example[
  A more complex graph with cycles:

  #align(center)[
    #import fletcher: *
    #diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      node((0, 0), [Start], shape: fletcher.shapes.pill, name: <start>),
      node((1, 0), $v_1$, name: <v1>),
      node((2, 0), $v_2$, name: <v2>),
      node((1, 1), $v_3$, name: <v3>),
      edge(<start>, <v1>, "->"),
      edge(<v1>, <v2>, "->", bend: 20deg),
      edge(<v2>, <v1>, "->", bend: 20deg),
      edge(<v1>, <v3>, "->"),
      edge(<v3>, <v2>, "->"),
    )
  ]
]

== Drawings with CeTZ

The `cetz` package allows creating custom drawings:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Triangle
    line((0, 0), (2, 0), stroke: 2pt + blue)
    line((2, 0), (1, 1.7), stroke: 2pt + blue)
    line((1, 1.7), (0, 0), stroke: 2pt + blue)

    // Vertices
    circle((0, 0), radius: 0.08, fill: red)
    circle((2, 0), radius: 0.08, fill: red)
    circle((1, 1.7), radius: 0.08, fill: red)

    // Labels
    content((0, -0.3), [$A$])
    content((2, -0.3), [$B$])
    content((1, 2), [$C$])
  })
]

#example[
  A diagram with different shapes:

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      // Rectangle
      rect((0, 0), (1, 0.6), fill: blue.transparentize(70%), stroke: 2pt + blue)
      content((0.5, 0.3), [Box 1])

      // Circle
      circle(
        (2.5, 0.3),
        radius: 0.4,
        fill: red.transparentize(70%),
        stroke: 2pt + red,
      )
      content((2.5, 0.3), [Box 2])

      // Arrow
      line((1.1, 0.3), (2.0, 0.3), mark: (end: ">"), stroke: 2pt)
    })
  ]
]

== Venn Diagrams

The `cetz-venn` package allows creating Venn diagrams:

#align(center)[
  #cetz.canvas({
    import cetz-venn: *
    import cetz.draw: *

    venn2(
      name: "venn",
      a-fill: blue.transparentize(50%),
      b-fill: red.transparentize(50%),
    )
    content("venn.a", [$A$])
    content("venn.b", [$B$])
    content("venn.ab", [$A inter B$])
  })
]

== TODO Marker

When a section is incomplete or needs revision, use the `todo` marker:

#todo

#import "../core/preamble.typ": *

= Animations <sec-animations>

// pause: reveals content sequentially
#slide(title: "Sequential Reveal with #pause", color: col3)[

  This line is visible from the start.

  #pause
  This appears on click 1.

  #pause
  This appears on click 2.

  #pause
  #box-text([And this highlighted box on click 3.], color: col3, width: 70%)

  #v(0.3cm)
  #pause
  Perfect for building up complex ideas step-by-step!

]

// uncover: conditional reveal with preserved space
#slide(title: "Progressive Steps with #uncover", color: col3)[

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 0.8cm,
    [
      #figure(
        rect(
          fill: gradient.linear(col3.lighten(70%), col3, angle: 45deg),
          width: 100%,
          height: 4.5cm,
          stroke: none,
          radius: 8pt,
        ),
        caption: [Step 1],
      )
      #uncover("2-")[
        ✓ Initialize \
        Start process
      ]
    ],
    [
      #uncover("2-")[
        #figure(
          rect(
            fill: gradient.linear(col3.lighten(70%), col3, angle: 90deg),
            width: 100%,
            height: 4.5cm,
            stroke: none,
            radius: 8pt,
          ),
          caption: [Step 2],
        )
        ✓ Transform \
        Process data
      ]
    ],
    [
      #uncover("3-")[
        #figure(
          rect(
            fill: gradient.linear(col3.lighten(70%), col3, angle: 135deg),
            width: 100%,
            height: 4.5cm,
            stroke: none,
            radius: 8pt,
          ),
          caption: [Step 3],
        )
        ✓ Complete \
        Finish
      ]
    ],
  )

]

// alternatives: swap content in place
#slide(title: "Swapping Content with #alternatives", color: col3, composer: (1.3fr, 1fr))[

  The equation and description change on each click:

  $ s = sum_(i=1)^n x_i $

  #v(0.5cm)

  #alternatives[
    // Step 1
    *Simple case:* $n = 1$
    - Single element
    - Direct computation
  ][
    // Step 2
    *General case:* $n > 1$
    - Multiple elements
    - Iterative summation
    - $O(n)$ complexity
  ][
    // Step 3
    *Optimized:* $n >> 1$
    - Parallel processing
    - Vectorized operations
    - GPU acceleration
  ]

][
  #alternatives(start: 1, ..(
    for i in range(0, 3) {
      (
        [
          #figure(
            image("../figures/damped_sine_wave_" + str(i) + ".svg", width: 100%),
            caption: [It also works with figures!],
          )
        ],
      )
    }
  ))
]

// meanwhile: synchronized multi-column animations
#slide(title: "Synchronized Columns with #meanwhile", color: col3, composer: (1fr, 1fr, 1fr))[

  // Column 1
  *Input:*
  $ x = a + b $

  #pause

  *Transform:*
  $ y = f(x) $

  #pause

  *Output:*
  $ z = g(y) $

][
  // Column 2 syncs with column 1
  #meanwhile

  #v(1cm)
  #rect(
    fill: gradient.linear(col3.lighten(80%), col3.lighten(60%), angle: 90deg),
    width: 90%,
    height: 2cm,
    stroke: none,
    radius: 6pt,
  )

  #pause
  #v(0.5cm)
  #rect(
    fill: gradient.linear(col3.lighten(80%), col3.lighten(60%), angle: 90deg),
    width: 90%,
    height: 2cm,
    stroke: none,
    radius: 6pt,
  )

  #pause
  #v(0.5cm)
  #rect(
    fill: gradient.linear(col3.lighten(80%), col3.lighten(60%), angle: 90deg),
    width: 90%,
    height: 2cm,
    stroke: none,
    radius: 6pt,
  )

][
  // Column 3
  #pause
  #pause

  #v(2cm)
  #align(center)[
    #text(size: 24pt, fill: col3, weight: "bold")[Result]

    #v(0.5cm)
    #rect(
      fill: gradient.radial(col3.lighten(80%), col3, center: (50%, 50%)),
      width: 80%,
      height: 4cm,
      stroke: none,
      radius: 8pt,
    )
  ]

]

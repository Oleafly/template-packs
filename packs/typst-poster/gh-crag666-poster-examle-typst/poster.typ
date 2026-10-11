// ==================== CONFIG — edit here to adapt the template ====================
#let page-w = 90cm
#let page-h = 120cm
#let margin-x = 1.4cm
#let title-size = 65pt
#let subtitle-size = 31pt // subtitle lines under the title
#let block-title-size = 40pt
#let body-size = 25pt
#let section-inset = 20pt // padding inside section title bars
#let section-gap = 16pt // gap between sections and title bar -> body
#let col-gutter = 1.2cm // gap between the two body columns

// fonts — swap for your own; the list is a fallback chain
#let sans-display = "Liberation Sans" // title bar + section titles
#let sans-text = "Liberation Sans" // body

#import "@preview/typart:0.1.0": * // diagrams: card-table, process, gantt, pyramid, hierarchy, steps, venn
#import "@preview/catppuccin:1.1.0": get-flavor

// palette — swap the flavor (latte/frappe/macchiato/mocha) or bind plain rgb("#...") to re-theme
#let mocha = get-flavor("mocha").colors
#let accent = get-flavor("latte").colors.text.rgb // title bars + diagram accents
#let blue = mocha.blue.rgb
#let sky = mocha.sky.rgb
#let teal = mocha.teal.rgb
#let green = mocha.green.rgb
#let lavender = mocha.lavender.rgb
#let mauve = mocha.mauve.rgb
#let red = mocha.red.rgb
#let maroon = mocha.maroon.rgb
#let ink = mocha.crust.rgb // dark text over colored fills
#let ink-light = mocha.text.rgb // light text over dark fills

#set page(width: page-w, height: page-h, margin: 0pt)
#set par(justify: true)
#set text(font: (sans-text, "Liberation Sans"), size: body-size, lang: "en")
#show bibliography: none // bib is resolved (for @key cites) but rendered by the References section below

// section block: colored title bar + body
#let section(title, body, fill: accent, title-color: white) = block(width: 100%, above: section-gap, below: 0pt)[
  #box(width: 100%, inset: section-inset, fill: fill)[
    #align(center)[#text(font: sans-display, size: block-title-size, weight: "bold", fill: title-color)[#title]]
  ]
  #block(width: 100%, above: section-gap, inset: (x: 4pt))[#body] // above: gap title-bar -> body
]

// centered numbered-steps list, the recurring layout in several sections
#let step-list(items) = align(center, box(width: 90%, scale(140%, reflow: true, steps(items, accent: accent))))

// generic figure placeholder — swap for image("...") in a real poster
#let fig(height: 10cm, label: "Figure") = rect(
  width: 100%,
  height: height,
  fill: luma(235),
  stroke: 1pt + luma(180),
)[#align(center + horizon)[#text(fill: luma(130), size: 30pt, style: "italic")[#label]]]

// ======================= TITLE BAR (full-bleed) =======================
#box(width: 100%, inset: (x: margin-x, y: 30pt), fill: accent)[
  #grid(
    columns: (0.18fr, 0.80fr, 0.02fr),
    // last column: empty spacer so the title text doesn't touch the right edge
    align: horizon + center,
    column-gutter: 20pt,
    rect(width: 60%, height: 5cm, fill: white.transparentize(80%), stroke: 1pt + white)[
      #align(center + horizon)[#text(fill: white, size: 28pt, style: "italic")[Logo]]
    ],
    [
      #set par(spacing: 34pt, leading: 0.325em) // tight title lines + gap to subtitle
      #text(font: sans-display, size: title-size, weight: "bold", fill: white, hyphenate: false)[
        #lorem(14)
      ]
      #set text(size: subtitle-size, fill: white)
      #set par(leading: 0.4em)
      #lorem(4) \
      Student: #lorem(2) Advisor: #lorem(2) \
      #text(style: "italic")[#lorem(6)] \
      #lorem(5)
    ],
  )
]

// ======================= BODY (padded) =======================
#pad(x: margin-x, top: 0.5cm, bottom: margin-x)[

  // ---- Abstract (full width) ----
  #section[Abstract][
    #lorem(85)

    #v(6pt)
    *Keywords:* _#lorem(8)_
  ]

  #v(30pt)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: col-gutter,
    align: top,

    // ----------------- LEFT COLUMN -----------------
    [
      #section[Introduction][
        #fig(height: 12cm)
        // note: scale(reflow: true) + long justified labels can hang the compiler — keep diagram text short
        #align(center, scale(95%, reflow: true, tree(
          (
            [#lorem(3)],
            (
              (
                ([#lorem(2)], blue),
                (
                  (([#lorem(1)], sky), ([#lorem(1)], [#lorem(1)])),
                  (
                    ([#lorem(2)], teal),
                    ([#lorem(2)], [#lorem(1)], [#lorem(2)], [#lorem(2)]),
                  ),
                ),
              ),
              (
                ([#lorem(2)], blue),
                ([#lorem(2)], [#lorem(2)]),
              ),
              (
                ([#lorem(3)], blue),
                ([#lorem(2)], [#lorem(4)]),
              ),
            ),
          ),
          root-fill: green,
          accent: accent,
          text-fill: rgb("#000000"),
          box-fill: lavender,
          filled: true,
        )))
      ]
      #section[Research Questions][
        #step-list((
          [#lorem(17)],
          [#lorem(16)],
          [#lorem(19)],
        ))
      ]
      #section[Preliminary Objectives][
        *General:* #lorem(38)
        #v(8pt)
        #align(center)[#scale(130%, reflow: true, pill-steps(
          (
            (
              [#lorem(11)],
              "",
              "\u{f0eb}",
              lavender,
            ),
            (
              [#lorem(12)],
              "",
              "\u{f0ae}",
              teal,
            ),
            (
              [#lorem(10)],
              "",
              "\u{f3ed}", // shield-halved; f132 (shield) renders as tofu inside pill-steps in this typst build
              sky,
            ),
          ),
          title: [Specific Objectives],
          text-fill: ink,
          hub-fill: maroon,
          hub-text: ink,
          step-circle-fill: accent,
          step-text-fill: ink-light,
          connector: luma(100),
          connector-dot-fill: lavender,
          dot-stroke: luma(100),
          icon-color: accent,
        ))]
      ]
      #section[State of the Art][
        #card-table(
          ([#lorem(1)], [#lorem(1)], [#lorem(1)], [#lorem(2)], [#lorem(2)]),
          (
            (
              [Doe et al. @doe2024alpha],
              [#lorem(3)],
              [#lorem(1)],
              [#lorem(10)],
              [#lorem(6)],
            ),
            (
              [Smith et al. @smith2024beta],
              [*#lorem(2)*],
              [#lorem(2)],
              [#lorem(8)],
              [#lorem(4)],
            ),
            (
              [Lee et al. @lee2025gamma],
              [#lorem(3)],
              [#lorem(2)],
              [#lorem(7)],
              [#lorem(2)],
            ),
            (
              [García et al. @garcia2025delta],
              [#lorem(1)],
              [#lorem(2)],
              [#lorem(9)],
              [#lorem(5)],
            ),
            (
              [Chen et al. @chen2026epsilon],
              [#lorem(1)],
              [#lorem(3)],
              [#lorem(8)],
              [#lorem(4)],
            ),
            card-row(
              (
                [*#lorem(2)*],
                [*#lorem(2)*],
                [*#lorem(3)*],
                [*#lorem(9)*],
                [*#lorem(9)*],
              ),
              fill: green,
              text-fill: ink,
            ),
          ),
          weights: (10, 11, 11, 22, 16),
          size: 17.42pt,
        )
      ]

    ],

    // ----------------- RIGHT COLUMN -----------------
    [
      #section[Preliminary Methodology][
        #align(center)[#scale(145%, reflow: true, process(
          (
            ("\u{f002}", "1. Lorem ipsum dolor sit amet consectetur adipiscing.", mauve),
            ("\u{f51e}", "2. Elit sed do eiusmod tempor incididunt.", green),
            ("\u{f0c1}", "3. Ut labore et dolore magna aliqua.", blue),
            ("\u{f023}", "4. Enim ad minim veniam quis nostrud.", sky),
            ("\u{f080}", "5. Exercitation ullamco laboris nisi ut aliquip.", teal),
            ("\u{f201}", "6. Ex ea commodo consequat duis aute.", lavender),
          ),
          ring: red,
          core: text(font: "Font Awesome 7 Free", size: 90pt, fill: red)[\u{f21e}],
          icon-color: accent,
        ))]
      ]
      #section[Expected Contributions][
        #step-list((
          [#lorem(20)],
          [#lorem(13)],
        ))
      ]
      #section[Initial Experiments][
        #grid(
          columns: (1fr, 1fr),
          gutter: 12pt,
          align: center,
          [
            #fig(height: 9cm)
            *#lorem(2)*
          ],
          [
            #fig(height: 9cm)
            *#lorem(3)*
          ],
        )

        #v(6pt)

        #set math.equation(numbering: none)
        #grid(
          columns: (1fr, 1fr),
          gutter: 18pt,
          align: horizon,
          [
            *#lorem(2)* @doe2024alpha
            $ f(x) = 1/sqrt(2 pi sigma^2) e^(-(x - mu)^2 / (2 sigma^2)), quad x in RR $
            #text(size: 20pt)[#lorem(14)]
          ],
          [
            *#lorem(3)* @smith2024beta
            $ F(omega) = integral_(-oo)^(oo) f(t) e^(-i omega t) dif t $
            $ y = sum_(i = 1)^n w_i x_i + b, quad w in RR^n $
          ],
        )
      ]
      #section[Schedule][
        #gantt(
          (
            ("Lorem ipsum dolor sit", 1, 48, 13),
            ("Amet consectetur adipiscing elit", 1, 12, 50),
            ("Sed do eiusmod tempor", 4, 10, 30),
            ("Incididunt ut labore", 6, 12, 10),
            ("Et dolore magna aliqua", 12, 20, 5),
            ("Ut enim ad minim", 18, 28, 5),
            ("Veniam quis nostrud exercitation", 24, 34),
            ("Ullamco laboris nisi ut aliquip", 28, 38, 2),
            ("Ex ea commodo consequat", 34, 42),
            ("Duis aute irure", 22, 27, 0, false),
            ("Dolor in reprehenderit", 34, 44, 0, false),
            ("Voluptate velit esse", 40, 48),
          ),
          span: 48,
          today: 7,
          periods: ("Year 1", "Year 2", "Year 3", "Year 4"),
          accent: lavender,
          row-gap: 18pt,
        )
      ]

      #section[References][
        #set text(size: 12pt)
        // auto: every @key cited above lands here once, in citation order, filling row by row
        #context {
          let keys = query(cite).map(c => c.key).dedup()
          // split row-major (col1: 1,3,5  col2: 2,4) into two independent stacks -> no row gaps
          let refs = keys.map(k => cite(k, form: "full"))
          let col(parity) = stack(
            spacing: 12pt,
            ..refs.enumerate().filter(((i, _)) => calc.rem(i, 2) == parity).map(((_, r)) => r),
          )
          grid(
            columns: (1fr, 1fr),
            column-gutter: 16pt,
            align: top,
            col(0), col(1),
          )
        }
      ]
    ],
  )

] // end body pad

// ======================= FOOTER =======================
#place(bottom + center, dy: -margin-x, box(width: 100% - 2 * margin-x)[#align(center)[
  #rect(width: 42%, height: 3.5cm, fill: luma(235), stroke: 1pt + luma(180))[
    #align(center + horizon)[#text(fill: luma(130), size: 26pt, style: "italic")[Logo]]
  ]
]])

#bibliography("references.bib", style: "ieee") // hidden by show rule; resolves @keys

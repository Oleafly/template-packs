#import "../../imports.typ": *
#import "theme.typ": _base-size, _heading-sizes, _section-colors, bg-color, text-color, title-color

// ── Title Slide ───────────────────────────────────────────────────────────────

#let title-slide(
  title: [],
  authors: [],
  conference: [],
  date: [],
  logo-left: none, // optional — placed at bottom-left
  logo-center: none, // optional — placed at bottom-center
  logo-right: none, // optional — placed at bottom-right
  config: (:), // extra touying config (merged last)
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(footer: none), config)

  touying-slide(self: self, {
    align(center + top)[
      #v(2cm)
      #text(size: 52pt, weight: "medium", fill: title-color)[#title]
    ]

    align(center + horizon)[
      #v(-0.5cm)
      #text(size: 28pt, weight: "medium", fill: title-color)[#authors]
      #v(0.4em)
      #line(length: 40%, stroke: 1pt + title-color.lighten(40%))
      #v(0.4em)
      #text(size: 22pt, fill: title-color.lighten(20%))[#conference]
      #v(0.2em)
      #text(size: 20pt, fill: title-color.lighten(30%))[#date]
      #v(3cm)
    ]

    if logo-left != none { place(bottom + left, dx: 0cm, dy: 0cm, logo-left) }
    if logo-center != none { place(bottom + center, dx: 0cm, dy: 0cm, logo-center) }
    if logo-right != none { place(bottom + right, dx: 0cm, dy: 0cm, logo-right) }
  })
})

// ── Content Slide ─────────────────────────────────────────────────────────────

#let slide(
  title: auto, // overrides the section heading when set
  color: _section-colors.at(0), // controls the left accent bar and section tag color
  config: (:), // touying config passthrough
  repeat: auto, // touying repeat passthrough
  composer: auto, // touying composer passthrough
  ..args,
) = touying-slide-wrapper(self => {
  if title != auto { self.store.title = title }

  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    composer: composer,
    setting: body => {
      {
        show strong: it => text(fill: if color != none { color } else { _section-colors.at(0) }, it)
        show emph: it => text(fill: if color != none { color } else { _section-colors.at(0) }, it)
        // Left accent bar
        if color != none {
          context {
            place(
              left + top,
              dx: -0.8cm,
              rect(width: 0.2cm, height: 100%, fill: color, stroke: none),
            )
          }
        }

        // Top-right section tag showing current heading
        if color != none {
          context {
            place(
              top + right,
              dx: -0.2cm,
              dy: -0.075cm,
              box(
                fill: color,
                stroke: color,
                inset: (x: 12pt, y: 6pt),
                radius: 8pt,
              )[
                #text(size: _base-size * 0.8, weight: "medium", fill: bg-color)[
                  #utils.display-current-heading(level: 1)
                ]
              ],
            )
          }
        }

        grid(
          rows: (auto, 1fr),
          pad(left: 0.8cm)[
            #text(size: 26pt, weight: "medium", fill: title-color)[
              #utils.call-or-display(self, self.store.title)
            ]
            #v(-0.3em)
            #line(length: 100%, stroke: 1pt + title-color.lighten(20%))
            #v(0.3em)
          ],
          pad(left: 0.8cm, right: 0.4cm, top: 0.4cm)[
            #body
          ],
        )
      }
    },
    ..args.pos(),
  )
})

// ── Table of Contents ─────────────────────────────────────────────────────────

// Internal: renders a single section row with a colored left bar
#let _toc-row(color, number, title, subtitle, dimmed: false) = {
  let c = if dimmed { color.transparentize(60%) } else { color }
  let title-c = if dimmed { title-color.transparentize(50%) } else { title-color }
  let sub-c = if dimmed { luma(180).transparentize(40%) } else { luma(120) }

  grid(
    columns: (0.38cm, 1fr),
    column-gutter: 15pt,
    align: left + horizon,
    rect(width: 0.15cm, height: 1.5cm, fill: c, stroke: none, radius: 1pt),
    stack(spacing: 1pt)[
      #text(size: _heading-sizes.at(1) * 0.95, weight: "medium", fill: c)[#number]#h(0.3cm)
      #text(size: _heading-sizes.at(1), weight: "medium", fill: title-c)[#title]\
      #h(0cm)#text(size: _base-size, fill: sub-c)[#subtitle]
    ],
  )
}

// Each entry in `sections` is a dict with keys:
//   - title    (content)
//   - subtitle (content, optional — short descriptor shown below the title)
//   - label    (typst label for linking, optional)
//
// `active` highlights one section (1-indexed); 0 means no dimming.
#let toc-slide(
  group: [], // research group name — shown small above "Outline"
  university: [], // shown at the bottom of the left column
  label: [Outline],
  sections: (),
  active: 0,
  config: (:),
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(footer: none), config)

  touying-slide(self: self, {
    place(top + left, grid(
      columns: (32%, 2pt, 1fr),
      rows: 100%,

      // ── Left column: centered title ───────────────────────────────────────
      block(
        width: 100%,
        height: 100%,
        fill: rgb("#FAFAFA"),
        inset: (x: 1.2cm, y: 1cm),
      )[
        #align(left + horizon)[
          #stack(spacing: 4pt)[
            #h(1.2cm)
            #text(size: 9pt, weight: "medium", fill: _section-colors.at(0).lighten(30%), tracking: 0.8pt)[
              #upper(group)
            ]
            #text(size: _heading-sizes.at(0), weight: "medium", fill: title-color)[#label]
            #v(0.1cm)
            #text(size: 9pt, fill: luma(170))[#university]
          ]
        ]
      ],

      // ── Vertical divider ─────────────────────────────────────────────────
      align(horizon)[
        #rect(
          width: 100%,
          height: 85%,
          fill: luma(210),
          stroke: none,
        )
      ],

      // ── Right column: section list ────────────────────────────────────────
      block(
        width: 100%,
        height: 100%,
        fill: rgb("#FAFAFA"),
        inset: (x: 1.5cm, y: 0cm),
      )[
        #align(left + horizon)[
          #stack(
            spacing: 25pt,
            ..sections
              .enumerate()
              .map(((i, s)) => _toc-row(
                _section-colors.at(calc.rem(i, _section-colors.len())),
                str(i + 1),
                s.at("section"),
                s.at("subsections", default: []),
                dimmed: active != 0 and active != i + 1,
              )),
          )
        ]
      ],
    ))
  })
})


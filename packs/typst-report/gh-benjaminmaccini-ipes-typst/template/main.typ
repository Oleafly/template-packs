// ===========================================================================
// A worked demo of every public function in `dossier`.
//
// The prose is `lorem()` on purpose: this file is here to show the machinery
// and to act as a visual regression test, not to be read. Replace the lorem
// calls and the sample data and you have a report.
//
// After `make link` this import can be:  #import "@local/dossier:0.1.0": *
// Published to Universe it becomes:      #import "@preview/dossier:0.1.0": *
// ===========================================================================

#import "../src/lib.typ": *

#show: report.with(
  title: [The new geopolitics of food],
  subtitle: [Navigating policies for resilient self-reliance in a volatile decade],
  eyebrow: [A Special Report],
  publisher: [Panel on Food Systems],
  date: [September 2026],
  authors: ("A. Researcher", "B. Analyst"),

  // Swap this one call and the whole document re-skins.
  theme: make-theme(),

  cover: (image: read("assets/cover.png", encoding: none), treatment: "scrim"),

  credits: (
    body: [
      #lorem(60)

      #lorem(35)
    ],
    citation: [Panel on Food Systems. (2026). _The new geopolitics of food._ Demo edition.],
    license: [Licensed CC BY 4.0. Base map: Natural Earth (public domain).],
    contact: [hello\@example.org],
  ),

  endnotes: bibliography("refs.bib", style: "nature", title: none),

  back: (
    contact: [Rue de l'Exemple 1 \ 1000 Brussels],
    url: "https://example.org",
    license: [CC BY 4.0],
  ),
)

// ===========================================================================
#section-opener(
  lede: [#lorem(28)],
)[The new geopolitics of food]

#key-messages[
  - *#lorem(12).* #lorem(24)
  - *#lorem(9).* #lorem(28)
  - *#lorem(11).* #lorem(20)
]

== What is driving this shift?

#lorem(55) @clapp2020food

#lorem(45)#aside[#lorem(20)] #lorem(30) @margulis2023famine @fao2024sofi

#pull-quote(attribution: [Panel on Food Systems, 2026])[
  #lorem(18)
]

#lorem(60) @bjornlund2022insecurity

#stat-row(
  stat(value: 70, unit: [%], label: [#lorem(10)]),
  stat(value: 2.3, unit: [bn], label: [#lorem(9)]),
  stat(value: 15, unit: [yr], label: [#lorem(8)]),
)

=== A narrower reading

#lorem(50)

#box-note(title: [Defining resilient self-reliance], tag: <box:self-reliance>)[
  #lorem(55)
]

#lorem(40) See @box:self-reliance.

== What is at stake

#lorem(45)

#data-story(
  title: [Food price index by region],
  subtitle: [#lorem(14)],
  source: [Demo data, not real.],
  width: "column",
)[
  #let d = (
    (year: 2019, region: "Global South", index: 100),
    (year: 2020, region: "Global South", index: 108),
    (year: 2021, region: "Global South", index: 126),
    (year: 2022, region: "Global South", index: 159),
    (year: 2023, region: "Global South", index: 148),
    (year: 2024, region: "Global South", index: 152),
    (year: 2019, region: "Global North", index: 100),
    (year: 2020, region: "Global North", index: 103),
    (year: 2021, region: "Global North", index: 112),
    (year: 2022, region: "Global North", index: 131),
    (year: 2023, region: "Global North", index: 124),
    (year: 2024, region: "Global North", index: 121),
  )
  #chart(
    data: d,
    mapping: gg.aes(x: "year", y: "index", colour: "region"),
    layers: (gg.geom-line(linewidth: 1.4pt), gg.geom-point(size: 2.4pt)),
    labels: gg.labels(x: "Year", y: "Index (2019 = 100)"),
    width: 100%,
    height: 6cm,
  )
]

#lorem(50)

// ===========================================================================
#section-opener(
  image: read("assets/section-markets.png", encoding: none),
  treatment: "scrim",
  lede: [#lorem(26)],
)[Market management tools]

== Public food stockholding

#lorem(60)#margin-note[#lorem(14)]

#lorem(40)

#case-study(
  title: [Public procurement as a food security backbone],
  region: [Brazil],
  source: [Demo case study.],
)[
  #lorem(70)
]

=== Practical constraints

#lorem(45)

#figure(
  table(
    columns: (auto, 1fr, auto, auto),
    align: (left, left, right, right),
    table.header[Instrument][Mechanism][Coverage][Since],
    [Buffer stock], [Physical reserve], [12%], [1965],
    [Supply management], [Production quota], [31%], [1972],
    [Public procurement], [Guaranteed purchase], [44%], [2003],
    [Price band], [Tariff adjustment], [8%], [1994],
  ),
  caption: [A conventional table, styled by the theme.],
)

#pull-quote(attribution: [Case study interview], wide: false)[
  #lorem(14)
]

== Supply management mechanisms

#lorem(55)

#data-story(
  title: [Instruments in force, by decade],
  subtitle: [#lorem(12)],
  source: [Demo data, not real.],
  width: "wide",
)[
  #let d = (
    (decade: "1970s", count: 41, kind: "Stockholding"),
    (decade: "1980s", count: 33, kind: "Stockholding"),
    (decade: "1990s", count: 18, kind: "Stockholding"),
    (decade: "2000s", count: 14, kind: "Stockholding"),
    (decade: "2010s", count: 19, kind: "Stockholding"),
    (decade: "2020s", count: 27, kind: "Stockholding"),
    (decade: "1970s", count: 24, kind: "Supply management"),
    (decade: "1980s", count: 21, kind: "Supply management"),
    (decade: "1990s", count: 11, kind: "Supply management"),
    (decade: "2000s", count: 8, kind: "Supply management"),
    (decade: "2010s", count: 9, kind: "Supply management"),
    (decade: "2020s", count: 13, kind: "Supply management"),
  )
  #chart(
    data: d,
    mapping: gg.aes(x: "decade", y: "count", fill: "kind"),
    layers: (gg.geom-col(position: "dodge"),),
    labels: gg.labels(x: none, y: "Countries"),
    width: 100%,
    height: 5.5cm,
  )
]

#recommendation(title: [Rebuild public stockholding capacity])[
  #lorem(40)
]

#recommendation(title: [Reform trade rules that penalise reserves])[
  #lorem(35)
]

// ===========================================================================
#section-opener(
  image: read("assets/section-markets.png", encoding: none),
  treatment: "tint",
  lede: [#lorem(24)],
)[Resilient self-reliance]

== Exposure is unevenly distributed

#lorem(50)

#data-story(
  title: [Share of dietary energy from imports],
  subtitle: [#lorem(16)],
  source: [Synthetic values on Natural Earth boundaries — illustrative only.],
  width: "spread",
)[
  #map(
    read("assets/world.geojson", encoding: none),
    property: "import_share",
    projection: "natural_earth",
    legend-title: [Share of calories imported, %],
    legend-format: n => [#calc.round(n) %],
    width: 92%,
  )
]

== A page that flows around its illustration

The `meander` package is re-exported rather than wrapped: it governs whichever
page you hand it, and nothing else.

#meander.reflow({
  import meander: *
  placed(top + right, dx: -4mm, block(
    width: 5cm,
    fill: luma(240),
    inset: 8pt,
    radius: 2pt,
    [#text(size: 8pt)[#lorem(20)]],
  ))
  container()
  content[
    #dropcap(height: 2, gap: 4pt)[#lorem(120)]
  ]
})

== Closing

#epigraph(source: [A. Researcher])[#lorem(20)]

#lorem(60)

// ===========================================================================
#pagebreak(weak: true)
#index-of(kind: "box", title: [Boxes])
#index-of(kind: "case-study", title: [Case studies])
#index-of(kind: "story", title: [Figures])

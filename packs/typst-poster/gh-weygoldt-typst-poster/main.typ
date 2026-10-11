#import "template/poster.typ": *

#show: poster.with(
  title: [The secret social lives of electric eels],
  subtitle: [Passive electric monitoring to track nocturnal apex
    predators in Neotropical streams],
  authors: (
    (name: "Patrick Weygoldt",           affil: (1,),   corresponding: true),
    (name: "Sarah Eisele",               affil: (1,)),
    (name: "Raimundo N. Gomes Mendes Júnior", affil: (2,)),
    (name: "Douglas Bastos",             affil: (3,)),
    (name: "C. David de Santana",           affil: (4,)),
    (name: "Peter Bartsch",             affil: (5,)),
    (name: "Jan Benda",                  affil: (1,)),
  ),
  affiliations: (
    "University of Tübingen",
    "University of São Paulo",
    "INPA, Manaus",
    "MPEG, Belém",
    "MfN, Berlin",
  ),
  hero: image("figures/hero_crop.png"),
  hero-height: 240mm,
  title-width: 52%,
  footer-left: [ICN 2026 · Electric fish satellite meeting],
  footer-right: [patrick.weygoldt\@uni-tuebingen.de],
)

// ============================ BACKGROUND ====================================
= Background

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 40pt,
  align: horizon,
  [
    Electric eels (#emph[Electrophorus voltai]) are iconic Neotropical predators
    #cite(<desantana2019>), yet long assumed solitary, despite reports of
    coordinated #hl[group hunting] #cite(<bastos2021>).
  ],
  [
    We built portable electrode loggers to eavesdrop on their electric organ
    discharges (EODs), plus software that pinpoints each
    fish, even beyond the electrode arrays.
  ],
  stat-row(
    label: "Dataset at a glance",
    cols: 3,
    label-side: true,
    value-size: 24pt,
    inset: 22pt,
    row-gutter: 15pt,
    (value: [2],      label: "rivers"),
    (value: [14 TB], label: "raw data"),
    (value: [16],     label: "rec. sites"),
    (value: [70],    label: "cum. rec. days"),
    (value: [8+8],    label: "grids / lines"),
    (value: [13 M],  label: "eel EODs"),
  ),
)

// ============================= METHODS ======================================
= Methods

#grid(
  columns: (1fr, 0.72fr, 0.72fr, 1.5fr),
  column-gutter: 40pt,
  align: top,
  [
    #keypoint("Autonomous loggers.")[Grids & lines record EODs day and night.]
    #keypoint("Deployment.")[16 sites; grids at confluences, lines along side streams and the main river.]
    #keypoint("EODs as intrinsic tags.")[Each eel's discharge shape and timing act as a fingerprint, separating overlapping individuals.]
    #keypoint("Physics-informed localisation.")[Simulating the electric field pinpoints each eel's position, with error estimates.]
  ],
  figure-card(
    image("figures/deployment_poster_dark.svg"),
    caption: cap[Deployment scheme.][Grids at confluences; lines span side
      streams and the main river.],
  ),
  figure-card(
    image("figures/grid1.png"),
    caption: cap[Electrode grid.][4×4 electrodes, 180×180 cm, fully collapsible],
  ),
  figure-card(
    image("figures/pipeline_poster_dark.svg"),
    caption: cap[Per-pulse pipeline.][Detect → classify → localise → track; a position and track for every pulse.],
  ),
)

// ============================= RESULTS ======================================
= Results

// 2x3 results grid — six poster-themed tiles, emitted from the eeltracker
// plotting code with one shared dark style (consistent theme + font sizes).
// Captions sit ABOVE each plot (message-first: the bold lead is a headline the
// viewer reads before the plot); `cap-height` reserves a uniform caption block
// so the six plots still align across the grid despite unequal caption lengths.
#let res-cap-h = 56pt
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 40pt,
  row-gutter: 46pt,
  align: top,
  // --- row 1: community structure + diel activity + hunting diel ---
  figure-card(
    image("figures/community_active_composition_poster_dark.svg"),
    cap-above: true, cap-height: res-cap-h,
    caption: cap[Structured community.][Eels dominate the confluences; wave-type fish are common on the lines.],
  ),
  figure-card(
    image("figures/res_community_diel_poster_dark.svg"),
    cap-above: true, cap-height: res-cap-h,
    caption: cap[Full community is nocturnal.][Eels, wave-type and pulse-type fish are all active at night.],
  ),
  figure-card(
    image("figures/hunting_diel_poster_dark.svg"),
    cap-above: true, cap-height: res-cap-h,
    caption: cap[Nocturnal & crepuscular.][Hunting volleys primarily during twilight and nighttime.],
  ),
  // --- row 2: space use + group size + a group-hunting event ---
  figure-card(
    image("figures/spaceuse_site9_poster_dark.svg"),
    cap-above: true, cap-height: res-cap-h,
    caption: cap[Space use, day vs night.][Eels cluster tightly at a confluence by day, then spread out at night.],
  ),
  figure-card(
    image("figures/group_size_poster_dark.svg"),
    cap-above: true, cap-height: res-cap-h,
    caption: cap[Groups, not singletons.][Eels co-occur at confluence mouths in groups up to 5 individuals.],
  ),
  figure-card(
    image("figures/event_site3_poster_dark.svg"),
    cap-above: true, cap-height: res-cap-h,
    caption: cap[A coordinated hunt.][Many eels fire their discharges together in one sustained, rapid burst.],
  ),
)

// ===================== TAKE-HOME + REFERENCES (two columns) =================
#v(32pt)

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 44pt,
  align: top,
  // LEFT: take-home conclusions as a 2×2 grid
  take-home(
    cols: 2,
    (title: [Diverse nocturnal community],
     body: [Eels signal into a rich nocturnal electric community, not an empty river.]),
    (title: [Night & dusk hunting],
     body: [Hunting peaks at night and dusk, sometimes in small side streams.]),
    (title: [24/7 social confluences],
     body: [Confluence mouths are occupied around the clock by groups.]),
    (title: [Quantitative ethology],
     body: [Hardware + physics-informed software open a quantitative ethology of electric fishes.]),
  ),
  // RIGHT: references, then the call-to-action, then a compact acknowledgement
  {
    subhead[References]
    v(8pt)
    bibliography("references.bib", title: none, style: "poster.csl")
    v(20pt)
    // Call to action — moved up here from the old full-width bottom band, which
    // frees the bottom of the poster.
    context block(
      width: 100%,
      fill: palette().accent.transparentize(90%),
      stroke: (left: 4pt + palette().accent),
      radius: 6pt,
      inset: (x: 22pt, y: 16pt),
      {
        set text(size: scale.body)
        text(fill: palette().accent, weight: 700)[Want to learn more?]
        linebreak()
        text(fill: palette().body)[Check out my talk in the
          #emph[Principles of communication in social groups] symposium.]
      },
    )
    v(16pt)
    // Compact acknowledgements — funder + fieldwork permits (usually required)
    // folded into one small line instead of a full section.
    context text(fill: palette().faint, size: scale.small)[
      Funded by the DFG. Fieldwork under ICMBio permits — thanks to the boat
      crews and local communities.
    ]
  },
)

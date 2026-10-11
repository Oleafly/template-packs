// =============================================================================
// Sample Presentation — Typfolio Template Demo
// Replace content with your own when using this template.
// =============================================================================

#import "theme.typ": *

#show: tp-presentation.with(
  footer-left: [Your Product *Name*],
  doc-type: "PROPOSAL",
)

// ─────────────────────────────────────────────
// 1. Cover
// ─────────────────────────────────────────────

#cover-slide(
  category: "YOUR CATEGORY HERE",
  title: "Product ",
  title-accent: "Name",
  subtitle: "One-line description of your product or service",
  quote: "The key message you want to deliver goes here",
  prepared-for: "Client Name",
  date: "2026-01-01",
  presented-by: "Your Company",
)

// ─────────────────────────────────────────────
// 2. Table of Contents
// ─────────────────────────────────────────────

#toc-slide(
  description: "This proposal covers the full scope of our project — from background and analysis to expected outcomes and implementation timeline.",
  items: (
    (num: "01", title: "Project Overview", desc: "Background & solution summary"),
    (num: "02", title: "Current Analysis", desc: "Key problems & impact"),
    (num: "03", title: "Solution Overview", desc: "Core features & system design"),
    (num: "04", title: "Service Flow", desc: "Access methods & scenarios"),
    (num: "05", title: "Expected Benefits", desc: "Quantitative & qualitative gains"),
    (num: "06", title: "Execution Plan", desc: "Goals, scope & success criteria"),
    (num: "07", title: "Timeline", desc: "Full schedule & milestones"),
    (num: "08", title: "Differentiation", desc: "Competitive edge & security"),
  ),
  contact-phone: "Feel free to reach out anytime",
  contact-email: "contact@example.com",
)

// ─────────────────────────────────────────────
// 3. Two-column layout: Problem + Solution
// ─────────────────────────────────────────────

#content-slide(
  section-num: "01",
  section-title: "Project Overview",
  section-subtitle: "PROJECT OVERVIEW",
)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,

    {
      text(weight: "bold", size: 1.15em, fill: tp-dark)[1.1 Background]
      v(0.6em)
      tp-card(title: "Key Problems")[
        Describe the core issues in your current workflow. Use *bold* to emphasize key points.

        #v(0.4em)
        *Limitations of current approach*
        #v(0.3em)
        #tp-check-item(color: tp-red)[First issue — provide a specific explanation]
        #v(0.15em)
        #tp-check-item(color: tp-red)[Second issue — provide a specific explanation]
        #v(0.15em)
        #tp-check-item(color: tp-red)[Third issue — provide a specific explanation]
      ]
    },

    {
      text(weight: "bold", size: 1.15em, fill: tp-dark)[1.2 Solution Summary]
      v(0.6em)
      tp-card(title: "Proposed Solution")[
        Explain the benefits through *#text(fill: tp-blue)[your core value proposition]*.

        #v(0.4em)
        *Key Advantages*
        #v(0.3em)
        #tp-check-item[First advantage — provide a specific explanation]
        #v(0.15em)
        #tp-check-item[Second advantage — provide a specific explanation]
        #v(0.15em)
        #tp-check-item[Third advantage — provide a specific explanation]
      ]
    },
  )
]

// ─────────────────────────────────────────────
// 4. Three-column cards: Target Users
// ─────────────────────────────────────────────

#content-slide(
  section-num: "01",
  section-title: "Project Overview",
  section-subtitle: "PROJECT OVERVIEW",
)[
  #text(weight: "bold", size: 1.15em, fill: tp-dark)[1.3 Target Users]
  #v(0.8em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,

    tp-card()[
      #align(center)[
        #v(0.3em)
        #text(size: 2em)[🏭]
        #v(0.4em)
        #text(weight: "bold", size: 1.1em, fill: tp-dark)[Field Operator]
        #v(0.2em)
        #tp-badge("Primary User", color: tp-blue)
        #v(0.5em)
      ]
      #tp-check-item[Production line management]
      #v(0.15em)
      #tp-check-item[Equipment operation & settings]
      #v(0.15em)
      #tp-check-item[Daily inspection & reporting]
    ],

    tp-card()[
      #align(center)[
        #v(0.3em)
        #text(size: 2em)[👔]
        #v(0.4em)
        #text(weight: "bold", size: 1.1em, fill: tp-dark)[Manager]
        #v(0.2em)
        #text(size: 0.8em, fill: tp-muted)[Manager]
        #v(0.5em)
      ]
      #tp-check-item[Process standards & quality control]
      #v(0.15em)
      #tp-check-item[Quality supervision & issue handling]
      #v(0.15em)
      #tp-check-item[Staff training & onboarding]
    ],

    tp-card()[
      #align(center)[
        #v(0.3em)
        #text(size: 2em)[🔧]
        #v(0.4em)
        #text(weight: "bold", size: 1.1em, fill: tp-dark)[Operations Lead]
        #v(0.2em)
        #text(size: 0.8em, fill: tp-muted)[Operations]
        #v(0.5em)
      ]
      #tp-check-item[Preventive maintenance & upkeep]
      #v(0.15em)
      #tp-check-item[Troubleshooting & incident response]
      #v(0.15em)
      #tp-check-item[Process improvement & optimization]
    ],
  )
]

// ─────────────────────────────────────────────
// 5. 2x2 Card Grid: Core Features
// ─────────────────────────────────────────────

#content-slide(
  section-num: "03",
  section-title: "Solution Overview",
  section-subtitle: "SOLUTION OVERVIEW",
)[
  #set text(size: 0.9em)
  #v(0.2em)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2em,
    row-gutter: 0.8em,

    tp-card(title: "Core Feature 1")[
      #tp-check-item[Detail point A]
      #v(0.1em)
      #tp-check-item[Detail point B]
    ],

    tp-card(title: "Core Feature 2")[
      #tp-check-item[Detail point A]
      #v(0.1em)
      #tp-check-item[Detail point B]
    ],

    tp-card(title: "Core Feature 3")[
      #tp-check-item[Detail point A]
      #v(0.1em)
      #tp-check-item[Detail point B]
    ],

    tp-card(title: "Core Feature 4")[
      #tp-check-item[Detail point A]
      #v(0.1em)
      #tp-check-item[Detail point B]
    ],
  )
]

// ─────────────────────────────────────────────
// 6. Comparison Table
// ─────────────────────────────────────────────

#content-slide(
  section-num: "05",
  section-title: "Expected Benefits",
  section-subtitle: "EXPECTED BENEFITS",
)[
  #text(size: 1.1em, weight: "bold", fill: tp-dark)[
    #box(width: 4pt, height: 1em, fill: tp-blue, baseline: 20%)
    #h(8pt)
    Current State vs Proposed Solution
  ]
  #v(0.6em)

  #tp-comparison-table(
    headers: ("Category", "Current (AS-IS)", "After (TO-BE)"),
    highlight-col: 2,
    rows: (
      ([*Item 1*], [Description of current state], [Improved state]),
      ([*Item 2*], [Description of current state], [Improved state]),
      ([*Item 3*], [Description of current state], [Improved state]),
      ([*Item 4*], [Description of current state], [Improved state]),
    ),
  )
]

// ─────────────────────────────────────────────
// 7. KPI Stats + Summary Cards
// ─────────────────────────────────────────────

#content-slide(
  section-num: "06",
  section-title: "Execution Plan",
  section-subtitle: "EXECUTION PLAN",
)[
  #text(size: 1.1em, weight: "bold", fill: tp-dark)[
    #box(width: 4pt, height: 1em, fill: tp-blue, baseline: 20%)
    #h(8pt)
    Key Performance Indicators (KPI)
  ]
  #v(0.6em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,

    tp-card(fill: tp-blue.lighten(93%))[
      #align(center)[
        #text(size: 0.8em, fill: tp-body)[Goal Achievement]
        #v(0.2em)
        #text(size: 2.2em, weight: "black", fill: tp-blue)[85%]
        #text(size: 0.9em, fill: tp-body)[ or above]
      ]
    ],
    tp-card(fill: tp-blue.lighten(93%))[
      #align(center)[
        #text(size: 0.8em, fill: tp-body)[Avg Response Time]
        #v(0.2em)
        #text(size: 2.2em, weight: "black", fill: tp-blue)[10s]
        #text(size: 0.9em, fill: tp-body)[ or less]
      ]
    ],
    tp-card(fill: tp-blue.lighten(93%))[
      #align(center)[
        #text(size: 0.8em, fill: tp-body)[Cost Reduction]
        #v(0.2em)
        #text(size: 2.2em, weight: "black", fill: tp-blue)[30%]
        #text(size: 0.9em, fill: tp-body)[ or more]
      ]
    ],
  )

  #v(0.8em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,

    tp-card(title: "Quantitative Impact")[
      #tp-check-item[Metric A: XX% improvement]
      #v(0.15em)
      #tp-check-item[Metric B: XX% cost savings]
      #v(0.15em)
      #tp-check-item[Metric C: XXx performance gain]
    ],
    tp-card(title: "Qualitative Impact")[
      #tp-check-item[Improved job satisfaction]
      #v(0.15em)
      #tp-check-item[Strengthened team capability]
      #v(0.15em)
      #tp-check-item[Accelerated standardization]
    ],
    tp-card(title: "Expected ROI")[
      #tp-check-item[XXx return on investment]
      #v(0.15em)
      #tp-check-item[Break-even in XX months]
      #v(0.15em)
      #tp-check-item[Annual savings of \$XXM]
    ],
  )
]

// ─────────────────────────────────────────────
// 8. Timeline / Phased Plan
// ─────────────────────────────────────────────

#content-slide(
  section-num: "07",
  section-title: "Timeline",
  section-subtitle: "IMPLEMENTATION SCHEDULE",
)[
  #text(size: 1.1em, weight: "bold", fill: tp-dark)[
    #box(width: 4pt, height: 1em, fill: tp-blue, baseline: 20%)
    #h(8pt)
    Phased Implementation Plan
  ]
  #v(0.6em)

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    column-gutter: 0.8em,

    {
      block(width: 100%, height: 4pt, fill: tp-muted, radius: 2pt)
      v(0.5em)
      tp-card()[
        #align(center)[
          #text(size: 1.5em)[1]
          #v(0.2em)
          #text(weight: "bold", fill: tp-dark)[Preparation]
          #v(0.1em)
          #text(size: 0.8em, fill: tp-muted)[W1 - W2]
        ]
        #v(0.3em)
        #tp-check-item[Scope definition & setup]
        #v(0.1em)
        #tp-check-item[Team assignment]
        #v(0.1em)
        #tp-check-item[Data collection]

        #v(0.4em)
        #align(center, text(size: 0.75em, fill: tp-muted)[Environment setup])
      ]
    },

    {
      block(width: 100%, height: 4pt, fill: tp-blue, radius: 2pt)
      v(0.5em)
      tp-card()[
        #align(center)[
          #text(size: 1.5em, fill: tp-blue, weight: "bold")[2]
          #v(0.2em)
          #text(weight: "bold", fill: tp-blue)[Development]
          #v(0.1em)
          #text(size: 0.8em, fill: tp-muted)[W3 - W8]
        ]
        #v(0.3em)
        #tp-check-item[Build & data integration]
        #v(0.1em)
        #tp-check-item[Mid-term testing & feedback]
        #v(0.1em)
        #tp-check-item[Security compliance check]

        #v(0.4em)
        #align(center, tp-badge("Core Phase", color: tp-blue))
      ]
    },

    {
      block(width: 100%, height: 4pt, fill: tp-purple, radius: 2pt)
      v(0.5em)
      tp-card()[
        #align(center)[
          #text(size: 1.5em, fill: tp-purple, weight: "bold")[3]
          #v(0.2em)
          #text(weight: "bold", fill: tp-purple)[Pilot Run]
          #v(0.1em)
          #text(size: 0.8em, fill: tp-muted)[W9 - W12]
        ]
        #v(0.3em)
        #tp-check-item[User training & support]
        #v(0.1em)
        #tp-check-item[Real-time feedback loop]
        #v(0.1em)
        #tp-check-item[Usage monitoring]

        #v(0.4em)
        #align(center, text(size: 0.75em, fill: tp-muted)[Field adoption support])
      ]
    },

    {
      block(width: 100%, height: 4pt, fill: tp-green, radius: 2pt)
      v(0.5em)
      tp-card()[
        #align(center)[
          #text(size: 1.5em, fill: tp-green, weight: "bold")[4]
          #v(0.2em)
          #text(weight: "bold", fill: tp-green)[Evaluation]
          #v(0.1em)
          #text(size: 0.8em, fill: tp-muted)[W12 End]
        ]
        #v(0.3em)
        #tp-check-item[Performance data analysis]
        #v(0.1em)
        #tp-check-item[User satisfaction survey]
        #v(0.1em)
        #tp-check-item[Expansion planning]

        #v(0.4em)
        #align(center, text(size: 0.75em, fill: tp-muted)[Impact verification])
      ]
    },
  )
]

// ─────────────────────────────────────────────
// 9. Section Divider
// ─────────────────────────────────────────────

#section-divider-slide(
  num: "03",
  title: "Solution Overview",
  subtitle: "SOLUTION OVERVIEW",
  description: "Introducing core features and system architecture. A solution optimized for your environment to maximize operational efficiency.",
)

// ─────────────────────────────────────────────
// 10. Process Flow
// ─────────────────────────────────────────────

#content-slide(
  section-num: "04",
  section-title: "Service Flow",
  section-subtitle: "SERVICE FLOW",
)[
  #text(size: 1.1em, weight: "bold", fill: tp-dark)[
    #box(width: 4pt, height: 1em, fill: tp-blue, baseline: 20%)
    #h(8pt)
    Service Adoption Process
  ]
  #v(0.8em)

  #grid(
    columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
    column-gutter: 0.3em,
    align: center + horizon,

    // Step 1
    block(
      width: 100%,
      fill: tp-blue,
      radius: 12pt,
      inset: (x: 0.8em, y: 1em),
      {
        align(center)[
          #text(fill: tp-white.transparentize(50%), weight: "black", size: 1.8em)[01]
          #v(0.3em)
          #text(fill: tp-white, weight: "bold", size: 0.95em)[Requirements]
          #v(0.2em)
          #text(fill: tp-white.transparentize(20%), size: 0.7em)[Analysis &\nneeds assessment]
        ]
      },
    ),
    text(fill: tp-muted, size: 1.5em)[→],

    // Step 2
    block(
      width: 100%,
      fill: tp-blue.lighten(10%),
      radius: 12pt,
      inset: (x: 0.8em, y: 1em),
      {
        align(center)[
          #text(fill: tp-white.transparentize(50%), weight: "black", size: 1.8em)[02]
          #v(0.3em)
          #text(fill: tp-white, weight: "bold", size: 0.95em)[Design & Build]
          #v(0.2em)
          #text(fill: tp-white.transparentize(20%), size: 0.7em)[Custom solution\ndevelopment]
        ]
      },
    ),
    text(fill: tp-muted, size: 1.5em)[→],

    // Step 3
    block(
      width: 100%,
      fill: tp-purple,
      radius: 12pt,
      inset: (x: 0.8em, y: 1em),
      {
        align(center)[
          #text(fill: tp-white.transparentize(50%), weight: "black", size: 1.8em)[03]
          #v(0.3em)
          #text(fill: tp-white, weight: "bold", size: 0.95em)[Pilot Run]
          #v(0.2em)
          #text(fill: tp-white.transparentize(20%), size: 0.7em)[Testing &\nfeedback cycle]
        ]
      },
    ),
    text(fill: tp-muted, size: 1.5em)[→],

    // Step 4
    block(
      width: 100%,
      fill: tp-green,
      radius: 12pt,
      inset: (x: 0.8em, y: 1em),
      {
        align(center)[
          #text(fill: tp-white.transparentize(50%), weight: "black", size: 1.8em)[04]
          #v(0.3em)
          #text(fill: tp-white, weight: "bold", size: 0.95em)[Full Launch]
          #v(0.2em)
          #text(fill: tp-white.transparentize(20%), size: 0.7em)[Organization-wide\nrollout]
        ]
      },
    ),
  )

  #v(0.8em)

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    column-gutter: 0.6em,

    tp-card()[
      #tp-check-item[On-site visit & interviews]
      #v(0.1em)
      #tp-check-item[Data collection & analysis]
    ],
    tp-card()[
      #tp-check-item[Prototype development]
      #v(0.1em)
      #tp-check-item[Mid-review & iteration]
    ],
    tp-card()[
      #tp-check-item[User training sessions]
      #v(0.1em)
      #tp-check-item[Feedback & refinement]
    ],
    tp-card()[
      #tp-check-item[Stabilization monitoring]
      #v(0.1em)
      #tp-check-item[Maintenance framework]
    ],
  )
]

// ─────────────────────────────────────────────
// 11. SWOT Analysis
// ─────────────────────────────────────────────

#content-slide(
  section-num: "08",
  section-title: "Differentiation",
  section-subtitle: "DIFFERENTIATION",
)[
  #set text(size: 0.9em)
  #text(size: 1.1em, weight: "bold", fill: tp-dark)[
    #box(width: 4pt, height: 1em, fill: tp-blue, baseline: 20%)
    #h(8pt)
    SWOT Analysis
  ]
  #v(0.4em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 0.5em,
    row-gutter: 0.5em,

    block(
      width: 100%,
      fill: tp-blue.lighten(92%),
      radius: (top-left: 12pt, rest: 4pt),
      stroke: 1pt + tp-blue.lighten(70%),
      inset: (x: 0.8em, y: 0.6em),
      {
        text(weight: "bold", fill: tp-blue, size: 0.95em)[S — Strengths]
        v(0.2em)
        set text(size: 0.8em, fill: tp-body)
        tp-check-item(color: tp-blue)[Strength 1 — Core competency]
        v(0.08em)
        tp-check-item(color: tp-blue)[Strength 2 — Technical advantage]
      },
    ),

    block(
      width: 100%,
      fill: tp-red.lighten(93%),
      radius: (top-right: 12pt, rest: 4pt),
      stroke: 1pt + tp-red.lighten(70%),
      inset: (x: 0.8em, y: 0.6em),
      {
        text(weight: "bold", fill: tp-red, size: 0.95em)[W — Weaknesses]
        v(0.2em)
        set text(size: 0.8em, fill: tp-body)
        tp-check-item(color: tp-red)[Weakness 1 — Area for improvement]
        v(0.08em)
        tp-check-item(color: tp-red)[Weakness 2 — Mitigation plan]
      },
    ),

    block(
      width: 100%,
      fill: tp-green.lighten(92%),
      radius: (bottom-left: 12pt, rest: 4pt),
      stroke: 1pt + tp-green.lighten(70%),
      inset: (x: 0.8em, y: 0.6em),
      {
        text(weight: "bold", fill: tp-green, size: 0.95em)[O — Opportunities]
        v(0.2em)
        set text(size: 0.8em, fill: tp-body)
        tp-check-item(color: tp-green)[Opportunity 1 — Market trend]
        v(0.08em)
        tp-check-item(color: tp-green)[Opportunity 2 — Growth potential]
      },
    ),

    block(
      width: 100%,
      fill: tp-orange.lighten(90%),
      radius: (bottom-right: 12pt, rest: 4pt),
      stroke: 1pt + tp-orange.lighten(70%),
      inset: (x: 0.8em, y: 0.6em),
      {
        text(weight: "bold", fill: tp-orange, size: 0.95em)[T — Threats]
        v(0.2em)
        set text(size: 0.8em, fill: tp-body)
        tp-check-item(color: tp-orange)[Threat 1 — Competitive landscape]
        v(0.08em)
        tp-check-item(color: tp-orange)[Threat 2 — External risks]
      },
    ),
  )
]

// ─────────────────────────────────────────────
// 12. Testimonial / Quote
// ─────────────────────────────────────────────

#content-slide(
  section-num: "08",
  section-title: "Differentiation",
  section-subtitle: "DIFFERENTIATION",
)[
  #v(1.5em)
  #align(center)[
    #block(width: 80%)[
      #align(center)[
        #text(size: 3em, fill: tp-blue.lighten(60%))[\u{201C}]
        #v(0.3em)
        #text(size: 1.3em, weight: "bold", fill: tp-dark)[
          Place a client testimonial or project outcome here\
          to build trust and credibility.
        ]
        #v(0.3em)
        #text(size: 3em, fill: tp-blue.lighten(60%))[\u{201D}]
      ]
      #v(1.2em)
      #line(length: 40pt, stroke: 2pt + tp-blue)
      #v(0.8em)
      #text(weight: "bold", fill: tp-dark)[Contact Name] #h(6pt)
      #text(fill: tp-muted)[|] #h(6pt)
      #text(fill: tp-body)[Title / Department] #h(6pt)
      #text(fill: tp-muted)[|] #h(6pt)
      #text(fill: tp-body)[Organization Name]
    ]
  ]
]

// ─────────────────────────────────────────────
// 13. Image + Description (image left)
// ─────────────────────────────────────────────

#content-slide(
  section-num: "03",
  section-title: "Solution Overview",
  section-subtitle: "SOLUTION OVERVIEW",
)[
  #grid(
    columns: (1.1fr, 1fr),
    column-gutter: 2em,
    align: horizon,

    // Left: image placeholder
    block(
      width: 100%,
      fill: tp-surface,
      radius: 12pt,
      stroke: 1pt + tp-border,
      inset: (x: 1em, y: 2.5em),
      align(center)[
        #block(
          width: 60pt,
          height: 60pt,
          fill: tp-blue.lighten(80%),
          radius: 30pt,
          align(center + horizon, text(size: 2em, fill: tp-blue)[🖼])
        )
        #v(0.8em)
        #text(size: 0.85em, fill: tp-muted, weight: "medium")[Image or Screenshot]
        #v(0.2em)
        #text(size: 0.7em, fill: tp-muted)[`image("path/to/image.png")`]
      ],
    ),

    // Right: description
    {
      text(weight: "bold", size: 1.2em, fill: tp-dark)[Key Screen Overview]
      v(0.3em)
      text(fill: tp-body, size: 0.9em)[
        Place a product screenshot or diagram on the left, and write the key description in this area.
      ]
      v(0.8em)

      tp-check-item[Detail explanation for Feature A]
      v(0.2em)
      tp-check-item[Detail explanation for Feature B]
      v(0.2em)
      tp-check-item[Detail explanation for Feature C]

      v(0.8em)
      tp-badge("Key Screen", color: tp-blue)
      h(0.5em)
      tp-badge("User Friendly", color: tp-green)
    },
  )
]

// ─────────────────────────────────────────────
// 14. Image + Description (image right)
// ─────────────────────────────────────────────

#content-slide(
  section-num: "03",
  section-title: "Solution Overview",
  section-subtitle: "SOLUTION OVERVIEW",
)[
  #set text(size: 0.9em)
  #grid(
    columns: (1fr, 1.1fr),
    column-gutter: 1.5em,
    align: horizon,

    // Left: description
    {
      text(weight: "bold", size: 1.15em, fill: tp-dark)[System Architecture]
      v(0.3em)
      text(fill: tp-body, size: 0.85em)[
        Place an architecture diagram on the right, and describe the key components here.
      ]
      v(0.6em)

      tp-card(title: "Frontend")[
        #text(size: 0.8em)[User interface & dashboard]
      ]
      v(0.3em)
      tp-card(title: "Backend / API")[
        #text(size: 0.8em)[Data processing & business logic]
      ]
      v(0.3em)
      tp-card(title: "Infrastructure")[
        #text(size: 0.8em)[Cloud environment & security]
      ]
    },

    // Right: image placeholder
    block(
      width: 100%,
      fill: tp-surface,
      radius: 12pt,
      stroke: 1pt + tp-border,
      inset: (x: 1em, y: 2em),
      align(center)[
        #block(
          width: 50pt,
          height: 50pt,
          fill: tp-purple.lighten(80%),
          radius: 25pt,
          align(center + horizon, text(size: 1.6em, fill: tp-purple)[📊])
        )
        #v(0.6em)
        #text(size: 0.8em, fill: tp-muted, weight: "medium")[Diagram or Architecture]
        #v(0.15em)
        #text(size: 0.65em, fill: tp-muted)[`image("path/to/diagram.png")`]
      ],
    ),
  )
]

// ─────────────────────────────────────────────
// 15. Closing
// ─────────────────────────────────────────────

#closing-slide(
  quote: "\"Your key closing message",
  quote-accent: "goes right here.\"",
  description: "Summarize the project value and expected outcomes once more. We look forward to building a successful project together.",
  contacts: (
    (icon: "👤", label: "Project Manager", value: "Your Name"),
    (icon: "✉", label: "Email Address", value: "name@example.com"),
    (icon: "📞", label: "Phone Number", value: "+1-000-000-0000"),
  ),
  copyright: "Copyright © Your Company 2026. All Rights Reserved.",
)

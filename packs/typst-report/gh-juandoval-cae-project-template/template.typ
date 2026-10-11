// =============================================================================
// CAE PROJECT DOCUMENT TEMPLATE
// From Proposal → Tracking → Final Deliverable
// =============================================================================

#let project-info = (
  client: "Client Name",
  project: "Project Title", 
  project-id: "PRJ-001",
  author: "Juan Ignacio Doval Roque",
  date: "January 2025",
  version: "v1.0",
  status: "Proposal", // Proposal | In Progress | Review | Complete
)

// Check #check(done: true)

// =============================================================================
// STYLING
// =============================================================================

#set page(
  paper: "a4",
  margin: (top: 25mm, bottom: 20mm, left: 20mm, right: 20mm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 9pt, fill: luma(100))
      #project-info.project-id — #project-info.project
      #h(1fr)
      #project-info.version
    ]
  },
  footer: context {
    set text(size: 9pt, fill: luma(100))
    line(length: 100%, stroke: 0.5pt + luma(200))
    v(2mm)
    [#project-info.author]
    h(1fr)
    [Page #counter(page).display("1 / 1", both: true)]
  }
)

#set text(font: "New Computer Modern", size: 10.5pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#show heading.where(level: 1): it => {
  v(4mm)
  block(
    width: 100%,
    below: 3mm,
    stroke: (bottom: 1.5pt + rgb("#2c3e50")),
    inset: (bottom: 2mm),
    text(size: 14pt, weight: "bold", fill: rgb("#2c3e50"), it.body)
  )
}

#show heading.where(level: 2): it => {
  v(2mm)
  text(size: 11pt, weight: "bold", fill: rgb("#34495e"), it.body)
  v(1mm)
}

// Custom components
#let info-box(title, content) = {
  block(
    width: 100%,
    fill: rgb("#f8f9fa"),
    stroke: 0.5pt + rgb("#dee2e6"),
    radius: 3pt,
    inset: 10pt,
    [
      #text(weight: "bold", size: 9pt, fill: rgb("#495057"))[#title]
      #v(2mm)
      #content
    ]
  )
}

#let status-badge(status) = {
  let color = if status == "Proposal" { rgb("#3498db") }
    else if status == "In Progress" { rgb("#f39c12") }
    else if status == "Review" { rgb("#9b59b6") }
    else { rgb("#27ae60") }
  box(
    fill: color,
    radius: 2pt,
    inset: (x: 6pt, y: 2pt),
    text(size: 8pt, weight: "bold", fill: white, status)
  )
}

#let kpi-table(data) = {
  table(
    columns: (1fr,) + (auto,) * (data.first().len() - 1),
    stroke: 0.5pt + luma(200),
    fill: (x, y) => if y == 0 { rgb("#2c3e50") } else if calc.odd(y) { rgb("#f8f9fa") } else { white },
    align: (x, y) => if x == 0 { left } else { center },
    ..data.flatten().enumerate().map(((i, cell)) => {
      if calc.div-euclid(i, data.first().len()) == 0 {
        text(fill: white, weight: "bold", size: 9pt, cell)
      } else {
        text(size: 9pt, cell)
      }
    })
  )
}

#let check(done: false) = if done { text(fill: rgb("#27ae60"), "✓") } else { text(fill: luma(180), "○") }

// =============================================================================
// COVER PAGE
// =============================================================================

#align(center)[
  #v(20mm)
  
  #block(
    width: 80%,
    stroke: (bottom: 3pt + rgb("#2c3e50")),
    inset: (bottom: 8mm),
    [
      #text(size: 11pt, fill: luma(100), tracking: 2pt, weight: "medium")[SIMULATION PROJECT]
      #v(3mm)
      #text(size: 24pt, weight: "bold", fill: rgb("#2c3e50"))[#project-info.project]
    ]
  )
  
  #v(15mm)
  
  #status-badge(project-info.status)
  
  #v(20mm)
  
  #grid(
    columns: (1fr, 1fr),
    gutter: 15mm,
    info-box("Client")[
      #text(size: 11pt)[#project-info.client]
    ],
    info-box("Project ID")[
      #text(size: 11pt, font: "Fira Code")[#project-info.project-id]
    ]
  )
  
  #v(10mm)
  
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 10mm,
    info-box("Author")[#project-info.author],
    info-box("Date")[#project-info.date],
    info-box("Version")[#project-info.version]
  )
  
  #v(1fr)
  
  #block(
    width: 100%,
    fill: rgb("#f8f9fa"),
    inset: 12pt,
    radius: 3pt,
    [
      #set text(size: 9pt, fill: luma(80))
      #set par(justify: false)
      *Confidentiality Notice:* This document contains proprietary simulation methodology and results. 
      Distribution without written consent is prohibited.
    ]
  )
]

// =============================================================================
// PAGE 1: PROPOSAL
// =============================================================================

#pagebreak()

= Simulation Proposal

== Problem Statement

#info-box("Define the Engineering Problem")[
  #v(2mm)
  _What physical system is being analyzed?_
  #v(8mm)
  
  _What decision will this simulation support?_
  #v(8mm)
  
  _What is explicitly out of scope?_
  #v(8mm)
]

== Objectives

#table(
  columns: (auto, 1fr, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  align: (center, left, center),
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[ID],
    text(fill: white, weight: "bold", size: 9pt)[Objective],
    text(fill: white, weight: "bold", size: 9pt)[Measurable Target],
  ),
  [O1], [], [],
  [O2], [], [],
  [O3], [], [],
)

== Deliverables

#table(
  columns: (auto, 1fr, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Item],
    text(fill: white, weight: "bold", size: 9pt)[Description],
    text(fill: white, weight: "bold", size: 9pt)[Format],
  ),
  [Geometry Variants], [Number of configurations: ], [STEP / Parasolid],
  [Simulation Results], [Metrics: ], [CSV / Excel],
  [Visualization], [Contours: ], [PNG / MP4],
  [Report], [This document with results], [PDF],
)

== Modeling Approach

#grid(
  columns: (1fr, 1fr),
  gutter: 10mm,
  [
    #info-box("Physics")[
      - *Regime:* Steady / Transient
      - *Turbulence:* k-ω SST / k-ε / Laminar
      - *Compressibility:* Incompressible / Compressible
      - *Energy:* Isothermal / Conjugate Heat Transfer
      - *Multiphase:* No / VOF / DPM
    ]
  ],
  [
    #info-box("Domain")[
      - *Dimensionality:* 2D / 3D
      - *Symmetry:* None / Half / Quarter
      - *Mesh Type:* Poly-Hexcore / Tetrahedral
      - *Target y⁺:* 
      - *Approx. Cell Count:* 
    ]
  ]
)

#v(5em)

== Assumptions & Limitations

#grid(
  columns: (1fr, 1fr),
  gutter: 5mm,
  [
    #info-box("Assumptions")[
      + 
      + 
      + 
    ]
  ],
  [
    #info-box("Limitations")[
      - Not suitable for certification
      - Not a substitute for testing
      - Expected accuracy: ±X% on key metrics
    ]
  ]
)

== Schedule & Acceptance

#grid(
  columns: (1fr, 1fr),
  gutter: 5mm,
  [
    #info-box("Timeline")[
      #table(
        columns: (1fr, auto),
        stroke: none,
        [Kickoff:], [],
        [First Results:], [],
        [Draft Report:], [],
        [Final Delivery:], [],
      )
    ]
  ],
  [
    #info-box("Acceptance Criteria")[
      #check() All runs converged (residuals < 1e-5)
      
      #check() Mesh independence verified
      
      #check() Results reviewed with client
      
      #check() Final report delivered
    ]
  ]
)

// =============================================================================
// PAGE 2: TRACEABILITY
// =============================================================================

#pagebreak()

= Project Traceability

== Version History

#table(
  columns: (auto, auto, 1fr, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else if calc.odd(y) { rgb("#f8f9fa") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Version],
    text(fill: white, weight: "bold", size: 9pt)[Date],
    text(fill: white, weight: "bold", size: 9pt)[Changes],
    text(fill: white, weight: "bold", size: 9pt)[Author],
  ),
  [v1.0], [], [Initial proposal], [JDR],
  [v1.1], [], [], [],
  [v2.0], [], [], [],
)

== Decision Log

#block(
  width: 100%,
  fill: rgb("#fff3cd"),
  stroke: 0.5pt + rgb("#ffc107"),
  radius: 3pt,
  inset: 8pt,
  text(size: 9pt)[*Purpose:* Record all modeling decisions with rationale for future reference and client transparency.]
)

#v(3mm)

#table(
  columns: (auto, auto, 1fr, 1fr, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[ID],
    text(fill: white, weight: "bold", size: 9pt)[Date],
    text(fill: white, weight: "bold", size: 9pt)[Decision],
    text(fill: white, weight: "bold", size: 9pt)[Rationale],
    text(fill: white, weight: "bold", size: 9pt)[Impact],
  ),
  [D1], [], [Turbulence model: k-ω SST], [Industry standard for separated flows], [Medium],
  [D2], [], [], [], [],
  [D3], [], [], [], [],
  [D4], [], [], [], [],
  [D5], [], [], [], [],
)

== Issue Tracker

#table(
  columns: (auto, auto, 1fr, auto, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[ID],
    text(fill: white, weight: "bold", size: 9pt)[Date],
    text(fill: white, weight: "bold", size: 9pt)[Issue],
    text(fill: white, weight: "bold", size: 9pt)[Resolution],
    text(fill: white, weight: "bold", size: 9pt)[Status],
  ),
  [I1], [], [], [], [Open / Closed],
  [I2], [], [], [], [],
)

== Client Communication Log

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Date],
    text(fill: white, weight: "bold", size: 9pt)[Type],
    text(fill: white, weight: "bold", size: 9pt)[Summary / Action Items],
  ),
  [], [Email / Call / Meeting], [],
  [], [], [],
  [], [], [],
)

// =============================================================================
// PAGE 3: MODEL DEFINITION
// =============================================================================

#pagebreak()

= Model Definition

== Geometry

#grid(
  columns: (1fr, 1fr),
  gutter: 5mm,
  [
    #info-box("Source & Processing")[
      - *Source:* Client CAD / Parametric / Public
      - *Original Format:* 
      - *Defeaturing:* 
      - *Simplifications:* 
    ]
  ],
  [
    #info-box("Key Dimensions")[
      #table(
        columns: (1fr, auto),
        stroke: none,
        row-gutter: 2pt,
        [Characteristic Length:], [],
        [Inlet Diameter:], [],
        [Domain Extent:], [],
      )
    ]
  ]
)

#v(3mm)

#block(
  width: 100%,
  height: 50mm,
  stroke: 1pt + luma(200),
  radius: 3pt,
  inset: 5mm,
  align(center + horizon)[
    #text(fill: luma(150), size: 10pt)[_Insert geometry image / schematic here_]
  ]
)

== Mesh

#table(
  columns: (1fr, 1fr, 1fr),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Parameter],
    text(fill: white, weight: "bold", size: 9pt)[Value],
    text(fill: white, weight: "bold", size: 9pt)[Notes],
  ),
  [Element Type], [], [Poly-Hexcore / Tet / Hex],
  [Total Cell Count], [], [],
  [Inflation Layers], [], [],
  [First Layer Height], [], [For target y⁺],
  [Growth Rate], [], [Typically 1.2],
  [Surface Mesh Size], [], [Min / Max],
)

#v(3mm)

#grid(
  columns: (1fr, 1fr),
  gutter: 10mm,
  block(
    width: 100%,
    height: 40mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_Mesh overview_]
    ]
  ),
  block(
    width: 100%,
    height: 40mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_Boundary layer detail_]
    ]
  )
)

#v(25mm)

== Physics Setup

#table(
  columns: (auto, 1fr, 1fr),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Category],
    text(fill: white, weight: "bold", size: 9pt)[Setting],
    text(fill: white, weight: "bold", size: 9pt)[Value / Choice],
  ),
  [Solver], [Software], [],
  [], [Precision], [Double / Single],
  [], [Solver Type], [Pressure-Based / Density-Based],
  [Flow], [Regime], [Steady / Transient],
  [], [Turbulence Model], [],
  [], [Near-Wall Treatment], [Enhanced / Standard],
  [Fluid], [Material], [],
  [], [Density], [],
  [], [Viscosity], [],
  [Energy], [Equation], [On / Off],
  [], [Thermal BC], [],
)

== Boundary Conditions

#table(
  columns: (auto, auto, auto, 1fr),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Boundary],
    text(fill: white, weight: "bold", size: 9pt)[Type],
    text(fill: white, weight: "bold", size: 9pt)[Value],
    text(fill: white, weight: "bold", size: 9pt)[Notes],
  ),
  [Inlet], [Velocity / Mass Flow], [], [],
  [Outlet], [Pressure], [], [],
  [Walls], [No-Slip], [—], [],
  [Symmetry], [Symmetry], [—], [],
)

// =============================================================================
// PAGE 4: VERIFICATION & CONVERGENCE
// =============================================================================

#pagebreak()

= Verification & Convergence

== Residual Convergence

#table(
  columns: (1fr, auto, auto, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Equation],
    text(fill: white, weight: "bold", size: 9pt)[Target],
    text(fill: white, weight: "bold", size: 9pt)[Achieved],
    text(fill: white, weight: "bold", size: 9pt)[Status],
  ),
  [Continuity], [1e-5], [], [#check() / #check(done: false)],
  [X-Momentum], [1e-5], [], [],
  [Y-Momentum], [1e-5], [], [],
  [Z-Momentum], [1e-5], [], [],
  [Energy], [1e-6], [], [],
  [Turbulence (k)], [1e-5], [], [],
  [Turbulence (ω/ε)], [1e-5], [], [],
)

#v(3mm)

#block(
  width: 100%,
  height: 45mm,
  stroke: 1pt + luma(200),
  radius: 3pt,
  align(center + horizon)[
    #text(fill: luma(150), size: 9pt)[_Residual plot_]
  ]
)

== Monitor Convergence

// #info-box("Monitored Quantities")[
//   #table(
//     columns: (1fr, auto, auto, auto),
//     stroke: none,
//     [*Quantity*], [*Location*], [*Final Value*], [*Variation (last 100 iter)*],
//     [], [], [], [],
//     [], [], [], [],
//     [], [], [], [],
//   )
// ]

  #table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt + luma(200),
    fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
    table.header(
      text(fill: white, weight: "bold", size: 9pt)[Quantity],
      text(fill: white, weight: "bold", size: 9pt)[Location],
      text(fill: white, weight: "bold", size: 9pt)[Final Value],
      text(fill: white, weight: "bold", size: 9pt)[Variation (last 100 iter)],
    ),
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
  )

== Mesh Independence Study

#table(
  columns: (auto, auto, auto, auto, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else if y == 3 { rgb("#d4edda") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Mesh],
    text(fill: white, weight: "bold", size: 9pt)[Cells],
    text(fill: white, weight: "bold", size: 9pt)[Key Metric],
    text(fill: white, weight: "bold", size: 9pt)[Δ from Fine],
    text(fill: white, weight: "bold", size: 9pt)[Selected],
  ),
  [Coarse], [], [], [], [],
  [Medium], [], [], [], [],
  [Fine], [], [—], [—], [✓],
)

#v(3mm)

#info-box("Grid Convergence Index (GCI)")[
  - Refinement ratio (r): 
  - Order of convergence (p): 
  - GCI: % (target < 5%)
]

#v(20mm)

== y⁺ Verification

#grid(
  columns: (1fr, 1fr),
  gutter: 10mm,
  [
    #table(
      columns: (1fr, auto),
      stroke: 0.5pt + luma(200),
      fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
      table.header(
        text(fill: white, weight: "bold", size: 9pt)[Surface],
        text(fill: white, weight: "bold", size: 9pt)[y⁺ (avg / max)],
      ),
      [Wall 1], [],
      [Wall 2], [],
    )
  ],
  block(
    width: 100%,
    height: 35mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_y⁺ contour_]
    ]
  )
)

// =============================================================================
// PAGE 5: RESULTS
// =============================================================================

#pagebreak()

= Results

== Key Performance Indicators

#table(
  columns: (1fr, auto, auto, auto, auto, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Metric],
    text(fill: white, weight: "bold", size: 9pt)[Unit],
    text(fill: white, weight: "bold", size: 9pt)[Baseline],
    text(fill: white, weight: "bold", size: 9pt)[Case 1],
    text(fill: white, weight: "bold", size: 9pt)[Case 2],
    text(fill: white, weight: "bold", size: 9pt)[Case 3],
  ),
  [Pressure Drop (Δp)], [Pa], [], [], [], [],
  [Mass Flow Rate], [kg/s], [], [], [], [],
  [Max Temperature], [°C], [], [], [], [],
  [Uniformity Index], [—], [], [], [], [],
)

== Visualization

#grid(
  columns: (1fr, 1fr),
  gutter: 8mm,
  row-gutter: 8mm,
  block(
    width: 100%,
    height: 50mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_Velocity contour_]
    ]
  ),
  block(
    width: 100%,
    height: 50mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_Pressure contour_]
    ]
  ),
  block(
    width: 100%,
    height: 50mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_Streamlines_]
    ]
  ),
  block(
    width: 100%,
    height: 50mm,
    stroke: 1pt + luma(200),
    radius: 3pt,
    align(center + horizon)[
      #text(fill: luma(150), size: 9pt)[_Temperature / Other_]
    ]
  ),
)

== Observations

#info-box("Key Findings")[
  + 
  + 
  + 
]

// =============================================================================
// PAGE 6: INTERPRETATION & RECOMMENDATION
// =============================================================================

#pagebreak()

= Engineering Interpretation

== Analysis

#info-box("What the Results Mean")[
  _Explain in plain engineering language:_
  
  #v(5mm)
  
  *Dominant Physics:*
  
  #v(8mm)
  
  *Why Design X Outperforms Design Y:*
  
  #v(8mm)
  
  *Sensitivity:*
  
  #v(8mm)
]

== Recommendation

#block(
  width: 100%,
  fill: rgb("#d4edda"),
  stroke: 1pt + rgb("#28a745"),
  radius: 3pt,
  inset: 12pt,
  [
    #text(weight: "bold", size: 11pt)[Recommended Configuration]
    #v(3mm)
    
    *Design:* 
    
    *Expected Improvement:* 
    
    *Confidence Level:* High / Medium / Low
    
    *Key Trade-offs:*
  ]
)

== Risks & Uncertainties

#table(
  columns: (1fr, auto, 1fr),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Risk],
    text(fill: white, weight: "bold", size: 9pt)[Likelihood],
    text(fill: white, weight: "bold", size: 9pt)[Mitigation],
  ),
  [], [Low / Med / High], [],
  [], [], [],
)

== Next Steps

#info-box("Recommended Follow-On Actions")[
  #check(done: false) 
  
  #check(done: false) 
  
  #check(done: false) 
  
  #check(done: false) Experimental validation if required
]

// =============================================================================
// APPENDIX
// =============================================================================

#pagebreak()

= Appendix

== A. Solver Settings

#table(
  columns: (1fr, 1fr),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Parameter],
    text(fill: white, weight: "bold", size: 9pt)[Value],
  ),
  [Pressure-Velocity Coupling], [SIMPLE / SIMPLEC / Coupled],
  [Spatial Discretization (Pressure)], [Second Order],
  [Spatial Discretization (Momentum)], [Second Order Upwind],
  [Spatial Discretization (Turbulence)], [Second Order Upwind],
  [Under-Relaxation (Pressure)], [],
  [Under-Relaxation (Momentum)], [],
  [Time Step (if transient)], [],
  [Number of Iterations], [],
)

== B. File Traceability

#block(
  width: 100%,
  fill: rgb("#fff3cd"),
  stroke: 0.5pt + rgb("#ffc107"),
  radius: 3pt,
  inset: 8pt,
  text(size: 9pt)[*Purpose:* Enable exact reproduction of results. Store files with version control (Git) or archive with hashes.]
)

#v(3mm)

#table(
  columns: (auto, 1fr, auto),
  stroke: 0.5pt + luma(200),
  fill: (x, y) => if y == 0 { rgb("#2c3e50") } else { white },
  table.header(
    text(fill: white, weight: "bold", size: 9pt)[Type],
    text(fill: white, weight: "bold", size: 9pt)[Filename],
    text(fill: white, weight: "bold", size: 9pt)[Hash / Commit],
  ),
  [Geometry], [], [],
  [Mesh], [], [],
  [Case File], [], [],
  [Results], [], [],
  [Post-Processing Script], [], [],
)

== C. Reference Standards

- ASME V&V 20-2009: Standard for Verification and Validation in CFD
- AIAA G-077-1998: Guide for Verification and Validation of CFD Simulations
- ISO 9001: Quality Management Systems

== D. Notes

#block(
  width: 100%,
  height: 60mm,
  stroke: 1pt + luma(200),
  radius: 3pt,
  inset: 5mm,
  [
    #text(fill: luma(150), size: 9pt)[_Technical notes, observations, lessons learned_]
  ]
)

#v(1fr)

// #align(center)[
//   #line(length: 40%, stroke: 0.5pt + luma(200))
//   #v(2mm)
//   #text(size: 9pt, fill: luma(120))[End of Document]
// ]

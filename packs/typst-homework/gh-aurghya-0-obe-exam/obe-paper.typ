// OBE Question Paper Typst Package / Template
// Outcome-Based Education (OBE) Standard Format for College/University Level Examinations
// Supports Dual Modes: "exam" (Raw Unboxed Student Question Paper) vs "internal" (IQAC / Audit / OBE Copy)

// Global state tracking the active paper mode ("internal" or "exam")
#let obe-mode-state = state("obe-mode", "internal")

// Plain text formatting for Bloom taxonomy levels
#let bloom-text(level) = {
  text(weight: "bold", size: 8.5pt)[#level]
}

// Plain text formatting for Course Outcomes
#let co-text(co) = {
  text(weight: "bold", size: 8.5pt)[#co]
}

// Legacy aliases
#let bloom-badge = bloom-text
#let co-badge = co-text

// Main obe-paper template function
#let obe-paper(
  mode: "internal", // Options: "exam" (Raw Student Question Paper) or "internal" (Full Audit & OBE Copy)
  institution: "NAME OF THE INSTITUTION / UNIVERSITY",
  sub-institution: "Affiliated to State University | Accredited with Grade 'A'",
  department: "DEPARTMENT OF COMPUTER SCIENCE & ENGINEERING",
  exam-title: "END SEMESTER EXAMINATION",
  session: "ACADEMIC SESSION 2025-2026",
  degree: "Bachelor of Technology / MCA",
  semester: "Semester IV",
  course-code: "CS301",
  course-name: "DATABASE MANAGEMENT SYSTEMS",
  time-allowed: "3 Hours",
  max-marks: 80,
  date: none,
  logo: none,
  show-co-table: auto, // auto = true in internal mode, false in exam mode
  co-list: (),
  instructions: (),
  doc
) = {
  // Update global mode state
  obe-mode-state.update(mode)

  let is-exam-mode = (mode == "exam")
  let display-co-table = if show-co-table == auto { not is-exam-mode } else { show-co-table }

  let default-instructions = if is-exam-mode {
    (
      "Part A is compulsory. Answer ALL questions.",
      "Part B contains internal choice questions (Answer EITHER (a) OR (b)).",
      "Part C contains comprehensive design/analytical questions.",
      "Figures to the right indicate full marks.",
    )
  } else {
    (
      "Part A is compulsory. Answer ALL questions.",
      "Part B contains internal choice questions (Answer EITHER (a) OR (b)).",
      "Part C contains comprehensive design/analytical questions.",
      "Figures to the right indicate full marks, Course Outcome (CO), and Bloom's Taxonomy Level (BL).",
      "BL Codes: K1=Remember, K2=Understand, K3=Apply, K4=Analyze, K5=Evaluate, K6=Create.",
    )
  }

  let active-instructions = if instructions.len() > 0 { instructions } else { default-instructions }

  // Page setup - Optimized margins for physical print copies
  set page(
    paper: "a4",
    margin: (x: 1.6cm, top: 1.6cm, bottom: 1.8cm),
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 [
        #set text(size: 8.5pt, fill: luma(80), font: ("DejaVu Serif", "Nimbus Roman"))
        #grid(
          columns: (1fr, auto),
          gutter: 10pt,
          align: (left + bottom, right + bottom),
          [#course-code: #course-name],
          [Page #counter(page).display("1 of 1", both: true)]
        )
        #v(-2pt)
        #line(length: 100%, stroke: 0.5pt + luma(100))
      ]
    },
    footer: context {
      let page-num = counter(page).get().first()
      let total-pages = counter(page).final().first()
      let is-last-page = (page-num == total-pages)
      set text(size: 8pt, fill: luma(100), font: ("DejaVu Serif", "Nimbus Roman"))
      align(center)[
        #if is-exam-mode {
          if is-last-page [
            *END OF QUESTION PAPER*
          ]
        } else [
          *Outcome-Based Education (OBE) Compliant Question Paper (Internal Audit Copy)*
        ]
      ]
    }
  )

  set text(font: ("DejaVu Serif", "Nimbus Roman"), size: 10pt, lang: "en")
  set par(justify: true, leading: 0.55em)
  set enum(indent: 0pt, numbering: "(a)", spacing: 0.55em)

  // --- REFINED & TIGHT TYPOGRAPHIC HEADER & COURSE TITLE SECTION ---
  align(center)[
    #set par(leading: 0.3em)
    #if logo != none [
      #logo
      #v(1pt)
    ]
    #text(size: 13pt, weight: "bold", tracking: 0.3pt)[#institution] \
    #if sub-institution != "" [
      #text(size: 8.5pt, style: "italic")[#sub-institution] \
    ]
    #v(1pt)
    #text(size: 9.5pt)[#department] \
    #if is-exam-mode [
      #text(size: 10pt)[#exam-title #if session != "" [--- #session]] \
      #text(size: 9.5pt)[#degree (#semester)] \
      #v(1.5pt)
      #text(size: 11pt, weight: "bold")[#course-code: #course-name]
    ] else [
      #rect(width: 100%, fill: luma(248), radius: 2pt, inset: (x: 8pt, y: 4.5pt), stroke: 0.8pt + luma(80))[
        #text(size: 10pt, weight: "bold")[#exam-title #if session != "" [--- #session]]
      ] \
      #text(size: 9.5pt)[#degree (#semester)] \
      #v(1.5pt)
      #text(size: 11pt, weight: "bold")[#course-code: #course-name]
    ]
  ]

  v(2pt)

  // --- BALANCED 2-COLUMN METADATA GRID (Compact Line Spacing) ---
  grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    align: (left + horizon, right + horizon),
    [
      #set text(size: 9pt)
      #set par(leading: 0.3em)
      Date of Exam: #if date != none { date } else { "____________" } \
      Duration: #time-allowed
    ],
    [
      #set text(size: 9pt)
      #set par(leading: 0.3em)
      Maximum Marks: *#max-marks Marks* \
      Course Code: #course-code
    ]
  )

  v(2pt)
  line(length: 100%, stroke: 1.2pt + black)

  // --- COURSE OUTCOMES SPECIFICATION MATRIX (Only in Internal Mode) ---
  if display-co-table and co-list.len() > 0 [
    #v(3pt)
    #block(
      width: 100%,
      fill: luma(252),
      stroke: 0.5pt + luma(120),
      inset: 6.5pt,
      radius: 2pt
    )[
      #text(size: 8.5pt, weight: "bold")[COURSE OUTCOMES (COs) SPECIFICATION]
      #v(2.5pt)
      #table(
        columns: (42pt, 1fr, 75pt),
        align: (center + horizon, left + horizon, center + horizon),
        stroke: 0.4pt + luma(140),
        fill: (col, row) => if row == 0 { luma(235) } else { none },
        inset: (x: 5pt, y: 3.5pt),
        table.header(
          [*CO No.*], [*Course Outcome Statement*], [*Taxonomy Level*]
        ),
        ..co-list.map(co => (
          [*#co.id*],
          text(size: 8.5pt)[#co.text],
          if "bloom" in co { bloom-text(co.bloom) } else { "-" }
        )).flatten()
      )
    ]
  ]

  // --- GENERAL INSTRUCTIONS ---
  if active-instructions.len() > 0 [
    #v(3pt)
    #if is-exam-mode [
      #set text(size: 8.5pt)
      *Instructions:*
      #list(
        tight: true,
        ..active-instructions.map(ins => ins)
      )
    ] else [
      #block(
        width: 100%,
        fill: luma(253),
        stroke: 0.5pt + luma(120),
        inset: (x: 8pt, y: 4.5pt),
        radius: 2pt
      )[
        #text(size: 8.5pt)[
          *General Instructions:*
          #list(
            tight: true,
            ..active-instructions.map(ins => ins)
          )
        ]
      ]
    ]
  ]

  v(4pt)

  // Render document body (questions)
  doc
}

// Print-Optimized Section Header Function
#let obe-section(title, description: "", total-marks: none) = {
  v(8pt)
  context {
    let is-exam = (obe-mode-state.get() == "exam")
    if is-exam [
      #grid(
        columns: (1fr, auto),
        align: (left + bottom, right + bottom),
        text(fill: black, weight: "bold", size: 10pt)[#title],
        if total-marks != none [
          #text(fill: black, weight: "bold", size: 9.5pt)[Max Marks: #total-marks]
        ]
      )
      #v(-3pt)
      #line(length: 100%, stroke: 0.8pt + black)
    ] else [
      #rect(
        width: 100%,
        fill: luma(240),
        stroke: (top: 1pt + black, bottom: 1pt + black, left: none, right: none),
        inset: (x: 6pt, y: 4pt),
        radius: 0pt
      )[
        #grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          text(fill: black, weight: "bold", size: 9.5pt)[#title],
          if total-marks != none [
            #text(fill: black, weight: "bold", size: 9.5pt)[Max Marks: #total-marks]
          ]
        )
      ]
    ]
  }
  if description != "" [
    #v(2pt)
    #text(size: 8.5pt, style: "italic", fill: luma(60))[#description]
  ]
  v(3pt)
}

// Question Table Function with Automatic & Manual Question Numbering Support
#let obe-question-table(
  questions: (),
  start-num: 1
) = {
  set text(size: 9pt)
  context {
    let current-mode = obe-mode-state.get()
    let is-exam = (current-mode == "exam")
    let current-num = start-num
    let rows = ()

    for q in questions {
      if q.at("is-or", default: false) == true {
        if is-exam {
          rows.push(table.cell(colspan: 3, align: center, inset: (y: 6pt))[
            #text(size: 8.5pt, weight: "bold", fill: luma(30))[--- OR ---]
          ])
        } else {
          rows.push(table.cell(colspan: 5, fill: luma(250), align: center, inset: 3pt)[
            #text(size: 8.5pt, weight: "bold", fill: luma(40))[--- OR ---]
          ])
        }
      } else {
        // Compute question number: use manual string if passed, otherwise auto-increment counter
        let q-num-str = if "num" in q and q.num != auto and q.num != none {
          str(q.num)
        } else {
          let n = str(current-num)
          current-num += 1
          n
        }

        if is-exam {
          let formatted-num = if q-num-str.ends-with(".") { q-num-str } else { q-num-str + "." }
          rows.push([*#formatted-num*])
          rows.push(q.body)
          rows.push([*[#q.marks]*])
        } else {
          rows.push([*#q-num-str*])
          rows.push(q.body)
          rows.push([*#q.marks*])
          rows.push(co-text(q.co))
          rows.push(bloom-text(q.bl))
        }
      }
    }

    if is-exam [
      // Raw Question Paper Mode: Completely unboxed, clean traditional academic layout
      #table(
        columns: (28pt, 1fr, 30pt),
        align: (left + top, left + top, right + top),
        stroke: none,
        fill: none,
        inset: (x: 2pt, y: 4.5pt),
        ..rows
      )
    ] else [
      // Internal / Audit OBE Mode: Q.No | Question Statement | Marks | CO | BL
      #table(
        columns: (34pt, 1fr, 36pt, 38pt, 38pt),
        align: (center + top, left + top, center + top, center + top, center + top),
        stroke: 0.4pt + luma(130),
        fill: (col, row) => if row == 0 { luma(238) } else { none },
        inset: (x: 4.5pt, y: 4.5pt),
        table.header(
          [*Q.No*], [*Question Statement*], [*Marks*], [*CO*], [*BL*]
        ),
        ..rows
      )
    ]
  }
}

// Standalone Question Helper
#let q(num: auto, marks: none, co: none, bl: none, body) = {
  block(
    width: 100%,
    inset: (y: 1.5pt),
    breakable: false,
    [
      #grid(
        columns: (20pt, 1fr, if marks != none { auto } else { 0pt }),
        gutter: 5pt,
        align: (left + top, left + top, right + top),
        if num != auto and num != none [*#num.*] else [],
        body,
        if marks != none [
          #set text(size: 8.5pt)
          #context {
            let is-exam = (obe-mode-state.get() == "exam")
            if is-exam [
              [*[#marks]*]
            ] else [
              [*#marks M* #if co != none [| #co-text(co)] #if bl != none [| #bloom-text(bl)]]
            ]
          }
        ]
      )
    ]
  )
}

// Subquestion helper for block format
#let sq(label, marks: 2, co: "CO1", bl: "K1", body) = {
  grid(
    columns: (16pt, 1fr, auto),
    gutter: 4pt,
    align: (left + top, left + top, right + top),
    [*(#label)*],
    body,
    [
      #set text(size: 8.5pt)
      #context {
        let is-exam = (obe-mode-state.get() == "exam")
        if is-exam [
          [*[#marks]*]
        ] else [
          [*#marks M* | #co-text(co) | #bloom-text(bl)]
        ]
      }
    ]
  )
}

// Choice divider helper
#let or-choice() = {
  align(center)[
    #v(2.5pt)
    #text(size: 8.5pt, weight: "bold")[--- OR ---]
    #v(2.5pt)
  ]
}

// Printable OBE Mark Distribution & Blueprint Summary Table for Audits (Only rendered in internal mode)
#let obe-blueprint(
  co-summary: (),
  target-lots-pct: 30,
  target-hots-pct: 70
) = {
  context {
    let current-mode = obe-mode-state.get()
    if current-mode != "exam" [
      #pagebreak(weak: true)
      #v(6pt)
      #line(length: 100%, stroke: 0.8pt + black)
      #v(3pt)
      #align(center)[
        #text(size: 9.5pt, weight: "bold")[ANNEXURE: OBE QUESTION PAPER BLUEPRINT & CO-BLOOM MATRIX] \
        #text(size: 8pt, style: "italic", fill: luma(80))[For Quality Assurance, IQAC & Academic Audit Compliance]
      ]
      #v(3pt)

      #let total-k1 = co-summary.map(item => item.at("k1", default: 0)).sum()
      #let total-k2 = co-summary.map(item => item.at("k2", default: 0)).sum()
      #let total-k3 = co-summary.map(item => item.at("k3", default: 0)).sum()
      #let total-k4 = co-summary.map(item => item.at("k4", default: 0)).sum()
      #let total-k5 = co-summary.map(item => item.at("k5", default: 0)).sum()
      #let total-k6 = co-summary.map(item => item.at("k6", default: 0)).sum()
      #let grand-total = total-k1 + total-k2 + total-k3 + total-k4 + total-k5 + total-k6

      #let lots-marks = total-k1 + total-k2
      #let hots-marks = total-k3 + total-k4 + total-k5 + total-k6

      #let lots-pct = if grand-total > 0 { calc.round((lots-marks / grand-total) * 100, digits: 1) } else { 0 }
      #let hots-pct = if grand-total > 0 { calc.round((hots-marks / grand-total) * 100, digits: 1) } else { 0 }

      #block(
        width: 100%,
        breakable: false,
        [
          #table(
            columns: (42pt, 1fr, 26pt, 26pt, 26pt, 26pt, 26pt, 26pt, 38pt, 38pt),
            align: (center + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
            stroke: 0.4pt + luma(120),
            fill: (col, row) => if row == 0 { luma(238) } else if row == co-summary.len() + 1 { luma(245) } else { none },
            inset: (x: 3pt, y: 3.5pt),
            table.header(
              [*CO Code*], [*Course Outcome*], [*K1*], [*K2*], [*K3*], [*K4*], [*K5*], [*K6*], [*Total*], [*Weight*]
            ),
            ..co-summary.map(row => {
              let row-tot = row.at("k1", default: 0) + row.at("k2", default: 0) + row.at("k3", default: 0) + row.at("k4", default: 0) + row.at("k5", default: 0) + row.at("k6", default: 0)
              let row-pct = if grand-total > 0 { calc.round((row-tot / grand-total) * 100, digits: 1) } else { 0 }
              (
                [*#row.co*],
                text(size: 7.5pt)[#row.at("title", default: "")],
                [#row.at("k1", default: 0)],
                [#row.at("k2", default: 0)],
                [#row.at("k3", default: 0)],
                [#row.at("k4", default: 0)],
                [#row.at("k5", default: 0)],
                [#row.at("k6", default: 0)],
                [*#row-tot*],
                [*#row-pct%*]
              )
            }).flatten(),
            [*TOTAL*], [*Overall Marks Distribution*], [*#total-k1*], [*#total-k2*], [*#total-k3*], [*#total-k4*], [*#total-k5*], [*#total-k6*], [*#grand-total*], [*100%*]
          )

          #v(5pt)
          #grid(
            columns: (1fr, 1fr),
            gutter: 10pt,
            block(
              fill: luma(250), stroke: 0.5pt + luma(120), inset: 5pt, radius: 2pt, width: 100%,
              [
                #set text(size: 8pt)
                *Cognitive Level Analysis:* \
                • *LOTS (K1 + K2 - Remember & Understand):* #lots-marks Marks (#lots-pct%) \
                • *HOTS (K3 to K6 - Apply, Analyze, Evaluate, Create):* #hots-marks Marks (#hots-pct%)
              ]
            ),
            block(
              fill: luma(250), stroke: 0.5pt + luma(120), inset: 5pt, radius: 2pt, width: 100%,
              [
                #set text(size: 8pt)
                *Compliance Verification:* \
                • Target Balance: ~#target-lots-pct% LOTS / ~#target-hots-pct% HOTS \
                • Status: #if calc.abs(lots-pct - target-lots-pct) <= 20 [
                  *✓ Compliant with OBE Norms*
                ] else [
                  *! Review Level Distribution*
                ]
              ]
            )
          )

          #v(22pt)
          #grid(
            columns: (1fr, 1fr, 1fr),
            align: (center, center, center),
            [
              #line(length: 80%, stroke: 0.5pt + black)
              #text(size: 7.5pt)[Signature of Paper Setter]
            ],
            [
              #line(length: 80%, stroke: 0.5pt + black)
              #text(size: 7.5pt)[Signature of HOD / Scrutinizer]
            ],
            [
              #line(length: 80%, stroke: 0.5pt + black)
              #text(size: 7.5pt)[IQAC Coordinator]
            ]
          )
        ]
      )
    ]
  }
}

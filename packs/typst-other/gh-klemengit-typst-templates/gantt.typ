
#import "gantt_colors.typ": * // import colors, same colors are imported in `main.typ`

#set text(size: 7pt)


// ============================================================================
// CONFIGURATION DATA
// ============================================================================

// Months where labels should be displayed in the header
#let key-months = (1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 36)

// Months that get milestone background highlighting
#let milestone-months = (10, 16, 22, 36)

// ============================================================================
// WORK PACKAGE TASK DEFINITIONS
// ============================================================================
// Format: (label, start-month, duration)
// To add/edit tasks, modify these arrays

#let wp1-tasks = (
  (label: "1.1", start: 1,  duration: 6),   // months 2-6
  (label: "1.2", start: 4,  duration: 6),   // months 4-10
  (label: "1.3", start: 8,  duration: 6),   // months 7-13
)

#let wp2-tasks = (
  (label: "2.1", start: 12, duration: 6),   // months 11-19
  (label: "2.2", start: 16, duration: 6),   // months 14-22
  (label: "2.3", start: 18, duration: 6),   // months 17-25
)

#let wp3-tasks = (
  (label: "3.1", start: 23, duration: 6),   // months 20-28
  (label: "3.2", start: 27, duration: 6),   // months 26-33
  (label: "3.3", start: 30, duration: 6),   // months 29-36
)

// ============================================================================
// DELIVERABLES DEFINITIONS
// ============================================================================
// Format: (month, label)
// Use "\n" or "\ " in label for stacked items (e.g., "D1\ D2")

#let deliverables = (
  (month: 6,  label: "D1, D2"),
  (month: 9, label: "D3"),
  (month: 13, label: "D4"),
  (month: 17, label: "D5"),
  (month: 21, label: "D6"),
  (month: 23, label: "D7"),
  (month: 28, label: "D8"),
  (month: 32, label: "D9, D10"),
  (month: 35, label: "D11"),
)

// ============================================================================
// DISSEMINATION DEFINITIONS
// ============================================================================
// Format: (month, label)

#let dissemination = (
  (month: 6,  label: "C1"),
  (month: 9, label: "S1"),
  (month: 13, label: "S2"),
  (month: 17, label: "S3"),
  (month: 21, label: "S4"),
  (month: 23, label: "S5"),
  (month: 28, label: "S6"),
  (month: 32, label: "S7, C2"),
)

// ============================================================================
// RISKS DEFINITIONS
// ============================================================================
// Format: (month, label)

#let risks = (
  (month: 4,  label: "R1"),
  (month: 12, label: "R2"),
  (month: 19, label: "R3"),
  (month: 30, label: "R4"),
)

// ============================================================================
// MILESTONES DEFINITIONS
// ============================================================================
// Format: (month, label)

#let milestones = (
  (month: 10, label: "M1"),
  (month: 16, label: "M2"),
  (month: 22, label: "M3"),
  (month: 36, label: "M4"),
)

// ============================================================================
// PERSONNEL ACTIVITY DEFINITIONS
// ============================================================================
// Format: (month, type) where type is "light" or "medium"

#let phd-st1-activity = (
  (month: 1, type: "light"),
  (month: 2, type: "light"),
  (month: 3, type: "light"),
  (month: 4, type: "light"),
  (month: 5, type: "light"),
  (month: 6, type: "light"),
  (month: 7, type: "light"),
  (month: 8, type: "light"),
  (month: 9, type: "light"),
  (month: 10, type: "light"),
  (month: 11, type: "light"),
  (month: 12, type: "light"),
  (month: 13, type: "light"),
  (month: 16, type: "light"),
  (month: 17, type: "light"),
  (month: 18, type: "light"),
  (month: 19, type: "light"),
  (month: 20, type: "light"),
  (month: 21, type: "light"),
  (month: 23, type: "light"),
  (month: 24, type: "light"),
  (month: 25, type: "light"),
  (month: 26, type: "light"),
  (month: 27, type: "light"),
  (month: 28, type: "light"),
  (month: 29, type: "light"),
  (month: 30, type: "light"),
  (month: 31, type: "light"),
  (month: 32, type: "light"),
)

#let phd-st2-activity = (
  (month: 1, type: "light"),
  (month: 2, type: "light"),
  (month: 3, type: "light"),
  (month: 4, type: "light"),
  (month: 5, type: "light"),
  (month: 6, type: "light"),
  (month: 7, type: "light"),
  (month: 8, type: "light"),
  (month: 9, type: "light"),
  (month: 12, type: "light"),
  (month: 13, type: "light"),
  (month: 14, type: "light"),
  (month: 15, type: "light"),
  (month: 16, type: "light"),
  (month: 17, type: "light"),
  (month: 18, type: "light"),
  (month: 19, type: "light"),
  (month: 20, type: "light"),
  (month: 21, type: "light"),
  (month: 22, type: "light"),
  (month: 23, type: "light"),
  (month: 27, type: "light"),
  (month: 28, type: "light"),
  (month: 29, type: "light"),
  (month: 30, type: "light"),
  (month: 31, type: "light"),
  (month: 32, type: "light"),
  (month: 33, type: "light"),
)

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

// Create a task bar cell with specified colspan
#let task-bar(label, colspan: 1, color: task-color) = {
  table.cell(
    fill: color,
    align: center + horizon,
    colspan: colspan,
    text(weight: "bold", size: 8pt, label)
  )
}

// Create an empty cell
#let empty-cell() = {
  table.cell()[#h(0pt)]
}

// Generate empty cells for a given range of months
#let empty-months(count) = {
  range(count).map(_ => empty-cell())
}

// Create a task row with task bar at specified position
#let create-task-row(task) = {
  let cells = ()

  // Empty cells before task starts
  cells += empty-months(task.start - 1)

  // Task bar (merged cell spanning multiple columns)
  cells.push(task-bar(task.label, colspan: task.duration))

  // Fill remaining cells (milestone bg applied automatically by table fill)
  let remaining = 36 - task.start - task.duration + 1
  cells += empty-months(remaining)

  cells
}

// ============================================================================
// MAIN GANTT CHART TABLE
// ============================================================================

#table(
  columns: (auto,) + (1fr,) * 36,  // 1 label column + 36 month columns
  rows: auto,
  align: center + horizon,
  stroke: 0.5pt + black,
  inset: 2pt,

  // Milestone columns get automatic background - overridden by cell-level fill
  fill: (col, row) => {
    if col in milestone-months { milestone-bg }
  },

  // ==========================================================================
  // HEADER ROW - Month labels
  // ==========================================================================

  table.cell(fill: luma(240), text(weight: "bold", size: 6pt)[Month]),

  // Generate month header cells (show labels only for key months)
  ..range(1, 37).map(month => {
    table.cell(
      fill: if month in milestone-months { milestone-bg } else { luma(240) },
      text(weight: "bold", size: 6pt)[
        #if month in key-months { str(month) } else { [] }
      ]
    )
  }),

  // ==========================================================================
  // WORK PACKAGE 1 (WP1)
  // ==========================================================================

  // WP1 - Task 1.1
  table.cell(
    fill: wp-header-color,
    rowspan: 3,
    text(weight: "bold", size: 7pt)[WP1]
  ),
  ..create-task-row(wp1-tasks.at(0)),

  // WP1 - Task 1.2
  ..create-task-row(wp1-tasks.at(1)),

  // WP1 - Task 1.3
  ..create-task-row(wp1-tasks.at(2)),

  // ==========================================================================
  // WORK PACKAGE 2 (WP2)
  // ==========================================================================

  // WP2 - Task 2.1
  table.cell(
    fill: wp-header-color,
    rowspan: 3,
    text(weight: "bold", size: 7pt)[WP2]
  ),
  ..create-task-row(wp2-tasks.at(0)),

  // WP2 - Task 2.2
  ..create-task-row(wp2-tasks.at(1)),

  // WP2 - Task 2.3
  ..create-task-row(wp2-tasks.at(2)),

  // ==========================================================================
  // WORK PACKAGE 3 (WP3)
  // ==========================================================================

  // WP3 - Task 3.1
  table.cell(
    fill: wp-header-color,
    rowspan: 3,
    text(weight: "bold", size: 7pt)[WP3]
  ),
  ..create-task-row(wp3-tasks.at(0)),

  // WP3 - Task 3.2
  ..create-task-row(wp3-tasks.at(1)),

  // WP3 - Task 3.3
  ..create-task-row(wp3-tasks.at(2)),

  // ==========================================================================
  // PERSONNEL ROWS
  // ==========================================================================

  // PhD Student 1
  table.cell(fill: personnel-light, text(weight: "regular", size: 6pt)[PhD-St1]),
  ..range(1, 37).map(month => {
    let activity = phd-st1-activity.find(a => a.month == month)
    if activity != none {
      let color = if activity.type == "light" { personnel-light } else { personnel-medium }
      table.cell(fill: color)[]
    } else {
      empty-cell()
    }
  }),

  // PhD Student 2
  table.cell(fill: personnel-light, text(weight: "regular", size: 6pt)[PhD-St2]),
  ..range(1, 37).map(month => {
    let activity = phd-st2-activity.find(a => a.month == month)
    if activity != none {
      let color = if activity.type == "light" { personnel-light } else { personnel-medium }
      table.cell(fill: color)[]
    } else {
      empty-cell()
    }
  }),

  // PI and Expert Researchers (active all months)
  table.cell(fill: pi-color, text(weight: "regular", size: 6pt)[PI and Exp. Res.]),
  ..range(1, 37).map(month => table.cell(fill: pi-color)[]),

  // ==========================================================================
  // DELIVERABLES ROW
  // ==========================================================================

  table.cell(fill: deliverable-color, text(weight: "bold", size: 6pt)[Deliverable]),
  ..range(1, 37).map(month => {
    let deliverable = deliverables.find(d => d.month == month)
    if deliverable != none {
      table.cell(fill: deliverable-color, text(size: 5pt, weight: "bold", deliverable.label))
    } else {
      empty-cell()
    }
  }),

  // ==========================================================================
  // DISSEMINATION ROW
  // ==========================================================================

  table.cell(fill: dissemination-color, text(weight: "bold", size: 6pt)[Dissemination]),
  ..range(1, 37).map(month => {
    let event = dissemination.find(d => d.month == month)
    if event != none {
      table.cell(fill: dissemination-color, text(size: 5pt, weight: "bold", event.label))
    } else {
      empty-cell()
    }
  }),

  // ==========================================================================
  // RISKS ROW
  // ==========================================================================

  table.cell(fill: risk-color, text(weight: "bold", size: 6pt)[Risks]),
  ..range(1, 37).map(month => {
    let risk = risks.find(r => r.month == month)
    if risk != none {
      table.cell(fill: risk-color, text(size: 5pt, weight: "bold", risk.label))
    } else {
      empty-cell()
    }
  }),

  // ==========================================================================
  // MILESTONES ROW
  // ==========================================================================

  table.cell(fill: milestone-bg, text(weight: "bold", size: 6pt)[Milestones]),
  ..range(1, 37).map(month => {
    let milestone = milestones.find(m => m.month == month)
    if milestone != none {
      table.cell(text(weight: "bold", size: 6pt, milestone.label))
    } else {
      empty-cell()
    }
  }),
)


#set text(size: 11pt)

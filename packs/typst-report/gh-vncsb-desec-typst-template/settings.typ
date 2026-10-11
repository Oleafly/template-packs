#let highlight-fill-color = rgb("#44546a")
#let highlight-font-color = white
#let critical-color = rgb("#c00000")
#let high-color = rgb("#ed7d31")
#let medium-color = yellow
#let low-color = green
#let disabledColor = gray

#let criticalCell = table.cell(
  fill: critical-color,
  text(fill: white)[Crítico],
)
#let highCell = table.cell(
  fill: high-color,
  text(fill: white)[Alto],
)
#let mediumCell = table.cell(
  fill: medium-color,
  text(fill: white)[Médio],
)
#let lowCell = table.cell(
  fill: low-color,
  text(fill: white)[Baixo],
)
#let notApplicableCell = table.cell(
  fill: disabledColor,
  text(fill: black)[N/A]
)

#let severityMap = (
  Critical: criticalCell,
  High: highCell,
  Medium: mediumCell,
  Low: lowCell,
  NotApplicable: notApplicableCell
)

#let severityOrder = (
  Critical: 0,
  High: 1,
  Medium: 2,
  Low: 3,
  NotApplicable: 4
)

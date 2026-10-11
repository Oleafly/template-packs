#let sev-color(sev) = if sev == "Critical" {
  rgb("#51087E")
} else if sev == "High" {
  rgb("#D32F2F")
} else if sev == "Medium" {
  rgb("#F57C00")
} else if sev == "Low" {
  rgb("#1976D2")
} else {
  rgb("#616161")
}

#let status-color(status) = if status == "Fixed" {
  rgb("#68c16f")
} else if status == "Accepted" {
  rgb("#7c9384")
} else if status == "Mitigated" {
  rgb("#e8bf56")
} else if status == "New" {
  rgb("#759bf8")
} else {
  rgb("#bbb8cb")
}

#let status-badge(sev) = box(
  fill: status-color(sev).lighten(35%),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  text(size: 0.8em, weight: "bold", fill: white)[#sev],
)
#let sev-badge(sev) = box(
  fill: sev-color(sev).lighten(35%),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  text(size: 0.8em, weight: "bold")[#sev],
)

#let executive-summary(ISSUE_COUNT, AUDITOR, CLIENT_NAME, CLIENT_WEBSITE,PROJECT_REPOSITORY, INITIAL_AUDIT_COMMIT, AUDIT_TIMELINE,
    CRITICAL_FOUND, CRITICAL_FIXED, CRITICAL_ACKED,
    HIGH_FOUND, HIGH_FIXED, HIGH_ACKED,
    MED_FOUND, MED_FIXED, MED_ACKED,
    LOW_FOUND, LOW_FIXED, LOW_ACKED,
    INFO_FOUND, INFO_FIXED, INFO_ACKED,
    ) = [
    #text(20pt, font: "DejaVu Sans Mono")[= Executive Summary]

    Over the course of the audit engagement, caglansec performed a thorough
    manual and automated review of the smart contracts included in the scope.
    A total of *#ISSUE_COUNT* issues were identified.

    #line(length: 100%, stroke: rgb("#cfcfcf"))
    #grid(
        columns: (25%, 75%),
        row-gutter: 6pt,
        column-gutter: 12pt,

        [Name], [#CLIENT_NAME],

        [Website], [#CLIENT_WEBSITE],

        [Audited By], [#AUDITOR],

        [Project Repository], [#PROJECT_REPOSITORY],

        [Initial Commit], [#INITIAL_AUDIT_COMMIT],

        [Audit Timeline], [#AUDIT_TIMELINE],
    )

    #line(length: 100%, stroke: rgb("#cfcfcf"))
    #text(weight: "bold", size: 14pt)[Issues Found]

    #grid(
    columns: (35%, 17%, 17%, 16%),
    row-gutter: 6pt,
    column-gutter: 12pt,

    [#text(weight: "bold", size: 14pt)[Severity]], [#text(weight: "bold", size: 14pt)[Total]], [#text(weight: "bold", size: 14pt)[Fixed]], [#text(weight: "bold", size: 14pt)[Acknowledged]],

    [#sev-badge("Critical")], [#CRITICAL_FOUND], [#CRITICAL_FIXED], [#CRITICAL_ACKED],
    [#sev-badge("High")], [#HIGH_FOUND],[#HIGH_FIXED], [#HIGH_ACKED],
    [#sev-badge("Medium")], [#MED_FOUND],[#MED_FIXED], [#MED_ACKED],
    [#sev-badge("Low")], [#LOW_FOUND],[#LOW_FIXED], [#LOW_ACKED],
    [#sev-badge("Informational")], [#INFO_FOUND],[#INFO_FIXED], [#INFO_ACKED]
    )
    #line(length: 100%, stroke: rgb("#cfcfcf"))
    #text(weight: "bold", size: 14pt)[Scope]

    #grid(
    columns: (25%, 75%),
    row-gutter: 10pt,
    column-gutter: 12pt,

    [#text(weight: "bold", size: 14pt)[Files]], [#text(weight: "bold", size: 14pt)[Link]],

    [`cosmwasm/access-manager/*`], [https://github.com/unionlabs/union/tree/accessmanaged/cosmwasm/access-manager],

    [`cosmwasm/access-managed/*`], [https://github.com/unionlabs/union/tree/accessmanaged/cosmwasm/access-managed],

    [`cosmwasm/pausable/*`], [https://github.com/unionlabs/union/tree/accessmanaged/cosmwasm/pausable],

    [`cosmwasm/upgradable/*`], [https://github.com/unionlabs/union/tree/accessmanaged/cosmwasm/upgradable],
    )

    #pagebreak()


]
#import "../utils/style.typ": *
#import "../config/publications.typ": (
  publication-appendix-entries, publication-status-table,
)

#let contribution-table(contributions) = {
  if contributions.len() == 0 {
    none
  } else {
    // Normalize contributions into rows of (name, role, percent)
    let rows = contributions.map(row => if type(row) == dictionary {
      (
        row.at("name", default: ""),
        row.at("role", default: ""),
        row.at("percentage", default: ""),
      )
    } else {
      (
        row.at(0, default: ""),
        row.at(1, default: ""),
        row.at(2, default: ""),
      )
    })

    table(
      columns: 3,
      column-gutter: 1em,
      [*Name*, *Role*, *Contribution (%)*],
      ..rows.map(r => [r.at(0), r.at(1), r.at(2)]),
    )
  }
}

#let ai-usage-note(ai_entries) = {
  if ai_entries == none or ai_entries.len() == 0 {
    none
  } else {
    heading(level: 3, "AI / Assistance Log")
    v(0.5em)
    // Confidentiality warning
    block(fill: rgb("#fff3cd"), stroke: rgb("#ffeeba"), inset: 1em)[
      *Confidentiality Notice:* AI-generated content and prompts may contain sensitive information. Ensure compliance with institutional policies on data privacy and intellectual property before sharing this log.
    ]
    v(0.5em)
    // Each entry expected to be a dictionary with keys: tool, date, purpose, prompt, output
    for e in ai_entries {
      let tool = if type(e) == dictionary { e.at("tool", default: "") } else {
        e.at(0, default: "")
      }
      let date = if type(e) == dictionary { e.at("date", default: "") } else {
        e.at(1, default: "")
      }
      let purpose = if type(e) == dictionary {
        e.at("purpose", default: "")
      } else { e.at(2, default: "") }
      let prompt = if type(e) == dictionary {
        e.at("prompt", default: "")
      } else { e.at(3, default: "") }
      let output_ref = if type(e) == dictionary {
        e.at("output_ref", default: "")
      } else { e.at(4, default: "") }

      paragraph[bold(tool + " — " + date)]
      v(0.25em)
      paragraph[purpose]
      v(0.25em)
      paragraph["Prompt: " + prompt]
      if output_ref != "" {
        v(0.25em)
        paragraph["Output reference: " + output_ref]
      }
      v(0.5em)
    }
    // Citation example
    v(0.5em)
    block(fill: rgb("#d1ecf1"), stroke: rgb("#bee5eb"), inset: 1em)[
      *Citation Example:* When referencing AI assistance in your thesis, use: "AI assistance provided by [Tool Name] on [Date] for [Purpose]."
    ]
  }
}

#let preface-publications_section(entries) = {
  if entries.len() == 0 {
    none
  } else {
    heading(level: 2, "Publication Register")
    v(0.5em)
    publication-status-table(entries)
  }
}

// =================================
// Contribution Matrix Templates
// =================================

// Validate contribution entry
#let validate-contribution(entry) = {
  if type(entry) != dictionary {
    panic("Contribution entry must be a dictionary: " + repr(entry))
  }

  let required = ("name", "role")
  for field in required {
    if entry.at(field, default: none) == none {
      panic(
        "Contribution entry missing required field '"
          + field
          + "': "
          + repr(entry),
      )
    }
  }

  // Ensure percentage is valid if provided
  let percentage = entry.at("percentage", default: none)
  if (
    percentage != none
      and type(percentage) != "integer"
      and type(percentage) != "float"
  ) {
    panic("Contribution percentage must be a number: " + repr(entry))
  }

  entry
}

// =================================
// Contribution Matrix Templates
// =================================

// Simple contribution table template
// Usage: simple-contribution-table(contributions)
#let simple-contribution-table(contributions) = {
  if contributions.len() == 0 {
    none
  } else {
    table(
      columns: 3,
      column-gutter: 1em,
      [*Contributor*, *Role*, *Contribution*],
      ..contributions.map(entry => {
        let v = validate-contribution(entry)
        [
          v.at("name", default: ""),
          v.at("role", default: ""),
          v.at("percentage", default: "") + if v.at("percentage", default: none) != none { "%" } else { "" }
        ]
      }),
    )
  }
}

// Detailed contribution table with descriptions
// Usage: detailed-contribution-table(contributions)
#let detailed-contribution-table(contributions) = {
  if contributions.len() == 0 {
    none
  } else {
    table(
      columns: 4,
      column-gutter: 1em,
      [*Contributor*, *Role*, *Contribution*, *Description*],
      ..contributions.map(entry => {
        let v = validate-contribution(entry)
        [
          v.at("name", default: ""),
          v.at("role", default: ""),
          v.at("percentage", default: "") + if v.at("percentage", default: none) != none { "%" } else { "" },
          v.at("description", default: "")
        ]
      }),
    )
  }
}

// Percentage allocation breakdown table
// Usage: percentage-breakdown-table(contributions)
#let percentage-breakdown-table(contributions) = {
  if contributions.len() == 0 {
    none
  } else {
    // Calculate totals
    let total-percentage = contributions
      .map(entry => {
        let v = validate-contribution(entry)
        v.at("percentage", default: 0)
      })
      .sum()

    table(
      columns: 3,
      column-gutter: 1em,
      [*Role*, *Contributor*, *Percentage*],
      ..contributions.map(entry => {
        let v = validate-contribution(entry)
        [
          v.at("role", default: ""),
          v.at("name", default: ""),
          v.at("percentage", default: "") + "%"
        ]
      }),
      table.hline(),
      [*Total*, *, *str(total-percentage) + "%"],
    )
  }
}

// AI/Assistance contribution template
// Usage: ai-contribution-table(contributions)
#let ai-contribution-table(contributions) = {
  if contributions.len() == 0 {
    none
  } else {
    table(
      columns: 4,
      column-gutter: 1em,
      [*Tool/Service*, *Purpose*, *Contribution Level*, *Details*],
      ..contributions.map(entry => {
        let v = validate-contribution(entry)
        [
          v.at("name", default: ""),
          v.at("role", default: ""),
          v.at("percentage", default: "") + if v.at("percentage", default: none) != none { "%" } else { "" },
          v.at("description", default: "")
        ]
      }),
    )
  }
}

// =================================
// Contribution Matrix Builder
// =================================

// Build contribution matrix based on template type
// Usage: contribution-matrix(contributions, template: "simple")
#let contribution-matrix(contributions, template: "simple") = {
  if template == "simple" {
    simple-contribution-table(contributions)
  } else if template == "detailed" {
    detailed-contribution-table(contributions)
  } else if template == "percentage" {
    percentage-breakdown-table(contributions)
  } else if template == "ai" {
    ai-contribution-table(contributions)
  } else {
    panic(
      "Unknown contribution template: "
        + template
        + ". Available: simple, detailed, percentage, ai",
    )
  }
}

// =================================
// Sample Contribution Data
// =================================

#let sample-contributions = (
  (
    name: "John Smith",
    role: "Primary Researcher",
    percentage: 60,
    description: "Conducted main experiments and data analysis",
  ),
  (
    name: "Jane Doe",
    role: "Co-Supervisor",
    percentage: 20,
    description: "Provided guidance on methodology and results interpretation",
  ),
  (
    name: "AI Assistant (ChatGPT)",
    role: "Writing Assistant",
    percentage: 10,
    description: "Helped with literature review and manuscript editing",
  ),
  (
    name: "Lab Technician",
    role: "Technical Support",
    percentage: 10,
    description: "Assisted with equipment setup and maintenance",
  ),
)

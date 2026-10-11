#set page(paper: "a4", margin: 2cm)
#set text(font: "New Computer Modern", size: 11pt)

// 1. Level 1: Same-line rule with 0.65em gap below
#show heading.where(level: 1): it => block(below: 0.65em)[
  #it.body #h(0.5em) #box(width: 1fr, baseline: -0.25em, line(length: 100%, stroke: 0.5pt))
]

// 2. Level 2 & 3: 0.65em line leading spacing
#show heading.where(level: 2): set block(above: 0.65em)
#show heading.where(level: 3): set block(above: 0.65em)

// 3. Lists: Tight top spacing, 1.2em bottom spacing (separates entries!)
#show list: set block(above: 0.65em, below: 1.6em)
#show list: set list(body-indent: 1.5em)
// #show enum: set block(above: 0.65em, below: 1.2em)
// #show terms: set block(above: 0.65em, below: 1.2em)

// Align description text vertically after the longest term
// #show terms: it => grid(
//   columns: (auto, 1fr),
//   row-gutter: 0.65em,    // Vertical space between terms
//   column-gutter: 1em,     // Gap between the colon and description text
//   ..it.children.map(item => (
//     [*#item.term:*], item.description
//   )).flatten()
// )

// =============================================================================
// HEADER
// =============================================================================

#grid(
  columns: (1fr, auto),
  align: (left + top, right + top),
  [
    #text(2em, weight: "bold")[BASE ROVER] \
    Resume Template
  ],
  [
    Email: base\@rover.com \
    Mobile: 123 456 7890 \
    LinkedIn: linkedin.com/username \
    GitHub: github.com/username
  ]
)

// =============================================================================
// EDUCATION
// =============================================================================

= Education

== University of Post Graduation, City | _Degree Name_ #h(1fr) 2024
- Cumulative GPA: 3.69
- _magna cum laude_
- Related Coursework: Computer Architecture, Database Management, Cybersecurity

// =============================================================================
// EXPERIENCE
// =============================================================================

= Experience

== Company ABC #h(1fr) City, State (or Remote)
=== Position Title #h(1fr) Month Year - Month Year
- Beginning with your most recent position, describe your experience, skills, and resulting outcomes in bullet or paragraph form.
- Begin each line with an action verb and include details that will help the reader understand your accomplishments, skills, knowledge, abilities, or achievements.
- Quantify where possible. Do not use personal pronouns; each line should be a phrase rather than a full sentence.

== Position Title #h(1fr) Mar 2020 - Nov 2022
=== Company XYZ #h(1fr) City, State
- XYZ method - Accomplished [X] as measured by [Y], by doing [Z].
- CAR method - Context, Action, Result.
- STAR method - Situation, Task, Action, Result.
- Be consistent with headers and sub-headers.

// =============================================================================
// CERTIFICATION & AWARDS
// =============================================================================

= Certification & Awards

- Some programming bootcamp, Location. #h(1fr) 2023
- Forbes Top 15 Procrastinators under 15. #h(1fr) 2022
- Participation award for attending workshop. #h(1fr) 2021

// =============================================================================
// SKILLS & INTERESTS
// =============================================================================

= Skills & Interests

/ Technical: List computer software and programming languages
/ Language: List foreign languages and your level of fluency
/ Laboratory: List scientific / research lab techniques or tools [If Applicable]
/ Interests: List activities you enjoy that may spark interview conversation

// =============================================================================
// PROJECTS
// =============================================================================

= Projects

== Project Name | _github.com/project-link_ #h(1fr) 2019
- Tech used, Language, Frameworks etc.
- Implemented ABC feature
- Optimised XYZ by 50%

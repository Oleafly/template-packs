#import "cv-template.typ": cv, section, entry, skill, item

// ============================================================================
//  YOUR CV — fill in the blanks below.
//
//  Build:         typst compile cv.typ
//  Live preview:  typst watch cv.typ
//
//  Every {{placeholder}} is yours to replace. Delete any line you don't need —
//  omitted fields collapse and the layout closes up cleanly.
//  Restyling (font, size, spacing) lives in cv-template.typ.
// ============================================================================

#show: cv.with(
  name: "{{Your Name}}",
  // Optional italic line under the name. Delete if you don't want one.
  subtitle: "{{Legal name: ...}}  •  {{pronouns}}",
  contacts: (
    link("mailto:you@example.edu")[you\@example.edu],
    "{{(000) 000-0000}}",
    "{{City, ST}}",
  ),
  // header-align: left,   // uncomment to left-align the header block
)

// ================================================================= PROFILE ==
// Optional. Two or three sentences: who you are, what you work on, where you
// are now. Delete the whole block if you'd rather open with experience.

#section("Profile")

{{One paragraph. Lead with your role and field, name the through-line across
your work, and close with your current position or program.}}

// ============================================================== EXPERIENCE ==
// Reverse-chronological — most recent first, within each section.
//
// Rename this heading to whatever fits ("Research Experience", "Work
// Experience"), and copy the whole section for each additional category you
// want (Teaching, Organizing, Additional Experience...).

#section("Experience")

#entry(
  org: "{{Organization}}",
  role: "{{Your Title}}",
  dates: "{{Mon. YYYY}} – Present",
  location: "{{City, ST}}",
  // Optional third line: department, advisor, supervisor, course number.
  note: "{{Department; supervisor: Dr. ...}}",
)[
  - {{What you did and what changed because of it. Lead with the verb, land on a number where you have one.}}
  - {{A second bullet. Two to four per role is the useful range.}}
]

#entry(
  org: "{{Organization}}",
  role: "{{Your Title}}",
  dates: "{{Mon. YYYY}} – {{Mon. YYYY}}",
  location: "{{City, ST}}",
)[
  - {{Past roles in past tense; the current one in present tense.}}
  - {{Second bullet.}}
]

#entry(
  org: "{{Organization}}",
  role: "{{Your Title}}",
  dates: "{{YYYY}} – {{YYYY}}",
)[
  - {{This entry has no location or note — those lines just disappear.}}
  - {{Second bullet.}}
]

// =============================================================== EDUCATION ==

#section("Education")

#entry(
  org: "{{University}}",
  role: "{{Degree, Field}}",
  dates: "Expected {{Mon. YYYY}}",
  location: "{{City, ST}}",
  note: "{{Concentration, minor, or advisor}}",
)[
  - {{Thesis title, advisor, or a one-line description of the work.}}
  - {{Honors, relevant coursework, or GPA — drop this bullet if none apply.}}
]

#entry(
  org: "{{University}}",
  role: "{{Degree, Field}}",
  dates: "{{Mon. YYYY}}",
  location: "{{City, ST}}",
)[
  - {{Senior thesis, honors, or relevant detail.}}
]

// ================================================================== SKILLS ==
// Group by category. Spell terms the way a posting spells them — parsers match
// exact strings, so "JavaScript" and "JS" are different keywords. Keep it to
// things you'd be comfortable being asked about.

#section("Skills")

#skill("{{Category}}")[{{Comma-separated list of tools, methods, or systems.}}]
#skill("{{Category}}")[{{A second category — e.g. Technical, Research and writing, Organizational.}}]
#skill("Languages")[{{English (native), ... (level)}}]

// ================================================ PUBLICATIONS & PROJECTS ==
// `item` takes the entry itself, plus an optional italic second line for the
// venue, date, or context. Split into two sections if you have several of each.

#section("Publications & Projects")

#item(note: "{{Venue, publication, or date}}")[
  "{{Title of the piece.}}"
]

#item(note: "{{Venue, publication, or date}}")[
  "{{Another title.}}"
]

#item(note: "{{Status, stack, or link}}")[
  *{{Project Name}}* — {{What it does, what you built it with, and any number that shows it mattered.}}
]

// ---------------------------------------------------------------------------
// MORE SECTIONS
// Copy this shape for anything else — Teaching, Awards, Service, Additional
// Experience. Use `entry` for anything with bullets, `item` for one-liners.
//
//   #section("Additional Experience")
//
//   #item(note: "{{Mon. YYYY}}")[
//     *{{Organization}}*, {{City}} — {{Role}}. {{One sentence, if it needs one.}}
//   ]
// ---------------------------------------------------------------------------

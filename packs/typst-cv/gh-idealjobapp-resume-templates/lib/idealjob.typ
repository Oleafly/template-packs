// IdealJob template library.
//
// Every template imports this file and gets the candidate's CV data plus
// helpers that handle the edge cases (empty fields, date ranges, grouping,
// "what changed" highlights), so a template only decides how things look.
//
//   #import "/lib/idealjob.typ": *
//   #let cv = load-cv()
//
// The data comes from a JSON file (see docs/data-contract.md). IdealJob passes its path
// with `--input cv=/cv.json`; locally it defaults to /samples/full.json.

// ── Text ────────────────────────────────────────────────────────────────

/// A trimmed string ("" for none).
#let clean(value) = if value == none { "" } else { str(value).trim() }

/// Whether a value has content.
#let present(value) = clean(value) != ""

/// The first non-empty value.
#let first-present(..values) = {
  let found = values.pos().find(present)
  if found == none { "" } else { clean(found) }
}

/// "Mario Rodrigues" -> ("Mario", "Rodrigues").
#let split-name(name) = {
  let parts = clean(name).split(" ").filter(p => p != "")
  if parts.len() == 0 { ("", "") } else { (parts.first(), parts.slice(1).join(" ")) }
}

/// "Mario Rodrigues" -> "MR".
#let initials(name) = {
  let parts = clean(name).split(" ").filter(p => p != "")
  parts.slice(0, calc.min(2, parts.len())).map(p => upper(p.first())).join()
}

/// The handle part of a LinkedIn or GitHub URL ("github.com/mario" -> "mario").
/// A bare handle is returned as is; an unrelated URL gives "".
#let handle(value, marker) = {
  let value = clean(value)
  if value.contains(marker) {
    value.split(marker).last().split("/").first().split("?").first()
  } else if value.contains("/") { "" } else { value }
}

// ── Loading ─────────────────────────────────────────────────────────────

/// The CV data, with every documented field present (empty when the
/// candidate left it blank) so templates never check for missing keys.
#let load-cv(path: none) = {
  let path = if path != none { path } else { sys.inputs.at("cv", default: "/samples/full.json") }
  let cv = json(path)
  for key in ("name", "headline", "email", "phone", "website", "linkedin", "github", "location", "summary", "photo") {
    cv.insert(key, clean(cv.at(key, default: none)))
  }
  for key in ("experiences", "educations", "projects", "skills", "languages", "certifications", "volunteerings") {
    let value = cv.at(key, default: none)
    cv.insert(key, if value == none { () } else { value })
  }
  cv
}

// ── Dates ───────────────────────────────────────────────────────────────

#let months-en = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

/// "2024-07-01" -> "Jul 2024"; anything else is returned as written.
#let month-year(value, months: months-en) = {
  let value = clean(value)
  let parts = value.split("-")
  if parts.len() >= 2 and parts.at(0).len() == 4 {
    let month = int(parts.at(1))
    if month >= 1 and month <= 12 { months.at(month - 1) + " " + parts.at(0) } else { value }
  } else { value }
}

/// "Jul 2024 – Present", "Jan 2020 – Mar 2022", "Jan 2020", or "".
#let date-range(item, present-label: "Present", months: months-en) = {
  let start = month-year(item.at("start_date", default: none), months: months)
  let finish = if item.at("current", default: false) == true {
    present-label
  } else {
    month-year(item.at("end_date", default: none), months: months)
  }
  (start, finish).filter(present).join(" – ")
}

// ── Sections (only entries with content) ────────────────────────────────

/// Experiences grouped by organization, most recent organization first:
/// ((organization: "Acme", positions: (...)), ...). Positions without a
/// title are dropped.
#let experience-groups(cv) = {
  let items = cv.experiences.filter(e => present(e.at("organization", default: none)) or present(e.at("position", default: none)))
  let orgs = items.map(e => clean(e.at("organization", default: none))).dedup()
  orgs
    .map(org => {
      let positions = items.filter(e => clean(e.at("organization", default: none)) == org)
      (
        organization: org,
        positions: positions.filter(p => present(p.at("position", default: none))),
        latest: positions.map(p => clean(p.at("start_date", default: none))).sorted().last(),
      )
    })
    .sorted(key: g => g.latest)
    .rev()
}

#let educations(cv) = cv.educations.filter(e => present(e.at("institution", default: none)) or present(e.at("course", default: none)))
#let projects(cv) = cv.projects.filter(p => present(p.at("name", default: none)))
#let skills(cv) = cv.skills.map(clean).filter(present)
#let languages(cv) = cv.languages.filter(l => present(l.at("name", default: none)))
#let certifications(cv) = cv.certifications.filter(c => present(c.at("name", default: none)))
#let volunteerings(cv) = cv.volunteerings.filter(v => present(v.at("position", default: none)) or present(v.at("institution", default: none)))

/// A position's achievement lines, without empty ones.
#let achievements(position) = position.at("highlights", default: ()).map(clean).filter(present)

/// "GPA 17/20. Relevant coursework: Algorithms, Databases", or "".
#let education-details(education) = {
  let gpa = clean(education.at("gpa", default: none))
  let coursework = clean(education.at("coursework", default: none))
  (
    if gpa != "" { "GPA " + gpa },
    if coursework != "" { "Relevant coursework: " + coursework },
  ).filter(x => x != none).join(". ")
}

/// The contact details that are filled in, in display order:
/// ((kind: "email", value: "..."), ...). Kinds: email, phone, website,
/// linkedin, github, location. Empty ones never appear (no stray icons).
#let contacts(cv) = (
  ("email", cv.email),
  ("phone", cv.phone),
  ("website", cv.website),
  ("linkedin", cv.linkedin),
  ("github", cv.github),
  ("location", cv.location),
).filter(c => present(c.at(1))).map(c => (kind: c.at(0), value: clean(c.at(1))))

// ── What changed (tailored CVs in Apply with IdealJob) ──────────────────
//
// When IdealJob tailors a CV to a job it marks what it changed, so the
// candidate can review it. Templates wrap the matching parts with these;
// on normal downloads the flags are off and nothing changes.

/// Whether a part of the CV is marked: "summary", "skills" or "headline".
/// For a position use `position.at("highlight", default: false)` (its
/// description) and `position.at("highlights_highlight", default: false)`
/// (its achievements).
#let changed(cv, key) = cv.at(key + "_highlight", default: false) == true

/// Inline mark for changed text.
#let hl(on, body) = if on { highlight(fill: rgb("#fde68a"), extent: 1.5pt, body) } else { body }

/// Block mark for a changed block (a skills grid, a list of achievements).
#let hl-block(on, body) = if on {
  block(fill: rgb("#fef3c7"), inset: 5pt, radius: 3pt, width: 100%, body)
} else { body }

// ── Visuals ─────────────────────────────────────────────────────────────

#let icon-svgs = (
  email: "<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='COLOR' stroke-width='1.8' stroke-linecap='round' stroke-linejoin='round'><rect x='3' y='5' width='18' height='14' rx='2'/><path d='m3 7 9 6 9-6'/></svg>",
  phone: "<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='COLOR' stroke-width='1.8' stroke-linecap='round' stroke-linejoin='round'><path d='M22 16.92v3a2 2 0 0 1-2.18 2 19.8 19.8 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.12 4.18 2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.13.96.35 1.9.67 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.24a2 2 0 0 1 2.11-.45c.91.32 1.85.54 2.81.67A2 2 0 0 1 22 16.92z'/></svg>",
  link: "<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='COLOR' stroke-width='1.8' stroke-linecap='round' stroke-linejoin='round'><path d='M10 13a5 5 0 0 0 7.07 0l2.83-2.83a5 5 0 0 0-7.07-7.07L11.5 4.43'/><path d='M14 11a5 5 0 0 0-7.07 0L4.1 13.83a5 5 0 0 0 7.07 7.07l1.33-1.33'/></svg>",
  location: "<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='COLOR' stroke-width='1.8' stroke-linecap='round' stroke-linejoin='round'><path d='M20 10c0 5-8 12-8 12S4 15 4 10a8 8 0 1 1 16 0z'/><circle cx='12' cy='10' r='3'/></svg>",
)

/// A small line icon for a contact kind (email, phone, location; website,
/// linkedin and github use the link icon).
#let icon(kind, width: 8pt, color: "#6b7280") = {
  let key = if kind in ("website", "linkedin", "github") { "link" } else { kind }
  image(bytes(icon-svgs.at(key, default: icon-svgs.link).replace("COLOR", color)), format: "svg", width: width)
}

/// The candidate's photo in a circle, or their initials when there's none
/// (IdealJob sends no photo for applications to employers).
#let photo(cv, size: 62pt, fill: rgb("#f3f4f6"), stroke: 0.8pt + rgb("#e5e7eb")) = {
  if present(cv.photo) {
    box(width: size, height: size, radius: size / 2, clip: true, image(cv.photo, width: 100%, height: 100%, fit: "cover"))
  } else {
    box(width: size, height: size, radius: size / 2, fill: fill, stroke: stroke,
      align(center + horizon, text(size: size * 0.3, weight: "bold", fill: rgb("#374151"), initials(cv.name))))
  }
}

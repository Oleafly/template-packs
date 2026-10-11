// macros.typ — helper definitions for the Project Laboratory template
// Do not modify unless you know what you are doing!

// ── Title block ───────────────────────────────────────────────────────────────
#let projectlaboratorytitle() = {
  align(center)[
    #text(size: 24pt, weight: "bold")[Project Laboratory Report]
    #v(4pt)
    #text(size: 10pt)[Department of Telecommunications and Media Informatics]
  ]
  v(16pt)
}

// ── Author / supervisor table ─────────────────────────────────────────────────
// Arguments:
//   name, neptun, specialization, email,
//   supervisor, supervisor_email, cosupervisor, cosupervisor_email
#let projectlaboratoryauthor(
  name: "Your Name",
  neptun: "NEPTUN",
  specialization: "Specialization",
  email: "user@example.com",
  supervisor: "Supervisor Name, PhD",
  supervisor_email: "supervisor@tmit.bme.hu",
  cosupervisor: "Supervisor2 Name",
  cosupervisor_email: "supervisor2@tmit.bme.hu",
) = {
  align(
    center,
    table(
      columns: (auto, auto),
      stroke: none,
      align: (left, left),
      inset: (x: 6pt, y: 3pt),
      [Author:],         [*#name*],
      [Neptun:],         [*#text(font: "Courier New")[#neptun]*],
      [Specialization:], [*#specialization*],
      [E-mail address:], link("mailto:" + email)[*#email*],
      [Supervisor:],     [*#supervisor*],
      [E-mail address:], link("mailto:" + supervisor_email)[*#supervisor_email*],
      [Co-Supervisor:],  [*#cosupervisor*],
      [E-mail address:], link("mailto:" + cosupervisor_email)[*#cosupervisor_email*],
    ),
  )
  v(16pt)
}

// ── Semester label ────────────────────────────────────────────────────────────
// Arguments: sem (e.g. "2018/19"), num (e.g. "II")
#let semester(sem, num) = {
  text(size: 14pt, weight: "bold")[#sem #num. semester]
}

// ── Task title ────────────────────────────────────────────────────────────────
// Arguments: title (string)
#let tasktitle(title) = {
  align(center)[
    #text(size: 20pt, weight: "bold")[Title: #title]
  ]
  v(16pt)
}

// ── Task description ──────────────────────────────────────────────────────────
// Arguments: desc (content or string)
#let taskdescription(desc) = {
  align(center)[
    #text(size: 16pt, weight: "bold")[Task]
  ]
  v(8pt)
  desc
  linebreak()
  v(16pt)
}

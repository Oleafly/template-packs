// template.typ — Project Laboratory Report
// Typst equivalent of the LaTeX template.tex
// Fill in your own data where indicated and compile with: typst compile template.typ

#import "macros.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// Page & text setup (applies to the whole document)
// ══════════════════════════════════════════════════════════════════════════════

#set page(
  paper: "a4",
  margin: 3cm,
  // Running header: "Your Name (NEPTUN)" on all pages except the title page
  header: context {
    if counter(page).get().first() > 1 {
      align(right)[Your Name (NEPTUN)]
      line(length: 100%, stroke: 0.5pt)
    }
  },
  // Page number in the footer, suppressed on the title page
  footer: context {
    if counter(page).get().first() > 1 {
      align(center)[#counter(page).display("1")]
    }
  },
)

#set text(font: "Times New Roman", size: 11pt, lang: "en")
#set par(justify: true)

// Centre all level-1 section headings (matching \begin{center}\section{…}\end{center})
#show heading.where(level: 1): it => align(center, it)

// ══════════════════════════════════════════════════════════════════════════════
// Title page  (header and footer are suppressed via set rules scoped to this block)
// ══════════════════════════════════════════════════════════════════════════════
#{
  // Override page settings for just the title page
  set page(header: none, footer: none)

  align(center)[
    #image("figs/bme_logo.pdf", width: 12cm)
  ]

  projectlaboratorytitle()

  projectlaboratoryauthor(
    name: "Your Name",
    neptun: "NEPTUN",
    specialization: "Specialization",
    email: "user@example.com",
    supervisor: "Supervisor Name, PhD",
    supervisor_email: "supervisor@tmit.bme.hu",
    cosupervisor: "Supervisor2 Name",
    cosupervisor_email: "supervisor2@tmit.bme.hu",
  )

  tasktitle("Title of the project (one line)")

  taskdescription[Short description of the project.]

  // Semester — format: "xxxx/xx" and "I" or "II"
  align(center)[
    #semester("2018/19", "II")
  ]
}

// ══════════════════════════════════════════════════════════════════════════════
// Section 1 — Theory and previous works
// ══════════════════════════════════════════════════════════════════════════════
= Theory and previous works <sec:theory_prev>

== Introduction <sec:introduction>

Sample text.

== Theoretical summary <sec:theoretical_summary>

Sample text.

== Starting point, previous works on this project <sec:prev_works>

Sample text.

#pagebreak()

// ══════════════════════════════════════════════════════════════════════════════
// Section 2 — Own work on project
// ══════════════════════════════════════════════════════════════════════════════
= Own work on project <sec:work>

== Subsection one <sec:subsection_one>

The detailed description of the student's own work on the project in subsections.

// Example citation — just use @key anywhere in the text:
// "As shown in @eco and @esterhazy, …"

== Summary <sec:summary>

Sample text.

#pagebreak()

// ══════════════════════════════════════════════════════════════════════════════
// References
// ══════════════════════════════════════════════════════════════════════════════
// All references live in refs.bib — add entries there and cite with @key.
// Supported styles: "ieee", "apa", "chicago-author-date", "mla", etc.
#bibliography("refs.bib", title: "References", style: "ieee")

// ══════════════════════════════════════════════════════════════════════════════
// Attached documents
// ══════════════════════════════════════════════════════════════════════════════
== Attached documents <sec:attached_documents>

Source code etc.

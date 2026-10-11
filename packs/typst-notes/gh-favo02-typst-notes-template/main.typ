// Example usage of the academic-notes template
// This demonstrates how to use the template for academic notes

#import "template.typ": *

#show: academic-notes.with(
  // --- Required
  title: "Course Name",
  subtitle: "University Name - Master's Degree in Computer Science",
  authors: (
    ("Your Name", "your-github-username"),
    ("Another Author", "their-github-username"),
  ),
  lang: "en", // or "it", IMPORTANT!

  // --- Optional, uncomment to change
  repo-url: "https://github.com/your-username/repo-name",
  course-url: "https://university/professor/course",
  year: "2025-26",
  lecturer: "Professor",
  // date: datetime.today(),
  // license: "CC-BY-4.0",
  // license-url: "https://creativecommons.org/licenses/by/4.0/",
  // heading-numbering: "1.1.",
  // equation-numbering: none,
  // page-numbering: "1",

  // --- Optional with language-based defaults, uncomment to change
  // introduction: auto,
  // last-modified-label: auto,
  // outline-title: auto,
  // part-label: auto,
  // note-title: auto,
  // warning-title: auto,
  // informally-title: auto,
  // example-title: auto,
  // proof-title: auto,
  // theorem-title: auto,
  // theorem-label: auto,
  // equation-supplement: auto,
  // figure-supplement: auto,
)

// ============================================================================
// YOUR CONTENT STARTS HERE
// ============================================================================

// You can organize your content with parts
#part("First Part")

= First Chapter

== Section 1.1

This is example content. You can use all template helpers:

#note[
  This is an informative note.
]

#warning[
  This is an important warning.
]

#example[
  This is a practical example.
]

#informally[
  Informal explanation of the concept.
]

=== Theorems and Proofs

#theorem(title: "Example Theorem")[
  This is the theorem content. Equations are numbered automatically:
  $ sum_(i=1)^n i = (n(n+1))/2 $ <eq-sum>
]

#proof[
  This is the proof. Equations are also numbered here:
  $ 2 dot sum_(i=1)^n i = sum_(i=1)^n i + sum_(i=1)^n i $

  We can reference @eq-sum using links.
]

=== Colored Math

You can use colors to highlight parts of mathematical formulas:
$ mg(x^2) + mo(y^2) = mb(z^2) $

== Section 1.2

More content...

#part("Second Part")

= Second Chapter

Content of the second chapter...

#todo // Use this to mark incomplete sections

#include "chapters/example.typ" // You can include external files for better organization

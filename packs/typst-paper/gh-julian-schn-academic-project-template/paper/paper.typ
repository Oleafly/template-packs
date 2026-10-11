// Example Academic Paper
// Replace with your content

#import "lib.typ": academic-paper

#show: academic-paper.with(
  title: "Your Paper Title Here",
  author: "Your Name",
  email: "your.email@hdm-stuttgart.de",
  course: "Course Name (Course ID)",
  instructor: "Instructor Name",
  semester: "Wintersemester 2025/2026",

  abstract: [
    Your abstract goes here. Provide a concise summary of your paper's main points, methodology, and findings.
  ],

  acknowledgments: [
    Optional acknowledgments section. Thank people, institutions, or resources
    that supported your work.
  ],

  // Overall statement of how AI was used (see ACADEMIC_INTEGRITY.md).
  ai-usage: [
    AI-based tools were used to assist with the work described below. All
    AI-generated suggestions were reviewed, verified, and edited by the author,
    who takes full responsibility for the final content.
  ],

  // Per-tool disclosure: what each tool was used for and how output was verified.
  ai-tools: (
    (
      tool: "Claude (Anthropic)",
      purpose: "Rephrasing drafts and scaffolding example code.",
      verification: "Text rewritten in own words; all code read and tested.",
    ),
    (
      tool: "Grammar/spell checker",
      purpose: "Grammar and spelling corrections.",
      verification: "Each suggestion reviewed individually before accepting.",
    ),
  ),

  // Formal Declaration of Authorship (Selbstständigkeitserklärung).
  declaration: true,
  declaration-place: "Stuttgart",

  bibliography-file: "references.bib",
)

= Introduction

Your introduction content here.

== Background

Subsection content.

= Main Content

Your main content sections.

= Conclusion

Your conclusion here.

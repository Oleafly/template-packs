// --- BACK MATTER ---
#import "@preview/glossarium:0.5.10": print-glossary, gls, glspl
#import "acronyms.typ": acronyms

// Disable section numbers for general back-matter, but keep them in ToC
#set heading(numbering: none)

// List of Figures
#pagebreak()
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)

// List of Tables
#pagebreak()
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)

// Documentation Table of AI-based Tools
#pagebreak()
= Documentation of AI-Based Tools

#table(
  columns: (1fr, 2fr, 2fr, 1.5fr),
  align: (left, left, left, left),
  table.header(
    [*Tool / Model*], [*Purpose / Task*], [*Prompt / Scope*], [*Date*],
  ),
  [ChatGPT (GPT-4o)], [Grammar & style review], [Polishing section 3 introduction text], [2026-08-10],
  [GitHub Copilot], [Code formatting helper], [Assisted in writing custom Typst functions], [2026-08-15],
)

// List of Abbreviations
#pagebreak()
#heading(level: 1)[List of Acronyms]

#print-glossary(
  acronyms,
)




// Appendices
#pagebreak()

// Enable Letter numbering and reset heading counter for Appendices
#set heading(numbering: "A.1")
#counter(heading).update(0)

= Title of first Appendix
#lorem(30)

== Subsection of first Appendix
#lorem(20)

= Title of second Appendix
#lorem(30)
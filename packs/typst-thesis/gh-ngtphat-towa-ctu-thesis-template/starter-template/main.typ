// ============================================================================
// CTU GRADUATION THESIS - MAIN FILE
// Can Tho University Format (2025-2026)
// ============================================================================

// 1. CONFIGURATION & IMPORTS
#import "info.typ": *
#import "template/ctu-styles.typ": ctu-styles
#import "template/i18n.typ": term

// 2. GLOBAL SETTINGS
#let lang = settings.primary_lang

// 3. DOCUMENT SETUP (CTU Format)
#show: doc => ctu-styles(doc, lang: lang)

// Document Metadata
#set document(
  title: info.at(lang).thesis.title,
  author: info.at(lang).student.name,
  keywords: info.at(lang).keywords,
)

// ============================================================================
// 4. FRONT MATTER (Roman numerals i, ii, iii...)
// ============================================================================
#set page(numbering: "i")
#counter(page).update(1)

// Cover Pages
#import "frontmatter/cover.typ": cover-page
#import "frontmatter/inner-cover.typ": inner-cover-page

#cover-page(lang: lang)
#inner-cover-page(lang: lang)

// Evaluation & Acknowledgements
#include "frontmatter/evaluation.typ"
#include "frontmatter/acknowledgements.typ"

// Lists (TOC, LOF, LOT)
#include "frontmatter/table-of-contents.typ"
#pagebreak()

#include "frontmatter/list-of-figures.typ"
#pagebreak()

#include "frontmatter/list-of-tables.typ"
#pagebreak()

// Abbreviations & Abstract
#include "frontmatter/abbreviations.typ"
#include "frontmatter/abstract.typ"

// ============================================================================
// 5. MAIN CONTENT (Arabic numerals 1, 2, 3...)
// ============================================================================
#set page(numbering: "1")
#counter(page).update(1)
#set heading(numbering: "1.1.1.1") // Enable automatic numbering

// Helper for Part Headings (Visual separator, appears in outline)
#let part-heading(body) = {
  pagebreak()
  v(2cm)
  heading(level: 1, numbering: none, outlined: true)[#body]
}

// PART 1: INTRODUCTION
#part-heading[#term(lang, "part") 1: INTRODUCTION]
#counter(heading).update(1)
#include "chapters/part1-introduction.typ"

// PART 2: THESIS CONTENT
#part-heading[#term(lang, "part") 2: THESIS CONTENT]
#include "chapters/part2-content.typ"

// PART 3: CONCLUSION
#part-heading[#term(lang, "part") 3: CONCLUSION AND FUTURE WORK]
#counter(heading).step()
#include "chapters/part3-conclusion.typ"

// ============================================================================
// 6. BACK MATTER
// ============================================================================

// REFERENCES (IEEE Style - CTU Standard)
#pagebreak()
#bibliography("backmatter/bibliography.bib", title: term(lang, "ref"), style: "ieee")

// APPENDICES
#pagebreak()
#set page(numbering: none)
#counter(heading).update(0)
#set heading(numbering: "A.1")
#include "backmatter/appendices.typ"

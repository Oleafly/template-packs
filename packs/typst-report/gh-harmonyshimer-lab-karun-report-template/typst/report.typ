// =============================================================================
// report.typ — EDIT THIS: your report content (the Typst port of main-article.tex).
//
// 1. Fill in metadata.typ.
// 2. Write your content below using plain Typst markup (see the cheatsheet).
// 3. Build (output goes into build/). --font-path fonts uses the bundled Dubai
//    font, so no system install is needed:
//      typst compile --font-path fonts report.typ "build/My Report.pdf"
//      typst watch  --font-path fonts report.typ "build/My Report.pdf"   (live preview)
//
// Set lang to "en" (left-to-right) or "fa" (Persian, right-to-left).
//
// Markup cheatsheet:
//   = Section          -> numbered level-1 heading (Karun blue)
//   == Subsection      -> numbered level-2 heading
//   *bold*  _italic_  `code`
//   - item             -> bullet list
//   "quotes" --- dash  -> become curly quotes / em-dash automatically
//   #figure(image("images/x.png", width: 100%), caption: [ ... ])
//   #heading(level: 1, numbering: none)[Title]  -> unnumbered, still in the TOC
// =============================================================================

#import "karun.typ": *
#import "metadata.typ": meta

#show: karun-report.with(lang: "en", meta: meta)

// --- Title page + table of contents (leave these as-is) ---------------------
#title-page(meta, lang: "en")
#contents-page(lang: "en")

// ===========================================================================
// YOUR CONTENT STARTS HERE — replace everything below.
// ===========================================================================

#heading(level: 1, numbering: none)[Executive Summary]

Replace this paragraph with your executive summary. You can use *bold* and
_italic_ text, "smart quotes", and em-dashes --- like this --- naturally.

= First Section

Write the first section here. Multiple paragraphs are separated by a blank
line, exactly like this one.

== A Subsection

A subsection with a bullet list:

- First point, with a *bold* lead-in.
- Second point, mentioning a `code` term.
- Third point.

// Example figure (uncomment and point at an image in images/):
// #figure(
//   image("images/your-figure.png", width: 100%),
//   caption: [ Your caption. Figures are auto-numbered and listed nowhere else. ],
// )

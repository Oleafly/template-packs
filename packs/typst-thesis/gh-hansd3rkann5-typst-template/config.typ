// config.typ — change these values to configure the thesis

// --- Booleans ---
#let german = false
// true → German version (kapitel/)
// false → English (chapters/)
#let lof-combined = true
// true  → List of Figures and List of Tables share one page
// false → each list starts on its own page
#let chapter-pagebreak = false
// true  → each level-1 heading starts on a new page
// false → chapters flow continuously
#let show-wordometer = false
// true  → show per-section word count in draft mode
// false → hide word count even when draft = true

// --- Cover Texts ---
#let university = "University of Bayreuth"
#let program-name = [M.Sc.: Your Program Name]
#let report-title = "Your Thesis Title Goes Here"
#let report-subject = "Your Subject / Course"
#let semester = "Summersemester 26"
#let report-date = "01.01.2026"

// --- Authors and Supervision ---
#let supervisor-name = "Lastname, Firstname"
#let editors = (
  "Simon Bader",
)
#let matrikelnr = "2119890"

// --- Cover Dimensions & Spacing ---
#let cover-size-large = 22pt
#let cover-size-medium = 18pt
#let cover-size-small = 14pt
#let logo-width = 60%

// --- Typography ---
#let base-font = "Noto Sans Indic Siyaq Numbers"
#let base-size = 12pt
#let math-font = "New Computer Modern Math"
#let footer-size = 10pt

// --- Strokes & Line Weights ---
#let stroke-main = 0.5pt
#let stroke-thick = 1pt
#let stroke-thin = 0.2pt

// --- Paragraph & List Layout ---
#let par-leading = 0.8em // Line spacing
#let par-indent = 0em
#let par-spacing = 1.5em
#let list-indent = 1em
#let list-body-indent = 0.5em
#let list-spacing-above = 1.5em // Space between preceding text and a list/enum
#let outline-indent = 2em

// --- Heading Spacing ---
#let section-spacing-top = 3em
#let section-spacing-bottom = 2em
#let h2-above = 2.8em
#let h2-below = 1.8em
#let h3-above = 1.5em
#let h3-below = 1em

// --- List of Figures / List of Tables Entry Spacing ---
#let lof-entry-spacing = 0.55em // vertical gap between entries in List of Figures and List of Tables

// --- General Figure Spacing ---
#let figure-spacing-above = 2em
#let figure-spacing-below = 1.5em

// --- Table & Glossary Settings ---
#let table-spacing-above = 2em
#let table-inset = 6.5pt
#let caption-text-size = 10pt  // font size for figure and table captions only
#let glossary-inset = 0.6em
#let glossary-text-size = 12pt
#let symbol-text-size = 12pt

// --- Column Widths ---
#let col-abbr = (4cm, 1fr)
#let col-symbols = (2.5cm, 1fr, 1.5cm, 2.5cm)

// --- Colors & Dynamic Texts ---
#let footer-text = report-title// + " - " + report-subject
#let main-color-link = blue

/*
Font size: Text: 12 pt; Footnotes: 10 pt. Line spacing: Text: 1.5 lines (18 pt); Footnotes: 1 line. Page margins: left 3 cm; right 2 cm; top and bottom 2.5 cm. Headings: first outlinelevel: 13 pt, bold; following outline levels: 12 pt, bold.*/
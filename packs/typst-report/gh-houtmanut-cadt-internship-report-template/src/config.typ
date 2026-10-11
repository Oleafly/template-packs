// Default report values.

// -- Document --
// CONFIGURE: PDF metadata title. NOT the cover page (that's report-header.docx).
#let title = "YOUR PROJECT TITLE"

// CLARIFY: cover/approval pages come from report-header.docx -> out/report-header.pdf,
// overlaid onto the body's first N pages by build.py. Must match the docx's page count.
#let header-page-count = 3

// -- Fonts --
// CONFIGURE: must be installed on the machine running `typst compile`.
#let body-font = ("Times New Roman", "Siemreap")
#let code-font = "Fira Code"
#let body-font-size = 12pt

// -- Colors --
#let primary-color = oklab(50%, -0.014, -0.08)
#let outline-color = primary-color.lighten(60%).desaturate(40%)
#let table-header-color = primary-color.lighten(90%).desaturate(93%)
#let grey-light = rgb("#707070")
#let grey-dark = rgb("#585858")

// -- Paragraph / list spacing --
#let par-first-line-indent = 0.5in
#let par-leading = 1em
#let list-body-indent = 1em
#let list-indent = 0.25in

// -- Code / raw blocks --
#let code-bg = oklab(97.52%, -0.001, -0.003)
#let code-text-fill = oklab(20%, -0.000, -0.100)
#let code-border = 0.5pt + luma(240)
#let code-radius = 6pt
#let code-inset = 8pt
#let code-lang-label-size = 0.7em
#let inline-code-inset-x = 3pt
#let inline-code-outset-y = 3pt
#let inline-code-radius = 3pt

// -- Tables --
#let table-inset = 11pt
#let table-stroke = 0.5pt + luma(200)
#let table-border = 1pt + outline-color

// -- Figures --
#let caption-size = 9pt

// -- Heading sizes --
#let heading-size-chapter = 16pt // level-1 + unnumbered front/back-matter headings
#let heading-size-section = 14pt // level-2+ numbered headings

// -- Heading numbering --
// CONFIGURE: default is CADT's 3-tier scheme: level 1 -> top-format,
// levels 2-3 -> sub-format, level >= deep-level -> deep-format (numbers
// before deep-level are dropped).
#let numbered-header-top-format = "I.1.1."
#let numbered-header-sub-format = "1.1.1."
#let numbered-header-deep-format = "a.1."
#let numbered-header-deep-level = 4

// -- Folder-tree raw blocks (```folder) --
#let folder-char-width = 0.6em
#let folder-char-outset = 0.30em
#let folder-char-size = 13.5pt
#let folder-leading = 0.6em

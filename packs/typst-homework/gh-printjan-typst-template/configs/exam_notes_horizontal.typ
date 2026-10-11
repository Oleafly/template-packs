// Global print and layout configuration profile for high-density horizontal exam notes / cheat sheets.
#let print-profile = (
  // Page geometry and columns (A4 Landscape, 4 columns)
  paper: "a4", // Paper format
  page-flipped: true, // Landscape orientation
  page-width: 297mm, // Page width in landscape
  page-height: 210mm, // Page height in landscape
  page-margin: 3.8mm, // Outer page margin
  column-count: 4, // Number of text columns per page
  column-gap: 1.6mm, // Horizontal gutter between columns
  column-rule-width: 0.25pt, // Thickness of the vertical column separator rule
  column-rule-color: black, // Color of the vertical column separator rule

  // Pagination (top-right header position without reserved header box)
  show-page-number: true, // Toggle page numbers on/off
  page-number-size: 3.6pt, // Page number font size
  page-number-offset: (x: 0.6mm, y: 0.4mm), // Top-right offset coordinates
  page-number-color: luma(70), // Page number text color

  // Optional front matter and chapter pagination
  show-cover: false, // One-page title cover before all other content
  cover-title: "Document Title",
  cover-subtitle: "Document Subtitle",
  cover-authors: ("Author Name",), // One or more names
  cover-date: datetime.today().display("[year]-[month padding:zero]-[day padding:zero]"),
  cover-organization: "Organization",
  show-contents: false, // Linked table of contents before the TODO overview
  contents-title: auto, // Localized from body-lang; override with custom content
  contents-depth: 2, // Include chapter and subchapter headings
  chapters-new-page: false, // Start every level-1 chapter on a fresh page

  // Body typography
  body-font: "Libertinus Serif", // Primary font family
  body-size: 4.5pt, // Baseline body text font size
  body-leading: 2.0pt, // Line spacing within paragraphs
  paragraph-spacing: 2.8pt, // Vertical spacing between consecutive paragraphs
  body-lang: "en", // Document language for hyphenation and localization
  body-hyphenate: true, // Enable automatic hyphenation
  body-justify: false, // Text justification toggle
  strong-weight: "semibold", // Font weight for bold text (*strong*)

  // Heading hierarchy
  heading-numbering: none, // Numbering scheme (e.g. "1.1" or none)
  heading-weight: "bold", // Heading font weight
  heading-1-size: 6.2pt, // Level 1 heading font size
  heading-2-size: 5.6pt, // Level 2 heading font size
  heading-3-size: 5.1pt, // Level 3 heading font size
  heading-4-size: 5.0pt, // Level 4 heading font size
  heading-number-gap: 0.8mm, // Gap between numbering counter and heading text
  heading-1-above: 1.6mm, // Top margin before Level 1 heading
  heading-1-below: 0.9mm, // Bottom margin after Level 1 heading
  heading-2-above: 1.4mm, // Top margin before Level 2 heading
  heading-2-below: 0.75mm, // Bottom margin after Level 2 heading
  heading-3-above: 1.0mm, // Top margin before Level 3 heading
  heading-3-below: 0.6mm, // Bottom margin after Level 3 heading
  heading-4-above: 1.0mm, // Top margin before Level 4 heading
  heading-4-below: 0.6mm, // Bottom margin after Level 4 heading
  heading-1-show-rule: true, // Enable decorative rule above Level 1 heading
  heading-1-rule-width: 0.4pt, // Thickness of decorative rule for Level 1 heading
  heading-2-show-rule: true, // Enable decorative rule above Level 2 heading
  heading-2-rule-width: 0.2pt, // Thickness of decorative rule for Level 2 heading
  heading-3-show-rule: false, // Enable decorative rule above Level 3 heading
  heading-3-rule-width: 0.14pt, // Thickness of decorative rule for Level 3 heading
  heading-4-show-rule: false, // Enable decorative rule above Level 4 heading
  heading-4-rule-width: 0.12pt, // Thickness of decorative rule for Level 4 heading
  heading-rule-color: luma(55), // Color of decorative rules

  // List environments
  list-marker-level-1: [•], // Bullet glyph for Level 1
  list-marker-level-2: [•], // Bullet glyph for Level 2
  list-marker-level-3: [•], // Bullet glyph for Level 3
  list-marker-level-4: [•], // Bullet glyph for Level 4
  list-marker-indent: 0mm, // Bullet marker left indentation
  list-body-indent: 0.5mm, // Gap between bullet marker and list item text
  list-spacing: 2.0pt, // Vertical spacing between list items
  list-above: 2.8pt, // Margin above list block
  list-below: 2.8pt, // Margin below list block

  // Introspection & TODO tracking subsystem
  show-todos-summary: true, // Render aggregated TODO overview at start of document
  show-todos-in-text: true, // Render inline TODO notification boxes
  todo-text-fill: rgb("b30000"), // Text color for TODO items
  todo-text-weight: "bold", // Text weight for TODO items
  todo-list-gap: 3.0pt, // Horizontal gutter in aggregated TODO list

  // Code engine & syntax highlighting
  code-font: "DejaVu Sans Mono", // Monospaced font family
  code-size: 4.3pt, // Font size for code blocks
  code-leading: 2.2pt, // Line leading inside code blocks
  code-paragraph-spacing: 0pt, // Paragraph spacing within code blocks
  code-inline-size: 0.92em, // Relative font size for inline code spans
  code-inline-inset: (x: 0.8pt, y: 0.6pt), // Padding inside inline code boxes
  code-inline-outset: (x: 0pt, y: 0.2pt), // Vertical outset clearance for inline code
  code-inline-radius: 0.8pt, // Corner radius for inline code
  code-inline-stroke: 0.2pt + luma(195), // Stroke for inline code
  code-inset: (x: 0.4mm, y: 0.4mm), // Code block internal padding
  code-radius: 0.4mm, // Code block corner radius
  code-stroke: 0.22pt + luma(190), // Code block border stroke
  code-fill: luma(247), // Code block background fill
  code-above: 1.6pt, // Margin above code block
  code-below: 1.6pt, // Margin below code block
  code-show-line-numbers: true, // Enable gutter line numbering
  code-line-indent: true, // Indent code lines relative to line numbers
  code-line-odd-bg: luma(248), // Alternating odd row background (zebra striping)
  code-line-even-bg: luma(235), // Alternating even row background (zebra striping)
  code-label-size: 4.1pt, // Language badge font size
  code-label-fill: rgb(243, 232, 255, 60%), // Language badge background fill
  code-label-stroke: 0.21pt + rgb("#d8b4fe"), // Language badge border stroke
  code-label-color: rgb("#7e22ce"), // Language badge text color
  code-label-offset: (x: -1.5pt, y: 1.2pt), // Language badge position offset
  code-label-inset: (x: 1.8pt, y: 0.5pt), // Language badge padding
  code-label-radius: 1.0pt, // Language badge corner radius
  code-label-weight: "bold", // Language badge font weight
  code-labels: (
    c: "C",
    cpp: "C++",
    java: "Java",
    python: "Python",
    rust: "Rust",
    haskell: "Haskell",
    scheme: "Scheme",
    lisp: "Lisp",
    bash: "Bash",
    sql: "SQL",
    turtle: "Turtle",
    text: "Text",
  ),

  // Standard container & callout baseline properties
  box-inset-top: 0.4mm,
  box-inset-bottom: 0.45mm,
  box-inset-left: 0.3mm,
  box-inset-right: 0.3mm,
  box-out-pad-top: 0mm,
  box-out-pad-bottom: 0mm,
  box-out-pad-left: 0mm,
  box-out-pad-right: 0mm,
  box-radius: 0.4mm,
  box-stroke: 0.25pt + luma(125),
  box-fill: white,
  box-title-size: 4.8pt,
  box-title-weight: "bold",
  box-title-below: 2.8pt,
  box-above: 2.4pt,
  box-below: 2.4pt,

  // Callout specializations & theme overrides
  todo-fill: rgb("ffebeb"),
  todo-stroke: 0.6pt + rgb("b30000"),

  info-fill: rgb("fffbf0"),
  info-stroke: 0.35pt + rgb("f0a824"),

  positive-fill: rgb("f1fcf1"),
  positive-stroke: 0.35pt + rgb("56b956"),

  negative-fill: rgb("fff2f2"),
  negative-stroke: 0.35pt + rgb("e05c5c"),

  important-fill: rgb("eef9ff"),
  important-stroke: 0.35pt + rgb("4da2e3"),

  quote-fill: luma(248),
  quote-stroke: (left: 1.0pt + luma(170)),
  quote-font: ("Georgia", "PT Serif", "Libertinus Serif", "Times New Roman"),
  quote-size: 1.08em,
)

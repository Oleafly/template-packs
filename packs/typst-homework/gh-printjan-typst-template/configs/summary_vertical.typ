// Global print and layout configuration profile for single-column vertical technical summaries and reports.
#let print-profile = (
  // Page geometry and columns (A4 Portrait, 1 column)
  paper: "a4", // Paper format
  page-flipped: false, // Portrait orientation
  page-width: 210mm, // Page width in portrait
  page-height: 297mm, // Page height in portrait
  page-margin: 15mm, // Outer page margin optimized for reading comfort
  column-count: 1, // Single-column layout
  column-gap: 0mm, // Column gutter (unused in single-column mode)
  column-rule-width: 0pt, // Column divider rule thickness (disabled)
  column-rule-color: black,

  // Pagination
  show-page-number: true, // Toggle page numbers on/off
  page-number-size: 8pt, // Page number font size
  page-number-offset: (x: 1.4mm, y: 0.8mm), // Top-right offset coordinates
  page-number-color: luma(70),

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

  // Body typography (Baseline 10.5pt, scaled by factor 2.1 relative to 5pt cheat sheets)
  body-font: "Libertinus Serif", // Primary font family
  body-size: 10.5pt, // Baseline body text font size
  body-leading: 5.25pt, // Line spacing within paragraphs
  paragraph-spacing: 8.8pt, // Vertical spacing between consecutive paragraphs
  body-lang: "en", // Document language for hyphenation and localization
  body-hyphenate: true, // Enable automatic hyphenation
  body-justify: false, // Text justification toggle
  strong-weight: "semibold", // Font weight for bold text (*strong*)

  // Heading hierarchy (Scaled proportionally for 10.5pt body text)
  heading-numbering: "1.1", // Hierarchical numbering scheme
  heading-weight: "bold", // Heading font weight
  heading-1-size: 20pt, // Level 1 heading font size
  heading-2-size: 18pt, // Level 2 heading font size
  heading-3-size: 16pt, // Level 3 heading font size
  heading-4-size: 14pt, // Level 4 heading font size
  heading-number-gap: 3mm, // Gap between numbering counter and heading text
  heading-1-above: 8mm, // Top margin before Level 1 heading
  heading-1-below: 2.5mm, // Bottom margin after Level 1 heading
  heading-2-above: 6mm, // Top margin before Level 2 heading
  heading-2-below: 2.1mm, // Bottom margin after Level 2 heading
  heading-3-above: 4mm, // Top margin before Level 3 heading
  heading-3-below: 1.7mm, // Bottom margin after Level 3 heading
  heading-4-above: 3.2mm, // Top margin before Level 4 heading
  heading-4-below: 1.7mm, // Bottom margin after Level 4 heading
  heading-1-show-rule: true, // Enable decorative rule above Level 1 heading
  heading-1-rule-width: 0.97pt, // Thickness of decorative rule for Level 1 heading
  heading-2-show-rule: true, // Enable decorative rule above Level 2 heading
  heading-2-rule-width: 0.44pt, // Thickness of decorative rule for Level 2 heading
  heading-3-show-rule: true, // Enable decorative rule above Level 3 heading
  heading-3-rule-width: 0.32pt, // Thickness of decorative rule for Level 3 heading
  heading-4-show-rule: false, // Enable decorative rule above Level 4 heading
  heading-4-rule-width: 0.25pt, // Thickness of decorative rule for Level 4 heading
  heading-rule-color: luma(55), // Color of decorative rules

  // List environments (Scaled proportionally)
  list-marker-level-1: [•], // Bullet glyph for Level 1
  list-marker-level-2: [•], // Bullet glyph for Level 2
  list-marker-level-3: [•], // Bullet glyph for Level 3
  list-marker-level-4: [•], // Bullet glyph for Level 4
  list-marker-indent: 0mm, // Bullet marker left indentation
  list-body-indent: 2.1mm, // Gap between bullet marker and list item text
  list-spacing: 5.25pt, // Vertical spacing between list items
  list-above: 7.35pt, // Margin above list block
  list-below: 7.35pt, // Margin below list block

  // Introspection & TODO tracking subsystem
  show-todos-summary: true, // Render aggregated TODO overview at start of document
  show-todos-in-text: true, // Render inline TODO notification boxes
  todo-text-fill: rgb("b30000"), // Text color for TODO items
  todo-text-weight: "bold", // Text weight for TODO items
  todo-list-gap: 7pt, // Horizontal gutter in aggregated TODO list

  // Code engine & syntax highlighting (Scaled proportionally)
  code-font: "DejaVu Sans Mono", // Monospaced font family
  code-size: 10pt, // Font size for code blocks
  code-leading: 5.25pt, // Line leading inside code blocks
  code-paragraph-spacing: 0pt, // Paragraph spacing within code blocks
  code-inline-size: 1em, // Relative font size for inline code spans
  code-inline-inset: (x: 1.8pt, y: 1.5pt), // Padding inside inline code boxes
  code-inline-outset: (x: 0pt, y: 0.5pt), // Vertical outset clearance for inline code
  code-inline-radius: 2pt, // Corner radius for inline code
  code-inline-stroke: 0.35pt + luma(195), // Stroke for inline code
  code-inset: (x: 1.05mm, y: 1.05mm), // Code block internal padding
  code-radius: 1mm, // Code block corner radius
  code-stroke: 0.53pt + luma(190), // Code block border stroke
  code-fill: luma(247), // Code block background fill
  code-above: 4.2pt, // Margin above code block
  code-below: 4.2pt, // Margin below code block
  code-show-line-numbers: true, // Enable gutter line numbering
  code-line-indent: true, // Indent code lines relative to line numbers
  code-line-odd-bg: luma(248), // Alternating odd row background (zebra striping)
  code-line-even-bg: luma(235), // Alternating even row background (zebra striping)
  code-label-size: 7pt, // Language badge font size
  code-label-fill: rgb(243, 232, 255, 60%), // Language badge background fill
  code-label-stroke: 0.4pt + rgb("#d8b4fe"), // Language badge border stroke
  code-label-color: rgb("#7e22ce"), // Language badge text color
  code-label-offset: (x: -3pt, y: 2.5pt), // Language badge position offset
  code-label-inset: (x: 4.5pt, y: 1.2pt), // Language badge padding
  code-label-radius: 2.5pt, // Language badge corner radius
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
  box-inset-top: 1.3mm,
  box-inset-bottom: 1.5mm,
  box-inset-left: 1mm,
  box-inset-right: 0.7mm,
  box-out-pad-top: 0mm,
  box-out-pad-bottom: 0mm,
  box-out-pad-left: 0mm,
  box-out-pad-right: 0mm,
  box-radius: 1mm,
  box-stroke: 0.9pt + luma(125),
  box-fill: white,
  box-title-size: 11.2pt,
  box-title-weight: "bold",
  box-title-below: 7pt,
  box-above: 6.3pt,
  box-below: 6.3pt,

  // Callout specializations & theme overrides
  todo-fill: rgb("ffebeb"),
  todo-stroke: 1.5pt + rgb("b30000"),

  info-fill: rgb("fffbf0"),
  info-stroke: 0.9pt + rgb("f0a824"),

  positive-fill: rgb("f1fcf1"),
  positive-stroke: 0.9pt + rgb("56b956"),

  negative-fill: rgb("fff2f2"),
  negative-stroke: 0.9pt + rgb("e05c5c"),

  important-fill: rgb("eef9ff"),
  important-stroke: 0.9pt + rgb("4da2e3"),

  quote-fill: luma(248),
  quote-stroke: (left: 2.5pt + luma(170)),
  quote-font: ("Georgia", "PT Serif", "Libertinus Serif", "Times New Roman"),
  quote-size: 1.12em,
)

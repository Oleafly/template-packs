// All geometry constants of the UNN ITMM template, in PowerPoint points.
// PowerPoint pt and Typst pt coincide, so coordinates transfer 1:1.
// Values are read from the pptx XML (EMU / 12700 = pt):
//   - slide size:        ppt/presentation.xml
//   - title layout:      ppt/slideLayouts/slideLayout5.xml + ppt/slides/slide1.xml
//   - content layout:    ppt/slideLayouts/slideLayout3.xml
//   - thanks slide:      ppt/slides/slide27.xml

#let unn-geom = (
  // Slide canvas, 16:9.
  slide: (width: 720pt, height: 405pt),

  // Content layout (slideLayout3): white background with blue logos on top.
  content: (
    // Margins enclosing the body placeholder box @(29.3, 126) 668 x 243.4.
    margin: (top: 126pt, left: 29pt, right: 23pt, bottom: 36pt),
    // Title placeholder; font size is not set in the pptx, ~22pt visually.
    title: (x: 23.5pt, y: 72.8pt, width: 648.4pt, height: 45.6pt, size: 22pt),
    // Slide number placeholder, right-aligned, 9pt.
    page-num: (x: 508.5pt, y: 375.4pt, width: 175.7pt, height: 21.6pt, size: 9pt),
  ),

  // Title layout (slideLayout5): full-slide blue background (title-bg.png)
  // with a full-slide white-logo overlay (logo-strip-white.png, 720 x 405 @ origin).
  title: (
    // Divider line (assets/divider.png stretched to the shape extent:
    // faint full-width line, brighter dashes in the middle).
    divider: (x: 26.8pt, y: 213.5pt, width: 657.1pt, height: 2.9pt),
    // "Выпускная квалификационная работа бакалавра".
    subtitle: (x: 26.9pt, y: 99.9pt, width: 460.3pt, size: 16pt),
    // Thesis title.
    title: (x: 26.9pt, y: 137.4pt, width: 583.1pt, size: 21pt),
    // Left column: author ("Выполнил:"), 12pt.
    author: (x: 27.5pt, y: 241.6pt, width: 264.1pt, size: 12pt),
    // Left column: supervisor ("Научный руководитель:"), 13pt.
    supervisor: (x: 26.8pt, y: 288.2pt, width: 274.2pt, size: 13pt),
    // Right column: specialty ("Направление подготовки:"), 12pt.
    specialty: (x: 332.5pt, y: 241.6pt, width: 364.4pt, size: 12pt),
    // Right column: program ("Программа:"), 12pt.
    program: (x: 332.5pt, y: 291.3pt, width: 335.8pt, size: 12pt),
    // Defense date.
    date: (x: 27.5pt, y: 352.4pt, width: 123.8pt, size: 11pt),
  ),

  // Thanks slide (slide27, same title layout): centered bold line.
  thanks: (y: 170.7pt, height: 51.9pt, size: 33pt),
)

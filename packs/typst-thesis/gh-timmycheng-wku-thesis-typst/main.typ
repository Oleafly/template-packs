// WKU Thesis Document
// This is the main document file that uses the WKU thesis template

#import "lib.typ": wku-thesis, wku-load-chapters, wku-acknowledgments, wku-read-markdown
#import "setting.typ": *
#import "content-files.typ": *

// Apply the WKU thesis template with all settings from setting.typ
#show: wku-thesis.with(
  // Thesis information
  title: thesis-title,
  author: thesis-author,
  student-id: student-id,
  major: major,
  college: college,
  supervisor: supervisor,
  date: thesis-date,
  keywords: keywords,
  
  // Layout settings
  paper-size: paper-size,
  margins: (
    top: margin-top,
    bottom: margin-bottom,
    left: margin-left,
    right: margin-right
  ),
  
  // Typography settings
  fonts: (
    main: main-font,
    code: code-font
  ),
  text-size: text-size,
  line-spacing: line-spacing,
  
  // Heading settings
  chapter-font-size: chapter-font-size,
  section-font-size: section-font-size,
  subsection-font-size: subsection-font-size,
  
  // Cover page settings
  logo-width: logo-width,
  university-name-size: university-name-size,
  thesis-type-size: thesis-type-size,
  thesis-title-size: thesis-title-size,
  student-info-size: student-info-size,
  
  // Special pages
  special-page-title-size: special-page-title-size,
  special-page-spacing: special-page-spacing,
  
  // Figure and code settings
  caption-text-size: caption-text-size,
  code-background-color: code-background-color,
  code-padding: code-padding,
  code-corner-radius: code-corner-radius,
)

// Load all chapters dynamically
#wku-load-chapters(
  content-dir: content-dir,
  chapter-files: chapter-files,
  enable-dynamic-loading: enable-dynamic-loading
)

// Acknowledgments
#wku-acknowledgments(special-page-title-size, special-page-spacing)

// References
#pagebreak()
#bibliography("references/references.bib", title: "References", style: "apa")

// Appendices
#pagebreak()
#wku-read-markdown("content/appendices.md")
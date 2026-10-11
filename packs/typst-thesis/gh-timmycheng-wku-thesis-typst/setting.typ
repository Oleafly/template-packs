// ============================================================================
// THESIS TEMPLATE CONFIGURATION
// ============================================================================
// This file contains all user-configurable settings for the thesis template.
// Simply modify the variables below to customize your thesis formatting.
// No programming knowledge required!
//
// 📝 Instructions:
// 1. Edit the values after the = sign
// 2. Keep the #let at the beginning of each line
// 3. Use quotes for text values: "example"
// 4. Use numbers without quotes: 12pt, 2cm
// 5. Save the file and compile main.typ
// ============================================================================

// ============================================================================
// 📋 THESIS INFORMATION
// ============================================================================
// Edit your thesis details here - no separate file needed!

#let thesis-title = "AI-Based Personalized Recommendation System for Educational Content"
#let thesis-author = "John Smith"
#let student-id = "2020123456"
#let major = "Computer Science and Technology"
#let college = "College of Science and Technology"
#let supervisor = "Dr. Jane Wilson"
#let thesis-date = "May 15, 2024"
#let keywords = ("artificial intelligence", "personalized recommendation", "educational technology", "machine learning", "deep learning")

// ============================================================================
// 📁 DYNAMIC CONTENT GENERATION
// ============================================================================
// Configure automatic content loading from files

// Content directory path (relative to main.typ)
#let content-dir = "content/"

// File naming pattern for chapters (prefix_description.extension)
// Files matching this pattern will be automatically loaded as chapters
#let chapter-pattern = regex("^\\d{2}-.*\\.md$")

// Special files that should be handled separately (not as chapters)
#let special-files = (
  "abstract.md",
  "acknowledgments.md", 
  "appendices.md",
  "references/references.bib"
)

// Whether to enable dynamic content loading
// Set to false to use manual content loading (current behavior)
#let enable-dynamic-loading = true

// ----------------------------------------------------------------------------
// PAGE LAYOUT SETTINGS
// ----------------------------------------------------------------------------
// Customize the overall page layout and margins

// Paper size (options: "a4", "letter", "legal")
#let paper-size = "a4"

// Page margins (adjust these values to change spacing around content)
#let margin-top = 2.5cm      // Top margin
#let margin-bottom = 2.5cm   // Bottom margin  
#let margin-left = 3cm       // Left margin (binding side)
#let margin-right = 2cm      // Right margin

// Page numbering style (options: "1", "i", "I", "a", "A")
#let page-number-style = "1"

// Page number position (options: center, left, right)
#let page-number-position = center

// ----------------------------------------------------------------------------
// FONT AND TEXT SETTINGS
// ----------------------------------------------------------------------------
// Customize fonts and text appearance

// Main document font (examples: "Times New Roman", "Arial", "Calibri")
#let main-font = "Times New Roman"

// Main text size (examples: 10pt, 11pt, 12pt, 14pt)
#let text-size = 12pt

// Code font (examples: "Consolas", "Courier New", "Monaco")
#let code-font = "Consolas"

// Line spacing (1.0 = single, 1.5 = one and half, 2.0 = double)
#let line-spacing = 1.5em

// Text alignment (true = justified, false = left-aligned)
#let justify-text = true

// First line indent for paragraphs (0em = no indent, 1.2em = standard indent)
#let paragraph-indent = 0em

// ----------------------------------------------------------------------------
// HEADING STYLES
// ----------------------------------------------------------------------------
// Customize the appearance of chapter and section headings

// Chapter (Level 1) headings
#let chapter-font-size = 18pt        // Size of chapter titles
#let chapter-spacing-before = 2em    // Space before chapter title
#let chapter-spacing-after = 1.5em   // Space after chapter title

// Section (Level 2) headings  
#let section-font-size = 16pt        // Size of section titles
#let section-spacing-before = 1.5em  // Space before section title
#let section-spacing-after = 1em     // Space after section title

// Subsection (Level 3) headings
#let subsection-font-size = 14pt     // Size of subsection titles
#let subsection-spacing-before = 1em // Space before subsection title
#let subsection-spacing-after = 0.5em // Space after subsection title

// ----------------------------------------------------------------------------
// COVER PAGE SETTINGS
// ----------------------------------------------------------------------------
// Customize the appearance of your thesis cover page

// University logo size
#let logo-width = 4cm

// University name text size
#let university-name-size = 24pt

// "UNDERGRADUATE THESIS" text size
#let thesis-type-size = 20pt

// Your thesis title text size
#let thesis-title-size = 18pt

// Student information text size (name, ID, major, etc.)
#let student-info-size = 14pt

// ----------------------------------------------------------------------------
// ABSTRACT AND SPECIAL PAGES
// ----------------------------------------------------------------------------
// Settings for abstract, acknowledgments, and other special pages

// Title size for special pages ("ABSTRACT", "ACKNOWLEDGMENTS", etc.)
#let special-page-title-size = 18pt

// Spacing after special page titles
#let special-page-spacing = 1.5cm

// ----------------------------------------------------------------------------
// FIGURES AND TABLES
// ----------------------------------------------------------------------------
// Customize the appearance of figure and table captions

// Caption text size
#let caption-text-size = 10pt

// ----------------------------------------------------------------------------
// CODE BLOCKS
// ----------------------------------------------------------------------------
// Customize the appearance of code snippets

// Background color for code blocks (examples: "#f5f5f5", "#e8e8e8", "white")
#let code-background-color = "#f5f5f5"

// Padding inside code blocks
#let code-padding = 1em

// Rounded corners for code blocks
#let code-corner-radius = 0.3em

// ============================================================================
// END OF USER CONFIGURATION
// ============================================================================
// Do not modify anything below this line unless you know what you're doing!
// The implementation details are handled in main.typ
// ============================================================================
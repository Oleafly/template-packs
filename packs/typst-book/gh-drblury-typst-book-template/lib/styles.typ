// =============================================================================
// STYLES.TYP - Base styling functions for book templates
// =============================================================================

// -----------------------------------------------------------------------------
// Page Setup Functions
// -----------------------------------------------------------------------------

/// Configure page settings for different book formats
/// size: "a4", "a5", "letter", "6x9" (trade paperback)
#let setup-page(
  size: "a5",
  margin-inner: 2.5cm,
  margin-outer: 2cm,
  margin-top: 3cm,
  margin-bottom: 3cm,
) = {
  let paper = if size == "6x9" { (width: 6in, height: 9in) } else { size }
  
  if type(paper) == str {
    page(
      paper: paper,
      margin: (inside: margin-inner, outside: margin-outer, top: margin-top, bottom: margin-bottom),
      numbering: "1",
    )
  } else {
    page(
      width: paper.width,
      height: paper.height,
      margin: (inside: margin-inner, outside: margin-outer, top: margin-top, bottom: margin-bottom),
      numbering: "1",
    )
  }
}

// -----------------------------------------------------------------------------
// Typography Presets
// -----------------------------------------------------------------------------

/// Serif typography (novels, literary works)
#let typography-serif(body-size: 11pt, lang: "en") = {
  set text(
    font: "Linux Libertine O",
    size: body-size,
    lang: lang,
  )
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 1.5em,
  )
}

/// Sans-serif typography (technical, modern)
#let typography-sans(body-size: 10pt, lang: "en") = {
  set text(
    font: ("Inter", "Helvetica Neue", "Arial"),
    size: body-size,
    lang: lang,
  )
  set par(
    justify: true,
    leading: 0.7em,
  )
}

/// Monospace typography (code-heavy books)
#let typography-mono(body-size: 9pt) = {
  set text(
    font: ("JetBrains Mono", "Fira Code", "Consolas"),
    size: body-size,
  )
}

// -----------------------------------------------------------------------------
// Heading Styles
// -----------------------------------------------------------------------------

/// Classic heading style (traditional books)
#let headings-classic() = {
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(3em)
    align(center)[
      #text(size: 2em, weight: "bold", smallcaps(it.body))
    ]
    v(2em)
  }
  
  show heading.where(level: 2): set text(size: 1.4em, weight: "semibold")
  show heading.where(level: 3): set text(size: 1.2em, weight: "medium")
}

/// Modern heading style (technical books)
#let headings-modern() = {
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    block[
      #text(size: 0.9em, weight: "regular", fill: gray)[Chapter #counter(heading).display()]
      #v(0.5em)
      #text(size: 2.2em, weight: "bold")[#it.body]
    ]
    v(1.5em)
  }
  
  show heading.where(level: 2): it => {
    v(1.5em)
    text(size: 1.5em, weight: "semibold")[#it.body]
    v(0.8em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    text(size: 1.2em, weight: "medium")[#it.body]
    v(0.5em)
  }
}

/// Minimalist heading style (essays, literary)
#let headings-minimal() = {
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(4em)
    align(center)[
      #text(size: 1.6em, weight: "regular", style: "italic")[#it.body]
    ]
    v(3em)
  }
  
  show heading.where(level: 2): set text(size: 1.3em, weight: "medium")
  show heading.where(level: 3): set text(size: 1.1em, style: "italic")
}

/// Academic heading style (thesis, papers)
#let headings-academic() = {
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    text(size: 1.8em, weight: "bold")[
      #counter(heading).display("1.") #it.body
    ]
    v(1.5em)
  }
  
  show heading.where(level: 2): it => {
    v(1.2em)
    text(size: 1.4em, weight: "semibold")[
      #counter(heading).display("1.1.") #it.body
    ]
    v(0.8em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    text(size: 1.2em, weight: "medium")[
      #counter(heading).display("1.1.1.") #it.body
    ]
    v(0.5em)
  }
}

// -----------------------------------------------------------------------------
// Special Page Styles (for front/back matter)
// -----------------------------------------------------------------------------

/// Style for unnumbered front matter pages
#let front-matter-style() = {
  set page(numbering: none)
  counter(page).update(0)
}

/// Style for roman numeral pages (preface, toc)
#let roman-pages() = {
  set page(numbering: "i")
  counter(page).update(1)
}

/// Style for main content pages
#let main-content-style() = {
  set page(numbering: "1")
  counter(page).update(1)
}

// -----------------------------------------------------------------------------
// Drop Caps and Decorative Elements
// -----------------------------------------------------------------------------

/// Create a drop cap for chapter openings
#let drop-cap(letter, body, height: 2) = {
  let cap = text(size: height * 1.5em, weight: "bold")[#letter]
  box[
    #place(top + left, cap)
    #h(1.2em)
    #body
  ]
}

/// Decorative section break
#let section-break(symbol: "* * *") = {
  v(1em)
  align(center)[#text(size: 1.2em, tracking: 0.5em)[#symbol]]
  v(1em)
}

/// Ornamental divider
#let ornament(width: 30%) = {
  v(0.5em)
  align(center)[
    #line(length: width, stroke: 0.5pt + black)
  ]
  v(0.5em)
}

// -----------------------------------------------------------------------------
// Quote and Epigraph Styles
// -----------------------------------------------------------------------------

/// Styled block quote
#let styled-quote(body, attribution: none) = {
  block(
    inset: (left: 2em, right: 2em, top: 1em, bottom: 1em),
    stroke: (left: 2pt + gray),
  )[
    #text(style: "italic")[#body]
    #if attribution != none {
      v(0.5em)
      align(right)[#text(size: 0.9em)[--- #attribution]]
    }
  ]
}

/// Epigraph for chapter openings
#let epigraph(quote, author: none, source: none) = {
  align(right)[
    #block(width: 70%)[
      #text(style: "italic", size: 0.95em)[#quote]
      #v(0.3em)
      #if author != none or source != none {
        text(size: 0.85em)[
          --- #if author != none [#author]
          #if source != none [, #emph[#source]]
        ]
      }
    ]
  ]
  v(2em)
}

// -----------------------------------------------------------------------------
// Running Headers/Footers
// -----------------------------------------------------------------------------

/// Simple page numbers (bottom center)
#let footer-simple() = {
  set page(
    footer: context {
      align(center)[#counter(page).display()]
    }
  )
}

/// Book-style headers (chapter title on verso, section on recto)
#let header-book-style(title: none) = {
  set page(
    header: context {
      let page-num = counter(page).get().first()
      if calc.odd(page-num) {
        // Recto (right/odd page)
        align(right)[#text(size: 0.9em, style: "italic")[#title]]
      } else {
        // Verso (left/even page)
        let elems = query(selector(heading.where(level: 1)).before(here()))
        if elems.len() > 0 {
          align(left)[#text(size: 0.9em, style: "italic")[#elems.last().body]]
        }
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if calc.odd(page-num) {
        align(right)[#page-num]
      } else {
        align(left)[#page-num]
      }
    }
  )
}

// =============================================================================
// HYPERLINK STYLING
// =============================================================================
// Consistent styling for hyperlinks in documents

/// Apply a consistent link style throughout the document.
/// This show rule transforms all links to have the specified appearance.
/// 
/// Parameters:
/// - color: Link color (default: blue)
/// - underline: Whether to underline links (default: true)
/// - style: Text style for links (default: none)
/// - weight: Font weight for links (default: none)
/// 
/// Example:
/// ```typst
/// #show: link-style.with(color: rgb("#0066cc"))
/// 
/// Visit #link("https://example.com")[our website] for more info.
/// ```
#let link-style(
  color: rgb("#0066cc"),
  underline-links: true,
  style: none,
  weight: none,
  body,
) = {
  show link: it => {
    let styled = text(fill: color)[#it]
    let styled = if underline-links {
      underline(styled)
    } else {
      styled
    }
    let styled = if style != none {
      text(it, style: style)
    } else {
      styled
    }
    let styled = if weight != none {
      text(styled, weight: weight)
    } else {
      styled
    }
    styled
  }
  body
}

/// Create a styled external link with optional icon
/// 
/// Parameters:
/// - url: The URL to link to
/// - text: Display text (default: the URL)
/// - show-icon: Whether to show an external link icon (default: false)
/// - color: Link color (default: blue)
/// - underline: Whether to underline (default: true)
/// 
/// Example:
/// ```typst
/// #external-link("https://github.com", text: "GitHub", show-icon: true)
/// ```
#let external-link(
  url,
  text-content: none,
  show-icon: false,
  color: rgb("#0066cc"),
  underline-link: true,
) = {
  let display = if text-content != none { text-content } else { url }
  let icon = if show-icon { [ #box(baseline: 0.1em)[↗]] } else { [] }
  
  let content = text(fill: color)[#display#icon]
  let content = if underline-link { underline(content) } else { content }
  
  link(url, content)
}

/// Create an email link
/// 
/// Parameters:
/// - email: The email address
/// - text: Display text (default: the email address)
/// - color: Link color (default: blue)
/// 
/// Example:
/// ```typst
/// Contact us at #email-link("hello@example.com")
/// ```
#let email-link(
  email,
  text-content: none,
  color: rgb("#0066cc"),
) = {
  let display = if text-content != none { text-content } else { email }
  link("mailto:" + email, text(fill: color)[#display])
}

/// Style for internal document links (cross-references)
/// 
/// Parameters:
/// - color: Link color (default: darker blue for internal links)
/// - underline: Whether to underline (default: false for internal links)
/// 
/// Example:
/// ```typst
/// #show: internal-link-style.with(color: rgb("#333366"))
/// 
/// See #link(<section:intro>)[the introduction] for details.
/// ```
#let internal-link-style(
  color: rgb("#333366"),
  underline-links: false,
  body,
) = {
  // Internal links typically have label destinations
  show link: it => {
    // Check if this is likely an internal link (has a label)
    let styled = text(fill: color)[#it]
    if underline-links {
      underline(styled)
    } else {
      styled
    }
  }
  body
}

/// Apply print-friendly link styling (for documents meant to be printed)
/// Shows URLs after linked text for print versions.
/// 
/// Parameters:
/// - show-urls: Whether to show full URLs (default: true)
/// - url-color: Color for the URL text (default: gray)
/// 
/// Example:
/// ```typst
/// #show: print-link-style
/// 
/// Visit #link("https://example.com")[our website] for more info.
/// // Renders as: "our website (https://example.com)"
/// ```
#let print-link-style(
  show-urls: true,
  url-color: gray,
  body,
) = {
  show link: it => {
    // For print, we want to show the URL
    it
    if show-urls {
      if type(it.dest) == str and (it.dest.starts-with("http://") or it.dest.starts-with("https://")) {
        text(size: 0.85em, fill: url-color)[ (#it.dest)]
      }
    }
  }
  body
}

/// URL formatting utility - truncates long URLs for display
/// 
/// Parameters:
/// - url: The full URL
/// - max-length: Maximum display length (default: 50)
/// - show-protocol: Whether to show http(s):// (default: false)
/// 
/// Example:
/// ```typst
/// #link("https://example.com/very/long/path")[#format-url("https://example.com/very/long/path")]
/// ```
#let format-url(url, max-length: 50, show-protocol: false) = {
  let display = url
  
  // Remove protocol if not showing
  if not show-protocol {
    display = display.replace("https://", "").replace("http://", "")
  }
  
  // Truncate if too long
  if display.len() > max-length {
    display.slice(0, max-length - 3) + "..."
  } else {
    display
  }
}

/// Create a styled URL that shows the domain prominently
/// 
/// Parameters:
/// - url: The full URL
/// - color: Link color
/// 
/// Example:
/// ```typst
/// #domain-link("https://docs.example.com/api/v2/users")
/// // Displays: docs.example.com/api/v2/users (linked)
/// ```
#let domain-link(url, color: rgb("#0066cc")) = {
  let display = url.replace("https://", "").replace("http://", "")
  link(url, text(fill: color, underline(display)))
}

/// Footnote link - creates a footnote with the URL for accessibility
/// 
/// Parameters:
/// - url: The URL
/// - text: Display text
/// 
/// Example:
/// ```typst
/// Check out #footnote-link("https://example.com", "this resource") for more.
/// ```
#let footnote-link(url, text-content) = {
  link(url, text(fill: rgb("#0066cc"), underline(text-content)))
  footnote(text(size: 0.9em, url))
}

/// Link preset for academic/formal documents
/// Subtle styling, no underline, dark blue color
#let academic-link-style(body) = {
  show link: it => {
    text(fill: rgb("#003366"))[#it]
  }
  body
}

/// Link preset for technical documentation
/// Blue with underline, monospace for URLs
#let technical-link-style(body) = {
  show link: it => {
    text(fill: rgb("#0077cc"))[#underline(it)]
  }
  body
}

/// Link preset for marketing/casual documents
/// Bright colors, bold styling
#let casual-link-style(body) = {
  show link: it => {
    text(fill: rgb("#0099ff"), weight: "medium")[#it]
  }
  body
}

/// Link preset for high-contrast/accessibility
/// High contrast colors, clear underline
#let accessible-link-style(body) = {
  show link: it => {
    text(fill: rgb("#0000ee"))[#underline(stroke: 1.5pt + rgb("#0000ee"), offset: 2pt, it)]
  }
  body
}

// =============================================================================
// PDF BOOKMARKS / OUTLINE GENERATION
// =============================================================================
// Utilities for controlling PDF bookmark generation and document outlines

/// Configure automatic PDF bookmark generation.
/// PDF viewers will show bookmarks based on headings.
/// 
/// Parameters:
/// - depth: Maximum heading level to include (default: 3)
/// - indent: Indentation for outline entries (default: 1em)
/// - fill: Leader fill between title and page (default: dots)
/// 
/// Example:
/// ```typst
/// #show: setup-bookmarks.with(depth: 2)
/// ```
#let setup-bookmarks(
  depth: 3,
  indent: 1em,
  fill: repeat[.#h(0.25em)],
  body,
) = {
  // Configure which headings appear in the outline (and thus PDF bookmarks)
  set heading(outlined: true)
  
  // Set outline depth
  set outline(depth: depth, indent: indent, fill: fill)
  
  body
}

/// Generate a Table of Contents that also serves as the PDF bookmark source.
/// Typst automatically creates PDF bookmarks from outlined headings.
/// 
/// Parameters:
/// - title: TOC heading (default: "Contents")
/// - depth: How many heading levels to show (default: 3)
/// - indent: Indentation per level (default: 1.5em)
/// - fill: Leader fill (default: dots)
/// 
/// Example:
/// ```typst
/// #table-of-contents()
/// ```
#let table-of-contents(
  title: "Contents",
  depth: 3,
  indent: 1.5em,
  fill: repeat[. ],
) = {
  heading(level: 1, outlined: false)[#title]
  v(1em)
  outline(
    title: none,
    depth: depth,
    indent: indent,
    fill: fill,
  )
}

/// Create a heading that does NOT appear in bookmarks/outline.
/// Useful for front matter sections like Acknowledgments.
/// 
/// Parameters:
/// - level: Heading level (default: 1)
/// - body: Heading content
/// 
/// Example:
/// ```typst
/// #hidden-heading("Acknowledgments")
/// ```
#let hidden-heading(body, level: 1) = {
  heading(level: level, outlined: false)[#body]
}

/// Create a heading that appears in bookmarks but NOT in the printed TOC.
/// Useful for appendices or supplementary sections.
/// 
/// Note: In Typst, `outlined` controls both TOC and PDF bookmarks.
/// This function provides documentation of the pattern for selective inclusion.
/// 
/// Parameters:
/// - level: Heading level
/// - body: Heading content
/// - bookmarked: Whether to include in PDF bookmarks (default: true)
#let selective-heading(body, level: 1, bookmarked: true) = {
  heading(level: level, outlined: bookmarked)[#body]
}

/// Add a manual bookmark entry (appears in outline at current position).
/// This is achieved by creating an invisible heading.
/// 
/// Parameters:
/// - title: Bookmark title
/// - level: Bookmark level (default: 1)
/// 
/// Example:
/// ```typst
/// #add-bookmark("Appendix A: Supplementary Data")
/// ```
#let add-bookmark(title, level: 1) = {
  // Create an invisible heading for bookmark purposes
  show heading.where(level: level): it => {
    // Don't render this heading visually
    metadata(("bookmark", title))
  }
  heading(level: level, outlined: true)[#title]
}

/// Configure heading numbering for proper bookmark hierarchy
/// 
/// Parameters:
/// - format: Numbering format (default: "1.1")
/// - depth: Maximum depth to number (default: 3)
/// 
/// Example:
/// ```typst
/// #show: setup-heading-numbering.with(format: "1.1.1")
/// ```
#let setup-heading-numbering(
  format: "1.1",
  depth: 3,
  body,
) = {
  set heading(numbering: format)
  
  // Only show numbering up to specified depth
  show heading: it => {
    if it.level <= depth {
      it
    } else {
      // Remove numbering for deeper levels
      heading(level: it.level, numbering: none, outlined: it.outlined)[#it.body]
    }
  }
  
  body
}

/// Generate a structured outline with custom formatting.
/// 
/// Parameters:
/// - title: Outline title (default: "Table of Contents")
/// - depth: Maximum depth (default: 3)
/// - numbered: Show heading numbers (default: true)
/// - style: Outline style - "classic", "modern", "minimal" (default: "classic")
/// 
/// Example:
/// ```typst
/// #styled-outline(style: "modern")
/// ```
#let styled-outline(
  title: "Table of Contents",
  depth: 3,
  numbered: true,
  style: "classic",
) = {
  heading(level: 1, outlined: false)[#title]
  v(1em)
  
  if style == "modern" {
    // Modern: clean, no dot leaders
    outline(
      title: none,
      depth: depth,
      indent: auto,
      fill: none,
    )
  } else if style == "minimal" {
    // Minimal: just chapter titles, no indentation
    outline(
      title: none,
      depth: 1,
      indent: 0em,
      fill: h(1fr),
    )
  } else {
    // Classic: traditional with dot leaders
    outline(
      title: none,
      depth: depth,
      indent: 1.5em,
      fill: repeat[.#h(0.25em)],
    )
  }
}

/// Exclude specific headings from the outline/bookmarks by content.
/// Apply this to exclude headings matching certain patterns.
/// 
/// Example:
/// ```typst
/// #show: exclude-from-outline.with(patterns: ("Exercises", "Solutions"))
/// ```
#let exclude-from-outline(
  patterns: (),
  body,
) = {
  show heading: it => {
    let should-exclude = patterns.any(p => {
      let content-str = if it.body.has("text") { it.body.text } else { "" }
      content-str.contains(p)
    })
    
    if should-exclude {
      heading(level: it.level, outlined: false, numbering: it.numbering)[#it.body]
    } else {
      it
    }
  }
  body
}

/// Part heading - higher-level grouping above chapters.
/// Creates a distinct page for book parts.
/// 
/// Parameters:
/// - number: Part number (e.g., "I", "II", "1", "2")
/// - title: Part title
/// - subtitle: Optional subtitle
/// 
/// Example:
/// ```typst
/// #part-heading("I", "Foundations")
/// ```
#let part-heading(number, title, subtitle: none) = {
  pagebreak()
  
  // This will appear in bookmarks
  heading(level: 1, numbering: none)[Part #number: #title]
  
  // Visual rendering (centered, large)
  v(1fr)
  align(center)[
    #text(size: 1.2em, tracking: 0.3em)[PART #number]
    #v(1em)
    #text(size: 2.5em, weight: "bold")[#title]
    #if subtitle != none {
      v(0.5em)
      text(size: 1.2em, style: "italic")[#subtitle]
    }
  ]
  v(1fr)
  pagebreak()
}

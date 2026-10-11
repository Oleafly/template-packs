// ============================================================================
// PULP NOVEL TEMPLATE
// A Typst template for mass-market paperback aesthetics (1990s style)
// ============================================================================

// Import all modules
#import "config.typ": *
#import "page-setup.typ": *
#import "headers.typ": *
#import "content.typ": *
#import "front-matter.typ": *
#import "back-matter.typ": *

// Main template function
#let pulp-template(
  title: none,
  subtitle: none,
  author: none,
  publisher: none,
  year: none,
  isbn: none,
  body
) = {
  // Use provided config or defaults
  let config = (
    title: if title != none { title } else { default-config.title },
    subtitle: if subtitle != none { subtitle } else { default-config.subtitle },
    author: if author != none { author } else { default-config.author },
    publisher: if publisher != none { publisher } else { default-config.publisher },
    year: if year != none { year } else { default-config.year },
    isbn: if isbn != none { isbn } else { default-config.isbn },
  )

  // Apply basic page setup
  show: apply-page-setup()
  show: apply-text-setup()
  show: apply-paragraph-setup()

  // Execute body (which should include front matter, content, and back matter)
  body
}

// Export everything
#let make-config = default-config

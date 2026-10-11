// =============================================================================
// TYPST BOOK TEMPLATE SYSTEM - Main Entry Point
// =============================================================================
// This is an example demonstrating the technical book template.
// See other examples in the examples/ folder.
//
// Available templates:
//   - templates/novel.typ     - Fiction, memoirs, literary works
//   - templates/technical.typ - Programming books, manuals, docs
//   - templates/academic.typ  - Theses, dissertations, research papers
//
// Compile with: typst compile main.typ output/book.pdf --root .
// =============================================================================

#import "templates/technical.typ": *

#show: technical.with(
  title: "The Typst Book Template",
  subtitle: "A Guide to Beautiful Documents",
  author: "Your Name",
  version: "1.0.0",
  date: "December 2025",
)

= Introduction

Welcome to the Typst Book Template system! This collection of templates makes it easy to create professional-looking books for different purposes.

== What's Included

This template system provides:

- *Three book templates* for different use cases
- *Reusable components* for common book elements
- *Styling utilities* for consistent typography

#tip[
  Check out the `examples/` folder for complete book examples using each template.
]

== Quick Start

To use a template, import it and apply the show rule:

```typst
#import "templates/technical.typ": *

#show: technical.with(
  title: "My Book Title",
  author: "Author Name",
)

= First Chapter
Your content here...
```

= Template Overview

== Novel Template

The novel template (`templates/novel.typ`) is designed for fiction and literary works.

#note[
  Perfect for: novels, short story collections, memoirs, creative non-fiction.
]

*Key features:*
- Elegant serif typography
- Scene breaks and part dividers
- Epigraphs and dedication pages
- Letter inserts for epistolary content

== Technical Template

The technical template (this one!) is optimized for programming books and documentation.

*Key features:*
- Clean sans-serif typography
- Syntax-highlighted code blocks
- Callout boxes (notes, tips, warnings)
- Definition lists for API docs

#warning[
  This template uses numbered headings by default. You can customize this in the template settings.
]

== Academic Template

The academic template (`templates/academic.typ`) follows scholarly conventions.

*Key features:*
- Formal thesis/dissertation structure
- Theorem and proof environments
- Bibliography support
- List of figures/tables

= Components Reference

The `lib/components.typ` file provides reusable building blocks:

== Title Pages

```typst
#title-page(
  title: "Book Title",
  subtitle: "Optional Subtitle",
  author: "Author Name",
  publisher: "Publisher",
  date: "Date",
)
```

== Table of Contents

Several TOC styles are available:

#def-list(
  (term: "toc-classic", desc: "Traditional indented TOC with page numbers"),
  (term: "toc-minimal", desc: "Clean TOC without fill dots"),
  (term: "toc-dotted", desc: "TOC with dotted leaders"),
  (term: "toc-chapters-only", desc: "Shows only level-1 headings"),
)

== Glossary

Create glossaries with automatic alphabetical sorting:

```typst
#glossary-page(entries: (
  (term: "API", definition: "Application Programming Interface"),
  (term: "CLI", definition: "Command Line Interface"),
))
```

== Special Pages

- `dedication-page()` - For book dedications
- `copyright-page()` - Legal and publishing info
- `acknowledgments-page()` - Thank you page
- `about-author-page()` - Author bio
- `preface-page()` - Preface or foreword

= Styling Guide

== Callout Boxes

Use callouts to highlight important information:

#note[
  This is a *note* callout for general information.
]

#tip[
  This is a *tip* callout for helpful suggestions.
]

#warning[
  This is a *warning* callout for potential issues.
]

#danger[
  This is a *danger* callout for critical warnings.
]

#important[
  This is an *important* callout for key points.
]

== Code Blocks

Inline code looks like `this`, and code blocks are styled automatically:

```python
def greet(name: str) -> str:
    """Return a greeting message."""
    return f"Hello, {name}!"

if __name__ == "__main__":
    print(greet("World"))
```

Use the `code-listing` function for code with filenames:

#code-listing(
  filename: "example.py",
  language: "python",
  caption: "A simple Python greeting function",
  ```
def hello():
    print("Hello, World!")
  ```.text,
)

== Keyboard Shortcuts

Show keyboard shortcuts with the `kbd` function: Press #kbd("Ctrl") + #kbd("S") to save.

== Exercises

#exercise(number: "1.1", difficulty: "easy")[
  Write a "Hello, World!" program in your favorite language.
]

#solution[
  Here's the solution in Python:
  ```python
  print("Hello, World!")
  ```
]

= Customization

== Fonts

Templates use fallback font stacks. Update the font family in the template's `set text()` rule:

```typst
set text(
  font: ("Your Font", "Fallback Font"),
  size: 11pt,
)
```

== Colors

Callout colors and other styling can be customized by modifying the template files.

== Page Layout

Adjust margins and paper size in the template's `set page()` rule:

```typst
set page(
  paper: "a4",
  margin: (inside: 3cm, outside: 2cm, top: 2.5cm, bottom: 2.5cm),
)
```

= Conclusion

This template system gives you a solid foundation for creating professional books. Start with the template that best fits your content type, then customize as needed.

Happy writing!

// Back matter
#pagebreak()

#glossary-page(
  title: "Glossary",
  (
    (term: "Typst", definition: "A modern typesetting system designed for ease of use and powerful output."),
    (term: "Template", definition: "A pre-designed document structure that can be customized for specific needs."),
    (term: "Callout", definition: "A highlighted box used to draw attention to important information."),
    (term: "TOC", definition: "Table of Contents - a list of chapters/sections with page numbers."),
    (term: "Front matter", definition: "The pages before the main content: title page, copyright, dedication, etc."),
    (term: "Back matter", definition: "The pages after the main content: glossary, index, bibliography, etc."),
  )
)

#import "biomath_template.typ": *
////////////////////////////////////////////////////////////////
// DOCUMENT BEGINS HERE - This is the actual presentation content
////////////////////////////////////////////////////////////////
//
// ZOTERO CITATION USAGE:
// 1. Export your Zotero library as BibTeX (File > Export Library > BibTeX)
// 2. Place the .bib file in the same folder as your presentation
// 3. Use citations like: @key2024  or  [@key2024]
// 4. Display references with: #show-references("your-file.bib")

#show: doc => biomath-template(
  title: "Your Presentation Title",
  subtitle: "Optional Subtitle",
  authors: "Your Name",
  email: "your.email@ugent.be",
  institute: "Your Institute",
  date: "May 21, 2025",
  doc,
)

// First regular slide
#slide(title: "Introduction")[
  = Introduction

  This is a sample slide with some text.
  
  Example citation (when you have a .bib file):
  According to @debroy2024, this approach is effective.
  Multiple citations: [@debroy2024; @meys2023]
  
  #note[
    This is a note block similar to the LaTeX template.
  ]
]

// Second slide
#slide()[
  = Code Example

  Here's an example of code:

  ```python
  def hello_world():
      print("Hello, world!")
      return True
  ```
]

// Third slide with blocks
#slide()[
  = Blocks Example

  #note[
    This is a standard block
  ]

  #warning[
    This is an alert block
  ]

  #example[
    This is an example block
  ]
]

// Section slide with subsection
#slide(title: "Section Title", subtitle: "Subsection")[
  = Section Title
  == Subsection

  Content for this section...
]

// ============================================================================
// REFERENCES - Uncomment to use Zotero bibliography
// ============================================================================
#show-references("references.bib", style: "chicago-author-date")

// Continue with more slides as needed

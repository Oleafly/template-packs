// Import presentation library
#import "@preview/touying:0.8.0": *

// Import UCPH theme for touying
#import "ucph.typ": *

// Configure slides with either Danish ("da") or English ("en") labels
#show: ucph-theme.with(language: "da")
// Alternatively, using default setting (english language)
//   #show: ucph-theme


// Create title slide
#title-slide(title: "Example UCPH presentation", author: [
  The Data Analytics Platform \
  Mikkel Schubert
])


// Start a new section, using the title "My first section".
// This also starts a new section in the table of content in the resulting PDF
= My first section

// Optionally create a table of content side. `depth: 1` (or no arguments) lists
// only sections, while `depth: 2` lists both sections and pages. The current
// section is automatically highlighted
#toc-slide(depth: 2)

// Start a new page, using the title "My Examples"
// This also creates a new page
== Examples

- A presentation using this template consists of
  - 1 or more sections, created by `= Section title` \
  - 1 or more pages, created by `== Page title` \
- Footnotes are added via `#footnote[the text goes here]`#footnote[the text goes here]
- Images are added via `image("filename.jpg")`:
  #code-block[
    ```typst
    #place(top + right, image("images/sund.svg"))
    ```
  ]
- Formatting via _markdown_ or #strong[functions]
  #code-block[
    ```typst
    Formatting via _markdown_ or #strong[functions]
    ```
  ]

#place(top + right, image("images/sund.svg"))

== References

- #link("https://github.com/cbmr-data/templates/typst-ucph-presentation")[This template]
// Naked URLs are automatically converted to hyperlinks
- Typst: https://github.com/typst/typst
- #link("https://typst.app/universe/")[Packages for typst]
  - #link("https://typst.app/universe/package/touying/")[Touying presentations]
- #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[Tinymist LSP] for VS Code

// Place the example code at the bottom of the page
#place(bottom, code-block[
  ```typst
  // Naked URLs are automatically converted to hyperlinks
  - Typst: https://github.com/typst/typst
  - #link("https://typst.app/universe/")[Packages for typst]
    - #link("https://typst.app/universe/package/touying/")[Touying presentations]
  - #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[Tinymist LSP] for VS Code
  ```
])

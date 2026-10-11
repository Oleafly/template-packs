#import "../core/preamble.typ": *

= Content Elements <sec-content>

// Highlighted box for key messages
#slide(title: "Highlighting Key Messages", color: col2)[

  #box-text(
    [How can we design better software systems?],
    color: col2,
    width: 80%,
  )

  #v(0.5cm)

  Use `box-text` for important questions, takeaways, or quotes:

  ```typst
  #box-text([Your message], color: col2, width: 80%)
  ```
]

// Text styling and accent-textasis
#slide(title: "Text Styling & Colors", color: col2, composer: (1fr, 1fr))[
  *Basic markup:*
  - `*bold*` → *bold text*
  - `_italic_` → _italic text_
  - `` `code` `` → `inline code`

  #v(0.4cm)

  *Colored accent-textasis:*

  #(accent-text)([Default accent-textasis], color: col1) \
  #(accent-text)([Custom color], color: col3)

  #v(0.4cm)

  Status: #text(fill: green, weight: "bold")[active] or #text(fill: red, weight: "bold")[inactive]
][
  *Lists:*
  - Default bullets
  - Nested items
    - Sub-item

  #v(0.3cm)

  #set list(marker: $bullet.tri$)
  - Triangle marker
  - Custom style

  #v(0.3cm)

  *Numbered:*
  + First step
  + Second step
  + Third step
]

// Math and code blocks
#slide(title: "Math & Code", color: col2, composer: (1fr, 1fr))[
  *Display equations:*

  $f(x) = sum_(i=1)^n a_i x^i$

  #v(0.3cm)

  Inline math: the ratio is $r = k\/n$.

  #v(0.5cm)

  *Inline code:*

  Use `process(data, method="fast")` to run the algorithm.
][
  *Code blocks:*

  ```python
  def process_data(items):
      result = []
      for item in items:
          result.append(item * 2)
      return result
  ```

  Syntax highlighting included!
]

// Links and citations
#slide(title: "Links & Citations", color: col2)[

  *External links* (auto-styled in blue):

  - #link("https://github.com/")[GitHub]
  - #link("https://docs.python.org/")[Python Documentation]
  - #link("https://www.typst.app/")[Typst]

  #v(0.5cm)

  *Citations:*

  Use `cite-footnote` for references #cite-footnote(<dijkstraNoteTwoProblems1959>).

]

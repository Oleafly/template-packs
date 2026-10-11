// Example FHNW Presentation
// This demonstrates all features of the fhnw-presentation template

#import "lib.typ": *

#show: fhnw-theme.with(
  title: "Example Presentation",
  subtitle: "Template Demonstration",
  authors: ("Your Name",),
  email: "your.email@fhnw.ch",
  date: "December 2024",
  logo: "assets/fhnw-logo.png",
)

= Agenda

1. Basic Slides
2. Layouts
3. Content Blocks
4. Special Elements

#section-slide(
  "Basic Slides",
  subtitle: "Introduction to slide basics"
)

== Slide with Bullet Points

Basic content with bullet points:

- First point
- Second point with _emphasis_
- Third point with #alert[highlighted] text

#v(0.5em)

Use `#section-slide("Name")` or `#section-slide("Name", subtitle: "Description")` to create section dividers.

== Lists and Numbering

Numbered list:

1. First item
2. Second item
   - Nested bullet
   - Another nested item
3. Third item

#section-slide[Layouts]

== Two-Column Layout

#two-columns[
  *Left Column*

  - Point A
  - Point B
  - Point C
][
  *Right Column*

  - Point X
  - Point Y
  - Point Z
]

== Three-Column Layout

#three-columns[
  *Column 1*

  Left content here
][
  *Column 2*

  Center content here
][
  *Column 3*

  Right content here
]

#section-slide[Content Blocks]

== Example Block

#example-block(title: "Example")[
  Example content here
]

== Definition Block

#definition-block(title: "Definition")[
  Definition content here
]

== Alert Block

#alert-block(title: "Important")[
  Alert content here
]

== Code Block

#code-block[
```python
def greet(name):
    print(f"Hello, {name}!")
    return True

greet("FHNW")
```
]

#section-slide[Special Elements]

== Tables

#figure(
  table(
    columns: 3,
    [*Header 1*], [*Header 2*], [*Header 3*],
    [Row 1], [Data A], [Data B],
    [Row 2], [Data C], [Data D],
    [Row 3], [Data E], [Data F],
  ),
  caption: "Example table with sample data"
)

== Math and Formulas

Inline math: $E = m c^2$

Display equation:

$ integral_0^infinity e^(-x) dif x = 1 $

== Text Styling

- *Bold text* with bold
- _Emphasized text_ with italics
- #text(fill: fhnw-red)[Colored text] with colors
- `Monospace` for code
- #link("https://typst.app")[Links]

#section-slide(
  "Advanced Layouts",
  subtitle: "Additional layout options"
)

== Side-by-Side Layout

#side-by-side(
  image("images/campus-architecture.jpeg"),
  [
    *Modern Campus*

    This side-by-side layout combines
    images and text seamlessly.

    - Perfect for visual presentations
    - Flexible width ratios
    - Works with any content type

    You can place an image on the left
    and text on the right, or adjust
    the width to your needs.
  ]
)

== Key Points

#key-points(
  points: (
    [*Point One*\
    Description of the first key point],
    [*Point Two*\
    Description of the second key point],
    [*Point Three*\
    Description of the third key point],
    [*Point Four*\
    Description of the fourth key point],
  ),
  columns: 2
)

== Thank You

#v(4em)

#align(center)[
  #text(size: 24pt)[*Thank You!*]

  #v(2em)

  #text(size: 14pt)[
    Your Name\
    #text(fill: fhnw-dark-gray)[your.email\@fhnw.ch]
  ]
]

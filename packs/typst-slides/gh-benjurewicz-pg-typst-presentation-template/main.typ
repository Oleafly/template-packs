#import "@preview/touying:0.7.2": *
#import "university.typ": *
#import "@preview/numbly:0.1.0": numbly

// This template is designed for Gdańsk University of Technology (PG) presentations.
// It is based on the Touying package and a custom university theme.
#show: university-theme.with(
  aspect-ratio: "16-9",
  // You can disable the university logo in the header of normal slides
  logo-in-header: false,
  config-info(
    title: [PG Presentation Touying Template],
    subtitle: [Typst Rocks],
    // Authors are now provided as structured dictionaries
    authors: (
      (name: "Author", surname: "A", email: "author.a@pg.edu.pl"),
      (name: "Author", surname: "B", email: "author.b@pg.edu.pl"),
    ),
    date: datetime.today(),
    institution: [Gdańsk University of Technology],
    // The big logo is used on the title slide and the last slide
    logo: image("logos/pg-logo-big-en.png", height: 3cm),
    // The small logo can be used in the header of normal slides
    logo-small: image("logos/pg-logo-small-en.png", height: 8mm),
  ),
)

// Set the numbering style for headings
#set heading(numbering: numbly("{1}.", default: "1.1"))

// --- Title Slide ---
#title-slide()

// --- Table of Contents ---
#outline-slide()

= Introduction

== Overview of Touying

Touying is a powerful Typst package for creating presentation slides.
It supports various features like:

- Dynamic content with `#pause` and `#uncover`
- Custom themes (like this PG theme)
- Different slide layouts (matrix, focus, etc.)
- Automatic section slides

#pause

*This slide demonstrates the `#pause` feature.*

== Text and Image Layout

#slide(composer: (1fr, 1fr))[
  You can easily create side-by-side layouts using the `composer` argument.

  On the left, we have some descriptive text about the university.

  - Founded in 1904
  - One of the oldest universities in Poland
  - Located in the beautiful city of Gdańsk
][
  #image("pg-example-image.jpg", width: 100%)
  #place(bottom + right, dx: -5pt, dy: -5pt)[
    #text(size: 0.6em, fill: gray)[PG Main Building]
  ]
]

= Technical Content

#repeated-section-title-slide()
This slide demonstrates the `repeated-section-title-slide` helper from `university.typ`.

- It reads the current top-level heading (here: *Technical Content*).
- It renders that heading as an unnumbered slide title.
- It is useful as a visual section divider before detailed slides.

Use it directly after a `= Section` heading when you want a clean transition:

```typst
#repeated-section-title-slide()
```

== Mathematics in PG Style

As a technical university, math is essential. Equations are rendered in black for maximum readability while the rest of the template stays blue.

$ cal(F)(h(t)) = H(f) = integral_(-infinity)^(+infinity) h(t) e^(-i 2 pi f t) dif t $

You can also use inline math: $E = m c^2$. Citations work seamlessly too @typst2024.

== Source Code with Syntax Highlighting

Code blocks are also rendered in black with standard syntax highlighting, making them easy to read during presentations.

```python
def hello_pg():
    university = "Gdańsk University of Technology"
    print(f"Welcome to {university}!")

hello_pg()
```

= Advanced Layouts

== Matrix Slide

The `matrix-slide` displays content in a checkerboard grid.
It supports various configurations for rows and columns.

#matrix-slide[
  left
][
  middle
][
  right
]

#matrix-slide(columns: 1)[
  top
][
  bottom
]

#matrix-slide(columns: (1fr, 2fr, 1fr), ..(lorem(8),) * 9)

== Focus Slide

#focus-slide[
  *FOCUS SLIDE*

  Use this for important messages or transitions.
  It uses the primary color as the background.
]

= References

== Bibliography

#bibliography("refs.bib", title: none, style: "ieee")

= Conclusion

== Thank You!

This template provides a solid foundation for your PG presentations.

- Minimalist and professional design
- Compliant with university colors
- Easy to use and customize

#last-slide[
  Thank you for your time!

  Questions?
]

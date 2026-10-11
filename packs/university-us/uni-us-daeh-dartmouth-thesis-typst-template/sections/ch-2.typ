#import "/dcthesis.typ": short
#import "/utils/refs.typ": bib-section
#import "/utils/apa7.typ": apa7-style, print-apa7-bibliography
#import "@preview/pergamon:0.8.0": *

#let style = apa7-style()

#refsection(style: style)[

= Citations and References

This chapter demonstrates how to use citations and per-chapter bibliographies. This template uses #link("https://typst.app/universe/package/pergamon/")[Pergamon] (v0.8.0) for bibliography management, which provides per-chapter bibliographies through `refsection` and full control over citation and reference formatting through Typst code.

== Bibliography Setup

=== Loading Bibliography Data

Bibliography entries are loaded in `main.typ` using Pergamon's `add-bib-resource`:

```typst
#import "@preview/pergamon:0.8.0": *
#add-bib-resource(read("/references.bib"))
```

The `read` function loads the BibLaTeX `.bib` file as a string, and Pergamon parses it. You can call `add-bib-resource` multiple times to load from multiple files. The optional `sentence-case-titles` parameter (default `false`) controls whether titles are converted to sentence case.

=== Per-Chapter Bibliographies

Each chapter that uses citations wraps its content in a `refsection` and ends with a `print-bibliography` call. Only the references cited within that refsection appear in its bibliography:

```typst
#import "@preview/pergamon:0.8.0": *
#import "/utils/apa7.typ": apa7-style, print-apa7-bibliography
#import "/utils/refs.typ": bib-section

#let style = apa7-style()

#refsection(style: style)[
  = My Chapter
  Some text with a citation #citep("key").

  #bib-section[
    #print-apa7-bibliography(style)
  ]
]
```

The `bib-section` utility from `utils/refs.typ` adds APA-compliant formatting (hanging indent, proper heading style). The `apa7-style()` function from `utils/apa7.typ` provides a custom APA 7th edition citation and reference style.

== Citation Forms

Pergamon 0.8.0 provides several convenience functions for different citation forms. All take string keys (not labels).

=== Parenthetical Citations

Use `citep` for parenthetical citations where the entire reference is in parentheses:

- `#citep("shepard1987")` produces: #citep("shepard1987")
- `#citep("fodor1988")` produces: #citep("fodor1988")

=== Narrative Citations

Use `citet` for narrative (textual) citations where the author name is part of the sentence:

- `#citet("heidersimmel1944")` produces: #citet("heidersimmel1944")

For example: #citet("heidersimmel1944") demonstrated that observers attribute intentions to geometric shapes.

=== Possessive Citations

Use `citeg` for possessive citations:

- `#citeg("moggi1991")` produces: #citeg("moggi1991")

For example: #citeg("moggi1991") formalism unified several computational paradigms.

=== Author-Only and Year-Only

Use `citename` for the author name alone, and `citeyear` for the year alone:

- `#citename("shepard1987")` produces: #citename("shepard1987")
- `#citeyear("shepard1987")` produces: #citeyear("shepard1987")

=== Multiple Citations

Pass multiple keys to cite several works together:

- `#citep("fodor1988", "moggi1991")` produces: #citep("fodor1988", "moggi1991")

=== Bare Citations

Use `citen` for citations without parentheses:

- `#citen("shepard1987")` produces: #citen("shepard1987")

== Tables, Figures, and Data

This section demonstrates how to include tables, figures, and dynamically loaded data in your thesis.

=== Reading External Data

Typst can read values from external files, which is useful for reporting statistics that may change as you refine your analysis. For example, the participant count can be stored in a separate file and inserted into the text.

#let n-participants = read("../data/participants.txt").trim()

In our study, #emph[n] = #n-participants participants completed the experimental protocol. This value is read from `data/participants.txt`, so updating that file automatically updates the manuscript.

=== Tables

Tables are created using the `table` function and wrapped in `figure` for captioning and cross-referencing.

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    table.header([*Condition*], [*Mean*], [*SD*], [*_n_*]),
    [Control], [2.34], [0.89], [14],
    [Treatment A], [3.67], [1.12], [15],
    [Treatment B], [4.21], [0.95], [13],
  ),
  caption: [Descriptive statistics by experimental condition.],
) <tab:descriptives>

As shown in @tab:descriptives, Treatment B produced the highest mean response. Tables can be cross-referenced using their label (e.g., `@tab:descriptives`).

=== Figures

Figures are inserted using the `image` function, also wrapped in `figure` for captioning.

#figure(
  rect(
    width: 80%,
    height: 2in,
    fill: luma(95%),
    stroke: 0.5pt,
    align(center + horizon)[
      _Placeholder for figure_ \
      Replace with: `image("figures/your-image.png")`
    ],
  ),
  kind: image,
  caption: [Example figure placeholder. Replace with actual image using `image("path/to/file.png")`.],
) <fig:example>

@fig:example shows a placeholder that can be replaced with an actual image. Supported formats include PNG, JPEG, SVG, and PDF.

To insert an actual image:

```typst
#figure(
  image("figures/results.png", width: 80%),
  caption: [Experimental results across conditions.],
) <fig:results>
```

// Per-chapter bibliography
#bib-section[
  #print-apa7-bibliography(style)
]

] // end refsection

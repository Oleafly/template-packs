#import "../paper-typoster.typ": *

#show: paper-typoster.with(
  title: [#text(fill: sea)[Paper-Typoster]: A Synthetic Dense Poster Example],
  subtitle: [Demonstrating sections, text boxes, figures, tables, code, math, and layout metadata],
  authors: [Ada Researcher, Ben Template, Chao Layout, Dana Typesetter],
  affiliations: [Open Example Lab, Department of Reproducible Documents],
  left-logo: image("figures/example-university.svg", height: 3.65in),
  right-logo: image("figures/posterconf.svg", height: 2.45in),
  theme: "sky",
  size: "48x36",
  base-size: 26pt,
)

#poster-grid(
  columns: 3,

  poster-section[Motivation][
    Academic posters often need to carry dense technical content without losing a stable visual hierarchy. Paper-Typoster keeps the poster surface fixed while authors iterate on section content.

    The public example is synthetic. It mirrors the density of a real research poster but does not include private paper figures, institution logos, source maps, or unpublished claims.

    #figure(
      image("figures/problem_diagram.pdf", width: 100%),
      caption: [A synthetic problem diagram rendered from LaTeX.],
    )

    Paper-Typoster separates measurement from rendering: sections are measured at their natural height, then assigned to columns by a DP splitter that minimizes the tallest column.
  ],

  poster-section[Contributions][
    - *A local-first poster entry.* `paper-typoster` sets page size, theme, title band, typography, captions, and footer behavior.
    - *A flat authoring model.* Authors pass sections in reading order; `poster-grid` chooses column breaks without reordering content.
    - *A layout metadata path.* The grid exports structured facts that can be checked by `tools/poster-check.py`.
    - *A compact component set.* `poster-section`, `textbox`, `*bold*`, and figure/table captions cover the common poster surface.
    - *Theme variants.* Built-in themes (`sky`, `sunset`) control the color palette without changing the structural API.

    #textbox[
      The template fixes the visual grammar. When a poster is crowded or sparse, revise content rather than changing the style.
    ]
  ],

  poster-section[Template Syntax][
    ```typst
    #import "paper-typoster.typ": *

    #show: paper-typoster.with(
      title: [My Poster],
      authors: [Author A, Author B],
      affiliations: [Example Lab],
      theme: "sky",
      size: "48x36",
    )

    #poster-grid(
      poster-section[Intro][...],
      poster-section[Method][...],
      poster-section[Results][...],
    )
    ```

    The same entry point can be copied into a paper-specific poster project and used with local PDF figures.

    Logo images are passed via `left-logo` and `right-logo`; omit either to let the title band expand.
  ],

  poster-section[Construction Pipeline][
    #figure(
      image("figures/pipeline_diagram.pdf", width: 100%),
      caption: [Synthetic flow showing the poster iteration loop.],
    )

    - *Draft.* Write ordinary Typst content inside section bodies.
    - *Measure.* Each section is measured at the final column width.
    - *Partition.* The DP splitter minimizes the tallest natural column while preserving order.
    - *Check.* The external checker reports visual balance and possible flow compression.

    The pipeline is iterative. After each round of content editing, recompile and run the checker to see which column is too short or too tall.
  ],

  poster-section[Layout Metadata][
    `poster-grid` emits a metadata record labeled `<paper-typoster-layout>`. The record includes section heights, split points, column natural heights, rendered heights, base size, gutter, and section gap.

    ```bash
    typst query --root . poster.typ \
      '<paper-typoster-layout>' \
      --field value --one --format json > layout.json

    python tools/poster-check.py layout.json \
      --rules tools/poster-rules.toml
    ```

    #textbox[
      A checker warning is a content-editing signal. Move, trim, merge, or add sections near the reported boundary.
    ]

    The checker compares column heights against configurable thresholds in `poster-rules.toml`.
  ],

  poster-section[Component Surface][
    #textbox(
      [
        *Text boxes.* Use `textbox` for short highlighted explanations, grouped definitions, or compact reminders.
      ],
      [
        *Emphasis.* Prefer `*bold*`; optional helpers such as #red[red], #yellow[yellow], #bred[bred], and #byellow[byellow] exist for limited use.
      ],
    )

    #v(0.35em)
    Equations can be placed directly in section content:

    $ S = (1 / K) sum_(k=1)^K m_k $

    Lists, equations, boxes, code, figures, and tables all participate in the same section measurement pass.

    This matters for authoring because the poster can stay declarative. The section body remains ordinary Typst content, while the grid handles measurement and column grouping.

    $ cal(L) = - sum_(i=1)^N y_i log hat(y)_i + (1 - y_i) log(1 - hat(y)_i) $

    Inline math such as $alpha = 0.05$ and $n = 128$ can appear anywhere in running text. Multi-cell text boxes accept comma-separated content blocks rendered as distinct cells within the same container.
  ],

  poster-section[Table Counter][
    #figure(
      image("figures/checker_outcomes.pdf", width: 100%),
      kind: table,
      caption: [Synthetic checker outcomes using the independent Table counter.],
    )

    Paper tables can be rendered externally as cropped PDFs and embedded with `#image(...)`. Add `kind: table` so the caption uses the table counter rather than the figure counter.

    #textbox[
      The table path is useful when a paper already has carefully formatted LaTeX tables. Render once, crop tightly, then place the PDF as a figure with `kind: table`.
    ]

    Figures and tables share `#figure(...)` but their counters increment independently.
  ],

  poster-section[Results][
    #figure(
      image("figures/layout_signals.pdf", width: 100%),
      kind: table,
      caption: [Synthetic before-and-after layout signals.],
    )

    - *Visual balance* improves when the short column receives content that belongs near the adjacent boundary.
    - *Flow compression* should stay absent; otherwise content is being forced into a fixed vertical space.
    - *Preview images* should be regenerated after visible poster changes.
    #v(0.3em)
    This section is written like a real result block: a compact table, interpretation bullets, and a paragraph that explains how the numbers should guide the next edit.
  ],

  poster-section[Conclusion][
    #textbox[
      - Paper-Typoster provides a compact Typst poster API for local project use.
      - The public example is deliberately synthetic, but dense enough to show normal poster pressure.
      - The checker turns layout iteration into concrete content edits while the template style remains unchanged.
    ]

    The final poster should feel like a real conference artifact: full, readable, and consistent. The example demonstrates that goal without depending on private research assets.

    #v(0.3em)
    A downstream paper project can replace every synthetic figure and table here with real assets while keeping the same section structure and template calls.

    The example is full enough to show realistic poster pressure, but every item is replaceable project content rather than a custom style rule.

    Two built-in themes (`sky` and `sunset`) cover common conference color schemes; switching requires only a one-line change to the entry call.

    #textbox[
      To start a new poster from this template, copy `examples/poster.typ` into your project directory, replace the synthetic content with your own, and recompile.
    ]
  ],
)

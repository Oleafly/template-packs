#import "../template.typ": caption_with_source, caption_long

= Figures, Tables, Code, and Math

This chapter demonstrates the visual elements of the template.
Delete it once you start writing your actual thesis.

== Tables

Tables use `#figure(table(...), caption: [...])` so they appear in the list of tables and get a caption above them (as required by DHBW guidelines).
The template applies booktabs-style rules automatically: a line above and below the header row and one at the bottom.

@tab-comparison shows a three-column example with a header row.

#figure(
  table(
    columns: (auto, 1fr, auto),
    table.header([*Method*], [*Description*], [*Complexity*]),
    [BM25],       [Bag-of-words term ranking],       [$O(n log n)$],
    [Embedding],  [Dense vector cosine similarity],  [$O(n dot d)$],
    [Hybrid],     [Weighted combination of both],    [$O(n dot d)$],
  ),
  caption: [Comparison of candidate ranking methods],
) <tab-comparison>

For a table that spans many rows or needs custom column widths, adjust the `columns:` argument.
Use `1fr` for a column that fills remaining space and `auto` for one that sizes to its content.

== Figures

Figures use `#figure(image(...), caption: [...])`.
If the image is from an external source, wrap the caption with `caption_with_source` — this keeps the source text out of the list of figures while still showing it below the image.

Import `caption_with_source` at the top of any chapter that needs it:
`#import "../template.typ": caption_with_source`

@fig-dhbw demonstrates this pattern.

#figure(
  image("../assets/DHBW-Logo.svg", width: 50%),
  caption: caption_with_source(
    [Placeholder figure — replace with your own image],
    [Source: DHBW Karlsruhe corporate identity],
  ),
) <fig-dhbw>

The source text ("Source: ...") is shown in the document but suppressed in the list of figures.

=== Short vs. long captions

Use `caption_long(short, long)` when the list of figures/tables should show a concise title while the figure itself carries a more descriptive caption.
Import it the same way: `#import "../template.typ": caption_with_source, caption_long`.

@fig-logo-long demonstrates this — check the list of figures at the front of the document to see the short version.

#figure(
  image("../assets/DHBW-Logo.svg", width: 30%),
  caption: caption_long(
    [DHBW logo],
    [The DHBW Karlsruhe wordmark used as a placeholder. Replace with a figure relevant to your thesis.],
  ),
) <fig-logo-long>

== Source Code Listings

Wrap a fenced code block in `#figure(...)` to get a numbered listing with a caption and an entry in the list of source code.
Specify the language after the opening backticks for syntax highlighting.

@lst-example shows a Python function.

#figure(
```python
def rank_candidates(nodes: list[Node], query: str) -> list[Node]:
    scores = {node: cosine_similarity(query, node.embedding) for node in nodes}
    return sorted(scores, key=scores.get, reverse=True)
```,
  caption: [Candidate ranking by cosine similarity],
) <lst-example>

Inline code such as `rank_candidates()` or a type like `list[Node]` uses backticks and is rendered with a light grey background.

Supported languages include `python`, `typescript`, `java`, `rust`, `sql`, `abap`, and `cds`.
The last two use the custom syntax definitions bundled with the template.

== Mathematics

Inline math uses `$...$` and display math uses a standalone `$ ... $` block.
Equations are numbered per chapter: the first equation in chapter 2 is (2.1), the second is (2.2), and so on.
Label an equation with `<label>` to cross-reference it.

The cosine similarity between query $bold(q)$ and embedding $bold(e)_v$ is defined as

$ s(v, bold(q)) = frac(bold(e)_v dot bold(q), ||bold(e)_v|| dot ||bold(q)||) $ <eq-example>

@eq-example yields values in $[-1, 1]$.
A weighted hybrid score combining @eq-example with a BM25 term is

$ s_"hybrid"(v) = alpha dot s(v, bold(q)) + (1 - alpha) dot "BM25"(v, q), quad alpha in [0, 1] $

Use `bold(x)` for vectors, `hat(x)` for estimates, and `overline(x)` for means.
Greek letters are written by name: `alpha`, `beta`, `theta`, `sigma`.

#import "/template.typ": block_emph, lorem

= Examples

== Footnotes

#lorem(20) #footnote[This is a footnote. It can contain any inline content, including citations @smith2022.]

#lorem(20)

== Citations

According to #cite(<doe2023>, form: "prose", supplement: "p. 1") "#lorem(10)"

#lorem(20) @smith2022.

#lorem(20) @un2021[pp.~12-13].

== Block quote

#lorem(30)

#quote(block: true, attribution: [@doe2023[p. 42]])[
  #lorem(30)
]

#lorem(30)

== Custom styled block emphasis

#block_emph[
  ```
  #import "/template.typ": block_emph
  ```
  #lorem(30)
]

== Table

#lorem(30)

#figure(
  {
    set text(size: 11pt)
    table(
      columns: (auto, 1fr, 1fr),
      align: (left, center, center),
      stroke: none,
      // toprule
      table.hline(stroke: 1.5pt),
      table.header(
        table.cell[*Principle*],
        table.cell[*Humanitarian Focus*],
        table.cell[*AI Ethics Focus*],
      ),
      // midrule
      table.hline(stroke: 0.75pt),
      [Privacy],        [Data minimisation],   [Differential privacy],
      [Accountability], [Organisational],      [Algorithmic audits],
      [Transparency],   [Stakeholder trust],   [Explainability],
      [Human control],  [Beneficiary agency],  [Human-in-the-loop],
      [Fairness],       [Non-discrimination],  [Bias mitigation],
      // bottomrule
      table.hline(stroke: 1.5pt),
    )
  },
  caption: [Example table — comparison of humanitarian and AI ethics principles],
) <tbl-example>

#lorem(30)

== Table from CSV

#lorem(30)

#{
  let data = csv("/assets/data/example-orgs.csv")
  let headers = data.first()
  let rows = data.slice(1)

  figure(
    {
      set text(size: 10pt)
      table(
        columns: headers.len(),
        align: (left, left, left, left, left),
        stroke: none,
        table.hline(stroke: 1.5pt),
        table.header(
          ..headers.map(h => table.cell(strong(h))),
        ),
        table.hline(stroke: 0.75pt),
        ..rows.flatten(),
        table.hline(stroke: 1.5pt),
      )
    },
    caption: [Example CSV-driven table — humanitarian organisations and AI tool use cases],
  )
}

#lorem(30)

#lorem(30)

== Cross-references

Reference a figure: @fig-example. Reference a table: @tbl-example.

You can also write it inline: see #ref(<fig-example>, supplement: [Figure]) for an example image, or #ref(<tbl-example>, supplement: [Table]) for a comparison. 

For headings, add a label after the heading and reference it:

== A Labelled Section <sec-labelled>

This section has the label `<sec-labelled>`. Reference it elsewhere as @sec-labelled.

== Glossarium Term Reference Patterns

All variants for the `ai` entry:

- `@ai` — full on first use, short thereafter: @ai
- `@ai` again (should now be short): @ai
- `@ai:short` — always short form: @ai:short
- `@ai:long` — always long form: @ai:long
- `@ai:pl` — plural: @ai:pl
- `@ai:short[]`-adjacent text (escaped): @ai:short[]-related
- `@llm:pl` — plural of another entry: @llm:pl
- `@ngo` — another example entry: @ngo
- `@un` — yet another entry: @un

== Text Formatting

_Italic text_ and *bold text* and _*bold italic*_.

#smallcaps[Small caps text — good for acronyms in running text.]

#underline[Underlined text — use sparingly.]

`Inline code or technical terms.`

#text(fill: rgb("#555555"))[Muted grey text — useful for captions or asides.]

== Lists

Bullet list:

- First item
- Second item
  - Nested item
  - Another nested item
- Third item

Numbered list:

+ First step
+ Second step
  + Sub-step A
  + Sub-step B
+ Third step

Mixed:

- Item one
  + Sub-step one
  + Sub-step two
- Item two

== Figure

#lorem(30)

#figure(
  image("/assets/uni-logo.jpg", width: 80%),
  caption: [Example figure — replace with actual content],
) <fig-example>

#lorem(30)

== Image Grid

Use a `#grid` inside a `#figure` to lay out multiple images with per-image labels.
The outer `figure` gives the grid a shared numbered caption in the List of Figures.

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1.5em,
    row-gutter: 0.75em,
    image("/assets/gemini-pro-2.5.png", width: 100%),
    image("/assets/gpt-4o.png",         width: 100%),
    image("/assets/gpt-o3.png",         width: 100%),
    align(center)[Gemini Pro 2.5],
    align(center)[GPT-4o],
    align(center)[GPT-o3],
    image("/assets/grok.png",           width: 100%),
    image("/assets/llama-4.png",        width: 100%),
    image("/assets/preplexity.png",     width: 100%),
    align(center)[Grok],
    align(center)[Llama 4],
    align(center)[Perplexity AI],
  ),
  caption: [AI model responses to the prompt "show a migrant at a border crossing"],
) <fig-ai-grid>

#lorem(20)
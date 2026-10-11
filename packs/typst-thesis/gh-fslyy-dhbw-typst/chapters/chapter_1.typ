#import "../template.typ": caption_with_source
#import "@preview/drafting:0.2.2": *

= Template Usage Guide

This chapter introduces the core writing features of the template.
Delete it once you start writing your actual thesis.

== Text and Headings

Headings are written with `=` signs — one per level.
Use `= Title` for top-level chapters, `== Section` for sections, and `=== Subsection` for subsections.
The template automatically applies the correct font size, spacing, and page break behaviour.

Paragraphs are separated by a blank line.
Text is set in Times New Roman 12 pt with 1.5-line spacing and justified alignment, as required by the DHBW guidelines.

You can emphasise text with *bold* or _italic_.
Inline identifiers like `myFunction()` or `SomeClass` are rendered with a light background.

=== Lists

Unordered lists use `-` and ordered lists use `+`:

- First bullet point
- Second bullet point
  - Nested item

+ First numbered item
+ Second numbered item
+ Third numbered item

=== Footnotes

Add a footnote with `#footnote[...]` directly after the word or sentence it belongs to.#footnote[Footnotes are numbered continuously throughout the entire document and appear at the bottom of the page in 10 pt, single-line spacing.]
The separator line and font size are handled automatically.

=== Block Quotes

Use `#quote(attribution: [...])[...]` for block quotations.
The attribution can include a citation using `@citekey`.

#quote(attribution: [@fdr_inaugural_address])[The only thing we have to fear is fear itself — nameless, unreasoning, unjustified terror which paralyzes needed efforts to convert retreat into advance.]

== Citations and Cross-References

=== Citing Sources

Cite a source with `@citekey`, where `citekey` matches an entry in your `.bib` file.
For example: this method was first described in @Junior2015.
All cited sources appear automatically in the bibliography at the end of the document.

=== Referring to Figures, Tables, and Equations

Every figure, table, equation, or heading can be given a label with `<my-label>`.
Refer to it anywhere with `@my-label` — Typst resolves the number automatically.

For example, @tab-example below is a simple reference target.
Further examples (equations, figures) are shown in the next chapter.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([*Key*], [*Description*]),
    [`@citekey`],       [Cite a bibliography entry],
    [`@label`],         [Cross-reference a figure, table, or equation],
    [`<label>`],        [Attach a label to any element],
  ),
  caption: [Reference syntax overview],
) <tab-example>

=== Acronyms

Define acronyms in `main.typ` under the `acronyms:` parameter.
Reference them in text with `@KEY` — glossarium handles the rest.
The abbreviation list is generated automatically if at least one acronym is defined.

For example: @LLM\-based tools such as @RAG pipelines have reshaped how developers write code.
On the second mention the short form is used: @LLM.

== Margin Notes

The `drafting` package is available for review annotations.
Use `#margin-note[...]` to leave a note in the margin during writing — remove all notes before submission.

#margin-note[This is a margin note. Remove before submitting.]

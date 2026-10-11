#import "@preview/codelst:2.0.2": *

#import "../lib/common.typ": distref, flcite
#import "../lib/acronym.typ": acr, acrlpl, acrpl, acrs

#set heading(numbering: "1.1") // To prevent a linter error

#import "../template.typ": *
#context bib_state.get()

= Introduction

#lorem(100)


= Examples

#lorem(30)

== Acronyms

Use the `acr` function to insert acronyms, which looks like this #acr("HTTP") the first time and like this #acr("HTTP") the second time .

#acrlpl("API") are used to define the interaction between different software systems.

#acrs("REST") (`acrs` for short form) is an architectural style for networked applications.

== Lists

Create bullet lists or numbered lists.

- This
- is a
- bullet list

+ It also
+ works with
+ numbered lists!

== Paragraphs

You can create paragraphs with level 4 headings:

==== Some title
#lorem(25)

==== This is another title
#lorem(50)

== Figures and Tables

Create figures or tables like this:

=== Figures

#figure(
  caption: "Image Example",
  image(width: 4cm, "../assets/svi-logo.jpg"),
) <figure-bla-bla>

Here I'm referencing the figure: @figure-bla-bla.

=== Tables

#figure(
  caption: "Table Example",
  table(
    columns: (1fr, 50%, auto),
    inset: 10pt,
    align: horizon,
    table.header([], [*Area*], [*Parameters*]),

    text("cylinder.svg"),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    text("tetrahedron.svg"), $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  ),
)<table>

== Code Snippets

Insert code snippets like this:

#figure(
  caption: "Codeblock Example",
  sourcecode[```ts
  const ReactComponent = () => {
    return (
      <div>
        <h1>Hello World</h1>
      </div>
    );
  };

  export default ReactComponent;
  ```],
) <code>

#pagebreak()

== References

Cite like this #cite(form: "prose", <iso18004>). Or like this @iso18004. You can also reference by adding `<ref>` with the desired name after figures or headings. For example this @table references the table on the previous page.

Or you can link to @appendix-long.

You can also cite URLs with Vergleiche with `#flcite`. #flcite(date: datetime(year: 2026, month: 05, day: 12), url: "https://google.com")

You can dynamically reference with `#distref(<ref>)`: #distref(<code>). This is close to the page is therefore not page number is shown.
But #distref(<appendix-long>) is far away, and therefore the page number is shown. Some scientific advisors want this.

== Text Formatting

Of course you can make text *bold* or _italic_. #text(size: 20pt)[And you can make text huge.] #underline[Underlining works too!] #overline[And overlining as well!] #text(fill: red)[We can also color the text.] #text(weight: "bold")[Bold works this way too.] #text(style: "italic")[Italic also works like this.] `Monospace text` also works inline.

#strike[strikethrough text]

#smallcaps[Small Caps Text]

H#sub[2]O and x#super[2]

*_bold and italic_* or #text(fill: blue, size: 14pt)[*blue, large and bold*]

#text(font: "Times New Roman")[Times New Roman]
#text(font: "Comic Sans MS")[Comic Sans]
#text(font: "Courier New")[Courier New]

#text(tracking: 10pt)[spaced out]

#set par(leading: 1.5em)
Text with larger line spacing.

#highlight[highlighted text]
#highlight(fill: yellow)[highlighted in yellow]

#box(fill: luma(230), inset: 5pt)[Text in gray box]

#v(2em)

#rotate(45deg)[rotated text]

#v(2em)

#scale(x: 150%)[horizontally stretched]

#v(2em)

#par(leading: 2em)[
  This text has larger line spacing. \
  Multiple lines are formatted accordingly.
]

= Conclusion

#lorem(100)

#import "../template/lib.typ": *
= Examples

#lorem(30)

== Acronyms

Use the `acr` function to insert acronyms, which looks like this #acr("HTTP").

#acrlpl("API") are used to define the interaction between different software systems.

#acrs("REST") is an architectural style for networked applications.

== Glossary

Use the `gls` function to insert glossary terms, which looks like this:

A #gls("Vulnerability") is a weakness in a system that can be exploited.

== Lists

Create bullet lists or numbered lists.

- This
- is a
- bullet list

+ It also
+ works with
+ numbered lists!

== Figures and Tables

Create figures or tables like this:

=== Figures

#figure(caption: [Image Example #footnote[#glcite(<iso18004>)]], image(width: 4cm, "../assets/ts.svg"))
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

#pagebreak()

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
)

== References

Cite like this #cite(form: "prose", <iso18004>).
Or like this @iso18004.
Or cite like in the guidelines #footnote[#glcite(<iso18004>)]

You can also reference by adding `<ref>` with the desired name after figures or headings.

For example this @table references the table on the previous page.

== Mermaid
#figure(
  caption: [Ein einfaches Mermaid-Flussdiagramm],
  mermaid(
    "
    graph TD
      A[Start] --> B{Diagramm benötigt?}
      B -- Ja --> C[Mermaid nutzen]
      B -- Nein --> D[Text schreiben]
      C --> E[Dokument kompilieren]
      D --> E
  ",
  ),
)<ref>

Referenz: @ref

#mermaid(
  "graph TD; A-->B;",
  base-theme: "default",
  theme: (
    background: "#ff0000",
    primary_color: "#ff0000",
  ),
  layout: (
    node_spacing: 50,
  ),
)

== Custom commands

==== TODO:
#todo[This is a todo]

==== Question:
#question[This is a question]

==== Important:
#important[This is important!]

==== Citation:
===== glcite:
#glcite(<iso18004>)

===== glcitel:
#glcitel("iso18004")

#glcitel("iso18004", note: [S. 42])

===== glcfcite:
#glcfcite("iso18004")

#glcfcite("iso18004", note: [S. 15-18])

===== glfootcite:
#glfootcite("iso18004")

#glfootcite("iso18004", note: [S. 100])

===== glcffootcite:
#glcffootcite("iso18004")

#glcffootcite("iso18004", note: [Kapitel 3])

==== Description:
#desc[Header][#lorem(20)]

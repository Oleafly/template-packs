#import "@preview/codelst:2.0.2": *

#import "../lib/acronym-lib.typ": acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl
#import "../lib/glossary-lib.typ": gls

#import "../template.typ": *
#context bib_state.get()

= Introduction

#lorem(100)

#lorem(100)

#lorem(100)

= Examples

#lorem(30)

== Acronyms

Use the `acr` function to insert acronyms, which looks like this #acr("HTTP") the first time and like this #acr("HTTP") the second time .

#acrlpl("API") are used to define the interaction between different software systems.

#acrs("REST") (`acrs` for short form) is an architectural style for networked applications.

== Glossary

Use the `gls` function to insert glossary terms, which looks like this: A #gls("Vulnerability") is a weakness in a system that can be exploited.

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

#figure(caption: "Image Example", image(width: 4cm, "../assets/TH_Mannheim_Logo_CMYK_blau.svg"))

=== Tables

#figure(
  caption: "Table Example",
  table(
    columns: (1fr, 50%, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [],
      [*Area*],
      [*Parameters*],
    ),

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
)

#pagebreak()

== References

Cite like this #cite(form: "prose", <iso18004>). Or like this @iso18004. You can also reference by adding `<ref>` with the desired name after figures or headings. For example this @table references the table on the previous page.

Or you can link to @appendix-long.

= Conclusion

#lorem(100)

#lorem(120)

#lorem(80)

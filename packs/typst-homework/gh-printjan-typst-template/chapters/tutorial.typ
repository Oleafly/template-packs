#import "../template.typ": (
  arrow-list, blockquote, code-block, code-box, custom-pad, framed, important, info, negative, positive, quote-box,
  remember, spacer, sparql, todo, turtle,
)

= Foundations & Tutorial

== 1. Getting Started

This template provides a unified engine for high-density *cheat sheets* (4-column layout) and structured *technical summaries* (1-column layout) with modular configuration profiles in `configs/`.

- List Level 1
  - List Level 2
    - List Level 3
      #arrow-list[- Implication / Deduction]
      - List Level 4

=== Mathematical Typesetting & Formulas

Formulas can be embedded inline ($E = m c^2$) or rendered as standalone display equations:

$ f(x) = sum_(i=0)^n a_i x^i $

== 2. Core Building Blocks & Admonitions

#info[
  *Info Box*: For contextual explanations, background details, or formal definitions.
]

#important[
  *Important*: For essential rules, key theorems, or critical exam takeaways.
]

#positive[
  *Positive Box*: For advantages, best practices, or valid state representations.
]

#negative[
  *Negative Box*: For pitfalls, edge-case hazards, anti-patterns, or common errors.
]

#remember[
  *Key Takeaway*: For high-priority retention points.
]

#quote-box(title: "Quote / Blockquote", author: "Alan Turing")[
  We can only see a short distance ahead, but we can see plenty there that needs to be done.
]

#todo[Pending item: Expand mathematical formula catalog]

== 3. Derivation Chains (Arrow Lists)

#arrow-list[
  - Precondition A holds
  - Precondition B holds
  - Event C follows as a logical consequence
]

== 4. Code Blocks & Custom Syntax Highlighting

Inline code spans such as `exA:Kitty` and full multiline code blocks with automatic syntax highlighting:

=== Standard Code Block:

```turtle
exA:Kitty rdf:type exT:Cat .
exA:Kitty exT:hasName "Kitty" .
```

=== Specialized Code Boxes with Titles & Verbatim Strings:

#turtle(
  title: "Turtle RDF Assertions",
  "
@prefix exA: <http://example.org/assertions/> .
@prefix exT: <http://example.org/terms/> .

exA:Kitty a exT:Cat .
exA:Kitty exT:hasName \"Kitty\" .
",
)

#sparql(
  title: "SPARQL Query",
  "
PREFIX exT: <http://example.org/terms/>

SELECT ?cat WHERE {
  ?cat a exT:Cat .
}
",
)

#code-box(
  lang: "python",
  title: "Python Script",
  "
def main():
    print(\"Hello Knowledge Graphs\")
",
)

== 5. Advanced Tables

Tables support flexible alignment (`align`), cell merging (`colspan` / `rowspan`), and embedding of nested code blocks and callouts:

#table(
  columns: (auto, 1fr, 1fr),
  align: top + left,
  inset: (x: 4pt, y: 6pt),
  stroke: 0.4pt,

  // Header merged across 2 columns (colspan: 2)
  [ ], table.cell(colspan: 2)[*Comparison of Typing & Subsumption*],

  [*Code Example*],
  [```turtle
  exA:Kitty a exT:Cat .
  ```],
  [```turtle
  exT:Cat rdfs:subClassOf exT:Mammal .
  ```],

  [*Semantics*],
  [Kitty is an instance of the class Cat.],
  [Every instance of Cat is also an instance of Mammal.],

  // Spanning column 1 across 2 rows vertically (rowspan: 2)
  table.cell(rowspan: 2)[*Explanation*],
  [#important[`rdf:type` binds an individual instance to a class.]],
  [#important[`rdfs:subClassOf` defines subclass hierarchy between classes.]],

  // Row spanning columns 2 & 3 at the bottom (colspan: 2)
  table.cell(colspan: 2)[
    #info[There is no single overloaded "is-a" relation in formal ontologies — strictly differentiate instances from subclasses!]
  ],
)

= Subsequent Chapter

== Subchapter (Level 2)

Section body content.

=== Nested Topic (Level 3)

With automatic decorative rule rendered above the heading.

==== Detailed Sub-item (Level 4)

Granular content and details.

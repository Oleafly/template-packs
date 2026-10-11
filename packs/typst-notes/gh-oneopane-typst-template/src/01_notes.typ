#import "../macros.typ": *

= Notes

Start writing notes here, or promote this file to a directory when it grows large enough to split:

```text
src/01_notes/
  index.typ
  00_first_topic.typ
  01_second_topic.typ
```

Then update `main.typ` to include `src/01_notes/index.typ` instead of `src/01_notes.typ`.

== Macro examples

Let $x in bbR$ and $A in cA$. We can write $norm(x)$, $abs(x)$, and $argmax_(x in bbR) f(x)$.

Probability examples: #EE[$X$], #EE($X$, given: $Y$), #EE($X$, given: $Y$, measure: $P$), #Var($X$, given: $Y$), and #Cov($X$, $Y$, given: $Z$).

Specialized notation can be imported only where it is needed:

```typst
#import "../macros/category.typ" as cat
#import "../macros/type-theory.typ" as tt
#import "../macros/diagrams.typ": commdiag, edge
```

Namespaced imports help avoid collisions in mixed-domain notes.

#definition(title: [Reusable template])[
A notes template separates document assembly, layout, notation, content, assets, and bibliography data.
] <def:reusable-template>

#theorem(title: [Stable includes])[
If every directory exposes one entrypoint and only includes immediate children, then the include graph remains tree-shaped.
] <thm:stable-includes>

See @def:reusable-template and @thm:stable-includes for labeled environment examples.

#lemma(title: [Local responsibility])[
When layout, notation, and content live in separate files, most edits have a single natural home.
]

#example(title: [Conditioning helper])[
The expectation macro supports conditioning: #EE($X$, given: $Y$).
]

#remark[
Theorem-family environments share a counter; definitions, examples, and remarks use their own counters.
]

#proof(title: [of @thm:stable-includes])[
The parent entrypoint determines order, and child content cannot include parents or siblings, so each included file has one path from `main.typ`.
]

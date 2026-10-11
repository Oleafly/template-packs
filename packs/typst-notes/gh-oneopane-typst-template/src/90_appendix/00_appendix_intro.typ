== Appendix Introduction

Appendices follow the same include graph rules as every other directory: the directory entrypoint is `index.typ`, and it includes only immediate children.

== Macro module reference

The default import remains:

```typst
#import "../macros.typ": *
```

`macros.typ` re-exports common modules:

- `macros/core.typ`: blackboard/calligraphic symbols, common operators, and delimiter helpers.
- `macros/probability.typ`: `Pr`, `EE`, `Var`, `Cov`, common distributions, and indicators.
- `macros/environments.typ`: definitions, theorem-family environments, examples, remarks, and proofs.
- `macros/formatting.typ`: callouts and small text-formatting helpers.

Optional domain modules can be imported directly:

- `macros/category.typ`: category-theory notation such as `Hom`, `Ob`, `Mor`, `Nat`, `lim`, and `colim`.
- `macros/type-theory.typ`: typing judgments, definitional equality, substitution, lambda, Pi, and Sigma notation.
- `macros/stochastic.typ`: filtrations, processes, and stopping-time notation.
- `macros/ml.typ`: losses, risks, activations, and common model/data notation.
- `macros/llm.typ`: transformer and sequence notation.
- `macros/diagrams.typ`: opt-in Fletcher-backed category-theory diagrams.

For category-theory diagrams, import the diagram module only in notes that use it:

#import "../../macros/diagrams.typ": commdiag, edge

#align(center)[
  #commdiag($
    A edge("r", f, "->") edge("d", g, "->") & B edge("d", h, "->") \
    C edge("r", k, "->") & D
  $)
]

The diagram module is intentionally not part of the default bundle because it pulls in Fletcher and its dependencies.

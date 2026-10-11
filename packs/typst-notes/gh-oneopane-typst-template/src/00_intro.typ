#import "../macros.typ": *

= Introduction

This repository is a reusable Typst notes template. Put short, self-contained top-level sections directly in `src/` as numbered `.typ` files.

#note[
Use `main.typ` only to assemble public section entrypoints. Keep substantive notes in `src/`.
]

Reusable notation lives in `macros/` modules. The top-level `macros.typ` file is the default bundle for common notation, probability helpers, theorem environments, and formatting. Specialized modules such as category theory, type theory, stochastic processes, machine learning, LLMs, and category-theory diagrams can be imported directly when a note needs them.

A sample citation can be written as `@knuth1984texbook` once an entry exists in `refs.bib`.

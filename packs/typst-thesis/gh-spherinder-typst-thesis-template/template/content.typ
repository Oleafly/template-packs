#import "thesis.typ": todo
#import "@preview/glossarium:0.5.9": gls, Gls

= Prologue
<prologue>

Open with what the work is and why it matters. You can reference glossary terms
inline; underlined terms such as @work-stealing and @faas link to their
definitions#footnote[Underlined terms throughout are hyperlinks to their
definitions in the #link(<glossary>)[Glossary].] at the back of the document,
and citations like @example-ref render from `bibliography.bib`.

#todo[Replace this skeleton with your introduction.]

= Basics
<basics>

Give the reader everything they need before the contribution. Use `#gls()` when
you want custom display text, e.g. a #gls("reactor", display: "reactor loop")
that drives an #gls("epoll") descriptor set.

== A Subsection

Sub-headings (`==`, `===`) are numbered automatically. Figures float and are
referenced by label, like @example-figure.

#figure(
  caption: [A table figure. Swap for `image("assets/your-plot.png")` as needed.],
  table(
    columns: 3,
    table.header([*Class*], [*Preemptible*], [*Tail*]),
    [IO], [yes], [light],
    [Compute], [no], [heavy],
  ),
) <example-figure>

= Problem

= Ideal

= Methodology

Inline code reads like `this`, and blocks render with
syntax highlighting:

```rust
fn admit(util: f64, workers: usize) -> bool {
    util * workers as f64 / (workers - 1) as f64 <= 1.0
}
```

= Praxis

= Analysis

= Epilogue


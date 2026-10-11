// Theorem-like environments.

#let _env-title(name, kind, title: none) = strong[
  #name #context counter(figure.where(kind: kind)).display()#if title != none [ (#title)].
]

#let _env-box(name, kind, title: none, accent: rgb("#4c78a8"), fill: rgb("#f7fbff"), body) = block(
  fill: fill,
  inset: (x: 0.85em, y: 0.7em),
  radius: 4pt,
  stroke: (left: 1.8pt + accent),
  width: 100%,
  above: 0.65em,
  below: 0.65em,
)[
  #_env-title(name, kind, title: title)
  #v(0.35em)
  #body
]

// Theorem-like environments are custom figures. This keeps existing
// `#theorem[...]`-style calls while allowing normal Typst labels after the call:
// `#theorem[Body] <thm:name>` and references with `@thm:name`.
#let env(
  name,
  title: none,
  kind: none,
  accent: rgb("#4c78a8"),
  fill: rgb("#f7fbff"),
  body,
) = {
  let env-kind = if kind == none { name } else { kind }
  figure(
    _env-box(name, env-kind, title: title, accent: accent, fill: fill, body),
    kind: env-kind,
    supplement: name,
    numbering: "1",
    outlined: false,
  )
}
#let definition(title: none, body) = env(
  "Definition",
  title: title,
  kind: "definition",
  accent: rgb("#5b8c5a"),
  fill: rgb("#f7fbf5"),
  body,
)
#let theorem(title: none, body) = env(
  "Theorem",
  title: title,
  kind: "theorem",
  accent: rgb("#4c78a8"),
  fill: rgb("#f5f9ff"),
  body,
)
#let lemma(title: none, body) = env(
  "Lemma",
  title: title,
  kind: "theorem",
  accent: rgb("#4c78a8"),
  fill: rgb("#f5f9ff"),
  body,
)
#let proposition(title: none, body) = env(
  "Proposition",
  title: title,
  kind: "theorem",
  accent: rgb("#4c78a8"),
  fill: rgb("#f5f9ff"),
  body,
)
#let corollary(title: none, body) = env(
  "Corollary",
  title: title,
  kind: "theorem",
  accent: rgb("#4c78a8"),
  fill: rgb("#f5f9ff"),
  body,
)
#let example(title: none, body) = env(
  "Example",
  title: title,
  kind: "example",
  accent: rgb("#8a6fb0"),
  fill: rgb("#fbf8ff"),
  body,
)
#let remark(title: none, body) = env(
  "Remark",
  title: title,
  kind: "remark",
  accent: rgb("#777777"),
  fill: rgb("#fafafa"),
  body,
)
#let proof(title: none, qed: $square$, body) = block(
  fill: rgb("#fcfcfc"),
  inset: (x: 0.85em, y: 0.6em),
  radius: 3pt,
  stroke: (left: 1.2pt + rgb("#777777")),
  width: 100%,
  above: 0.45em,
  below: 0.65em,
)[
  #strong[Proof#if title != none [ (#title)].]
  #v(0.3em)
  #body#if qed != none [ #h(1fr) #qed]
]

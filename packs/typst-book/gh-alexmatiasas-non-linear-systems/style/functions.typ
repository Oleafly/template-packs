// Custom functions: theorems, equations, code blocks, figures

#import "theme.typ": primary-color, accent-color, code-bg

// ============================================
// THEOREMS, LEMMAS, PROPOSITIONS, COROLLARIES
// ============================================

#let make-theorem(body, name) = {
  block(
    fill: rgb("#f7fafc"),
    inset: (left: 1.2em, top: 0.8em, right: 1.2em, bottom: 0.8em),
    stroke: (left: 3pt + primary-color, rest: 1pt + rgb("#e2e8f0")),
    radius: (right: 4pt),
  )[
    #text(weight: "bold")[#name:] #body
  ]
}

#let theorem(body) = make-theorem(body, "Theorem")
#let lemma(body) = make-theorem(body, "Lemma")
#let proposition(body) = make-theorem(body, "Proposition")
#let corollary(body) = make-theorem(body, "Corollary")

#let proof(body) = {
  block(
    fill: none,
    inset: (left: 0em, top: 0.5em, right: 0em, bottom: 0.5em),
  )[
    #text(weight: "bold")[Proof.] #body #h(1fr) □
  ]
}

// ============================================
// NUMBERED EQUATIONS
// ============================================

#let eq-counter = counter("equation")

#let make-equation(body, label: none) = {
  eq-counter.step()
  figure(
    body,
    caption: label,
    kind: "equation",
    supplement: none,
    number: context {
      let ch = counter(heading).get()
      let eq = eq-counter.get()
      if ch.len() > 0 {
        "(" + str(ch.last()) + "." + str(eq.first()) + ")"
      } else {
        "(" + str(eq.first()) + ")"
      }
    }
  )
}

// ============================================
// CODE BLOCKS
// ============================================

#let python-block(body, caption: none) = {
  figure(
    caption: caption,
    kind: "code",
    supplement: "Code",
  )[
    ```python
#body
    ```
  ]
}

#let rust-block(body, caption: none) = {
  figure(
    caption: caption,
    kind: "code",
    supplement: "Code",
  )[
    ```rust
#body
    ```
  ]
}

#let terminal-output(body, prompt: ">>> ") = {
  block(
    fill: rgb("#1a1a2e"),
    inset: (left: 1em, top: 0.8em, right: 1em, bottom: 0.8em),
    radius: 4pt,
  )[
    #text(size: 11pt, fill: rgb("#a0aec0"), font: ("Menlo", "Monaco"))[#prompt #body]
  ]
}

// ============================================
// FIGURES AND IMAGES
// ============================================

#let book-figure(path, caption: none, width: 80%) = {
  figure(
    image(path, width: width),
    caption: caption,
    kind: "figure",
    supplement: "Fig."
  )
}
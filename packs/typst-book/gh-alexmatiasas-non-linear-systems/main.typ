// Non-Linear Systems: From Navier-Stokes to Chaos
// Main document file

#import "style/theme.typ": *
#import "style/layout.typ": *
#import "style/functions.typ": *

// ============================================
// DOCUMENT SETUP
// ============================================

#set document(
  title: "Non-Linear Systems",
  author: "Your Name",
)

#set text(
  font: text-font,
  size: 12pt,
  lang: "en",
)

#set heading(numbering: "1.1")

#set par(
  justify: true,
  spacing: par-spacing,
)

#set enum(indent: 1.5em)
#set list(indent: 1.5em)

// Math formatting
#set math.equation(numbering: "(1)")
#show math.equation: it => {
  if it.has("label") {
    figure(it, supplement: none, number: context {
      let ch = counter(heading).get()
      let eq = counter("equation").get()
      if ch.len() > 0 {
        "(" + str(ch.last()) + "." + str(eq.first()) + ")"
      } else {
        "(" + str(eq.first()) + ")"
      }
    })
  } else {
    it
  }
}

// ============================================
// FRONTMATTER
// ============================================

#pagebreak()
#set page(numbering: "i")

*Foreword*

This book represents a comprehensive journey through non-linear systems, with a particular focus on the Navier-Stokes equations and their applications.

#pagebreak()

*Preface*

This book was written to fill a gap in the literature on non-linear systems, providing both theoretical foundations and practical applications using the Navier-Stokes equations as our primary example.

#pagebreak()

// Table of contents
#outline(title: "Table of Contents", depth: 3)

#pagebreak()

// ============================================
// MAIN MATTER
// ============================================

#set page(numbering: "1")
#counter(page).update(1)

// --------------------------------------------
// PART I: PREAMBLE
// --------------------------------------------

#include "parts/01_preamble/ch_introduction.typ"

// Placeholder for more preamble chapters
// #include "parts/01_preamble/ch_math_foundations.typ"
// #include "parts/01_preamble/ch_dynamical_systems.typ"

// --------------------------------------------
// PART II: NAVIER-STOKES
// --------------------------------------------

#include "parts/02_navier_stokes/ch_navier_stokes_intro.typ"

// Placeholder for more Navier-Stokes chapters
// #include "parts/02_navier_stokes/ch_derivation.typ"
// #include "parts/02_navier_stokes/ch_existence.typ"
// #include "parts/02_navier_stokes/ch_turbulence.typ"

// ============================================
// BACKMATTER
// ============================================

#set page(numbering: "i")
#counter(page).update(1)

#pagebreak()
#set heading(numbering: none)

= Appendix A: Python Setup

#python-block(
```python
# Install required packages
pip install numpy matplotlib scipy

# Verify installation
import numpy as np
import matplotlib.pyplot as plt
print("Installation successful!")
```,
caption: [Python environment setup]
)

= Appendix B: Rust Setup

#rust-block(
```rust
// Cargo.toml dependencies
[dependencies]
nalgebra = "0.32"
serde = { version = "1.0", features = ["derive"] }
plotters = "0.3"

fn main() {
    println!("Rust environment ready!");
}
```,
caption: [Rust environment setup]
)

#pagebreak()

// Bibliography
#set heading(numbering: none)
= Bibliography

#bibliography("bib/references.yml")

#pagebreak()

= Index

// Index would be generated here
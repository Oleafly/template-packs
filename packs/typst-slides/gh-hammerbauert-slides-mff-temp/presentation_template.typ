// =============================================
// Conference Presentation Template
// Faculty of Mathematics and Physics, Charles University
// Red and White Theme — Typst 0.13, no external packages
// =============================================


#import "temp_src.typ": *


// --- Global page settings ---
#set page(paper: "presentation-16-9", margin: 0pt)
#set text(font: "Arial", size: 18pt, fill: dark-blue-uk)

// =============================================
// SLIDES  (edit / replace from here onwards)
// =============================================

#let logo = "LOGO_MATFYZ_UK-EN.png"

// ----- Title -----
#title-slide(
  title:       "Your Presentation Title",
  subtitle:    "Conference Name 2026",
  author:      "Your Name",
  institution: "Faculty of Mathematics and Physics, Charles University",
  date:        "February 27, 2026",
  logo:        logo,
)

// ----- Outline -----
#outline-slide(logo: logo)

// ----- Section -----
#section-slide(title: "Introduction", logo: logo)

// ----- Math demo slide -----
#slide(title: "Mathematical Environments", logo: logo)[
  #definition(name: "Convergence")[
    A sequence $(x_n)$ converges to $L$ if $forall epsilon > 0, exists N : n > N => |x_n - L| < epsilon$.
  ]
  #v(0.5em)
  #theorem(name: "Bolzano–Weierstrass")[
    Every bounded sequence in $RR^n$ has a convergent subsequence.
  ]
  #v(0.5em)
  #proof[
    By induction on dimension using the nested interval theorem.
  ]
]

// ----- Math demo slide 2 -----
#slide(title: "More Environments", logo: logo)[
  #lemma[
    If $f$ is continuous on $[a,b]$, then $f$ attains its maximum.
  ]
  #v(0.4em)
  #corollary[
    A continuous function on a compact set is bounded.
  ]
  #v(0.4em)
  #example[
    $f(x) = sin(x)$ on $[0, pi]$ attains maximum $1$ at $x = pi/2$.
  ]
  #v(0.4em)
  #remark[
    Compactness is essential; the result fails on open intervals.
  ]
]

// ----- Section -----
#section-slide(title: "Methods", logo: logo)

// ----- Content slide -----
#slide(title: "Research Approach", logo: logo)[
  = Research Approach

  + Systematic methodology
  + Data collection procedures
  + Analysis framework

  #v(1em)

  #info-box[Your important methodological note goes here.]
]

// ----- Section -----
#section-slide(title: "Results", logo: logo)

// ----- Two-column slide -----
#two-col-slide(title: "Results & Discussion", logo: logo)[
  == Findings

  - Result 1
  - Result 2
  - Result 3

  #v(0.5em)
  Significant improvements across all metrics.
][
  == Implications

  - Impact on field
  - Future directions
  - Applications

  #v(0.5em)
  These results open new research opportunities.
]

// ----- Section -----
#section-slide(title: "Conclusions", logo: logo)

// ----- Summary -----
#slide(title: "Summary", logo: logo)[
  = Main Conclusions

  + First major conclusion
  + Second key takeaway
  + Third important result

  #v(1.5em)

  #align(center)[
    #text(size: 30pt, fill: red-uk, weight: "bold")[Thank You!]

    #v(0.4em)

    #text(size: 18pt)[Questions & Discussion]
  ]
]

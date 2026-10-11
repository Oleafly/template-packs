#import "../src/lib.typ": cea-theme, glossary_page, part_cover, report

#show: report.with(
  theme: cea-theme,
  title: "Lorem ipsum dolor",
  author: "John Doe",
  email: "john.doe@example.com",
  company: "My Internship Corp.",
  dates: "October 2026",
  logo-path: "../../assets/images/Lorem_ipsum.png",
  acknowledgments: [
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. We also thank Jane Doe for her invaluable review.
  ],
)

// -----------------------------------------------------------------------------
// Glossary Page Example
// -----------------------------------------------------------------------------
#glossary_page(
  cea-theme,
  terms: (
    (
      "Lorem",
      "Ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    (
      "Modular Design",
      "An approach that subdivides a system into smaller parts called modules, which can be independently created and then used in different systems.",
      "smith2024", // NOTE: This key will generate a citation because the bibliography is included below
    ),
  ),
)

// -----------------------------------------------------------------------------
// Part Cover Example
// -----------------------------------------------------------------------------
#part_cover(
  title: "Part 1: Theoretical Background",
  target: "Researchers and Engineers",
  preamble: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at porttitor sem. Aliquam erat volutpat.",
  cea-theme,
)

// -----------------------------------------------------------------------------
// Main Content (Lorem Ipsum)
// -----------------------------------------------------------------------------
= Introduction
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eu eros id sem commodo venenatis. Nulla facilisi. Integer a faucibus est, et elementum ex. Quisque nec varius nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas @doe2023.

== Sub-section: Core Concepts
Suspendisse potenti. Mauris vitae libero ac neque viverra eleifend. Phasellus malesuada sit amet magna id sollicitudin. Curabitur vel elit cursus, condimentum velit vel, cursus libero. Sed in ex sit amet elit vestibulum egestas a ac nunc @smith2024.

Nam at tristique ligula, nec pretium justo. Maecenas commodo quam quis felis eleifend, at tempus metus vehicula. Integer tristique magna quis leo pulvinar vulputate.

// -----------------------------------------------------------------------------
// Second Part Cover Example
// -----------------------------------------------------------------------------
#part_cover(
  title: "Part 2: Practical Implementation",
  target: "Software Developers",
  preamble: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  cea-theme,
)

= Methodology
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum @doe2023.

== Results
Aliquam erat volutpat. Fusce congue leo id justo eleifend, at semper nisi commodo. Nunc finibus lacus ac massa consectetur, id tempus neque auctor. Sed auctor mi rhoncus libero egestas laoreet.

// -----------------------------------------------------------------------------
// Bibliography
// -----------------------------------------------------------------------------
#pagebreak()
#bibliography("references.bib")

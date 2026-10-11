// Morteza Hosseini - Curriculum Vitae
//
// NOTE: To customize, edit settings below.


// =============================================================================
// SETTINGS
// =============================================================================
#let accent = rgb("#538135")

// Page setup
#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 15mm, left: 25mm, right: 25mm),
)

// Title style
#let title(body) = text(font: "Gill Sans", fill: accent, size: 26pt)[#body]

// Headings
// v: vertical space
#show heading.where(level: 1): it => {
  set text(font: "Gill Sans", fill: accent, size: 11.5pt, weight: "regular")
  v(3mm)
  it
  v(1.5mm)
}

// Body text
#set text(font: "EB Garamond", size: 10pt)

// Paragraph settings
// leading: space between lines
// spacing: space between paragraphs
#set par(justify: true, leading: 0.65em, spacing: 1.7em)

// List settings
#set list(marker: [--], indent: 4mm)

// =============================================================================
// BODY
// =============================================================================
#align(center)[
  #title[JOHN DOE] \
  #v(-1mm)
  Manchester, UK | user\@email.com | github.com/github | linkedin.com/in/linkedin
]

#v(1mm)

// =============================================================================

= ABOUT ME

#lorem(80)

// =============================================================================

= EXPERIENCE

*Third Job Title* | Company C, London, UK | 2024 - Now
- #lorem(40)
- #lorem(30)
- #lorem(45)

*Second Job Title* | Company B, Freelance | 2023 - 2024
- #lorem(45)
- #lorem(30)
- #lorem(35)

*First Job Title* | Company A, Oxford, UK | 2020 - 2023
- #lorem(55)
- #lorem(25)

// =============================================================================

= SKILLS

*Programming:* Python, Shell \
*ML:* PyTorch, NumPy, pandas, XGBoost \
*Data Engineering:* Spark, Airflow, Docker, Jupyter Notebooks \
*Cloud Platforms:* Azure, AWS, GCP \

// =============================================================================

= EDUCATION

*MSc in Computer Science* | University of Manchester, UK | 2019 - 2020

// ---------------------------------------------------------------
// Minimal Typst résumé template
// Built from three reusable pieces: global page/text defaults,
// a `section()` component (title + rule), and the `#h(1fr)`
// trick for right-aligned dates. Swap the placeholder content
// below for your own — the structure stays the same.
// ---------------------------------------------------------------

#set page(
  paper: "us-letter",
  margin: (top: 0.1in, bottom: 0.1in, left: 0.45in, right: 0.45in),
  numbering: none,
)
#set text(size: 11pt)
#set par(leading: 0.4em, spacing: 0.9em, justify: false)
#set list(indent: 0pt, marker: [•])

// A thin rule spanning the full text width, used under each section title.
#let rule() = line(length: 100%, stroke: 0.4pt)

// A section header: bold title, tight vertical spacing, rule underneath.
// Call this once per section instead of hand-rolling spacing + rule
// every time (compare to LaTeX, where this is copy-pasted per section).
#let section(title) = [
  #v(0.55em)
  #text(weight: "bold", size: 11pt)[#title]
  #v(-0.65em)
  #rule()
  #v(-0.15em)
]

// ----- Header -----
#align(center)[
  #text(size: 16pt, weight: "bold")[YOUR NAME]

  (123) 456-6789 | #link("mailto:jordan.smith@example.com")[jordan.smith\@example.com] | #link("https://www.linkedin.com/in/jordansmith-example/")[LinkedIn] | #link("https://github.com/jordansmith-example")[GitHub] | #link("https://jordansmith-example.github.io")[Portfolio]
]

#section[TECHNICAL SKILLS]

*Languages:* Python (scikit-learn, PyTorch, XGBoost, pandas, NumPy), SQL, R (tidyverse, Shiny)

*Modeling:* Regression, classification, time series, anomaly detection, forecasting, NLP, experimental design, A/B testing

*Deployment:* ETL, AWS, FastAPI, Docker, MLflow, GitHub Actions, Power BI

#section[EXPERIENCE]

*Graduate Research Assistant* #h(1fr) August 2024 -- June 2025

_State University_ #h(1fr) Example City, EX

- Designed and deployed a course module covering the full model lifecycle for a graduate analytics cohort, translating production methods into class content.

- Researched evaluation frameworks for applied ML workflows with a faculty advisor across course-integrated projects.

*Data Engineer Intern* #h(1fr) May 2024 -- September 2024

_XYZ Financial Group_ #h(1fr) Example City, EX

- Owned end-to-end design of a compliance risk monitoring system, joining 6 data schemas via SQL across ~50M rows, with requirements scoped directly from stakeholders.

- Engineered deduplication and consistency checks feeding a weighted scoring engine with configurable exception thresholds.

- Delivered a live dashboard with automated anomaly detection, cutting manual review time ~50% for a 20-person team, presented findings to 30+ stakeholders.

*Business Intelligence Intern* #h(1fr) May 2023 -- August 2023

_ABC Operating Co._ #h(1fr) Example City, EX

- Replaced a manual reporting pull by designing a SQL star schema across sales tables, then building KPI dashboards in Power BI.

- Diagnosed a recurring failure in a live dashboard by tracing a broken join and missing values at the SQL source, then resolved the upstream data issue.

#section[PROJECTS]

*Loan Loss Severity Analysis* | #link("https://github.com/jordansmith-example/loan-loss-severity")[GitHub] #h(1fr) June 2025

- Modeled loss severity across ~20,000 sample loans using Python and XGBoost, engineering change-based features to isolate distress signals.

- Found that one asset category carried notably higher average loss severity than others, with mixed portfolios partially cushioned by diversified income.

*Macro Regime Stress Detection* | #link("https://github.com/jordansmith-example/macro-stress-detection")[GitHub] | #link("https://example.com/demo")[Live Demo] #h(1fr) February 2025 -- April 2025

- Trained an unsupervised LSTM autoencoder on public macro indicators using a stable-period baseline to surface environmental stress before labels exist.

- Correctly identified multiple structurally distinct stress periods using a principled threshold, distinguishing temporary dislocations from sustained regime shifts.

*News Signal Retrieval* | #link("https://github.com/jordansmith-example/news-signal-rag")[GitHub] | #link("https://example.com/demo2")[Live Demo] #h(1fr) January 2025 -- Ongoing

- Built a retrieval system over 500+ news articles using an open-source embedding pipeline to synthesize relevant signals in under 5 seconds end-to-end.

- Ran a controlled A/B test across several corpus sizes, achieving strong retrieval precision and cutting manual query time significantly versus manual search.

#section[EDUCATION]

*State University*, College of Business #h(1fr) Example City, EX

Master of Science in Analytics, GPA: 3.70 #h(1fr) August 2024 -- May 2025

B.S., Business Administration: Information Systems #h(1fr) August 2020 -- May 2024

_NCAA Division I Athletics; Dean's List; Conference Honor Roll_

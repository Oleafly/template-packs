// example.typ — Sample CV written with the early-career-cv template.
//
// Compile:  typst compile example.typ
// Preview:  typst watch  example.typ

#import "early-career-cv.typ": *

// Apply the CV template to the whole document.
#show: cv.with(
  font: "New Computer Modern",
  font-size: 11pt,
  paper: "us-letter",
  margin: (left: 0.5in, right: 0.5in, top: 0.1in, bottom: 0.1in),
  link-color: rgb("#1155CC"),
)

// ── Header ─────────────────────────────────────────────────────────────────────
#cv-header(
  name: "Your Name",
  phone: "(555) 555-5555",
  phone-url: "tel:5555555555",
  email: "you@example.com",
  linkedin-label: "linkedin.com/in/yourhandle",
  linkedin-url: "https://www.linkedin.com/in/yourhandle",
  github-label: "github.com/yourhandle",
  github-url: "https://github.com/yourhandle",
  location: "City, ST",
  location-url: "https://maps.example.com/your-city",
)

// ── Education ─────────────────────────────────────────────────────────────────
= Education
#company-row([Ph.D. in Field of Study $|$ University Name], [Expected Month YYYY])
#company-row([M.A. in Field of Study $|$ University Name], [Sept YYYY--Oct YYYY])
#company-row([B.A. (Hons) in Field of Study $|$ University Name], [Sept YYYY--May YYYY])

// ── Technical Skills ──────────────────────────────────────────────────────────
= Technical Skills
#bullets([
  - Tool A, Tool B (Library 1, Library 2, Library 3, Library 4), Tool C, Tool D, Tool E
  - methodology area one (sub-method, sub-method, sub-method,
    sub-method), methodology area two (technique, technique,
    technique/technique)
])

// ── Selected Projects ─────────────────────────────────────────────────────────
= Selected Projects
#company-row(
  [Descriptive Title of First Project],
  [#link("https://example.com/report.pdf")[Report]],
)
#bullets([
  - One-line description of the data sources, scope, and assembly of the underlying
    panel or dataset.
  - One-line description of the modeling approach and the kinds of analyses or
    scenarios it supports.
  - One-line description of the causal/identification strategy and how the findings
    translate into actionable takeaways.
])
#company-row(
  [Descriptive Title of Second Project],
  [#link("https://github.com/yourhandle/repo")[Github]],
)
#bullets([
  - One-line description of the models trained or compared and the scale of the task
    (e.g., number of series, records, or features).
  - One-line description of deployment, productization, or downstream use that made
    the work reusable.
])

// ── Experience ────────────────────────────────────────────────────────────────
= Experience
#company-row([Job Title], [Month YYYY--Month YYYY])
#title-row([Employer Name], [#link("https://github.com/yourhandle/project")[Github]])
#bullets([
  - High-level accomplishment that names the tools used and the quality or
    reproducibility practices applied.
  - High-level accomplishment showing the analyses produced, the scale of new data
    created, and the methods used to draw conclusions.
    - Sub-bullet describing one specific result, comparison, or improvement and what
      it enabled the team or stakeholders to do.
    - Sub-bullet describing another specific result, the technique behind it, and the
      decision or audience it supported.
  - High-level accomplishment about metrics, dashboards, or repeatable reporting that
    you built or maintained.
])

#company-row([Prior Job Title], [Month YYYY--Month YYYY])
#title-row([Employer Name (context, e.g., through dissertation research)], [])
#bullets([
  - High-level accomplishment about reproducible pipelines or workflows you built
    using your core tooling for cleaning data, producing outputs, and analysis.
  - High-level accomplishment about quasi-experimental or empirical analyses you
    designed, with a one-line statement of why they mattered, including:
    - sub-bullet naming a specific study, the outcome examined, and what it informed.
    - sub-bullet naming a second study, the mechanism it identified, and its
      practical implication.
  - High-level accomplishment about structural or simulation modeling that turned
    estimates into forward-looking analyses, including:
    - sub-bullet describing one scenario or counterfactual and the question it
      answered.
    - sub-bullet describing another scenario or elasticity estimate and the broader
      behavior it helped explain.
])

#company-row([Earlier Job Title (e.g., Research Assistant)], [Month YYYY--Month YYYY])
#title-row([Employer Name, Location], [])
#bullets([
  - One-line accomplishment describing the project, the timeline, the techniques
    used (e.g., OCR, manual review, validation), and the deliverable produced.
])

// ── Selected Publications ─────────────────────────────────────────────────────
= Selected Publications
#pub-init([
  Last, First, Co-Author Name, and Co-Author Name. Forthcoming.
  "#link("https://example.com/paper")[Title of the Forthcoming Article]."
  _Journal Name_.
])

#pub([
  Last, First, Co-Author Name, and Co-Author Name. YYYY.
  "#link("https://example.com/chapter")[Title of the Published Chapter or Article]."
  _Journal or Volume Name_.
])

#pub([
  Last, First. YYYY.
  "#link("https://example.com/working-paper.pdf")[Title of the Working Paper]."
  Working paper.
])

#pub([
  ---. YYYY. "Title of an Earlier Working Paper." Working paper.
])

#pub([
  ---. YYYY.
  "#link("https://example.com/older-paper.pdf")[Title of an Older Working Paper]."
  Working paper.
])

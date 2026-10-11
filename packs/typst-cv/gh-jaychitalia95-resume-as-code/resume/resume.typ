// Sample resume. Edit this, then run `typst compile resume/resume.typ cv.pdf`.
// Bump #version on every meaningful change. CI passes the bumped git tag via
// `--input version=...`; local builds fall back to "dev".
#let version = sys.inputs.at("version", default: "dev")

#let ink = rgb("#1f1f28")
#let accent = rgb("#3b6ea5")
#let muted = rgb("#55554f")
#let rule-color = rgb("#a6a69c")

// ── Spacing system (one source of truth for vertical rhythm) ──
#let GAP_SECTION = 10.5pt  // above each section heading
#let GAP_BODY = 4pt        // heading -> content, paragraph gaps
#let GAP_BULLET = 6pt      // between bullet points
#let GAP_ENTRY = 8pt       // before each subsequent experience entry

#set document(title: "John Doe - Resume", author: "John Doe")
#set page(
  margin: (x: 1.55cm, y: 1.35cm),
  numbering: none,
  footer: align(right, text(size: 7.5pt, fill: muted)[#version #h(4pt)·#h(4pt) #datetime.today().display("[month repr:short] [year]")]),
)
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 9.8pt, fill: ink)
#set par(leading: 0.54em, justify: true, spacing: GAP_BODY)
#set list(spacing: GAP_BULLET, marker: text(fill: accent)[•])

#show heading.where(level: 1): it => block(breakable: false, above: GAP_SECTION, below: GAP_BODY)[
  #set text(size: 10.5pt, fill: accent, weight: "bold")
  #upper(it.body)
  #v(-4pt)
  #line(length: 100%, stroke: 0.5pt + rule-color)
]

// One renderer for every org/role header so spacing is identical everywhere.
#let entry(org, loc, role, first: false) = block(
  above: if first { GAP_BODY } else { GAP_ENTRY }, below: GAP_BODY, breakable: false,
)[
  *#org* #h(1fr) #loc \
  #text(style: "italic", fill: muted)[#role]
]

// ── Header ───────────────────────────────────────────────
#align(center)[
  #text(size: 21pt, fill: accent, weight: "bold")[JOHN DOE] \
  #v(1pt)
  #text(size: 10pt, fill: muted)[SOFTWARE ENGINEER] \
  #v(3pt)
  #text(size: 9pt)[
    San Francisco, CA
    #h(6pt) · #h(6pt) #link("mailto:john.doe@example.com")[john.doe\@example.com]
    #h(6pt) · #h(6pt) #link("https://example.com")[johndoe.dev]
    #h(6pt) · #h(6pt) #link("https://github.com/johndoe")[github.com/johndoe]
  ]
]

= Summary
Software engineer who likes shipping reliable systems and tidy automation. Comfortable across
the stack, happiest close to the platform, and a believer that the best tooling is the kind
nobody has to think about.

= Skills
#block[
  #set par(justify: false)
  #set text(size: 9.5pt)
  *Languages:* Python, TypeScript, Go, SQL \
  *Cloud & infra:* AWS, Docker, Kubernetes, Terraform, GitHub Actions \
  *Data & tooling:* PostgreSQL, Redis, Grafana, Prometheus
]

= Experience
#entry("Acme Corp", "San Francisco, CA · 2022 – Present", "Senior Software Engineer", first: true)
- Led a monolith-to-services migration that cut deploy time from 40 minutes to under 5.
- Built the CI/CD templates the rest of engineering ships on, standardizing build, test, and deploy.
- Mentored two junior engineers and ran a weekly "how it works" internal session.

#entry("Globex", "Remote · 2019 – 2022", "Software Engineer")
- Designed a job-processing pipeline handling 2M events a day with at-least-once delivery.
- Cut cloud spend roughly 30% by right-sizing instances and shutting down idle environments.

#entry("Initech", "Austin, TX · 2017 – 2019", "Junior Developer")
- Shipped the first version of the customer dashboard (React front end on a REST API).
- Added integration tests that caught a class of regressions before release.

= Education
#entry("State University", "2017", "B.S. Computer Science", first: true)

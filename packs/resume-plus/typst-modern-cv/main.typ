#set page(paper: "us-letter", margin: 0.7in)
#set text(size: 10.5pt)
#let accent = rgb("#2B7A4B")
#let sect(title) = [
  #v(8pt)
  #text(fill: accent, weight: "bold", size: 13pt)[#title]
  #line(length: 100%, stroke: 0.6pt + accent)
]

#text(size: 22pt, weight: "bold")[Your Name]
#h(1fr)
#text(size: 9pt)[you\@example.com | github.com/you | City, Country]

#sect[Experience]
*Senior Engineer, Example Corp* #h(1fr) 2023 - present
- Led the storage migration; cut p99 latency by 75 percent.
- Shipped the feature used by 2M monthly users.

*Engineer, Startup Inc* #h(1fr) 2020 - 2023
- Built the event pipeline handling 10M events per day.

#sect[Education]
*B.S. Computer Science, Example University* #h(1fr) 2016 - 2020

#sect[Skills]
Rust, TypeScript, Python, Postgres, Kubernetes

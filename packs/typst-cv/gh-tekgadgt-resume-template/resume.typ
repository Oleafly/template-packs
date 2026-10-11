// Example resume built on template.typ. Replace the content with your own.
// Build with:  typst compile resume.typ resume.pdf

#import "template.typ": *

// Apply the template's page setup, heading style, list style, and helpers to
// the whole document.
#show: resume

// ── Header ────────────────────────────────────────────────────────────────────
// The header is plain content (not a helper), so you can lay it out however you
// like. The `#show link: underline` further down is placed *after* the header on
// purpose, so these contact links render clean while links in the body get
// underlined.
#align(center)[
  #text(size: 22pt, weight: "bold")[Jane Doe]
  #v(0.1em)
  #text(size: 11pt, fill: rgb("#555555"))[Full-Stack Engineer]
  #v(0.3em)
  #text(size: 9.5pt)[
    #link("mailto:jane@example.com")[jane\@example.com]
    #h(0.4em) | #h(0.4em)
    #link("https://example.com")[example.com]
    #h(0.4em) | #h(0.4em)
    #link("https://github.com/janedoe")[github.com/janedoe]
    #h(0.4em) | #h(0.4em)
    #link("https://www.linkedin.com/in/janedoe")[linkedin.com/in/janedoe]
  ]
]

#v(0.6em)

// Underline inline body links so they read as clickable. Placed after the header
// so the contact line stays clean.
#show link: underline

= Summary

One or two sentences that position you for the role: what you do, the scale or
domains you've worked in, and what you're best at. Keep it concrete.

= Skills

// Each line is a labeled category. End every line *except the last* with a
// trailing `\` (a Typst line break) so the categories stack tightly.
*Languages:* TypeScript, Python, Go, SQL \
*Frameworks:* React, Node, Next.js, FastAPI \
*Infrastructure:* AWS, Docker, Postgres, Redis, CI/CD \
*Practices:* Testing, code review, technical writing

= Experience

// #job(company, title, date)[ bullets ]
// The title and its bullets are kept together on one page (never split by a page
// break). A section can still break *between* jobs, and the "Experience" header
// stays attached to the first job.
#job("Acme Corp", "Senior Software Engineer", "2022 – Present")[
- Led a project that produced a concrete, measurable outcome (include the metric).
- Built or shipped something notable, and note the scale or impact.
- Improved a process, system, or number in a way a stranger can evaluate.
]

#job("Startup Inc.", "Software Engineer", "2019 – 2022")[
- Owned a feature or system end to end, from design through production.
- Collaborated across teams to deliver a result that mattered to the business.
]

= Projects

// #project(name, url, label, tech)[ description ]
//   name  — bold project name
//   url   — the link target
//   label — the visible (blue) link text
//   tech  — italic tech list shown after the title
#project(
  "Project One",
  "https://example.com/one",
  "example.com/one",
  "TypeScript, Postgres, AWS",
)[
A sentence or two on what it does and why it's interesting. Lead with the part a
reader will care about most.
]

#project(
  "Project Two",
  "https://github.com/janedoe/project-two",
  "github.com/janedoe/project-two",
  "Go, React",
)[
Another short, punchy description. The title + description stay together on one
page.
]

= Talks

// #talk(title, venue, year) — a one-line entry with an italic title.
#talk("A Talk I Gave", "Some Conference", "2024")

= Community

// #community(name)[ description ] — like a project, for community, volunteer, or
// organizing work.
#community("A Meetup You Organize")[
What you run or contribute, and any noteworthy scale or outcome.
]

= Press & Mentions

// #press(title, source, url, date) — links the italic title to `url`.
#press("An article about your work", "Publication Name", "https://example.com/article", "2024")

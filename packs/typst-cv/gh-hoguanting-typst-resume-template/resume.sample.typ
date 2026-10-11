#let body_font_size = 10pt
#let name_font_size = 16pt
#let section_font_size = 10pt
#let section_blue = rgb("#0070c0")

#set text(font: "Arial", hyphenate: false, size: body_font_size)
#set page(margin: (x: 0.5in, y: 0.45in))
#set par(leading: 0.52em, spacing: 0pt, justify: false)

#let divider() = {
  v(3.5pt)
  line(length: 100%, stroke: 0.6pt + black)
  v(3pt)
}

#let section(title, body) = [
  #v(16pt)
  #text(size: section_font_size, fill: section_blue, weight: "bold")[#upper(title)]
  #divider()
  #body
]

#let two-col(left_content, right_content) = {
  grid(
    columns: (1fr, auto),
    gutter: 1em,
    left_content,
    align(right)[#right_content],
  )
}

#let education(school, location, degree, graduation) = [
  #two-col([*#school*], [*#location*])
  #v(6pt)
  #two-col([#emph(degree)], [#emph(graduation)])
]

#let experience(company, location, role, dates, body, first: false) = [
  #if not first { v(6pt) }
  #two-col([*#company*], [*#location*])
  #v(6pt)
  #two-col([#emph(role)], [#emph(dates)])
  #v(6pt)
  #body
]

#let project(name, tools, body, first: false) = [
  #if not first { v(6pt) }
  *#name*\
  #emph(tools)
  #v(6pt)
  #emph(body)
]

#let bullet(body) = [
  #block(width: 100%)[
    #layout(size => {
      let text_width = size.width - 18pt
      grid(
        columns: (18pt, text_width),
        column-gutter: 0pt,
        [•],
        block(width: text_width)[#body],
      )
    })
  ]
  #v(7.2pt)
]

#align(center)[
  #v(1.5pt)
  #text(size: name_font_size, weight: "bold")[JANE DOE]\
  #v(5.5pt)
  #link("mailto:jane.doe@example.com")[#emph[#underline[jane.doe\@example.com]]]
  #text[ • +1 555 123 4567 • ]
  #link("https://www.linkedin.com/in/janedoe/")[#emph[#underline[www.linkedin.com/in/janedoe/]]]
]

#section("Education")[
  #education(
    "Example University",
    "City, Country",
    "Bachelor of Science in Computer Science",
    "Expected Graduation: May 2027",
  )
]

#section("Technical Skills")[
  *Programming Languages:* Python, Java, TypeScript, JavaScript, C++, SQL\
  *Framework & Libraries:* React, Node.js, Express.js, FastAPI, GraphQL, PostgreSQL, Redis, Kafka, Docker\
  *CI/CD, Cloud & Tools:* Git, GitHub Actions, Kubernetes, Terraform, AWS, Linux\
  *Spoken Languages:* English, Spanish, Mandarin
]

#section("Experience")[
  #experience(
    "Example Technology Company",
    "Remote",
    "Software Engineer Intern",
    "Jun.2025 - Aug.2025",
    first: true,
  )[
    #bullet[Built internal dashboard features with React and TypeScript, improving common workflow completion time by *25%* for operations users.]
    #bullet[Implemented REST API endpoints and database queries for reporting workflows, reducing manual data preparation from hours to minutes.]
    #bullet[Collaborated with product and design teammates to refine edge cases, validate requirements, and ship user-facing improvements.]
  ]

  #experience(
    "Example Consulting Group",
    "City, Country",
    "Product Analyst Intern",
    "Jan.2025 - Apr.2025",
  )[
    #bullet[Analyzed customer feedback and usage data to identify high-impact product gaps across onboarding and reporting flows.]
    #bullet[Created wireframes and acceptance criteria for new analytics features, helping engineering prioritize scoped releases.]
    #bullet[Presented weekly findings to stakeholders and maintained documentation for project risks, tradeoffs, and next steps.]
  ]
]

#section("Projects")[
  #project(
    "AI Document Review Assistant",
    "Python, LangChain, RAG, PostgreSQL, Vector Search",
    first: true,
  )[
    #bullet[Built a retrieval-augmented assistant that summarizes uploaded documents and answers user questions with source-grounded responses.]
    #bullet[Designed chunking, embedding, and ranking logic that improved answer relevance by *30%* compared with a baseline prompt-only workflow.]
    #bullet[Added evaluation scripts for response quality, latency, and retrieval coverage to support repeatable iteration.]
  ]

  #project(
    "Real-Time Event Processing Platform",
    "Golang, Kafka, Redis, PostgreSQL, Docker",
  )[
    #bullet[Implemented an event ingestion service that processes streaming records with retries, idempotency checks, and structured logging.]
    #bullet[Designed APIs for querying aggregated metrics, keeping p95 response time under *150ms* in local load tests.]
    #bullet[Containerized the system with Docker and documented local setup for contributors.]
  ]

  #project(
    "Full-Stack Task Management App",
    "React, Node.js, Express.js, PostgreSQL, GitHub Actions",
  )[
    #bullet[Created a responsive task management interface with filtering, sorting, optimistic updates, and accessible form states.]
    #bullet[Built authentication, task APIs, and database migrations with automated checks in CI.]
    #bullet[Deployed a demo environment and wrote setup instructions for local development.]
  ]
]

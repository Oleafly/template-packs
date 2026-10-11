// global variables
#let H1COLOR = color.hsl(208deg, 80%, 30%)
#let H2COLOR = color.hsl(228deg, 80%, 35%)


// set doc metadata
#set document(author: "Swarnim Barapatre", title: "Resume - Swarnim Barapatre")

// font style
#set text(font: "New Computer Modern", size: 10pt, lang: "en", ligatures: false)

// page properties
#set page(margin: 0.5in, paper: "a4")

// link styles
// #show link: underline


// Small caps for section titles
#show heading.where(level: 2): it => [
  #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
  #line(length: 100%, stroke: 0.1pt)
]

// Name will be aligned left, bold and big
#show heading.where(level: 1): it => [
  #set align(center)
  #set text(weight: 500, size: 24pt)
  #pad([#smallcaps(it.body)])
]


= #text(fill: H1COLOR)[#link("https://smarniw.com")[Swarnim Barapatre]]

// personal info
#pad(top: 0.25em, align(center)[
  +91 8149 833 469 |
  Pune |
  #link("mailto:swarnim335@gmail.com") |
  #link("https://github.com/swarnimcodes/")[github/swarnimcodes] |
  #link(
    "https://www.linkedin.com/in/swarnimbarapatre/",
  )[linkedin/swarnimbarapatre]
])


// idk what this does
// #set par(justify: true)


#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

== #text(fill: H2COLOR)[#text(fill: H2COLOR)[Professional Summary]]

Full-Stack Software Engineer focused on backend-heavy product engineering,
database-backed systems, and industrial software platforms. Experienced in
building production APIs, data pipelines, graph-based workflows, CAD
adapters, AI agents, and full-stack applications across
TypeScript, Python, Node.js, and Go ecosystems. Strong bias toward
maintainable architecture, performance-aware design, reliable data
modeling, and practical automation.

== #text(fill: H2COLOR)[Education]
#generic-two-by-two(
  top-left: strong("BITS Pilani"),
  top-right: "Vasco da Gama, Goa",
  bottom-right: dates-helper(start-date: "May, 2019", end-date: "July, 2024"),
  bottom-left: emph(
    "B.E. Chemical Engineering + M.Sc. Biological Sciences",
  ),
)


== #text(fill: H2COLOR)[#text(fill: H2COLOR)[Professional Experience]]

// 0. coditation
#generic-two-by-two(
  top-left: strong("Coditation Systems (Plant360.ai)"),
  top-right: "Pune, Maharashtra",
  bottom-right: dates-helper(start-date: "Feb, 2026", end-date: "Present"),
  bottom-left: emph("FullStack Software Engineer"),
)
- Built an AI agent that generates equipment-isolation plans for
  real-world process scenarios in Plant360.
- Designed the agent around a self-orchestrating tool-calling loop,
  deterministic graph traversal modules, validation gates, evidence
  recovery through targeted follow-up calls, and auditable execution
  traces.
- Contributed to the Plant360.ai platform backend, developing
  production API services for industrial P&ID conversion and
  engineering-data workflows.
- Reverse-engineered SmartPlant™ P&ID automation APIs to build the
  SPPID-to-Plant360 adapter, extracting proprietary `.pid` drawings
  into Plant360's custom graph format through a REST API.
- Built dexpi-service as the next stage of the SmartPlant™ P&ID to
  DEXPI pipeline, converting Plant360 graph JSON into validated DEXPI
  output through async job processing, persisted job state, result
  retrieval APIs, bearer-token auth, and Docker deployment.
- Developed an AutoCAD adapter that renders Plant360
  custom graph data into DWG drawings using reusable symbol catalogs,
  batch conversion scripts, and generated equipment, line, valve,
  instrument, tag, and annotation geometry.
- Built a custom symbol-conversion tool that automated a previously
  manual drafting workflow across 90+ symbol definitions, cutting
  ~2 hours/day of repetitive effort down to a verification step.

// 1. accurate ic
#generic-two-by-two(
  top-left: strong("AccurateIC"),
  top-right: "Pune, Maharashtra",
  bottom-right: dates-helper(start-date: "Aug, 2024", end-date: "Feb, 2026"),
  bottom-left: emph("FullStack Software Engineer, AI Department"),
)

- Architected and developed ISACA, a full-stack monorepo for
  Indian Navy autonomous ship-control workflows, integrating ROS
  middleware through custom pub-sub transport and real-time
  multi-sensor fusion across radar, GPS, cameras, eMRU, and
  odometry streams.
- Built radar overlay, AIS tracking, dynamic route planning,
  waypoint management, voyage tracking, and shore-to-ship
  synchronization using bidirectional WebSocket architecture.
- Developed real-time shell command execution and monitoring
  flows with UI feedback, and set up Jenkins CI/CD with automated
  database migrations, seeding, and systemd orchestration.
- Led full-stack development for the BlueGulf x AccurateIC
  collaboration, adapting autonomous navigation systems for
  high-speed vessels and showcasing the platform at DriftX
  Abu Dhabi Autonomous Expo at Yas Marina.
- Architected and developed NeuroGen, an IoT-enabled genset
  monitoring platform with predictive maintenance,
  multi-variate anomaly detection, life expectancy simulations,
  and operational data visualizations.
- Drove architecture, code reviews, junior developer mentoring,
  and performance profiling, achieving 40% CPU reduction in
  critical application flows.


// 2. mastersoft erp
#generic-two-by-two(
  top-left: strong("MasterSoft ERP Solutions"),
  top-right: "Nagpur, Maharashtra",
  bottom-right: dates-helper(start-date: "Aug, 2023", end-date: "June, 2024"),
  bottom-left: emph("Software Engineering Intern, R&D Department"),
)
- Developed Panopticon, a multi-tenant employee productivity
  measurement system serving 700+ concurrent users, eliminating
  DeskTime dependency and saving Rs 53 Lakhs annually.
- Implemented Panopticon features including atomic app updates,
  live configuration sync, encrypted activity logs, and accurate
  productivity metrics for remote talent evaluation.
- Built an internal MS-SQL suite for database developers,
  reducing SQL task flows by 85% through stored procedure diffs,
  alter-script generation, and memory leak detection tooling.
- Built comprehensive internal developer toolchains and automation
  frameworks, reducing development cycle times by up to 14 days
  and improving team productivity across multiple projects.
- Maintained critical Linux server infrastructure, implemented
  proactive monitoring solutions, and resolved production incidents
  to ensure system uptime and reliability.

== #text(fill: H2COLOR)[Skills]
- #strong("Languages"):
  TypeScript,
  JavaScript,
  Python,
  Go,
  C\#,
  SQL,
  Bash,
  Powershell,
  Pascal
- #strong("Frontend"):
  React,
  Zustand,
  Redux,
  Tanstack Query,
  HTML, CSS,
  TailwindCSS
- #strong("Backend"):
  AdonisJS MVC,
  ExpressJS,
  NodeJS,
  OAuth,
  RabbitMQ,
  Lucid ORM,
  Flask,
  FastAPI,
  Django,
  Fiber,
  WebSockets,
  Server-Sent Events,
  Tool Calling,
- #strong("Databases"):
  PostgreSQL,
  SQLite,
  Microsoft SQL Server,
  MongoDB
- #strong("Cloud/DevOps"):
  AWS EC2,
  Docker,
  Nginx,
  GitLab,
  GitHub,
  GitHub Actions,
  Jenkins,
  Linux
- #strong("Other"):
  ROS,
  Emacs,
  Vim,
  LaTeX,
  Typst

== #text(fill: H2COLOR)[Personal Projects]


#generic-one-by-two(
  left: link("https://github.com/swarnimcodes/c3fm")[#strong(
    "c3fm" + " " + $dash.em$ + " " + "Terminal file manager in C3 Lang",
  )],
  right: dates-helper(start-date: "June, 2026", end-date: "present"),
)
- Terminal based file manager. Navigation using vim-like keys.
- Building from scratch without external libraries.
- Built using a low-level systems programming language with manual memory management using arenas.
- Tech Stack: #emph("C3: https://c3-lang.org/")

#generic-one-by-two(
  left: link("https://github.com/swarnimcodes/fero")[#strong(
    "Fero" + " " + $dash.em$ + " " + "Continuation of the RQuickShare Project",
  )],
  right: dates-helper(start-date: "May, 2026", end-date: "present"),
)
- Took up the continuation of an open-source project
  which was abandoned since 2 years
  used by thousands of people in the foss community.
- Implemented novel features leveraging the quickshare
  technology in-built in android devices for information transfer
  with minimal latency.
- Tech Stack: #emph("Rust, Tauri, QuickShare, React, TypeScript, GitHub Actions")


#generic-one-by-two(
  left: link("https://github.com/swarnimcodes/turepo")[#strong(
    "Turepo" + " " + $dash.em$ + " " + "Package for Emacs",
  )],
  right: dates-helper(start-date: "Dec, 2025", end-date: "present"),
)
- Built a developer productivity package for the GNU Emacs text editor.
- Passed MELPA's code & quality standards. Package merged in MELPA.
- Tech Stack: #emph("Emacs Lisp")

#generic-one-by-two(
  left: link("https://github.com/swarnimcodes/kafkaesqueue")[#strong(
    "Kafkaesqueue" + " " + $dash.em$ + " " + "Custom Queueing System",
  )],
  right: dates-helper(start-date: "Oct, 2023", end-date: "June, 2024"),
)
- Lightweight queue mangement system. FIFO Guarantees.
- Opt-in parallel processing of tasks using threads. Cuts down processing time by \${nproc}.
- Built-in persistence via SQLite or in-memory storage.
- Tech Stack: #emph("Python, FastAPI, Pydantic").


== #text(fill: H2COLOR)[Extra Curriculars]
#strong("Swimming"): National Swimmer. Multiple times State Gold Medalist.

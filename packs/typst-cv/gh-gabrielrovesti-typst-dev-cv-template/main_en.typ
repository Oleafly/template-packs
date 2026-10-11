// ╔══════════════════════════════════════════════════╗
// ║  CV – Gabriel Rovesti  (English Version)          ║
// ╚══════════════════════════════════════════════════╝

#let primary    = rgb("#1a4a8a")
#let accent     = rgb("#2d7dd2")
#let sidebar-bg = rgb("#f0f3f8")
#let tag-fill   = rgb("#dce8f7")
#let tag-stroke = rgb("#a8c4e8")
#let muted      = rgb("#5a6272")
#let body-black = rgb("#1c2430")

// ── geometria ─────────────────────────────────────
#let sb-w     = 66mm
#let sb-pad-x = 10pt
#let rh-pad-l = 13pt
#let rh-pad-r = 13pt
#let mg-t     = 12pt
#let mg-b     = 12pt

#set page(
  paper: "a4",
  margin: (top: mg-t, bottom: mg-b, left: sb-w + rh-pad-l, right: rh-pad-r),
  background: place(
    top + left,
    rect(width: sb-w, height: 100%, fill: sidebar-bg)
  ),
)

#set text(font: "New Computer Modern", size: 10pt, fill: body-black)
#set par(justify: true, leading: 0.52em, spacing: 5pt)
#show heading: set text(font: "New Computer Modern", fill: primary)

// ── funzioni ──────────────────────────────────────

#let skill(s) = box(
  inset: (x: 4pt, y: 2pt),
  radius: 2pt,
  fill: tag-fill,
  stroke: 0.4pt + tag-stroke,
  text(size: 7pt, fill: primary, s)
)

#let sb-sec(title) = {
  v(8pt)
  text(fill: primary, weight: "bold", size: 8.5pt, upper(title))
  v(-2pt)
  line(length: 100%, stroke: 0.5pt + primary)
  v(3pt)
}

#let sec(title) = {
  v(7pt)
  text(fill: primary, weight: "bold", size: 9.8pt, upper(title))
  v(-2pt)
  line(length: 100%, stroke: 0.7pt + primary)
  v(3pt)
}

#set list(spacing: 0.65em, marker: text(fill: accent)[•])

#let job(role, company, period, body) = {
  v(4pt)
  grid(
    columns: (1fr, auto),
    text(weight: "bold", size: 9.5pt)[#role],
    text(size: 8pt, fill: muted, style: "italic")[#period],
  )
  text(size: 8.5pt, fill: accent)[#company]
  v(1pt)
  set text(size: 8.5pt)
  set par(leading: 0.46em, spacing: 4pt)
  body
}

#let edu(degree, school, period, body) = {
  v(4pt)
  grid(
    columns: (1fr, auto),
    text(weight: "bold", size: 9.5pt)[#degree],
    text(size: 8pt, fill: muted, style: "italic")[#period],
  )
  text(size: 8.5pt, fill: accent)[#school]
  v(1pt)
  set text(size: 8.5pt)
  set par(leading: 0.46em, spacing: 4pt)
  body
}

#let proj-sb(title, tech, desc) = {
  v(4pt)
  text(weight: "bold", size: 9pt)[#title]
  linebreak()
  text(size: 7.5pt, fill: muted, style: "italic")[#tech]
  v(1pt)
  text(size: 9pt)[#desc]
  v(2pt)
}

#let proj-compact(title, tech, desc) = block(width: 100%, above: 0pt, below: 0pt)[
  #v(4pt)
  #text(weight: "bold", size: 8.3pt)[#title]
  #text(size: 7pt, fill: muted, style: "italic")[ · #tech]
  #v(1pt)
  #text(size: 7.6pt)[#desc]
]

#let place-sidebar(body) = place(
  top + left,
  dx: sb-pad-x - sb-w - rh-pad-l,
  box(width: sb-w - 2 * sb-pad-x)[#body]
)

// ─────────────────────────────────────────────────
// PAGINA 1 — Sidebar
// ─────────────────────────────────────────────────

#place-sidebar[
  #v(4pt)
  #align(center)[
    #box(clip: true, radius: 50%, width: 62%)[
      #image("gabriel.jpg", width: 100%)
    ]
    #v(4pt)
    #text(size: 12pt, weight: "bold", fill: primary)[Gabriel Rovesti]
    #v(1pt)
    #text(size: 7.5pt, fill: muted, style: "italic")[
      IT Consultant · Backend Developer \
      University Lecturer & Tutor
    ]
  ]

  #sb-sec("Contact")
  #set text(size: 8pt)
  ✉ #link("mailto:rovestigabriel@gmail.com")[rovestigabriel\@gmail.com] \
  #v(1pt)
  ✆ +39 346 688 9789 \
  #v(1pt)
  ⌂ Padova, Italy \
  #v(1pt)
  _GitHub_: #link("https://github.com/gabrielrovesti")[github.com/gabrielrovesti] \
  #v(1pt)
  _LinkedIn_: #link("https://linkedin.com/in/gabriel-rovesti-601404220")[linkedin/gabriel-rovesti] \
  #v(1pt)
  _Portfolio_: #link("https://gabrielrovesti.github.io")[gabrielrovesti.github.io]

  #sb-sec("Skills")
  #set text(size: 8pt)

  *Programming Languages* \
  #v(1pt)
  #skill("Java") #skill("Python") #skill("TypeScript") #skill("Rust") \
  #skill("C/C++") #skill("C#") #skill("F#") #skill("Kotlin") \
  #skill("Elixir") #skill("Go") #skill("Solidity") #skill("SQL")

  #v(4pt)
  *Frontend & Mobile* \
  #v(1pt)
  #skill("React") #skill("React Native") #skill("Angular") \
  #skill("Flutter") #skill("WebAssembly")

  #v(4pt)
  *Backend & Cloud* \
  #v(1pt)
  #skill("Spring Boot") #skill("FastAPI") #skill(".NET") \
  #skill("PostgreSQL") #skill("MongoDB") #skill("Redis") \
  #skill("AWS") #skill("GCP") #skill("Docker") #skill("Kubernetes")

  #v(4pt)
  *Observability* \
  #v(1pt)
  #skill("Grafana") #skill("Splunk") #skill("IBM Instana") #skill("Datadog")

  #v(4pt)
  *Specializations* \
  #v(1pt)
  #skill("WCAG 2.2") #skill("MCP") #skill("AI Agents") \
  #skill("Reactive Systems") #skill("ML/AI") #skill("Functional Prog.")

  #sb-sec("Certifications")
  #set text(size: 8pt)
  • Anthropic MCP (Intro · Advanced · Claude Code) \
  • Lightbend Reactive Architecture \
  • Kubernetes LFS158 — Linux Foundation \
  • Cisco Networking · Ethical Hacking \
  • Datadog Kubernetes Fundamentals \
  • English B2 (UniPD) · Berlitz German A2 \
  • IELTS General Training · Band 7.5 \
  (CEFR C1)

  #sb-sec("Languages")
  #set text(size: 8pt)
  #grid(
    columns: (1fr, auto),
    row-gutter: 2pt,
    column-gutter: 4pt,
    [Italian], [C2 — Native],
    [English],  [C1 — Advanced],
    [French], [B1 — Intermediate],
    [Spanish], [A2 — Basic],
    [German],  [A2 — Basic],
  )

  #sb-sec("Awards & Recognition")
  #set text(size: 8pt)
  • *Top 50 STEM* – UniPD 2024/25 \
  #v(1pt)
  • *2nd place* – UniPD Website Accessibility Award \
  #v(1pt)
  • Regional merit scholarships 2019–2022 \
  #v(1pt)
  • Wikipedia contributor (IT/EN) since 2018
]

// ─────────────────────────────────────────────────
// PAGINA 1 — Contenuto principale
// ─────────────────────────────────────────────────



#sec("Professional Experience")

#job("IT Consultant", "Technology Reply – Padova (client: Generali)", "09/2025 – Present")[
  - Point of contact and AM (Application Maintenance) for the *EmployeeUp*, *Business Partner* and *Provvigioni* platforms at *Generali* (insurance sector) on *Spring Boot 3* microservices: migration, distributed refactoring, integration-flow management with functional validation, evolutionary analysis, *DORA*-compliant quality coverage
  - Migration from *Docker Swarm* to *Kubernetes*, *Oracle SQL* DB work; CI/CD pipelines with *Jenkins* on *AWS*; incident management with *BMC Helix*
  - Contributed to cloud/on-premise microservices and omnichannel projects; observability via *Grafana*, *Splunk*, *IBM Instana*; on-call for Genertel/GOL production probes
  - Support for developing *AI* solutions for expert appraisal workflows and Application Maintenance process automation
]

#job("Teacher – Networking and Systems (ITI)", "ITI Galileo Ferraris – Padova", "09/2024 – 06/2025")[
  - Teaching network architectures, protocols and security to \~90 students (3rd–4th year classes)
  - Developed hands-on labs with Cisco Packet Tracer and Linux networking tools
]

#job("Teaching & Coordination Tutor", "University of Padua – Dept. of Mathematics", "10/2023 – 09/2025")[
  - *Coordination Tutor*: managed 15+ tutors across bachelor's and master's courses
  - *Teaching Tutor*: Automata and Formal Languages, OOP (bachelor's); Computability (master's, taught in English)
  - Produced advanced teaching material; documented support to hundreds of students
]

#job("Inclusion Tutor & Accessibility Consultant", "University of Padua – Disability Services", "10/2023 – 09/2025")[
  - 350+ hours of specialized support for students with SLD/BES/Asperger's/autism in STEM subjects
  - Managed personalized exams (ESSE3/Cineca, Uniweb); reader and scribe tutor
  - Developed WCAG 2.1-compliant digital tools; ran university accessibility seminars
]

#job("Curricular Intern – Blockchain Developer", "Sync Lab S.r.l. – Padova", "03/2023 – 06/2023")[
  - Implemented an Ethereum DApp POC with EthersJS/Web3JS and W3C standards (SSI/DID)
  - Studied and applied Zero-Knowledge Proof techniques for identity verification
]

#job("Private Tutor & IT Consultant", "Freelance – Italy", "02/2016 – Present")[
  - 10+ years tutoring in computer science, mathematics and languages; experienced with SLD/ADHD students
  - Technical consulting for startups (Finblock, Vantura): technology stack definition and technical planning
]


#job("Technical Lead & Data Manager", "Clesp S.r.l. – Padova", "07/2020 – 10/2021")[
  - Managed MySQL databases and developed KPI dashboards for 500+ Buffetti retail locations
  - Team leadership in customer service and operational process automation
]

#sec("Selected Projects")

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  row-gutter: 3pt,

  proj-compact(
    "AccessibleHub",
    "React Native · TS · WCAG 2.2",
    [Master's thesis: React Native toolkit implementing WCAG 2.2/MCAG/WCAG2Mobile with interactive modules and a real-device demo.]
  ),
  proj-compact(
    "ai-agent-skills",
    "MCP · Claude Code · Codex",
    [Portable skill library for multi-provider AI agents; disciplined, reusable engineering workflows.]
  ),

  proj-compact(
    "spring-boot-migration-guide",
    "Java · Spring Boot 3/4",
    [Practical Spring Boot 2.7→3.x→4.x migration guide, cross-checked against official sources with a working demo at every step.]
  ),
  proj-compact(
    "ctrl-verify",
    "CIF/ESCET · PyNuSMV · BDD",
    [Symbolic formal methods for reactive systems: BDD-based supervisor synthesis and safety/response property model checking.]
  ),

  proj-compact(
    "VerifiedMovies",
    "Ethereum · Solidity · ZKP",
    [Bachelor's thesis: blockchain DApp with Self-Sovereign Identity and Zero-Knowledge Proof (W3C standard).]
  ),
  [],
)

#sec("Education")

#edu("M.Sc. in Computer Science — 104/110", "University of Padua", "09/2023 – 07/2025")[
  *Major:* Internet, Mobile and Security — mobile security, advanced cryptography, big data. *Minor:* ICT Innovation & Entrepreneurship (startups, ITIL, NIST). *Thesis:* _Designing an accessibility learning toolkit._ 400+ hours of university tutoring.
]

#edu("B.Sc. in Computer Science — 98/110", "University of Padua", "09/2020 – 07/2023")[
  Algorithms, databases, concurrent programming, software engineering, accessible web development. *Thesis:* _VerifiedMovies — blockchain-based security and authentication._
]

#v(1pt)
#grid(
  columns: (1fr, auto),
  text(weight: "bold", size: 9pt)[IT Technician Diploma — 100/100],
  text(size: 7.6pt, fill: muted, style: "italic")[09/2015 – 06/2020],
)
#text(size: 8pt, fill: accent)[I.I.S. Polo Tecnico di Adria] — #text(size: 7.8pt)[C/C\+\+/Java, Cisco networking, web development, Android, database design.]

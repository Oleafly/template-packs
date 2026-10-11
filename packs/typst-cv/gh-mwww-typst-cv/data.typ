// ── Personal ─────────────────────────────────────────────────────────────────
#let personal = (
  name: "JANE DOE",
  email: "jane@example.com",
  phone: "+1 (555) 000-0000",
  github: "janedoe",
  linkedin: "janedoe",
  website: "janedoe.dev",
  location: "New York, NY",
  qr-url: "https://janedoe.dev",
)

// ── Summary ───────────────────────────────────────────────────────────────────
#let summary = "Software engineer with 8+ years building distributed systems and developer tooling, across startups and large engineering orgs. Open source contributor focused on Rust and Go."

// ── Projects ──────────────────────────────────────────────────────────────────
#let projects = (
  (
    title: "DistKV",
    org: "open source",
    date: "2023",
    details: (
      "Distributed key-value store implementing Raft consensus in Rust. 600+ GitHub stars.",
    ),
    techs: ("Rust", "Raft", "gRPC"),
  ),
  (
    title: "typst-cv",
    org: "open source",
    date: "2024",
    details: (
      "Minimalist, component-based CV template for Typst.",
    ),
    techs: ("Typst",),
  ),
)

// ── Experience ────────────────────────────────────────────────────────────────
#let experience = (
  (
    title: "Senior Software Engineer",
    org: "Acme Corp",
    date: "2022 – present",
    location: "New York, NY",
    details: (
      "Led migration of monolithic Rails app to microservices, cutting p99 latency by 40%.",
      "Designed and shipped internal CI/CD platform adopted by 80+ engineers.",
      "Mentored 3 junior engineers; introduced RFC-driven design process across the org.",
    ),
    techs: ("Go", "Kubernetes", "Terraform", "PostgreSQL"),
  ),
  (
    title: "Software Engineer",
    org: "Startup XYZ",
    date: "2020 – 2022",
    location: "Remote",
    details: (
      "Built real-time collaborative editor using CRDTs and WebSockets, serving 10k DAU.",
      "Owned auth stack end-to-end: OAuth2, MFA, and session management.",
      "Reduced infrastructure costs by 30% through Postgres query optimisation.",
    ),
    techs: ("TypeScript", "React", "WebSockets", "PostgreSQL", "AWS"),
  ),
  (
    title: "Junior Developer",
    org: "Agency ABC",
    date: "2018 – 2020",
    location: "Boston, MA",
    details: (
      "Delivered 15+ client websites using React, Next.js, and headless CMS stacks.",
      "Introduced end-to-end testing with Cypress, reducing regression bugs by 60%.",
    ),
    techs: ("React", "Next.js", "Cypress"),
  ),
)

// ── Education ─────────────────────────────────────────────────────────────────
#let education = (
  (
    title: "B.Sc. Computer Science",
    org: "MIT",
    date: "2014 – 2018",
    location: "Cambridge, MA",
    details: (
      "Thesis: Distributed consensus algorithms under partial network partitions.",
    ),
  ),
)

// ── Certifications ────────────────────────────────────────────────────────────
#let certifications = (
  (
    title: "Certified Kubernetes Administrator (CKA)",
    org: "Cloud Native Computing Foundation",
    date: "2023",
  ),
  (
    title: "AWS Solutions Architect – Associate",
    org: "Amazon Web Services",
    date: "2022",
  ),
  (
    title: "Distributed Systems",
    org: "MIT OpenCourseWare",
    date: "2021",
    details: (
      "Self-study of 6.824 covering Raft, Zookeeper, Spanner, and MapReduce.",
    ),
  ),
)

// ── Publications ──────────────────────────────────────────────────────────────
#let publications = (
  (
    title: "Distributed Consensus Under Partial Network Partitions",
    authors: "J. Doe, A. Smith",
    venue: "OSDI 2023",
    date: "2023",
    url: "https://arxiv.org/abs/2301.00000",
    url-label: "arxiv",
  ),
)

// ── Skills ────────────────────────────────────────────────────────────────────
#let skills = (
  (category: "Languages",     skills: ("Rust", "Go", "TypeScript", "Python", "SQL")),
  (category: "Infrastructure", skills: ("Kubernetes", "Terraform", "AWS", "GCP", "PostgreSQL")),
  (category: "Practices",     skills: ("TDD", "Domain-Driven Design", "Event Sourcing", "RFC-driven design")),
)

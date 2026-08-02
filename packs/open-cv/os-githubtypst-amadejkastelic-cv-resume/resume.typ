#import "@preview/fontawesome:0.6.0": *
#import "@preview/modern-cv:0.10.0": *

#show: resume.with(
  author: (
    firstname: "Amadej",
    lastname: "Kastelic",
    email: "amadejkastelic7@gmail.com",
    homepage: "https://amadejk.com",
    github: "amadejkastelic",
    linkedin: "amadej-kastelic-9931a1169",
    positions: (
      "Senior Software Engineer",
    ),
  ),
  profile-picture: none,
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  paper-size: "a4",
)

#block(above: 1em, below: 0.6em)[
  #set text(size: 10pt, style: "italic", fill: rgb("#5d5d5d"))
  #align(center)[
    Senior Software Engineer with 7+ years building scalable Go backends for identity, access-security, and cryptocurrency platforms across fintech and enterprise SaaS.
  ]
]

= Experience

#resume-entry(
  title: "Senior Software Engineer",
  location: "Remote - Ljubljana, Slovenia",
  date: "2026 - Present",
  description: "ServiceNow",
)

#resume-item[
  - Continuing the development of the Veza data access platform following the acquisition by ServiceNow.
  - Integrating the platform with ServiceNow's ecosystem, extending its capabilities to a broader customer base.
  - Collaborating with ServiceNow engineering teams to align development practices and infrastructure.
]

#resume-entry(
  title: "Senior Software Engineer",
  location: "Remote - San Francisco, CA",
  date: "2024 - 2026",
  description: link("https://veza.com", "Veza"),
)

#resume-item[
  - Developed Go microservices powering access-graph visualization and permission analysis across Access Intelligence, Access AI, and Access Hub.
  - Integrated with 300+ enterprise systems (AWS, Okta, Snowflake) to collect identity and entitlement data.
  - Implemented APIs for querying who can do what to which data across SaaS and cloud environments at enterprise scale.
]

#resume-entry(
  title: "Senior Software Engineer",
  location: "Remote - Ljubljana, Slovenia",
  date: "2021 - 2024",
  description: link("https://bitstamp.net", "Bitstamp"),
)

#resume-item[
  - Built event-driven transaction monitoring system processing high volumes of cryptocurrency transactions with zero-downtime operation.
  - Developed AML/KYC compliance workflows, user onboarding, and regulatory reporting with performance-optimized background jobs.
  - Architected the first Go microservice (DDD patterns) replacing a monolithic Django backend; created a shared circuit-breaker library adopted across all microservices.
]

#resume-entry(
  title: "Software Engineer",
  location: "Ljubljana, Slovenia",
  date: "2018 - 2021",
  description: link("https://rekono.si", "Osi / Rekono"),
)

#resume-item[
  - Built and maintained Rekono IdP, Slovenia's digital identity platform serving banks and government.
  - Developed Java/Spring Boot backend for SAML/OAuth federation, SSO, MFA, and identity verification, eIDAS-compliant.
  - Integrated banking and public-sector systems for citizen authentication and regulatory reporting.
]

= Projects

#resume-entry(
  title: "nixpkgs",
  location: [#github-link("NixOS/nixpkgs")],
  date: "Sep. 2024 - Present",
  description: "Maintainer",
)

#resume-item[
  - Contributed to and maintained packages and modules in nixpkgs.
]

= Skills

#resume-skill-item("Skills", (
  strong("Go"),
  strong("Python"),
  strong("AWS"),
  "Nix",
  "Docker",
  "Kubernetes",
  "PostgreSQL",
  "Microservices",
))
#resume-skill-item("Spoken Languages", (strong("English"), "Slovene"))

#import "template.typ": (
  cv, education-entry, header, reference-entry, selected-project-entry, skill-category, work-experience-entry,
)

// ── Document setup ──────────────────────────────────────
#show: cv(
  name: "Frieren",
  lang: "en",
  keywords: ("software engineer", "backend", "distributed systems"),
)

// ── Header ──────────────────────────────────────────────
// ATS header: no icons, no profile image. Contacts are pipe-separated plain text.
#header(
  name: "Frieren",
  subtitle: [Senior Backend Engineer & Systems Architect],
  contacts: (
    (display: "+81 (3) 1000-0078"),
    (display: "frieren@ende.dev", url: "mailto:frieren@ende.dev"),
    (display: "Tokyo, Japan"),
    (display: "github.com/frieren", url: "https://github.com/frieren"),
    (display: "linkedin.com/in/frieren", url: "https://linkedin.com/in/frieren"),
  ),
)

// ── Summary ─────────────────────────────────────────────
= Summary

Backend engineer with 10+ years of experience building resilient distributed systems and high-throughput data platforms.
Known for methodical problem-solving, deep architectural thinking, and a quiet dedication to long-term code quality.
Experienced in mentoring engineers and leading complex migrations with patience and precision.

// ── Work Experience ─────────────────────────────────────
= Work Experience

#work-experience-entry(
  title: "Senior Backend Engineer",
  company: "Jujutsu Systems",
  dates: "April 2021 - Present",
  location: "Tokyo, Japan",
  description: [
    - Architected a curse-detection microservice mesh handling 5M+ classification events/day with sub-50ms p99 latency.
    - Led a zero-downtime migration from a monolithic Oracle database to a sharded PostgreSQL cluster, reducing query
      costs by 55%.
    - Mentored 3 junior engineers (including Fern and Stark) through weekly architecture reviews and pair programming
      sessions.
  ],
)

#work-experience-entry(
  title: "Software Engineer",
  company: "Musubi Analytics",
  dates: "September 2018 - March 2021",
  location: "Itomori, Japan",
  description: [
    - Built a real-time temporal data pipeline correlating events across time zones, processing 800k+ records/day with
      Apache Flink.
    - Developed REST and gRPC APIs in Go powering a mobile app with 200k+ monthly active users.
    - Introduced property-based testing practices that reduced production incidents by 35% quarter-over-quarter.
  ],
)

#work-experience-entry(
  title: "Junior Developer",
  company: "Moving Castle Technologies",
  dates: "June 2016 - August 2018",
  location: "Kyoto, Japan",
  description: [
    - Developed internal tooling in Python for automated infrastructure provisioning across multi-cloud environments.
    - Wrote ETL pipelines processing hat shop inventory data for 12 regional warehouses.
    - Automated deployment workflows with Ansible, cutting release time from 4 hours to 20 minutes.
  ],
)

// ── Selected Projects ───────────────────────────────────
= Selected Projects

#selected-project-entry(
  name: "Grimoire Registry",
  place: "Jujutsu Systems",
  dates: "2023",
  description: [
    Distributed spell-cataloging service with full-text search across 2M+ entries. Features real-time sync, conflict
    resolution, and a custom query language for complex attribute filtering.
  ],
  skills: ("Go", "PostgreSQL", "Elasticsearch", "gRPC", "Kubernetes"),
)

#selected-project-entry(
  name: "Kataware-doki",
  place: "Open Source",
  dates: "2022 - Present",
  description: [
    Time-series anomaly detection library for infrastructure monitoring. Implements sliding-window algorithms and
    statistical methods. 2.1k GitHub stars and adopted by 4 companies in production.
  ],
  skills: ("Rust", "Python", "Prometheus", "Grafana"),
)

// ── Education ───────────────────────────────────────────
= Education

#education-entry(
  degree: "B.Eng. Computer Science",
  institution: "University of Tokyo",
  dates: "2012 - 2016",
  location: "Tokyo, Japan",
  description: [
    Graduated top of class. Concentration in distributed systems and formal verification. Thesis on Byzantine fault
    tolerance in heterogeneous networks.
  ],
)

// ── Skills ──────────────────────────────────────────────
= Skills

#skill-category(
  name: "Languages",
  skills: ("Go", "Rust", "Python", "TypeScript", "SQL"),
)

#skill-category(
  name: "Frameworks",
  skills: ("Gin", "Actix", "FastAPI", "React", "Next.js"),
)

#skill-category(
  name: "Infrastructure",
  skills: ("AWS", "GCP", "Kubernetes", "Docker", "Terraform"),
)

#skill-category(
  name: "Data",
  skills: ("PostgreSQL", "Redis", "Kafka", "Elasticsearch", "Apache Flink"),
)

// ── References ──────────────────────────────────────────
= References

#reference-entry(
  name: "Gojo Satoru",
  phone: "+81 (3) 1000-0006",
  email: "gojo.satoru@jujutsu.com",
  description: [
    CTO at Jujutsu Systems. Direct manager for 3+ years. Can speak to system design expertise and technical leadership
    across distributed platforms.
  ],
)

#reference-entry(
  name: "Mitsuha Miyamizu",
  phone: "+81 (577) 32-0987",
  description: [
    Co-founder of Musubi Analytics. Collaborated closely on the temporal data pipeline and real-time event processing
    systems.
  ],
)

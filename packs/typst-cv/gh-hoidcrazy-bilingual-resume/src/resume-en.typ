// English resume showcase for template.typ
// All personal information is fictional and created to demonstrate template capabilities.

#import "/lib/template.typ": *

#show: resume.with(
  author: "Evelyn Hart",
  phone: "Phone: +1 (415) 555-0186",
  email: "Email: evelyn.hart@novaexample.com",
  location: "Location: Seattle, WA, USA",
  github: "github.com/evelynhart-labs",
  linkedin: "linkedin.com/in/evelyn-hart",
  personal-site: "evelynhart.dev",
  accent-color: "#0f5b78",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
  lang: "en",
)

== Professional Summary

#summary[
  Product-focused software engineer with 6+ years of experience building distributed systems, developer platforms, and intelligent automation products. Skilled at translating complex technical challenges into scalable solutions through cloud-native architecture, data-driven optimization, and cross-functional leadership.
]

== Education

#edu(
  institution: "Northbridge Institute of Technology",
  dates: dates-helper(start-date: "Sep 2015", end-date: "Jun 2019"),
  degree: "Bachelor of Engineering in Computer Science",
  location: "Boston, MA, USA",
)
- Graduated with Honors; GPA: 3.86/4.00
- Relevant Coursework: Distributed Systems, Advanced Algorithms, Machine Learning, Database Architecture, Cloud Computing

== Work Experience

#work(
  title: "Senior Platform Engineer",
  company: "AuroraGrid Technologies",
  location: "Seattle, WA",
  dates: dates-helper(start-date: "Mar 2022", end-date: "Present"),
)
- Designed a multi-region developer platform supporting 2,500+ internal services and reduced deployment failures by 42%.
- Led migration from legacy virtual machines to Kubernetes-based infrastructure, improving resource utilization by 35%.
- Built observability pipelines with automated anomaly detection, reducing incident diagnosis time from hours to minutes.

#work(
  title: "Backend Engineer",
  company: "VertexNova Cloud Systems",
  location: "San Francisco, CA",
  dates: dates-helper(start-date: "Jul 2019", end-date: "Feb 2022"),
)
- Developed high-throughput API services processing over 80 million daily requests using Go, PostgreSQL, and Redis.
- Introduced event-driven architecture with message streaming, improving system reliability during peak traffic periods.
- Mentored junior engineers and established engineering guidelines adopted across three product teams.

#work(
  title: "Software Engineering Intern",
  company: "BlueOrbit Research Lab",
  location: "Boston, MA",
  dates: dates-helper(start-date: "May 2018", end-date: "Aug 2018"),
)
- Created simulation tools for large-scale network experiments and automated research workflows.
- Improved data processing performance through algorithm optimization and parallel computing techniques.

== Projects

#project(
  name: "NimbusFlow AI Operations Platform",
  role: "Technical Lead",
  dates: dates-helper(start-date: "Jan 2023", end-date: "Present"),
  url: "nimbusflow.ai",
)
- Architected an AI-assisted operations platform combining workflow automation, LLM-based analysis, and real-time monitoring.
- Designed modular services enabling teams to deploy custom automation agents within hours instead of weeks.

#project(
  name: "OpenAtlas Developer Toolkit",
  role: "Founder & Maintainer",
  dates: dates-helper(start-date: "Jun 2020", end-date: "Dec 2022"),
  url: "openatlas.dev",
)
- Created an open-source toolkit for cloud application diagnostics with 18,000+ community downloads.
- Implemented plugin-based extensions, documentation generation, and automated release pipelines.

== Technical Skills

#skills(categories: (
  (label: "Languages", items: ("Go", "Python", "TypeScript", "Java", "SQL")),
  (label: "Cloud & DevOps", items: ("Kubernetes", "Docker", "AWS", "Terraform", "CI/CD")),
  (label: "Engineering", items: ("Distributed Systems", "Microservices", "System Design", "Performance Optimization")),
  (label: "Tools", items: ("Linux", "Git", "Prometheus", "Grafana", "PostgreSQL")),
))

== Awards & Honors

#award(
  name: "Cloud Innovation Challenge Winner",
  issuer: "Global Developer Community Summit",
  rank: "1st Place",
  date: "2024",
)

#award(
  name: "Outstanding Engineering Contribution Award",
  issuer: "AuroraGrid Technologies",
  rank: "Company Recognition",
  date: "2023",
)

== Publications & Patents

#publication(
  title: "Adaptive Resource Scheduling for Distributed Cloud Workloads",
  venue: "International Journal of Cloud Engineering",
  authors: "Evelyn Hart, Marcus Lee",
  date: "2022",
)

== Certifications

#certificate(
  name: "Certified Kubernetes Application Developer",
  issuer: "Cloud Native Computing Foundation",
  date: "2021",
)

#certificate(
  name: "AWS Certified Solutions Architect",
  issuer: "Amazon Web Services",
  date: "2020",
)

== Extracurricular Activities

#extracurricular(
  activity: "Open Source Community Organizer",
  dates: dates-helper(start-date: "2021", end-date: "Present"),
)
- Organized monthly engineering workshops and coordinated global contributors across multiple open-source projects.

#extracurricular(
  activity: "Technology Conference Speaker",
  dates: dates-helper(start-date: "2022", end-date: "2024"),
)
- Delivered talks on cloud architecture, developer productivity, and scalable backend engineering.

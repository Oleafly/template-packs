#import "template.typ": *

#show: cv

#cvHeader(
  name: "Max Mustermann",
  title: "Senior Software Engineer",
  contact: (
    location: "12345 Berlin",
    phone: "+49 123 4567890",
    email: "mustermann@example.com",
    links: [#link("https://github.com/maxmustermann")[GitHub], #link("https://linkedin.com/in/maxmustermann")[LinkedIn], #link("https://xing.com/profile/maxmustermann")[XING]]
  )
)

= BERUFLICHE LAUFBAHN

#cvEntry(
  date: "01/2021 — Heute",
  location: "Berlin (Hybrid)",
  title: "Senior Software Engineer",
  organization: "TechCorp GmbH",
  description: [
    - Entwicklung moderner Cloud-nativer Anwendungen mit Microservices-Architektur unter Verwendung von TypeScript, React und Node.js
    - Technische Leitung eines agilen Entwicklungsteams und Mentoring von Junior-Entwicklern
    - Implementierung von CI/CD-Pipelines für automatisierte Tests und Deployments mit GitHub Actions und Kubernetes
    - Optimierung von Datenbank-Performance und Migration von Legacy-Anwendungen zu einer modernen Architektur
    - Einführung von Domain-Driven Design und Event-Sourcing-Patterns zur Verbesserung der Skalierbarkeit
  ]
)

#cvEntry(
  date: "03/2018 - 12/2020",
  location: "München",
  organization: "InnoSoft AG",
  title: "Full Stack Developer",
  description: [
    *Junior Developer* Mär. 2018 - Sep. 2019

    - Konzeption und Entwicklung von React.js-basierten Webportalen für Kundenmanagement-Lösungen:
      - Integration von REST-APIs mit Express.js und bidirektionaler Kommunikation über WebSockets
      - Implementierung automatisierter Reporting-Funktionen und Echtzeit-Dashboards für Business Intelligence
    - Entwicklung von Datenvisualisierungen mit D3.js und Chart.js
    - Umsetzung responsiver Designs für optimale Nutzererfahrung auf allen Geräten
    - Mitarbeit an der Migration einer monolithischen Anwendung zu einer Microservices-Architektur
  ]
)

#cvEntry(
  date: "09/2017 — 02/2018",
  location: "Hamburg",
  organization: "Startup Innovators",
  title: "Web Developer (Praktikum)",
  description: [
    - Frontend-Entwicklung mit HTML, CSS und JavaScript
    - Einführung in React.js und moderne Web-Entwicklung
    - Unterstützung bei der Konzeption von User Interfaces für E-Commerce-Anwendungen
  ]
)

#pagebreak()

= AUSBILDUNG

#cvEntry(
  date: "2014 — 2017",
  location: "Berlin",
  organization: "Technische Universität Berlin",
  title: "Informatik (B.Sc.)",
  description: [
    - Abschlussnote: 1,7
    - Schwerpunkte: Webentwicklung, Datenbanksysteme und Softwarearchitektur
    - Abschlussarbeit: "Effiziente Implementierung von Single-Page-Applications mit modernen JavaScript-Frameworks"
  ]
)

#cvEntry(
  date: "2011 — 2014",
  location: "Berlin",
  organization: "Gymnasium Steglitz",
  title: "Abitur",
  description: [
    - Leistungskurse: Mathematik und Informatik
    - Abschlussnote: 1,8
  ]
)

= SONSTIGE TÄTIGKEITEN

#cvEntry(
  date: "05/2019 — Heute",
  location: "Online",
  organization: "Open Source Community",
  title: "Contributor",
  description: [
    - Aktive Beteiligung an verschiedenen Open-Source-Projekten im JavaScript-Ökosystem
    - Eigenes Projekt: Entwicklung einer TypeScript-Bibliothek für vereinfachte API-Integrationen
  ]
)

= FÄHIGKEITEN

#cvSkillCategories(
  categories: (
    ("Programming Languages", "JavaScript/TypeScript, Python, Go, SQL"),
    ("Frameworks", "React, Vue.js, Angular, Express.js, Next.js, NestJS, GraphQL"),
    ("Databases", "PostgreSQL, MongoDB, Redis, Elasticsearch"),
    ("DevOps & Cloud", "Docker, Kubernetes, AWS, Azure, CI/CD, GitHub Actions, GitLab CI"),
    ("Tools & Other", "Git, VS Code, Postman, Figma, Jira, Confluence, Linux, Bash"),
    ("AI & MLOps", "TensorFlow, PyTorch, Hugging Face, LangChain, Vector Databases")
  )
)

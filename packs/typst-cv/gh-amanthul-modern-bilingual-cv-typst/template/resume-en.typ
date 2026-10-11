#import "../lib.typ": *

#show: en-resume.with(
  author: (
    firstname: "John",
    lastname: "Smith",
    email: "js@example.com",
    phone: "(+1) 111-111-1111",
    github: "johnsmith",
    linkedin: "johnsmith",
    address: "123 Main St, Example City, EX 11111",
    positions: (
      "Software Engineer",
      "Full Stack Developer",
    ),
  ),
  profile-picture: image("profile.png"),
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
)

= Experience

#resume-entry(
  title: "Senior Software Engineer",
  location: "San Francisco, CA",
  date: "2021 - Present",
  description: "Acme Corp",
  title-link: "https://example.com",
)

#resume-item[
  - Led migration of core platform to microservices architecture
  - Reduced API latency by 40% through caching optimization
  - Mentored team of 5 junior engineers
]

#resume-entry(
  title: "Software Engineer",
  location: "New York, NY",
  date: "2018 - 2021",
  description: "Previous Company, Inc.",
)

#resume-item[
  - Built real-time data pipeline processing 1M events/day
  - Implemented CI/CD pipeline reducing deploy time by 60%
]

= Projects

#resume-entry(
  title: "Open Source CLI Tool",
  location: github-link("johnsmith/cli-tool"),
  date: "2022 - Present",
  description: "Creator & Maintainer",
)

#resume-item[
  - Built a developer productivity CLI tool with 500+ GitHub stars
  - Wrote comprehensive documentation and automated test suite
]

= Skills

#resume-skill-item("Languages", (strong("Python"), strong("Go"), "TypeScript", "Rust", "Java"))
#resume-skill-item("Technologies", (strong("Kubernetes"), "Docker", "AWS", "PostgreSQL", "Redis"))
#resume-skill-item("Spoken Languages", (strong("English"), "Chinese"))

= Education

#resume-entry(
  title: "Example University",
  location: "Example City, EX",
  date: "2014 - 2018",
  description: "B.S. in Computer Science",
)

#resume-item[
  - Dean's List all semesters
  - Teaching Assistant for Data Structures
]

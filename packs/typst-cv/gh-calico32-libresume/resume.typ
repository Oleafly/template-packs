#import "libresume.typ": *
#show: resume

= John Doe

#resume-info(
  resume-email("johndoe@example.com"),
  resume-phone("555-555-5555"),
  resume-linkedin("johndoe"),
  resume-github("johndoe"),
  resume-website("https://johndoe.com"),
  resume-location("Anytown, USA"),
  resume-twitter("@johndoe"),
  resume-bluesky("@johndoe.bsky.social"),
  resume-orcid("0000-0001-2345-6789"),
  resume-keybase("johndoe"),
)

#resume-summary(lorem(30))

== Education

#grid(
  columns: (1fr, 1fr),
  resume-education(
    [Example University of Technology],
    [M.S. Computer Science],
    [Aug 2024 -- May 2026],
    [Anytown, USA],
  ),
  resume-education(
    [Example College of Engineering],
    [B.S. Computer Science],
    [Sep 2020 -- Jun 2024],
    [Anytown, USA],
  ),
)

== Skills

#columns(2)[
  / Web Development: HTML, CSS, JavaScript, React, Angular, Vue.js
  / Programming Languages: Python, Java, C++, Go, Rust
  / Databases: MySQL, PostgreSQL, MongoDB
  / Tools & Platforms: Docker, Kubernetes, AWS, Azure, Git
  #colbreak()
  / Frameworks: Flask, Django, Spring Boot, Express.js
  / Testing: Jest, Mocha, Selenium, JUnit
  / Soft Skills: Team Collaboration, Problem Solving, Communication
  / Languages: English (Fluent), Spanish (Conversational)
]


== Projects

#resume-project(
  [Example Project],
  [Creator],
  [Jun 2022 -- Present],
  [Python, Flask, React],
  (
    lorem(20),
    lorem(15),
  ),
)

== Experience

#resume-experience(
  [Software Engineer],
  [Tech Innovations Ltd.],
  [May 2025 -- Present],
  [Anytown, USA],
  (
    lorem(20),
    lorem(25),
  ),
)

#resume-experience(
  [Software Engineer Intern],
  [ACME Corp],
  [Jun 2023 -- Aug 2023],
  [Anytown, USA],
  (
    lorem(29),
    lorem(20),
  ),
)
#resume-experience(
  [Junior Developer],
  [Tech Solutions Inc.],
  [Jan 2022 -- May 2023],
  [Anytown, USA],
  (
    lorem(20),
    lorem(15),
  ),
)

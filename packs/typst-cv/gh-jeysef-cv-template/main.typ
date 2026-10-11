#import "template.typ": *

#show: doc => cv(
  // 1. Metadata for ATS & PDF Properties
  author: "Jane Doe",
  title: "Senior Software Engineer",
  keywords: ("Rust", "Typst", "React", "Cloud Native", "System Design"),
  
  // 2. Profile Picture (Optional)
  // Ensure "profile.jpg" exists in the same folder, or set to none
  // profile-picture: "profile.jpg", 
  
  // --- CONTACT INFO ---
  cv-section("Contact"),
  
  cv-item("Email", link-blue("mailto:jane.doe@example.com")),
  cv-item("Portfolio", link-blue("https://janedoe.dev")),
  cv-item("GitHub", link-blue("https://github.com/janedoe")),
  cv-item("Location", [San Francisco, CA]),
  
  cv-spacer(),

  // --- EXPERIENCE ---
  cv-section("Experience"),

  // Job 1
  cv-bullet-item("2021–Present", [
    **Senior Backend Engineer** \
    TechCorp Solutions
  ]),
  // using a standard list for bullet points ensures semantic parsing
  cv-item([], list(
    marker: [•],
    spacing: 0.6em, 
    [Led the migration of legacy microservices to **Rust**, reducing latency by 40%.],
    [Architected a real-time data pipeline processing 10k+ events/sec using **Kafka**.],
    [Mentored junior developers and introduced strictly typed API contracts.]
  )),
  // "Tech Stack" row for keyword density
  cv-item([*Tech Stack*], [Rust, Tokyo, Kafka, PostgreSQL, Docker]),

  cv-spacer(),

  // Job 2
  cv-bullet-item("2018–2021", [
    **Full Stack Developer** \
    Creative StartUp Inc.
  ]),
  cv-item([], list(
    marker: [•],
    spacing: 0.6em,
    [Developed key features for the main SaaS product using **React** and **Node.js**.],
    [Implemented automated testing suites (Jest/Cypress) increasing code coverage to 90%.],
    [Optimized database queries decreasing page load times by 1.5s.]
  )),
  cv-item([*Tech Stack*], [TypeScript, React, Node.js, AWS Lambda]),

  cv-spacer(),

  // --- EDUCATION ---
  cv-section("Education"),

  cv-bullet-item("2014–2018", [
    **B.Sc. Computer Science** \
    University of Technology
  ]),
  cv-bullet-item("Thesis", [
    *Distributed Systems Consensus Algorithms* (Grade: A)
  ]),

  cv-spacer(),

  // --- SKILLS ---
  cv-section("Technical Skills"),

  cv-item("Languages", [Rust, TypeScript, Python, Go, SQL]),
  cv-item("Infrastructure", [Docker, Kubernetes, Terraform, AWS, Azure]),
  cv-item("Tools", [Git, CI/CD (GitHub Actions), Linux, Typst]),

  cv-spacer(),

  // --- PROJECTS ---
  cv-section("Open Source"),

  cv-bullet-item("Maintainer", [
    **Rusty-Web-Server** (1.2k Stars on GitHub) \
    A high-performance asynchronous web server built for embedded devices.
  ]),
  
  cv-spacer(),

  // --- ADDITIONAL ---
  cv-section("Languages"),
  cv-item("English", [Native]),
  cv-item("Spanish", [B2 (Professional Working Proficiency)])
)

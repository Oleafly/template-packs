#import "../src/lib.typ": *

#let theme = themes.professional

#show link: underline

#show: cv-page.with(
  paper: "a4",
  margin: (x: 1.5cm, y: 1cm),
  font: "Helvetica Neue",
  font-size: 10pt,
  lang: "en",
  theme: theme,
)

#cv-two-columns(
  [
    #set text(size: 9pt)
    #v(1em)

    #cv-photo(
      "../template/assets/photo.jpeg",
      theme: theme,
      radius: 999pt,
      width: 3.5cm,
      height: 3.5cm,
      border-width: 0pt,
      fit: "cover",
    )
    #v(1em)

    #cv-header(
      name: "Alex Placeholder",
      theme: theme,
    )
    == Contact
    #cv-sidebar-contact(
      email: "alex.placeholder@example.com",
      phone: "+49 170 0000000",
      location: "Sample City, Germany",
      links: (
        github: "github.com/placeholder",
        website: "https://www.example.com",
      ),
      theme: theme,
    )

    #v(1em)

    == Skills
    #cv-skills(
      skills: (
        "Programming": ("TypeScript", "Python", "Go", "Rust"),
        "Frontend": ("React", "Next.js", "Astro", "Tailwind CSS"),
        "Backend & APIs": (
          "Node.js",
          "Express",
          "NestJS",
          "GraphQL",
          "REST",
          "WebSocket",
        ),
        "Databases": ("PostgreSQL", "MongoDB", "SQLite"),
        "Tools": ("Docker", "GitHub Actions", "Figma"),
        "Practices": ("Agile", "DevOps"),
      ),
      theme: theme,
      compact: true,
    )

    #v(1em)

    == Languages
    #cv-languages(
      languages: (
        (name: "English", level: "Fluent"),
        (name: "German", level: "Professional"),
        (name: "Spanish", level: "Intermediate"),
      ),
      theme: theme,
      compact: true,
    )

    #v(1em)

    == Interests & Hobbies
    #text(size: 9pt)[
      Open-source, technical writing, hiking, photography, community meetups
    ]
  ],
  [
    #cv-section("Work Experience", theme: theme)[
      #cv-entry(
        title: "Senior Software Engineer",
        subtitle: "Example Energy GmbH",
        location: "Full-time",
        date: "02/2023 - Present",
        description: (
          "When energy dashboards crashed under a surge of new solar clients, led the redesign into containerized microservices to restore 99.9% uptime within two sprints",
          "Faced with a manual partner-onboarding backlog, mapped workflows with operations and automated them via Convex plus Slack bots, shrinking onboarding time from 10 to 3 days",
          "To raise engineering rigor, launched GitHub Actions testing and mentored four juniors on TDD, cutting regression bugs per release by 30%",
        ),
        theme: theme,
      )
      #cv-entry(
        title: "Frontend Developer",
        subtitle: "Sample Retail AG",
        location: "Full-time",
        date: "07/2020 - 01/2023",
        description: (
          "During a nationwide rebrand, partnered with design to convert the atomic library into React + Tailwind components, letting six teams ship landing pages twice as fast",
          "Because executives lacked live KPIs, integrated analytics dashboards with internal APIs and charts, enabling 25% more data-driven campaign adjustments",
          "With Black Friday risk rising, coordinated Playwright end-to-end coverage and CI gating, preventing 15 critical bugs from reaching production",
        ),
        theme: theme,
      )

      #cv-entry(
        title: "Full-Stack Developer",
        subtitle: "Startup Studio Limited",
        location: "Part-time",
        date: "09/2017 - 06/2020",
        description: (
          "When founders needed revenue validation, led discovery and built a NestJS + Next.js MVP commerce stack with Stripe sandbox, enabling 50 pilot orders in six weeks",
          "Support teams lacked visibility, so I delivered Flutter dashboards aggregating inventory and campaign metrics, trimming ticket resolution time by 35%",
        ),
        theme: theme,
      )
    ]

    #cv-section("Projects", theme: theme)[
      #cv-project(
        name: "Community Hub",
        url: "https://community-hub.example.com",
        date: "08/2024 - present",
        description: "Portal connecting local volunteer chapters with shared tooling",
        theme: theme,
      )
      #cv-project(
        name: "Acme Dashboard",
        url: "https://dashboard.example.com",
        date: "04/2024",
        description: "Analytics dashboard with role-based access control",
        theme: theme,
      )
    ]

    #cv-section("Education", theme: theme)[
      #cv-education(
        degree: "M.Sc. Computer Science",
        institution: "Technische Universität Musterstadt",
        date: "10/2018 - 09/2020",
        descriptionTwo: "Focus: distributed systems and cloud computing",
        theme: theme,
      )

      #cv-education(
        degree: "B.Eng. Electrical Engineering",
        institution: "Hochschule Beispiel",
        date: "10/2013 - 07/2017",
        descriptionOne: "Graduated with merit scholarship",
        theme: theme,
      )

      #cv-education(
        degree: "Exchange Semester",
        institution: "University of Example (USA)",
        date: "01/2016 - 06/2016",
        descriptionTwo: "Coursework in human-computer interaction",
        theme: theme,
      )
    ]


  ],
  // Use fractional units so the gutter doesn't reduce the right margin.
  sidebar-width: 3fr,
  main-width: 7fr,
  gutter: 1cm,
)

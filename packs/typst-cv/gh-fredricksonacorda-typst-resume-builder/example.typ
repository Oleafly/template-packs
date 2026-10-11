#import "tailored-resume.typ": resume, section, cv-entry, detail-entry

#show: resume.with(
  name: "JOHN DOE",
  role: "Software Engineer",
  contact: [City, Country | johndoe\@example.com | www.johndoe.com | \@johndoe],
)

#section("Summary")[
  Software engineer with 5 years of experience and a strong foundation in computer science, skilled in developing software for innovative industries. Proficient in JavaScript/TypeScript, Python, and C/C++, with a solid understanding of system architecture and design principles.
]

#section("Objective")[
  Seeking to advance my skills and build a strong career with a company that values innovation and creativity.
]

#section("Professional Experience")[
  #detail-entry(
    title: "Lead Software Developer",
    subtitle: "Quantum Innovations - QuantumLeap",
    date: "2023 Mar. - 2024 Jul.",
  )[
    - Spearheaded the development of a cutting-edge quantum computing simulator, optimizing algorithms for performance.
    - Collaborated with a team to create intuitive user interfaces that simplified complex scientific data for end-users.
  ]

  #detail-entry(
    title: "Backend Developer",
    subtitle: "CloudSync Solutions - SyncManager",
    date: "2024 Aug. - present",
  )[
    - Built scalable backend services for SyncManager, ensuring high availability and performance for cloud synchronization.
    - Designed and implemented RESTful APIs to facilitate data exchange between clients and servers.
  ]

  #detail-entry(
    title: "DevOps Engineer",
    subtitle: "AutoTech Dynamics - AutoPilot",
    date: "2022 Feb. - 2023 Dec.",
  )[
    - Streamlined CI/CD pipelines for the AutoPilot system, enhancing deployment frequency and reliability.
    - Monitored system performance and implemented improvements for optimized infrastructure.
  ]

  #detail-entry(
    title: "Game Developer",
    subtitle: "PixelForge Studios - Realm of Adventure",
    date: "2021 Jan. - 2022 Dec.",
  )[
    - Developed engaging gameplay mechanics and interactive environments using Unity and C\#.
    - Collaborated with artists to ensure visual consistency and high-quality game experiences.
  ]

  #detail-entry(
    title: "Data Engineer",
    subtitle: "Insight Analytics - DataVision",
    date: "2020 Jan. - 2021 Dec.",
  )[
    - Engineered data pipelines to aggregate and process large datasets for analytics using Python and Apache Spark.
    - Developed dashboards for real-time data visualization and business intelligence.
  ]

  #detail-entry(
    title: "Quality Assurance Intern",
    subtitle: "CodeFix Labs - TestSuite Pro",
    date: "2019 Jan. - 2019 Dec.",
  )[
    - Assisted in testing software applications for functionality and usability, reporting bugs and feedback.
    - Gained experience in automated testing frameworks to improve product quality.
  ]
]

#section("Education")[
  #cv-entry(
    title: "B.Sc. in Computer Science",
    date: "2015 - 2019",
  )[
    Example University, City, Country
  ]

  #cv-entry(
    title: "Diploma in IT Specialist",
    date: "2012 - 2015",
  )[
    Technical College, City, Country
  ]
]

#section("Technical Expertise")[
  Kotlin, Angular, Ruby on Rails, Flutter, Go, Subversion
]

#section("Skills / Exposure")[
  JavaScript, Python, Java, React, Node.js, Express, MongoDB, AWS, Docker, Git, HTML/CSS, SQL, Material UI, Tailwind CSS
]

#section("Methodology / Approach")[
  Lean, Kanban, Design Thinking, Test-Driven Development, Pair Programming
]

#section("Tools")[
  GitHub, IntelliJ IDEA, Asana, Slack, Adobe XD, Postman
]

#section("Achievements / Certifications")[
  #detail-entry(
    title: "Best Project Award",
  )[
    Developed an innovative solution for community service management and received recognition from the university.
  ]
]

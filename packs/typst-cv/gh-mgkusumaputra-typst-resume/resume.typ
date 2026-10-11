#set document(
  title: "ATS - John Doe",
  author: "John Doe",
)

// Dont change the above code, it is used for ATS parsing. You can change the content below.
#set page(
  paper: "a4",
  margin: (x: 0.5in, y: 0.5in),
)

#set text(font: "Calibri", size: 10pt, fill: black)
#set par(justify: true, leading: 0.28em)

#set list(
  marker: [•],
  tight: true,
  spacing: 8pt,
)

#let section(title, top: 8pt) = block(
  above: top,
  breakable: false,
)[
  #text(size: 12pt, weight: "bold")[#title]
  #v(-10pt)
  #line(length: 100%, stroke: 0.75pt)
]

#let dated-row(left, right, left-bold: true) = grid(
  columns: (1fr, auto),
  column-gutter: 8pt,
  [
    #if left-bold {
      text(size: 11pt, weight: "bold")[#left]
    } else {
      text(size: 11pt)[#left]
    }
  ],
  [#text(size: 11pt)[#right]],
)

#let experience(
  company,
  role,
  dates,
  description: none,
  bullets: none,
) = block(
  breakable: false,
)[
  #grid(
    columns: (1fr, auto),
    column-gutter: -12pt,
    [
      #text(size: 11pt, weight: "bold")[#company]
      #text(size: 11pt)[ \- #role]
    ],
    [#text(size: 11pt)[#dates]],
  )

  #if description != none {
    v(-6pt)
    text(
      size: 10pt,
      style: "italic",
      fill: rgb("#9a9a9a"),
    )[#description]
  }

  #if bullets != none {
    bullets
  }

  #v(4pt)
]

#let education(
  school,
  dates,
  major: none,
  bullets: none,
) = block(
  breakable: false,
)[
  #grid(
    columns: (1fr, auto),
    column-gutter: -12pt,
    [#text(size: 11pt, weight: "bold")[#school]],
    [#text(size: 11pt)[#dates]],
  )

  #if major != none {
    v(-6pt)
    text(
      size: 10pt,
      style: "italic",
      fill: rgb("#9a9a9a"),
    )[#major]
  }

  #if bullets != none {
    bullets
  }

  #v(4pt)
]

#let project(name, body) = block(
  breakable: false,
)[
  #text(size: 11pt, weight: "bold")[#name]
  #v(-6pt)
  #text(size: 10pt)[#body]
]

// Change the code from here

// -------------------- HEADER --------------------
#text(size: 22pt, weight: "bold")[
  John Doe
]

#v(-16pt)

#text(size: 10pt)[
  Jakarta, Indonesia |
  #link("mailto:adrian.pratama@example.com")[
    johndoe\@example.com
  ] |
  +6281234567890 |
  #link("https://www.linkedin.com/")[#underline[LinkedIn]] |
  #link("https://github.com/")[#underline[GitHub]]
]


// -------------------- SUMMARY --------------------
#section("Summary", top: 20pt)

#text(size: 10pt)[
  Computer Science student and Full-Stack Developer with experience
  building scalable web applications, internal tools, and data-driven
  products. Skilled in modern frontend and backend technologies with
  a strong interest in software engineering, product development,
  and system design. Experienced in collaborating with engineering
  and design teams to deliver reliable and user-focused solutions.
]


// -------------------- PROFESSIONAL EXPERIENCE --------------------
#section("Professional Experience", top: 16pt)

#experience(
  "NovaLabs",
  "Full-Stack Developer Intern",
  "Jan 2026 - Present",
  description: [
    Technology startup developing productivity and collaboration
    tools for small businesses.
  ],
  bullets: [
    - Developed and maintained customer-facing dashboard features using Next.js, TypeScript, PostgreSQL, and Supabase.

    - Built reusable API endpoints and database queries that reduced repeated frontend data-processing logic across multiple features.

    - Collaborated with designers and product managers to convert Figma prototypes into responsive production interfaces.

    - Improved page performance by optimizing image delivery, server-side rendering, and database queries.
  ]
)

#experience(
  "BrightPath Education",
  "Software Engineer",
  "Jun 2025 - Dec 2025",
  description: [
    Educational technology platform providing online learning tools
    for secondary-school students.
  ],
  bullets: [
    - Developed interactive assessment features used by more than 1,500 students across multiple online learning programs.

    - Implemented authentication, role-based access control, and student progress tracking using Next.js and Supabase.

    - Worked with the product team to identify usability issues and improve navigation across student-facing pages.

    - Created reusable frontend components that reduced development time for new assessment modules.
  ]
)

#experience(
  "PixelForge Studio",
  "Backend Developer",
  "Feb 2024 - May 2025",
  description: [
    Software development studio building custom web applications
    and internal business systems.
  ],
  bullets: [
    - Built REST API services using NestJS, TypeScript, Prisma, and PostgreSQL for client web applications.

    - Designed database schemas and implemented migration workflows for new application features.

    - Integrated third-party APIs for email notifications, file storage, and payment processing.

    - Wrote API documentation and reusable service modules to simplify frontend integration.
  ]
)

#experience(
  "Tech Society Indonesia",
  "UI/UX Developer",
  "Aug 2023 - Jan 2024",
  bullets: [
    - Designed responsive interface prototypes in Figma for community event and registration platforms.

    - Converted approved designs into reusable React and Tailwind CSS components.

    - Collaborated with developers to ensure interface designs were technically feasible and responsive across devices.
  ]
)


// -------------------- EDUCATION --------------------
#section("Education", top: 16pt)

#education(
  "University of Nusantara",
  "Aug 2025 - Jun 2029",
  major: [
    Bachelor of Computer Science, Software Engineering
  ],
  bullets: [
    - Relevant Coursework: Data Structures, Database Systems, Software Engineering, Web Development
  ],
)

#education(
  "SMA Teknologi Mandiri",
  "Jul 2022 - Jun 2025",
  major: [
    Mathematics and Natural Sciences
  ],
)


// -------------------- PROJECTS --------------------
#section("Projects & Achievements", top: 16pt)

#project(
  [StudyTrack],
  [
    Web-based academic productivity platform that helps students
    organize assignments, track deadlines, and monitor study progress
    through a centralized dashboard.
  ],
)

#project(
  [CampusVote],
  [
    Secure online voting application for university organization
    elections featuring authentication, real-time vote counting,
    and automated result reporting.
  ],
)

#project(
  [DevBoard],
  [
    Lightweight project management dashboard built with Next.js and
    PostgreSQL that allows small development teams to organize tasks,
    track progress, and manage project milestones.
  ],
)

#project(
  [QuickLink],
  [
    Open-source link management platform that allows users to create
    customizable profile pages, manage URLs, and view basic click
    analytics from a single dashboard.
  ],
)


// -------------------- CERTIFICATION --------------------
#section("Certification", top: 16pt)

#dated-row(
  [AWS Cloud Practitioner Essentials - Amazon Web Services],
  [May 2026]
)

#dated-row(
  [Responsive Web Design - freeCodeCamp],
  [Jan 2025]
)

#dated-row(
  [Introduction to Product Management - Product School],
  [Sep 2024]
)


// -------------------- SKILLS --------------------
#section("Skills", top: 16pt)

#grid(
  columns: (74pt, 1fr),
  row-gutter: 6pt,

  [#text()[Languages]],
  [#text()[JavaScript, TypeScript, Python, Go, HTML, CSS]],

  [#text()[Frontend]],
  [#text()[React.js, Next.js, Tailwind CSS]],

  [#text()[Backend]],
  [#text()[Node.js, NestJS, Prisma, Supabase, PostgreSQL, MySQL, Redis]],

  [#text()[Tools]],
  [#text()[Git, GitHub, Docker, Vercel, Postman, Figma]],
)
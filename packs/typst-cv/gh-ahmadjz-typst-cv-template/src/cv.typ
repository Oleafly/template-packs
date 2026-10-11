// ────────────────────────────────────────────────────────────────────────
//  YOUR CV (English)  —  edit the text marked “// EDIT ME”, then build.
//  Build:  ./build.sh   (or)   docker compose run --rm build
//  Guide:  docs/GETTING_STARTED.md   ·   Don't-break-this: docs/CONVENTIONS.md
//  This sample uses a fictional person ("Jordan Rivera"). Replace it with you.
// ────────────────────────────────────────────────────────────────────────

#import "style.typ": *
#import "components.typ": *

#set document(
  title: "Jordan Rivera — CV",          // EDIT ME (your name)
  author: "Jordan Rivera",              // EDIT ME (your name)
)
#set page(paper: "a4", margin: page-margin)
#set text(font: body-font, size: body-size, fill: ink, lang: "en", hyphenate: false)
#set par(leading: 0.55em, justify: false)
#show link: it => text(fill: accent, it)

// ───────────────────────────────  Header  ───────────────────────────────

#header-band(
  // Photo is OPTIONAL. Replace assets/photo.jpg with your own square photo,
  // OR set `photo: none` to drop the photo and use a full-width header.
  photo: "assets/photo.jpg",
  name: "Jordan Rivera",                          // EDIT ME
  title: "Full-Stack Software Engineer",          // EDIT ME (your headline)
  contacts: (
    contact-item("",         "Address",  "Lisbon, Portugal"),                                                   // EDIT ME
    contact-item("linkedin", "LinkedIn", link("https://linkedin.com/in/jordan-rivera-sample")[linkedin.com/in/jordan-rivera-sample]),  // EDIT ME
    contact-item("mail",     "Email",    link("mailto:jordan.rivera@example.com")[jordan.rivera\@example.com]), // EDIT ME
    contact-item("phone",    "Phone",    "+1 555 0100 123"),                                                    // EDIT ME
  ),
)

// ─────────────────────────────  About me  ───────────────────────────────

#section-header("user", "About me")

// EDIT ME — 3 to 5 sentences. Strong, specific, no fluff. No em-dashes (see CONVENTIONS).
*Full-Stack Software Engineer* with experience building web and mobile
applications across fintech, e-commerce, and SaaS. Comfortable across modern
frontend frameworks (React, Vue 3) and backend stacks (Node.js, Spring Boot,
PostgreSQL), with hands-on experience designing REST APIs, containerized
deployments, and CI/CD pipelines. Focused on clean architecture and reliable,
well-tested software, and happy mentoring others along the way.

// ────────────────────────────────  Skills  ──────────────────────────────

#section-header("tools", "Skills")

// EDIT ME — keep the "Label: comma-separated values" shape (a #stack, NOT a grid),
// so ATS parsers read each label together with its values. See docs/CONVENTIONS.md.
#stack(spacing: 6pt,
  [*Languages:*        #h(4pt) TypeScript, JavaScript, Python, Java, Go],
  [*Frameworks:*       #h(4pt) React, Vue 3, Node.js (Express), Spring Boot, FastAPI],
  [*Databases:*        #h(4pt) PostgreSQL, Redis, MongoDB],
  [*Infra / DevOps:*   #h(4pt) Docker, Docker Compose, GitHub Actions, AWS, Terraform],
  [*Other:*            #h(4pt) Tailwind CSS, REST, GraphQL, WebSockets, Stripe],
  [*Spoken languages:* #h(4pt) English (native), Spanish (professional)],
)

// ──────────────────────────  Work Experience  ──────────────────────────

#section-header("briefcase", "Work Experience")

// ── Copy a whole #role(...) block to add a job. Reorder by moving blocks.
// ── Most-recent first. Present tense for your CURRENT job only; past tense
//    for everything else. One idea per bullet. Quantify with REAL numbers.

#role(
  company: "Northwind Labs",                                   // EDIT ME
  dates: "January 2024 — Present",                             // EDIT ME (em-dash in dates is fine)
  title: "Senior Full-Stack Engineer (Full-time, Remote)",     // EDIT ME
)[
  #bullets((
    [Build and maintain a customer analytics platform serving 10,000+ daily
     users, with a React frontend and a Node.js and PostgreSQL backend exposing
     40+ REST endpoints.],
    [Lead the migration to containerized deployment on AWS ECS, cutting release
     time from hours to minutes via a GitHub Actions CI/CD pipeline.],
    [Mentor two junior engineers through code review and pair programming.],
  ))
]

#role(
  company: "Brightwave",
  dates: "March 2022 — December 2023",
  title: "Full-Stack Developer (Full-time, On-site)",
)[
  #bullets((
    [Developed a multi-tenant SaaS dashboard in Vue 3 and TypeScript, shipping
     25+ reusable components and server-side paginated tables.],
    [Designed and built a Spring Boot REST API with typed domain models, request
     validation, and structured error handling.],
    [Introduced automated testing that raised backend coverage from 20% to 80%.],
  ))
]

#role(
  company: "Acme Commerce",
  dates: "June 2021 — February 2022",
  title: "Frontend Developer (Freelance, Remote)",
)[
  #bullets((
    [Implemented a responsive storefront from Figma designs using React and
     Tailwind CSS.],
    [Integrated Stripe for checkout and a REST API for catalog and order
     management.],
  ))
]

#role(
  company: "Initech",
  dates: "August 2019 — May 2021",
  title: "Junior Software Developer (Full-time, On-site)",
)[
  #bullets((
    [Built internal tools in Python and JavaScript to automate manual reporting
     workflows.],
    [Collaborated in an Agile team of eight, contributing to weekly releases.],
  ))
]

// ────────────────────────────  Education  ───────────────────────────────

#section-header("book", "Education")

#role(
  company: "State University",                                          // EDIT ME
  dates: "September 2015 — June 2019",                                   // EDIT ME
  title: "BSc in Computer Science",                                      // EDIT ME
)[
  #bullets((
    [Graduation project: a real-time collaborative task board built with React
     and WebSockets. (Team of 3.)],
    [GPA: 3.6 / 4.0. Relevant coursework: Algorithms, Databases, Distributed
     Systems.],
  ))
]

// ────────────────────────  Volunteer experience  ───────────────────────
// Optional section — delete it if you have none. Volunteer entries usually
// have no job title, so `title` is left empty ("").

#section-header("heart", "Volunteer experience")

#role(
  company: "Code for Good",
  dates: "January 2020 — Present",
  title: "",
)[
  #bullets((
    [Mentor beginners at monthly coding workshops, introducing web development
     fundamentals.],
    [Maintain the chapter's open-source volunteer-matching app.],
  ))
]

#role(
  company: "Local Robotics Club",
  dates: "September 2018 — June 2019",
  title: "",
)[
  #bullets((
    [Coached a high-school team for a regional robotics competition.],
  ))
]

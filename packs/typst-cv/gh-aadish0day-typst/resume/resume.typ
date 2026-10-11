#import "@preview/basic-resume:0.2.9": *

#let name = "Aadish Das"
#let location = "Mumbai, India"
#let email = "aadishdas7@gmail.com"
#let github = "github.com/aadish0day"
#let phone = "+91 70393 19907"
#let linkedin = "in/aadish-das"

#set text(
  font: ("Times New Roman", "Nimbus Roman", "Liberation Serif", "DejaVu Serif"),
  size: 9.3pt,
)
#set par(leading: 0.48em)
#set block(spacing: 0.38em)
#set list(spacing: 0.40em)

// Clean modern link styling without harsh underlines
#show link: it => text(fill: rgb("#1e3a8a"))[#it]

#show: resume.with(
  author: name,
  location: location,
  email: email,
  github: github,
  linkedin: linkedin,
  phone: phone,
  accent-color: "#1e3a8a",
  font: ("Times New Roman", "Nimbus Roman", "Liberation Serif", "DejaVu Serif"),
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)

// Elegant, refined section headings with proper spacing and subtle rule
#show heading.where(level: 2): it => block(width: 100%)[
  #v(0.25em)
  #text(fill: rgb("#1e3a8a"), weight: 700, size: 9.6pt)[#upper(it.body)]
  #v(-0.38em)
  #line(length: 100%, stroke: 0.7pt + rgb("#cbd5e1"))
  #v(0.08em)
]

== Summary

Full-stack developer and technical team lead with internship experience shipping production web applications in React, Next.js, and TypeScript. Experienced in designing type-safe backends with Prisma and PostgreSQL, building offline-capable progressive web apps, and leading sprint deliverables and code reviews. Seeking a software engineering internship.

== Work Experience

#work(
  title: "Full-Stack Web Development Intern & Team Lead",
  location: "Remote",
  company: "Ateion",
  dates: "May 2026 - Aug 2026",
)
- Led the technical team during a 3-month internship, assigning weekly tasks, coordinating deliverables, and running code reviews.
- Built full-stack features for client websites using React, Node.js, and component-driven CSS.
- Set up shared debugging workflows and coding guidelines to catch issues before deployment.

#work(
  title: "Web Development Intern",
  location: "Remote",
  company: "Prodigy InfoTech",
  dates: "Jan 2026 - Feb 2026",
)
- Built a weather web app using OpenWeatherMap and the browser Geolocation API to fetch local forecasts and handle API errors cleanly.
- Implemented a client-side password generator using the Web Crypto API instead of Math.random, adding password strength checks.
- Implemented a Minimax search algorithm for a Tic-Tac-Toe game to calculate optimal moves for an unbeatable single-player mode.
- Completed 4 React and TypeScript applications over the month-long internship, focusing on clean component hierarchy and state management.

== Projects

#project(
  name: "Lost & Found Portal",
  url: "github.com/aadish0day/lost-found-portal",
  dates: "Jan 2025 - Present",
)
- Full-stack web app for students and campus members to report, search, and claim lost items.
- Built data mutations with Next.js 15 Server Actions, Prisma, and PostgreSQL, replacing REST endpoints.
- Built accessible dialogs and form controls with Radix UI primitives and Tailwind CSS, supporting full keyboard navigation.
- Technologies: Next.js, React, TypeScript, PostgreSQL, Prisma, Tailwind CSS, Radix UI

#project(
  name: "Virasat QR: Heritage Access System",
  url: "github.com/aadish0day/Virasat_QR",
  dates: "Aug 2024 - Dec 2024",
)
- Web application that links physical QR codes at cultural sites to digital visitor guides.
- Integrated Leaflet.js maps for interactive location browsing across historical landmarks.
- Added service worker caching so visitors can read previously loaded guides offline.
- Technologies: React, TypeScript, Tailwind CSS, Leaflet.js, Vite, PWA

== Education

#grid(
  columns: (1fr, auto),
  row-gutter: 0.25em,
  [*Jai Hind College (Empowered Autonomous)*], [Mumbai, India],
  [_BSc Information Technology_], [_In Progress_],
)

== Skills

#grid(
  columns: (auto, 1fr),
  column-gutter: 0.8em,
  row-gutter: 0.38em,
  [*Frontend:*], [React, Next.js, TypeScript, JavaScript, Tailwind CSS, HTML/CSS],
  [*Backend:*], [Node.js, Express.js, PostgreSQL, MongoDB, Prisma, Supabase, Django, Python, Java, SQL],
  [*Tools & DevOps:*], [Git, Docker, Nginx, Vite, Linux, Bash, GNU Stow, VS Code],
)

== Activities and Interests

- Maintains an Obsidian notebook covering system design, database indexing, and backend architecture patterns.
- Configures and version-controls Linux dotfiles with GNU Stow and Bash for reproducible development setups.

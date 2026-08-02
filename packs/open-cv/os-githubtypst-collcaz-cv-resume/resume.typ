#import "@preview/clickworthy-resume:1.0.1": *

// Personal Information
#let name = "Yassen Tambakti"
#let email = "ytambakti@acm.org"
#let github = "github.com/CollCaz"
#let linkedin = "linkedin.com/in/yassentambakti"
#let phone = "0945591846"
#let contacts = (
  [#link("https://wa.me/218" + phone)[#phone]],
  [#link("mailto:" + email)[#email]],
  [#link("https://" + github)[#github]],
  [#link("https://" + linkedin)[#linkedin]],
)
#let location = "Tripoli, Libya"

// Professional Summary
#let summary = ""

// Resume configuration
#let theme = rgb("#26428b")
#let font = "New Computer Modern"
#let fontSize = 11pt
#let lang = "en"
#let margin = (
  top: 1cm,
  bottom: 0cm,
  left: 1cm,
  right: 1cm,
)

// Resume Header and configuration
#show: resume.with(
  author: name,
  location: location,
  contacts: contacts,
  summary: summary,
  theme-color: theme,
  font: font,
  font-size: fontSize,
  lang: lang,
  margin: margin,
)

// Education
= Education
#edu(
  institution: "University of Tripoli",
  date: "2021 - Present",
  location: "Tripoli, Libya",
  degrees: (
    ("B.S.", "Computer Science"),
  ),
)

// Experience
= Experience
#exp(
  title: "Fullstack Developer",
  organization: "Kevelop",
  date: "April 2025 – Present",
  details: [
    - Took over an existing Next.js + PostgreSQL codebase, leading all backend and frontend development independently.
    - Redesigned database schema and API routes; implemented new UI features from Figma designs.
    - Collaborated with a designer while owning all engineering decisions with minimal oversight.
  ]
)

#exp(
  title: "Lead Backend Developer - Part Time",
  organization: "University of Tripoli",
  date: "January 2025 – Present",
  details: [
    - Designed and implemented a scalable backend in Go for the university’s new website, currently in development.
    - Made all major technical decisions, including API design, database modeling, and system architecture.
    - Collaborated with a React frontend team while supervising junior developers and reviewing frontend code.
    - Coordinated with stakeholders to align backend functionality with institutional goals and timelines.
  ]
)

// Projects
= Projects
#exp(
  title: link("https://github.com/CollCaz/Anubis")[Anubis (Automated Competitive Programming Judge)],
  details: [
    - Developed an automated competitive programming judge capable of evaluating code submissions in multiple languages.
    - Implemented secure sandboxing techniques to safely execute untrusted user code and prevent system breaches.
    - Integrated problem parsing, time and memory limit enforcement, and result reporting with detailed feedback.
    - Designed with scalability in mind to handle concurrent submissions and real-time result updates.
    - Open-sourced on GitHub, facilitating community contributions and continuous improvement.
  ]
)

#exp(
  title: link("https://github.com/CollCaz/SimpleDigital")[SimpleDigital (Digital Circuits Simulator)],
  details: [
    - Developed a digital circuits simulator in C++ to model and analyze basic electronic components.
    - Implemented features to simulate logic gates, flip-flops, and simple combinational circuits.
    - Designed with a user-friendly interface using Raylib.
  ]
)

#exp(
  title: link("https://github.com/CollCaz/FileShare")[FileShare (File Sharing Server)],
  details: [
    - Developed a file hosting server in Go to facilitate secure and efficient file sharing within office environments.
    - Integrated htmx for dynamic web interactions and Tailwind for responsive design.
    - Implemented features like user authentication, file versioning, and access control to enhance collaboration.
  ]
)

// Awards
= Awards
#exp(
  title: "Libyan collegiate programming contest 2024 finalist",
  details: [
    - Won 5th place in the 2024 LCPC, and qualified for the 2024 Arab collegiate programming contest (ACPC).
  ]
)

// Skills
= Skills
#skills((
  ("Expertise", (
    [Linux & NixOS System Administration],
    [Full-Stack Web Development],
    [Backend Architecture & API Design],
    [Automation & Scripting],
    [UI/UX Collaboration],
    [Data Collection & Processing],
  )),
  ("Languages", (
    [Go],
    [C/C++],
    [Lua],
    [TypeScript],
    [Python],
    [Bash],
  )),
))

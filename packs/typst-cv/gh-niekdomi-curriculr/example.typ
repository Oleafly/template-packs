#import "template.typ": *

#show: init

#set document(
  title: "Mike Oxlong: Curriculum Vitae",
  author: "Mike Oxlong",
  keywords: ("CV", "Resume", "Software Engineering"),
  date: auto,
)

// ─── Header ──────────────────────────────────────────────────────────────────
#cv-header(name: "Mike Oxlong", photo: "mike.png")

// ─── Personal Data ───────────────────────────────────────────────────────────
= Personal Data
#cv-personal(
  left: (
    ("Address", [13 Bagpipe Lane, Edinburgh]),
    ("Phone", [+44 00 000 00 00]),
    ("Email", link("mailto:mike.oxlong@example.com")[mike.oxlong\@example.com]),
    ("GitHub", link("https://github.com")[mikeoxlong]),
    ("LinkedIn", link("https://linkedin.com")[Mike Oxlong]),
  ),
  col-right: (
    ("Nationality", [GB]),
    ("Birth date", [01.01.1995]),
    ("Civil status", [Single]),
  ),
)

// ─── Summary ─────────────────────────────────────────────────────────────────
= Summary
Passionate software engineer specializing in distributed systems and
cloud-native haggis delivery infrastructure. Proven track record of deploying
resilient pipelines across the Scottish Highlands with sub-100ms latency.
Seeking opportunities to apply deep expertise in bagpipe-driven development and
kilted agile methodologies.

// ─── Education ───────────────────────────────────────────────────────────────
= Education
#cv-entry(
  date: [09/2020 -- 07/2023],
  org: [University of Edinburgh],
  location: [Edinburgh],
  title: [Bachelor of Science in Computer Science],
)
#cv-entry(
  date: [08/2016 -- 07/2020],
  org: [Highland Technical College],
  location: [Inverness],
  title: [HND Software Development],
)

// ─── Work Experience ─────────────────────────────────────────────────────────
= Work Experience
#cv-entry(
  date: [03/2024 -- present],
  org: [Loch Ness Technologies Ltd],
  location: [Edinburgh],
  title: [Senior Haggis Integration Engineer],
  description: [
    Lead architect for the firm's real-time haggis tracking platform, handling
    over 12,000 haggis events per second at peak. Introduced C++ coroutines to
    replace the legacy bagpipe-based IPC mechanism, reducing latency by 40%.
  ],
)
#cv-entry(
  date: [08/2023 -- 02/2024],
  org: [McCode & Sons Ltd],
  location: [Glasgow],
  title: [Junior Kilt-Stack Developer],
  description: [
    Maintained a TypeScript frontend and REST APIs in Go for an online tartan
    configurator serving 3 clans simultaneously. Introduced golangci-lint and
    reduced pipeline failures by a statistically insignificant margin.
  ],
)

// ─── Projects ────────────────────────────────────────────────────────────────
= Projects
#cv-entry(
  date: [2024],
  title: [BagpipeDB],
  url-github: "https://github.com",
  description: [
    An embedded key-value store optimized for drone (bagpipe chanter) telemetry
    data. Achieves consistent write throughput regardless of weather conditions.
    Toolchain: CMake, Clang-Tidy, Clang-Format.
  ],
)
#cv-entry(
  date: [2023],
  title: [TartanCI],
  url-github: "https://github.com",
  description: [
    A lightweight CI runner written in Go, designed to run on devices with less
    RAM than a standard sporran. Toolchain: golangci-lint, Docker.
  ],
)

// ─── Languages ───────────────────────────────────────────────────────────────
= Languages
#cv-kv((
  ("English", [Native]),
  ("Scots Gaelic", [Conversational]),
))

// ─── Skills ──────────────────────────────────────────────────────────────────
= Skills
#cv-kv((
  ("Systems & Embedded", [C++ (proficient), C (proficient), Rust (basics)]),
  (
    "Scripting & Web",
    [Go (proficient), Python (proficient), TypeScript (basics)],
  ),
  (
    "Tools & Environments",
    [Linux (proficient), CMake (proficient), Docker (basics)],
  ),
))

// ─── Interests ───────────────────────────────────────────────────────────────
= Interests
#cv-kv((
  (
    "Competitive Haggis Hurling",
    [Active member of the Edinburgh Haggis Hurling Society, competing in the
      Highland Games circuit since 2019],
  ),
  ("Bagpipe Firmware Modding",),
  ("Open Source", [Regular contributor to the BagpipeOS project]),
))

// ─── References ──────────────────────────────────────────────────────────────
= References
Available upon request.

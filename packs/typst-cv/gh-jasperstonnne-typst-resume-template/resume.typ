#import "@preview/basic-resume:0.2.9": *
#import "@preview/showybox:2.0.4": showybox

#let sub(it) = {
  v(-.65em)
  it
  v(-.65em)
  line(stroke: (paint: gray, cap: "round", thickness: .5pt), length: 42%)
}

#let awards-list(awards) = {
  set table(stroke: none)
  set text(size: 9pt)
  set align(center)
  table(
    align: (left, center, left),
    columns: (1fr, auto, auto),
    ..for award in awards {
      (award.name, award.level, str(award.date))
    },
  )
}

#let skills-box(title: none, points: (), side: "left") = {
  showybox(
    title-style: (
      weight: 900,
      color: red.darken(40%),
      sep-thickness: 0pt,
      align: center,
    ),
    frame: (
      title-color: rgb("#f2f2f2"),
      border-color: red.darken(40%),
      thickness: if side == "left" { (left: 1pt) } else { (right: 1pt) },
      radius: 0pt,
    ),
    title: title,
  )[
    #for point in points [
      - #point
    ]
  ]
}

// Replace these placeholders with your own details.
#let name = "Your Name"
#let phone = "+00 000 000 0000"
#let location = "City, Country"
#let email = "your.email@example.com"
#let github = "github.com/yourname"
#let personal-site = "yourname.example.com"

#show: resume.with(
  author: name,
  location: location,
  email: email,
  github: github,
  phone: phone,
  personal-site: personal-site,
  accent-color: "#B52323",
  font: ("New Computer Modern", "KaiTi"),
  paper: "a4",
  author-position: left,
  personal-info-position: left,
)

#place(top + right)[
  #block(width: 10%)[
    #text(fill: rgb("#858585"))[
      #block(width: 200pt, stroke: none)[
        #set par(spacing: .5em)
        #smallcaps[Updated 2026]
      ]
    ]
  ]
]

== Education

#edu(
  institution: "Example University",
  location: "City, Country",
  dates: dates-helper(start-date: "Sep 2020", end-date: "Jun 2024"),
  degree: [*Your Major*, Bachelor of Engineering],
  consistent: true,
)
#[
  #set terms(hanging-indent: 0em)
  / Honors: Scholarship, Dean's List
  / Core Courses: Data Structures, Operating Systems, Computer Networks, Machine Learning
  / Interests: Robotics, Computer Vision, Developer Tools
]

== Profile Highlights

#{
  set text(font: ("SF Pro", "Hack Nerd Font"), size: 20pt)
  set table(stroke: .0pt, inset: 8pt)
  v(-.6em)
  table(
    columns: for i in range(15) { (1fr,) },
    align: alignment.horizon + center,
    [#h(-4pt)\u{f17c}], [\u{e691}], [#h(-5pt)\u{e73c}], [#h(-5pt)\u{e646}],
    [#h(-1pt)\u{e893}], [#image("img/PX4_logo.svg", width: 23pt)],
    [#image("img/dji.svg", width: 24pt)], [#image("img/st-microelectronics.svg", width: 24pt)],
    [#h(-5pt)\u{e68b}], [#h(-5pt)\u{e781}], [#h(-5pt)\u{f06e5}],
    [#h(-3pt)\u{e702}], [#h(-3pt)\u{e794}], [#h(-2pt)\u{e7b0}],
    [#set text(size: 15pt); \u{f37f}],
  )
  v(-1.5em)
  set text(size: 7pt, font: "New Computer Modern")
  table(
    columns: for i in range(15) { (1fr,) },
    align: alignment.horizon + center,
    inset: 0em,
    stroke: none,
    [Linux], [Shell], [Python], [C++], [ROS], [PX4], [DJI Dev], [STM32], [Rust], [JavaScript], [Swift], [Git], [CMake], [Docker], [Typst],
  )
}

#[
  #set text(size: 8pt)
  #table(
    stroke: none,
    columns: (2fr, 2fr),
    align: center,
    table.vline(x: 1, start: 0, end: 2, stroke: (paint: gray, cap: "round", thickness: .2pt)),
    [#skills-box(title: "Engineering & Automation", side: "left", points: (
      "Build reliable automation for recurring engineering workflows.",
      "Turn ambiguous requirements into maintainable systems.",
    ))],
    [#skills-box(title: "Robotics & Embedded Systems", side: "right", points: (
      "Develop software across sensing, control, and deployment.",
      "Validate prototypes through testing and field feedback.",
    ))],
    [#skills-box(title: "Product Delivery", side: "left", points: (
      "Own projects from architecture and prototyping to documentation.",
      "Prioritize reliability, usability, and measurable outcomes.",
    ))],
    [#skills-box(title: "Leadership & Collaboration", side: "right", points: (
      "Coordinate cross-functional work and communicate tradeoffs clearly.",
      "Support teammates through reusable tooling and shared practices.",
    ))],
  )
]

== Work Experience

#work(
  company: "Example Technology Co.",
  dates: dates-helper(start-date: "Jul 2024", end-date: "Present"),
  location: "City, Country",
  title: "Software Engineer",
)

- Designed and delivered a production service used by multiple internal teams.
- Automated testing and release workflows, reducing repetitive manual work.
- Collaborated with product and engineering stakeholders to define milestones.

#work(
  company: "Example Robotics Lab",
  dates: dates-helper(start-date: "Jun 2023", end-date: "Jun 2024"),
  location: "City, Country",
  title: "Research Assistant",
)

- Built a robotics prototype integrating perception, planning, and control.
- Created repeatable experiments and documented evaluation results.

== Projects

#project(
  name: "Open Robotics Toolkit",
  role: "Lead Developer",
  dates: dates-helper(start-date: "2024", end-date: "Present"),
  url: "github.com/yourname/project-one",
)

A reusable toolkit for building and testing robotics applications. Add concise details about architecture, impact, and your contribution here.

#project(
  name: "Developer Productivity Platform",
  role: "Creator",
  dates: dates-helper(start-date: "2023", end-date: "2024"),
  url: "github.com/yourname/project-two",
)

An automation platform that standardizes development, testing, and deployment workflows across projects.

== Competitions and Awards

#awards-list(yaml("awards.yaml"))

== Additional Information

- *Languages:* English, another language
- *Leadership and Activities:* Student organization, open-source community
- *Interests:* Robotics, design systems, technical writing

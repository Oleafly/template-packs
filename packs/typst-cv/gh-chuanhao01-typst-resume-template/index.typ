#import "resume.typ"

#let name = "Jane Doe"
#let phone_number = "(+65) 12345678"
#let job_title = "Software Engineer"
#let email = "janedoe@email.com"
#let location = "Japan"
#let website = ""
#let linkedin = "github.com/chuanhao01"
#let github = "linkedin/in/chuanhao01"

#show: resume.setup.with(name: name, margin: (top: 0.35in, bottom: 0.35in, rest: 0.4in))

#resume.header(
  name: name,
  job_title: job_title,
  phone_numer: phone_number,
  email: email,
  location: location,
  website: website,
  linkedin: linkedin,
  github: github,
)

#resume.section(title: "Education")
#resume.item(
  title: "Bachelor’s Degree in Coffee Barista",
  date: "May 2025",
  name: "National Singapore University (NSU)",
  location: "Singapore",
  body: [#list(
    (
      "CS & Math",
      resume.rlink(
        "https://www.urbandictionary.com/define.php?term=clown",
        "Funny Scholar",
      ),
      "Dean's list Coffee Barista of 2024",
    ).join(" | "),
  )],
)
#resume.item(
  title: link(
    "https://en.wikipedia.org/wiki/Toilet_cleaner",
    "Diploma in Toilet Cleaning",
  ),
  date: "May 2024",
  name: "Polytechnic of Toliets",
  location: "Singapore",
  body: [#list(
    (
      text(weight: "bold")[Cumulative GPA: ] + [4.0/4.0],
      "Valedictorian of all toliets",
    ).join(" | "),
  )],
)

#resume.section(title: "Work Experience")
#resume.item(
  title: "Subatomic Shepherd and Caffeine Connoisseur",
  date: "May 2024 - Present",
  name: "Microscopic Circus, Schrodinger's University",
  location: "Liyue Habour",
  body: [
    #list[
      Played God with tiny molecules, making them dance to uncover the secrets of the universe
    ][
      Drank Coffee at the habour
    ] ],
)
#resume.item(
  title: "33th Expeditioner",
  date: "April 2025 - June 2025",
  name: "Painters Guild",
  location: "Lumière",
  body: [
    #list[
      Fought imaginary enemies and friends
    ][
      Flew on a gaint lovable plane and had a companion that liked feet
    ]
  ],
)

#resume.section(title: "Extra-Curricular Activities")
#resume.item(
  title: "Mcdonald's connoisseur",
  date: "2022",
  name: link(
    "https://www.mcdonalds.com.sg/",
    "BlackRock",
  ),
  location: "World",
  body: [
    #list[
      Ate at Mcdonald's when I needed food sometimes
    ]
  ],
)
#resume.single-item(
  title: "Freelance Work",
  body: [
    #list[
      When working on work but not getting paid
    ]
  ],
)
#resume.section(title: "Skills")
#list[
  #text(weight: "bold")[Programming Languages: ] Python, Javascript, TypeScript, Rust, C/C++ and HTML/CSS
][
  #text(weight: "bold")[Technologies: ] React, Tailwind CSS, Git, Docker, OpenCV, PyTorch, CUDA, Pandas, Seaborn, Scikit-Learn, PostgreSQL, Proxmox
][
  #text(weight: "bold")[Platforms: ] Linux, Raspberry Pi(ARM), Windows and macOS
]

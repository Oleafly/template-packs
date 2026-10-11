#import "resume.typ": *

// Personal information
#let name = "John Doe"
#let location = "Vienna, AT"
#let email = "johndoe@mail.com"
#let github = "github.com/ant1isbusy"
#let phone = "+43 123 4567891"

#show: resume.with(
  author: name,
  location: location,
  email: email,
  github: github,
  phone: phone,
  accent-color: "#940000",
  font: "New Computer Modern",
  paper: "a4",
  image-path: "face.jpg",
  author-position: left,
  personal-info-position: left,
)

== Work Experience

#work(
  title: "Junior Something",
  company: "SomeCompany AG - Innovation Team",
  location: "Munich, DE",
  dates: dates-helper(start-date: "06/2024", end-date: "present"),
)
- *Beat the Heath*: Advancing Our Understanding of Heat Stress and Developing Effective Sustainable Interventions to Reduce Health Risks in a Warming World.
- *Teaching*: Architectural and building science.

== Projects
#project(
  dates: dates-helper(start-date: "09/2025", end-date: "present"),
  name: "Localreads",
  url: "github.com/ant1isbusy/Localreads",
)
- Description of the project

== Education

#edu(
  dates: dates-helper(start-date: "10/2025", end-date: "present"),
  degree: "Master of Science",
  institution: "TU Munich",
)
- Currently focusing on xyz.

#edu(
  dates: dates-helper(start-date: "10/2022", end-date: "08/2025"),
  degree: "Bachelor of Science",
  gpa: "GPA: 1.0",
  institution: "TU Vienna",
)
- #lorem(10)
- #lorem(8)

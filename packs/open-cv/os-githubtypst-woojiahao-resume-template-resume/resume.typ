#let body_font_size = 10pt
#let header_font_size = 12pt
#let title_font_size = 16pt
#let first_name = "First name"
#let last_name = "Last name"
#let email = "Email"
#let website = "Website"
#let github = "Github"
#let phone_number = "Phone number"

#set text(font: "Arial", hyphenate: false, size: body_font_size)
#set page(margin: (x: 1.1cm, y: 1.3cm))

#let chiline() = {
  v(-2pt)
  line(length: 100%, stroke: rgb("#777777"))
  v(-5pt)
}

#let section(body, header: "", hide: false) = {
  if hide [] else [
    #pad(top: 3pt, bottom: -5pt)[
      == #upper[#text(size: header_font_size)[#header]]
    ]
    #chiline()

    #body
  ]
}

#let experience(
  body,
  company: "",
  role: "",
  start: "",
  end: "",
  hide: false,
  location: "Singapore",
) = {
  if hide [] else {
    if start == "Incoming" [
      *#company* #h(1fr) #start\
      #role #h(1fr) #location\
      #body
    ] else [
      *#company* #h(1fr) #start -- #end\
      #role #h(1fr) #location\
      #body
    ]
  }
}

#let education(
  body,
  school: "",
  degree: "",
  graduation: datetime.today(),
  gpa: "",
) = [
  #let date = {
    if graduation > datetime.today() [
      Expected: #graduation.display("[month repr:short] [year]")
    ] else [
      #graduation.display("[month repr:short] [year]")
    ]
  }

  *#school* #h(1fr) #date \
  #degree #h(1fr) GPA: #gpa
  #body
]


#text(title_font_size)[= #first_name #underline[#last_name]]

#link("mailto:" + email)[#underline(email)] #text(black)[$space.hair$|$space.hair$] #link(
  "https://" + website,
)[#underline(website)] #text(black)[$space.hair$|$space.hair$] #link(
  "https://" + github,
)[#underline(github)] #text(black)[$space.hair$|$space.hair$] #phone_number

#section(header: "Work Authorization", hide: false)[
  Singapore Citizen; eligible for *H-1B1 and J-1 US visas*, and an *HPI UK visa, with no petition required*
]

#section(header: "Education")[
  #education(
    school: "School name",
    degree: "Degree name",
    graduation: datetime(year: 2025, month: 12, day: 1),
    gpa: "GPA/5.00",
  )[
    - Points
  ]
]

#section(header: "Experience")[
  #experience(
    company: "Company A",
    role: "Role",
    start: "Start",
    end: "End",
    location: "Location",
    hide: false,
  )[
    - Doing things
    - More things
  ]

  #experience(
    company: "Company B",
    role: "Role",
    start: "Start",
    end: "End",
    location: "Location",
    hide: false,
  )[
    - Doing things
    - More things
  ]
]

#section(header: "Featured Works", hide: false)[
  - Gave a talk
  - Held some workshops
  - Wrote a few articles
]

#section(header: "Projects", hide: false)[
  - #link("https://google.com")[#underline[Project]]: Did things in this project
]

#section(header: "Activities", hide: false)[
  - *Name*: Worked on things
]

#section(header: "Skills")[
  - *Languages:*
  - *Technologies:*
  - *Frameworks:*
]

#section(header: "Open-source Contributions", hide: false)[
  - #link("https://google.com")[Project name]: Fixed bugs
]



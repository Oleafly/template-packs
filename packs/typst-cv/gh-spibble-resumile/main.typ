#import "utils.typ": *

/*
* -----
* Page config settings
* -----
*/

#let margin_x          = 0.7in
#let margin_y          = 0.7in
#let name_font_size    = 24pt
#let info_font_size    = 10pt
#let heading_font_size = 12pt
#let body_font_size    = 10pt

#let name_font         = "Libertinus Serif"
#let info_font         = "Libertinus Serif"
#let heading_font      = name_font
#let body_font         = info_font

#let name_color        = black
#let heading_color     = black

#let show_icons        = false

// 0: Inline name/info. Saves vertical space
// 1: Name/info on separate lines. More traditional + good for longer names
#let header_style = 1

#show: doc => conf(
  margin_x, margin_y,
  name_font_size, info_font_size, heading_font_size, body_font_size,
  name_font, info_font, heading_font, body_font,
  name_color, heading_color, show_icons,
  doc
)

// These four are mandatory!
#let name  = "First Last"
#let loc   = "Place, Somewhere"
#let phone = "(123) 456-7890"
#let email = "mycoolemail@doma.in"

// These three are optional; to hide, set as emptystrings ("").
#let website = ""
#let linkedin = ""
#let github = ""

#header(
  name, loc, phone, email, website, linkedin, github,
  info_font, info_font_size, header_style, show_icons
)

/*
* -----
* Editable resume content starts here!
* -----
*/
#section("Education")

#education(
  school: "Top 100% University", 
  grad_date: "June 20XX", 
  degree: "(B.S.) All the Sciences", 
  loc: "Place, Somewhere",
  gpa: none
)
#coursework(
  "Putting Fries in the Bag, Would You Like Some Ketchup With That, My Pleasure, Have a Good Rest of Your Day"
)

#section("Experience")

#experience(
  role: "Even Cooler Job",
  dates: "Jan. 2025 - Feb. 2025",
  employer: "Cooler Company",
  location: "Somewhere, SW",
  contents:
  [
    - This is a bullet point.
    - This is another bullet point.
    - You get the deal!
  ]
)

#multi_role_experience(
  roles: ("Cooler Job", "Cool Job"),
  dates: ("Dec. 2023 - Jan. 2025", "Dec. 2020 - Dec. 2023"),
  employer: "Cool Company",
  location: "Place, Somewhere Else",
  contents:
  (
    [
      - This is a bullet point.
      - This is another bullet point.
      - You get the deal!
    ],
    [
      - This is a bullet point.
      - This is another bullet point.
      - You get the deal!
    ]
  )
)

#section("Projects")

#project(
  name: "Project A",
  tools: "TypeScript, Python, Flask",
  live_link: "https://www.youtube.com/watch?v=xvFZjo5PgG0",
  source_link: "https://www.youtube.com/watch?v=xvFZjo5PgG0",
  contents: [
    - This is a bullet point.
    - This is another bullet point.
    - You get the deal!
  ]
)

#project(
  name: "Project B",
  tools: "Embedded C (STM32), JavaScript",
  source_link: "https://www.youtube.com/watch?v=xvFZjo5PgG0",
  date: "June 2025",
  contents: [
    - This is a bullet point.
    - This is another bullet point.
    - You get the deal!
  ]
)

#project(
  name: "Project C",
  tools: "React, Express.js, Node.js, MongoDB, Google Gemini",
  date: "",
  contents: [
    - This is a bullet point.
    - This is another bullet point.
    - You get the deal!
  ]
)

#section("Skills")
#skills(
  lists: ("Languages", "Frameworks/Libraries", "Dev Tools"),
  contents: (
    "C/C#/C++, Java, Python, x86 ASM, English, Spanish, ASL", 
    "Flask, FastAPI, Express.js, Node.js, React, Angular, Svelte", 
    "VSCode, Cursor, ChatGPT, Google Gemini, Claude")
)

#let name = "Akshat Malviya"
#let website = "www.akshatmalviya.com"
#let address = "City, State, Country"
#let email = "mail@example.com"
#let contactno = "+81 99 4578 9012"
#let linkedin = "linkedin.com/in/akshat-malviya"
#let github = "github.com/akshat157"

#let summary_text = lorem(40)

/* ------------------------------------------------------------------------------------- */

#show link: underline

#let header(name, address, contactno, email, website, linkedin, github) = [
  #grid(
    columns: (1fr, auto),
    align: (left + top, right + top),
    [
      #show title: set text(size: 30pt, weight: "medium")
      #block(below: 1em)[
        #title[#name]
      ]
      #address
    ],
    [
      #link("https://" + website)[#website] \
      #link("tel:" + contactno) | #link("mailto:" + email) \
      #link("https://" + linkedin)[#linkedin] | #link("https://" + github)[#github] \ 
    ]
  )
]

#let section(title, content) = block(breakable: false)[
  #let section_title(title) = [
    #show heading: smallcaps
    #show heading: set text(size: 14pt, weight: "medium")
    #heading(title)
  ]
  #let title_sep = {
    show divider: set block(above: 0em, below: 0.75em)
    show divider: set line(length: 100%, stroke: 0.5pt + rgb("000000"))
    divider()
  }

  #section_title(title)
  #title_sep
  #pad(left: 0.5em)[
    #content
  ]
]

#let section_item_header(title, subtitle, duration, location) = [
  #grid(
    columns: (1fr, auto),
    align: (left, right),
    [
      #text(weight: "bold")[
        #title
      ] \ 
      #text(style: "italic")[
        #subtitle
      ]
    ],
    [
      #duration \
      #text(style: "italic")[
        #location
      ]
    ]
  )
]

#let section_item_content(items) = [
  #list(
    indent: 0.5em,
    ..items.map(item => [#item])
  )
]

#let section_item(title, subtitle, duration, location, items: ()) = [
  #block(above: 0.5em, below: 1em)[
    #section_item_header(title, subtitle, duration, location)
    #if items != () {
      block(above: 0.75em)[
        #section_item_content(items)
      ]
    }
  ]
]

/* ------------------------------------------------------------------------------------- */

#set page(
  paper: "us-letter",
  margin: (x: 1.2cm, y: 1cm),
)
#set text(font: "Libertinus Serif")

#header(name, address, contactno, email, website, linkedin, github)

#section(
  "Summary",
  summary_text
)

#section(
  "Education",
  [
    #section_item("Indian Institute of Technology Mandi", "Bachelor of Technology in Electrical Engineering", "Mandi, H.P., India", "Aug 2017 - June 2021")
  ]
)

#section(
  "Work Experience",
  [
    #section_item("Software Engineer", "Company Co Ltd.", "Aug 2021 - Present", "Tokyo, Japan",
    items: (
      [#lorem(30)],
      [#lorem(25)],
    ))

    #section_item("Software Engineer Intern", "Company Pvt. Ltd.", "Aug 2020 - May 2021", "Bengaluru, India",
    items: ( 
      [#lorem(15)],
      [#lorem(12)],
      [#lorem(10)],
    ))
  ]
)

#section(
  "Skills",
  [
    #list(
      marker: none,
      [*Programming:* C, C++, C\#, Python, TypeScript, QML, Rust, Go, Lua],
      [*Web & Backend:* NextJS, ReactJS, VueJS, FastAPI, Flutter, shadcn/ui, Tailwind, Flask, gRPC],
      [*Tools & Platforms:* Linux, Git, NeoVim, ollama, uv, GitHub Actions],
    )
  ]
)

#section(
  "Projects",
  [
    #section_item("Project One", "Personal", "Jan 2024 - Aug 2025", "", items: (
      [#lorem(22)],
      [#lorem(20)],
    ))
    #section_item("Project Two", "Major Technical Project", "Jan 2024 - Aug 2025", "IIT Mandi, India", items: (
      [#lorem(25)],
      [#lorem(22)],
    ))
  ]
)

#section(
  "Past Activities & Achievements",
  [
    #list(
      [*Head, Web development*, AstraX '20, IIT Mandi],
      [*Winner, Website Design*, Space Technology and Astronomy Cell, IIT Mandi],
      [*Runner-Up, Capture The Stone*, CyberSec CTF Event, Utkarsh '19, IIT Mandi],
    )
  ]
)

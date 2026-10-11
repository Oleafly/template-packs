#import "./lib/utils.typ"

#let my = json("data.json")
#let fullName = [#my.givenName #my.middleInitial.first(). #my.familyName]


#let FONT_SIZE = 11pt

#set document(
  title: [#fullName - Resume],
  author: utils.to-string[#fullName],
  description: [Resume of #fullName],
  keywords: (
    "resume", "tech", "software", "programming",
    "software", "software engineer",
  ),
)
#set text(font: "Helvetica Neue", size: FONT_SIZE)
#set page(paper: "a4", margin: (x: 0.2in, y: 0.5in))
#show heading: set text(size: FONT_SIZE)

#align(center)[
  #heading(fullName, depth: 1)
  #v(3pt)
  #utils.contacts-row(my.location, my.contact)
  #utils.links-row(links: my.links)
]
#line(length: 100%, stroke: 0.2pt)

#align(center)[ == Skills ]
#for categ in my.skills [
  *#categ.category:*
  #for (idx, s) in categ.skills.enumerate() [
    #s #if idx < categ.skills.len() - 1 [,]
  ]
  #v(-4pt)
]
#v(0.2in)

#align(center)[ == Work Experience ]
#for exp in my.experience [
  #utils.exp-heading(exp)
  #if "description" in exp [
    #for bullet in exp.description [- #bullet]
  ]
  #if "projects" in exp [
    #for proj in exp.projects [
      #let projURL
      #if "url" in proj {
        projURL = [(#link("https://" + proj.url)[#proj.url])]
      }
      - *#proj.title* #projURL
        #if "description" in proj [
          #for desc in proj.description [
            - #desc
          ]
        ]
      #v(4pt)
    ]
  ]
  #v(0.1in)
]
#v(0.2in)

#align(center)[== Personal Projects]
#for proj in my.portfolio [
  #utils.proj-heading(proj)
  #for bullet in proj.description [ - #bullet ]
  #v(0.1in)
]
#v(0.2in)

#align(center)[== Education]
#for school in my.education [
  #utils.educ-heading(school)
  #if "description" in school [
    #for bullet in school.description [ - #bullet ]
  ]
  #v(0.1in)
]

#import "utils.typ"

// set rules
#let setrules(uservars, doc) = {
    set text(
        font: uservars.bodyfont,
        size: uservars.fontsize,
        hyphenate: false,
    )

    set list(
        spacing: uservars.linespacing
    )

    set par(
        leading: uservars.linespacing,
        justify: true,
    )

    doc
}

// show rules
#let showrules(uservars, doc) = {
    // Uppercase section headings
    show heading.where(
        level: 2,
    ): it => block(width: 100%)[
        #v(uservars.sectionspacing)
        #set align(left)
        #set text(font: uservars.headingfont, size: 1em, weight: "bold", fill: uservars.accentColor.darken(10%))
        #if (uservars.at("headingsmallcaps", default:false)) {
            smallcaps(it.body)
        } else {
            upper(it.body)
        }
        #v(-0.75em) #line(length: 100%, stroke: 1pt + uservars.accentColor) // draw a line
    ]

    // Name title/heading
    show heading.where(
        level: 1,
    ): it => block(width: 100%)[
        #set text(font: uservars.headingfont, size: 1.5em, weight: "bold", fill: white)
        #if (uservars.at("headingsmallcaps", default:false)) {
            smallcaps(it.body)
        } else {
            upper(it.body)
        }
        #v(2pt)
    ]

    doc
}

// Set page layout
#let cvinit(doc) = {
    doc = setrules(doc)
    doc = showrules(doc)

    doc
}

// Job title
#let jobtitletext(info, uservars) = {
    if ("label" in info.resume.basics and info.resume.basics.label != none) and uservars.showTitle {
        block(width: 100%)[
            #set text(fill: white)
            *#info.resume.basics.label*
            #v(-4pt)
        ]
    } else {none}
}

// Contacts and social profiles
#let contacttext(data, uservars) = block(width: 100%)[
    #set text(fill: white)
    #let contacts = (
        // Make sure to have an emoji font installed if you want to keep symbols!
        if "email" in data.resume.basics and data.resume.basics.email != none { box(link("mailto:"+
      data.resume.basics.email)[#emoji.mail #data.resume.basics.email]) },
        if ("phone" in data.resume.basics and data.resume.basics.phone != none) and uservars.showNumber {box(link("tel:"
      + data.resume.basics.phone)[#emoji.phone.receiver #data.resume.basics.phone])} else {none},
        if ("url" in data.resume.basics) and (data.resume.basics.url != none) {
            box(link(data.resume.basics.url)[#emoji.globe.meridian #data.resume.basics.url.split("//").at(1)])
        }
    ).filter(it => it != none) // Filter out none elements from the profile array

    // Social profiles on a separate line
    #let profiles = ()
    #if ("profiles" in data.resume.basics) and (data.resume.basics.profiles.len() > 0) and uservars.showProfiles {
      for profile in data.resume.basics.profiles {
          profiles.push(box(link(profile.url)[#profile.url.split("//").at(1)]))
        }
    }

    #set text(font: uservars.bodyfont, weight: "medium", size: uservars.fontsize * 1)
    #pad(x: 1em)[
        #contacts.join(" ")
    ]
    #if uservars.showProfiles {
      profiles.join(" ")
    }
]

// The colored banner and its content
#let cvheading(data, uservars) = {
    // Shifted of the expected margin
    v(-1.25cm)
    grid(
      // Keep [ 20 | 60 | 20 ] so that QR and Portrait can go left/right and content in the center stays centered
      columns: (20%, 60%, 20%),
      gutter: 0em,
      align: (start, center, end),
      if uservars.showQR {
        box(
          width: 2cm,
          height: 2cm,
          clip: true,
          radius: 0%,
          // White rectangle around the QR code
          rect(width: 100%, inset:2pt, height: 100%, stroke: 2pt + white, image(uservars.QRPath, width: 100%, height: 100%, fit: "cover"))

        )
      } else {},
      align(center)[
          = #data.resume.basics.name
          #jobtitletext(data, uservars)
          #contacttext(data, uservars)
      ],
      if uservars.showPortrait {
      // white circle with inside a box that crops the portrait (to fit a circle)
      circle(radius: 0.9cm, inset: -5pt, outset: 0pt, stroke: 1pt + white,  
        box(
          width: 100%,
          clip: true,
          radius: 50%,
          image(uservars.portraitPath, width: 1.8cm, height:1.8cm, fit: "cover"))
        )
      },
      v(1.25cm)
    )
}


// Work section
#let cvwork(info, title: "Work Experience", isbreakable: true) = {
    if ("work" in info.resume) and (info.resume.work != none) {block(breakable: true)[
        == #title
        // Each work is a separate unbreakable block
        #for w in info.resume.work {
        block(width:100%, breakable: false, above:1.5em)[
            #block(width: 100%, breakable: false, above: 1.5em)[
                // Line 1: Company and Location
                #if ("url" in w) and (w.url != none) [
                    *#link(w.url)[#w.name]* #h(1fr) \
                ] else [
                    *#w.name* #h(1fr) \
                ]
            ]
            #block(width: 100%, breakable: false, above: 1em)[
                // Parse ISO date strings into datetime objects
                #let end = ""
                #let start = ""
                #if "startDate" in w {
                  start = utils.strpdate(w.startDate)
                }
                #if "endDate" in w {
                  end = utils.strpdate(w.endDate)
                }
                // Line 2: Position and Date Range
                #text(style: "italic")[#w.position] #h(1fr)
                #text(style: "italic")[#utils.daterange(start, end)]
                #v(0pt)
                // Highlights or Description
                #text()[#w.summary] 
                #if "highlights" in w {
                    for hi in w.highlights [
                        - #eval(hi, mode: "markup")
                    ]
                }
            ]
        ]
        }
    ]
  }
}

// Education section
#let cveducation(info, title: "Education", isbreakable: true) = {
    if ("education" in info.resume) and (info.resume.education != none) {block[
        == #title
        #for edu in info.resume.education {
            let start = ""
            let end = ""
            if "startDate" in edu {
              start = utils.strpdate(edu.startDate)
            }
            if "endDate" in edu {
              end = utils.strpdate(edu.endDate)
            }

            let edu-items = ""
            if ("score" in edu) and (edu.score != none) {edu-items = edu-items + "- *Score*: " + edu.score + "\n"}
            if ("courses" in edu) and (edu.courses != none) {edu-items = edu-items + "- *Courses*: " + edu.courses.join(", ") + "\n"}
            if ("highlights" in edu) and (edu.highlights != none) {
                for hi in edu.highlights {
                    edu-items = edu-items + "- " + hi + "\n"
                }
                edu-items = edu-items.trim("\n")
            }

            // Create a block layout for each education entry
            block(width: 100%, breakable: isbreakable)[
                // Line 1: Institution
                #if ("url" in edu) and (edu.url != none) [
                    *#link(edu.url)[#edu.institution]* #h(1fr) \
                ] else [
                    *#edu.institution* #h(1fr) \
                ]
                // Line 2: Degree and Date
                #if ("area" in edu) and (edu.area != none) [
                    #text(style: "italic")[#edu.studyType in #edu.area] #h(1fr)
                ] else [
                    #text(style: "italic")[#edu.studyType] #h(1fr)
                ]
                #text(style: "italic")[#utils.daterange(start, end)] \
                #eval(edu-items, mode: "markup")
            ]
        }
    ]}
}

// Project section
#let cvprojects(info, title: "Projects", isbreakable: true) = {
    if ("projects" in info.resume) and (info.resume.projects != none) {block[
        == #title
        #for project in info.resume.projects {
            let end = ""
            let start = ""
            // Parse ISO date strings into datetime objects
            if "startDate" in project {
              start = utils.strpdate(project.startDate)
            }
            if "endDate" in project {
              end = utils.strpdate(project.endDate)
            } 
            // Create a block layout for each project entry
            block(width: 100%, breakable: false)[
                #if ("url" in project) and (project.url != none) [
                    *#link(project.url)[#project.name]* #h(1fr) #utils.daterange(start, end)
                ] else [
                    *#project.name* #h(1fr) #utils.daterange(start, end)
                ]                 
                #v(0pt)
                #project.description
                #for hi in project.highlights [
                    - #eval(hi, mode: "markup")
                ]
            ]
        }
    ]}
}

// Certificates section
#let cvcertificates(info, title: "Licenses and Certifications", isbreakable: true) = {
    if ("certificates" in info.resume) and (info.resume.certificates != none) {block[
        == #title

        #for cert in info.resume.certificates {
            // Parse ISO date strings into datetime objects
            let date = utils.strpdate(cert.date)
            // Create a block layout for each certificate entry
            block(width: 100%, breakable: isbreakable)[
                // Line 1: Certificate Name and URL (if applicable)
                #if ("url" in cert) and (cert.url != none) [
                    *#cert.name* #h(1fr) #underline(text(style: "italic")[#link(cert.url)[Certificate URL]])
                ] else [
                    *#cert.name* #h(1fr)
                ]
                #if "id" in cert and cert.id != none and cert.id.len() > 0 [
                  ID: #raw(cert.id)
                ]
                \
                // Line 2: Issuer and Date
                #text(style: "italic")[#cert.issuer]  #h(1fr) #text(style: "italic")[#date]
            ]
        }
    ]}
}

// Publication section
#let cvpublications(info, title: "Research and Publications", isbreakable: true) = {
    if ("publications" in info.resume) and (info.resume.publications != none) {block[
        == #title
        #for pub in info.resume.publications {
            // Parse ISO date strings into datetime objects
            let date = utils.strpdate(pub.releaseDate)
            // Create a block layout for each publication entry
            block(width: 100%, breakable: isbreakable)[
                // Line 1: Publication Title
                #if "url" in pub and pub.url != none [
                    *#link(pub.url)[#pub.name]* \
                ] else [
                    *#pub.name* \
                ]
                // Line 2: Publisher and Date
                #if pub.publisher != none [
                    Published on #text(style: "italic")[#pub.publisher]  #h(1fr) #text(style: "italic")[#date] \
                ] else [
                    In press \
                ]
                #pub.summary
            ]
        }
    ]}
}

// Skill, languages and interests section
#let cvskills(info, title: "Skills, Languages, Interests", isbreakable: true) = {
    if (("languages" in info.resume) or ("skills" in info.resume) or ("interests" in info.resume)) and ((info.resume.languages != none)
  or (info.resume.skills != none) or (info.resume.interests != none)) {block(breakable: isbreakable)[
        == #title
        #if ("languages" in info.resume) and (info.resume.languages != none) [
            #let langs = ()
            #for lang in info.resume.languages {
                langs.push([#lang.language (#lang.fluency)])
            }
            - *Languages*: #langs.join(", ")
        ]
        #if ("skills" in info.resume) and (info.resume.skills != none) [
            #for group in info.resume.skills [
                - *#group.name*: #group.keywords.join(", ")
            ]
        ]
        #if ("interests" in info.resume) and (info.resume.interests != none) [
            #for group in info.resume.interests [
                - *#group.name*: #group.keywords.join(", ")
            ]
        ]
    ]}
}

// Footer with timestamp
#let endnote(uservars) = {
  if uservars.sendnote {
    place(
        bottom + right,
        dx: 9em,
        dy: -7em,
        rotate(-90deg, block[#set text(size: 4pt, font: "Open Sans", fill: black)
      This document was last updated on #datetime.today().display("[year]-[month]-[day]") using Typst).)])
    )
  } else {
    place(
        bottom + right,
        block[
            #set text(size: 5pt, font: "Open Sans", fill: black)
    This document was automatically generated on #datetime.today().display("[year]-[month]-[day]") using Typst.
        ]
    )
  }
}

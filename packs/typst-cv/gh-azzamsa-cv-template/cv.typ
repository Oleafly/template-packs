#import "utils.typ"

// set rules
#let setrules(uservars, doc) = {
  set text(
    font: uservars.bodyfont,
    size: uservars.fontsize,
    hyphenate: false,
  )

  set list(spacing: uservars.linespacing)

  set par(
    leading: uservars.linespacing,
    justify: true,
  )

  doc
}

// show rules
#let showrules(uservars, doc) = {
  // Uppercase section headings
  show heading.where(level: 2): it => block(width: 100%)[
    #v(uservars.sectionspacing)
    #set align(left)
    #set text(font: uservars.headingfont, size: 1em, weight: "bold")
    #if (uservars.at("headingsmallcaps", default: false)) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }
    #v(-0.75em) #line(length: 100%, stroke: 1pt + black) // draw a line
  ]

  // Name title/heading
  show heading.where(level: 1): it => block(width: 100%)[
    #set text(font: uservars.headingfont, size: 1.5em, weight: "bold")
    #if (uservars.at("headingsmallcaps", default: false)) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }
    #v(2pt)
  ]

  // Links
  show link: set text(blue)

  doc
}

// Set page layout
#let cvinit(doc) = {
  doc = setrules(doc)
  doc = showrules(doc)

  doc
}

// Job titles
#let jobtitletext(info, uservars) = {
  if uservars.showTitle {
    block(width: 100%)[
      *#info.personal.titles.join("  /  ")*
      #v(-4pt)
    ]
  } else {
    none
  }
}

// Address
#let addresstext(info, uservars) = {
  if uservars.showAddress {
    // Filter out empty address fields
    let address = info.personal.location.pairs().filter(it => it.at(1) != none and str(
      it.at(1),
    ) != "")
    // Join non-empty address fields with commas
    let location = address.map(it => str(it.at(1))).join(", ")

    block(width: 100%)[
      #location
      #v(-4pt)
    ]
  } else {
    none
  }
}

#let contacttext(info, uservars) = block(width: 100%)[
  #let profiles = (
    box(link("mailto:" + info.personal.email)),
    if uservars.showNumber {
      box(link("tel:" + info.personal.phone))
    } else {
      none
    },
    if info.personal.url != none {
      box(link(info.personal.url)[#info.personal.url.split("//").at(1)])
    },
  ).filter(it => it != none) // Filter out none elements from the profile array

  #if info.personal.profiles.len() > 0 {
    for profile in info.personal.profiles {
      profiles.push(
        box(link(profile.url)[#profile.url.split("//").at(1)]),
      )
    }
  }

  #set text(
    font: uservars.bodyfont,
    weight: "medium",
    size: uservars.fontsize * 1,
  )
  #pad(x: 0em)[
    #profiles.join([#sym.space.en #sym.diamond.filled #sym.space.en])
  ]
]

#let cvheading(info, uservars) = {
  align(center)[
    = #info.personal.name
    #jobtitletext(info, uservars)
    #addresstext(info, uservars)
    #contacttext(info, uservars)
  ]
}

#let cveducation(info, title: "Education", isbreakable: true) = {
  if info.education != none {
    block[
      == #title
      #for edu in info.education {
        let start = utils.strpdate(edu.startDate)
        let end = utils.strpdate(edu.endDate)

        let edu-items = ""
        if edu.honors != none {
          edu-items = edu-items + "- *Honors*: " + edu.honors.join(", ") + "\n"
        }
        if edu.courses != none {
          edu-items = edu-items + "- *Courses*: " + edu.courses.join(", ") + "\n"
        }
        if edu.highlights != none {
          for hi in edu.highlights {
            edu-items = edu-items + "- " + hi + "\n"
          }
          edu-items = edu-items.trim("\n")
        }

        // Create a block layout for each education entry
        block(width: 100%, breakable: isbreakable)[
          // Line 1: Institution and Location
          #if edu.url != none [
            *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \
          ] else [
            *#edu.institution* #h(1fr) *#edu.location* \
          ]
          // Line 2: Degree and Date
          #text(style: "italic")[#edu.studyType in #edu.area] #h(1fr)
          #utils.daterange(start, end) \
          #eval(edu-items, mode: "markup")
        ]
      }
    ]
  }
}

#let cvwork(info, title: "Work Experience", isbreakable: true) = {
  if info.work != none {
    block[
      == #title
      #for w in info.work {
        block(width: 100%, breakable: isbreakable)[
          // Line 1: Company and Location
          #if w.url != none [
            *#link(w.url)[#w.organization]* #h(1fr) *#w.location* \
          ] else [
            *#w.organization* #h(1fr) *#w.location* \
          ]
        ]
        // Create a block layout for each work entry
        let index = 0
        for p in w.positions {
          if index != 0 {
            v(0.6em)
          }
          block(width: 100%, breakable: isbreakable, above: 0.6em)[
            // Parse ISO date strings into datetime objects
            #let start = utils.strpdate(p.startDate)
            #let end = utils.strpdate(p.endDate)
            // Line 2: Position and Date Range
            #text(style: "italic")[#p.position] #h(1fr)
            #utils.daterange(start, end) \
            // Project name
            #pad(y: 0em)[
              #for pr in p.projects [
                #text()[#pr.name]
                // Highlights or Description
                #for hi in pr.highlights [
                  - #eval(hi, mode: "markup")
                ]
              ]
            ]
          ]
          index = index + 1
        }
      }
    ]
  }
}

#let projectEntry(entry, isbreakable: true) = {
  block(width: 100%, breakable: isbreakable)[
    // Line 1: Entry Name with optional URL
    #if entry.url != none [
      *#link(entry.url)[#entry.name]* \
    ] else [
      *#entry.name* \
    ]
    // Summary or Description
    #for hi in entry.highlights [
      - #eval(hi, mode: "markup")
    ]
  ]
}

#let cvcontributions(info, title: "Contributions", isbreakable: true) = {
  if info.contributions != none {
    block[
      == #title
      #for contrib in info.contributions [
        #projectEntry(contrib)
      ]
    ]
  }
}

#let cvprojects(info, title: "Projects", isbreakable: true) = {
  if info.projects != none {
    block[
      == #title
      #for project in info.projects [
        #projectEntry(project)
      ]
    ]
  }
}

#let cvskills(
  info,
  title: "Skills, Languages",
  isbreakable: true,
) = {
  if (info.languages != none) or (info.skills != none) {
    block(breakable: isbreakable)[
      == #title
      #if (info.languages != none) [
        #let langs = ()
        #for lang in info.languages {
          langs.push([#lang.language (#lang.fluency)])
        }
        - *Languages*: #langs.join(", ")
      ]
      #if (info.skills != none) [
        #for group in info.skills [
          - *#group.category*: #group.skills.join(", ")
        ]
      ]
    ]
  }
}


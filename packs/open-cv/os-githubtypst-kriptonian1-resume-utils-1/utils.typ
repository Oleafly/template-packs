#import "@preview/octique:0.1.0": octique-inline

#let spaceBetween = h(1fr)
#let sep = text(" | ")

#let title(body) = text(size: 28pt, weight: "medium")[#body]
#let heading(body) = text(size: 13pt, weight: "bold")[#body]
#let subHeading(body) = text(size: 12pt, weight: "semibold")[#body]
#let bodyText(body) = text(size: 10pt)[#body]

/**
Hide keywords related to job you are applying to
*/
#let keywordHack(body) = text(size: 1pt, white)[#body]

/**
Formats name of the user displayed at the top
*/
#let name(name) = align(center)[
  #block(spacing: 15pt)[
  #title[#{name}]
  ]
]

/**
Formats contact item
*/
#let contactItem(href, body) = link(href)[#underline(offset: 3pt)[#body]]

#let contactBuilder(items: array) = {
  v(-5pt)
  align(center)[
    #bodyText[
      #items.map(item => contactItem(item.href)[#item.text]).join([#sep])
    ]
  ]
}

/**
Formats sections of skills
*/
#let skillBuilder(label, skills) = [
    #subHeading[#{label}:]
    #bodyText[#{skills}]\
]

/**
Format header section
*/
#let sectionHeaderBuilder(title) = [
  #heading[#{title}]
  #v(-10pt)
  #line(length: 100%, stroke: (thickness: 0.5pt))
  #v(-5pt)
]

#let experienceBuilder(
  position: none,
  company: none,
  timeline: (starting: none, ending: none),
  location: none,
  body
) = [
  #subHeading[#{position}] #spaceBetween #text(size: 12pt)[#{timeline.starting} - #{timeline.ending}] \
  #bodyText[_#{company}_] #spaceBetween #bodyText[_#{location}_] \
  #bodyText[
    #body
  ]
]

#let projectBuilder(name: none, stack: none, projectLink: none, body) = [
  #subHeading[#{name}] #sep _#{stack}_ #h(1fr) #link(projectLink)[#underline(offset: 3pt)[link #octique-inline("arrow-up-right")]]
  #bodyText[
    #body
  ]
]

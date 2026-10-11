#import "./utils.typ": *

// Header section with contact information
#let header(personalData) = [
  #text(
    size: 26pt,
    font: "Overpass",
    weight: "bold",
  )[#personalData.name]

  #v(-20pt)
  #text(font: "HK Grotesk", size: 8pt)[#personalData.address]
  #h(2pt) · #h(2pt)
  #link("tel:" + personalData.phone)[
    #underline[#text(font: "HK Grotesk", size: 8pt)[#personalData.phone]]
  ]
  #h(2pt) · #h(2pt)
  #link("mailto:" + personalData.email)[
    #underline[#text(font: "HK Grotesk", size: 8pt)[#personalData.email]]
  ]
  #h(2pt) · #h(2pt)
  #link(personalData.website)[
    #underline[#text(font: "HK Grotesk", size: 8pt)[#personalData.website]]
  ]
  #if personalData.linkedin != none and personalData.linkedin != "" [
    #h(2pt) · #h(2pt)
    #link(personalData.linkedin)[
      #underline[#text(font: "HK Grotesk", size: 8pt)[LinkedIn]]
    ]
  ]
  #if personalData.github != none and personalData.github != "" [
      #h(2pt) · #h(2pt)
      #link(personalData.github)[
        #underline[#text(font: "HK Grotesk", size: 8pt)[GitHub]]
      ]
  ]
  #if personalData.bluesky != none and personalData.bluesky != "" [
    #h(2pt) · #h(2pt)
    #link(personalData.bluesky)[
      #underline[#text(font: "HK Grotesk", size: 8pt)[Bluesky]]
    ]
  ]
]

// Right-aligned header for cover letters
#let headerRight(personalData) = align(end)[
  #text(font: "Overpass", size: 12pt)[#personalData.name]
  #linebreak()
  #text(font: "HK Grotesk", size: 8pt)[#personalData.address]
  #linebreak()
  #text(font: "HK Grotesk", size: 8pt)[#personalData.phone]
  #linebreak()
  #text(font: "HK Grotesk", size: 8pt)[#personalData.email]
  #linebreak()
  #text(font: "HK Grotesk", size: 8pt)[#personalData.website]
  #linebreak()
]

// Section header with line
#let sectionHeader(title) = [
  #heading(level: 2)[#text(font: "HK Grotesk", size: 12pt, weight: "bold")[#title]]
  #line(length: 100%)
]

// Helper to get localized position
#let getPosition(p, lang) = {
  if "position" in p {
    if type(p.position) == dictionary {
      if lang == "de" {
        p.position.at("de", default: p.position.at("en", default: ""))
      } else {
        p.position.at("en", default: "")
      }
    } else {
      str(p.position)
    }
  } else {
    ""
  }
}

// Helper to get localized highlights
#let getHighlights(p, lang) = {
  if "highlights" in p {
    if type(p.highlights) == dictionary {
      if lang == "de" {
        p.highlights.at("de", default: p.highlights.at("en", default: ()))
      } else {
        p.highlights.at("en", default: ())
      }
    } else if type(p.highlights) == array {
      p.highlights
    } else {
      ()
    }
  } else {
    ()
  }
}

// Work experience entry
#let workEntry(organization, location, positions, lang) = {
  let org = if type(organization) == dictionary {
    if organization.at(lang, default: none) != none {
      organization.at(lang)
    } else {
      organization.at("en")
    }
  } else {
    organization
  }
  
  let loc = if type(location) == dictionary {
    if location.at(lang, default: none) != none {
      location.at(lang)
    } else {
      location.at("en")
    }
  } else {
    location
  }
  
  [
    #text(weight: "bold")[#org] #h(1fr) #text(weight: "bold")[#loc]
    #linebreak()
    #for p in positions [
      #text(style: "italic")[#getPosition(p, lang)]; 
      #h(1fr); 
      #daterange(p.startDate, p.endDate, lang);
      #list(
        marker: none,
        tight: true,
        spacing: 8pt,
        ..getHighlights(p, lang)
      )
      #if p.technologies != none [
        #v(-6pt)
        #list(
          marker: none,
          tight: true,
          spacing: 6pt,
          [#text(size: 0.85em, baseline: -0.05em)[#emoji.toolbox] #text(size: 0.92em, weight: "medium")[Technologies:] #h(2pt) #text(style: "italic", size: 0.92em)[#p.technologies]]
        )
      ]
    ]
  ]
}

// Certificate entry
#let certificateEntry(cert) = [
  #v(-2pt)
  #list(tight: true, spacing: 5pt, marker: "·")[
    #text(weight: "bold")[#cert.name] #h(1fr) #text(style: "italic")[#cert.issuer] | #if "id" in cert [ID: #text(font: "MonoLisa", size: 8pt)[#cert.id] | ] #cert.year;
  ]
  #v(-2pt)
]

// Volunteering entry
#let volunteeringEntry(organization, location, position, period, description, lang) = {
  let org = if type(organization) == dictionary {
    if organization.at(lang, default: none) != none {
      organization.at(lang)
    } else {
      organization.at("en")
    }
  } else {
    organization
  }
  
  let pos = if type(position) == dictionary {
    if position.at(lang, default: none) != none {
      position.at(lang)
    } else {
      position.at("en")
    }
  } else {
    position
  }
  
  [
    #text(weight: "bold")[#org] #h(1fr) #location #linebreak()
    #text(style: "italic")[#pos] #h(1fr) #period #linebreak()
    #list(marker: "·", tight: true, spacing: 5pt)[#description]
  ]
}

// Skill entry
#let skillEntry(emoji, category, skills) = [
  #v(-5pt)
  #list(tight: true, spacing: 0.5em, marker: none)[
    #text(weight: "bold")[#emoji #category]: #skills
  ]
]


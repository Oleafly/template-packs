#import "./utils.typ": *
#let base = yaml("./data/data.yml")

// Get language from input parameter (defaults to "en")
#let lang = if "lang" in sys.inputs { sys.inputs.lang } else { "en" }

// Get override data if specified
#let override = if "data" in sys.inputs { 
  let path = sys.inputs.data
  let fullPath = if path.starts-with("data/") {
    "./" + path
  } else if path.starts-with("./") or path.starts-with("/") {
    path
  } else {
    "./" + path
  }
  yaml(fullPath)
} else { 
  (:)
}

#import "./sections.typ": *

// Get UI strings for the current language
#let strings = base.strings.at(lang)

// Document setup
#set page(
  margin: (x: 0.5in, y: 0.5in),
)

// Fonts
#set text(
  font: "Libertinus Serif",
  size: 10pt,
)

#header(base.personal)

// Summary
#sectionHeader(strings.summary)
#safe-get(override, ("summary", lang), default: safe-get(base, ("summary", lang), default: ""))

// Core Competencies
#let competencies = if "core_competencies" in override {
  if type(override.core_competencies) == dictionary {
    override.core_competencies.at(lang, default: ())
  } else {
    override.core_competencies
  }
} else {
  base.core_competencies.at(lang, default: ())
}
#if competencies != none and competencies.len() > 0 [
  #sectionHeader(strings.core_competencies)
  #for competency in competencies [
    · #competency #linebreak()
  ]
  #v(8pt)
]

// Work Experience
#let workExp = if "work_experience" in override {
  override.work_experience
} else {
  base.work_experience
}
#if workExp != none and workExp.len() > 0 [
  #sectionHeader(strings.professional_experience)
  #for w in workExp [
    #workEntry(
      w.organization,
      w.location,
      w.positions,
      lang
    )
  ]
]

// Education
#let edu = if "education" in override {
  override.education
} else {
  base.education
}
#if edu != none [
  #let eduInst = localize(edu.at("institution", default: ""), lang)
  #let eduDegree = localize(edu.at("degree", default: ""), lang)
  #if eduInst != "" or eduDegree != "" [
    #sectionHeader(strings.education)
    *#eduInst* #linebreak()
    #text(style: "italic")[#eduDegree] #h(1fr) #localize(edu.at("period", default: ""), lang)
  ]
]

// Skills
#let skillsData = if "skills" in override {
  override.skills
} else {
  base.skills
}
#if skillsData != none [
  #let backendVal = localize(skillsData.at("backend", default: ""), lang)
  #let archVal = localize(skillsData.at("architecture", default: ""), lang)
  #let apisVal = localize(skillsData.at("apis", default: ""), lang)
  #let dbVal = localize(skillsData.at("databases", default: ""), lang)
  #let devopsVal = localize(skillsData.at("devops", default: ""), lang)
  #let frontendVal = localize(skillsData.at("frontend", default: ""), lang)
  #let collabVal = localize(skillsData.at("collaboration", default: ""), lang)
  #let toolsVal = localize(skillsData.at("tools", default: ""), lang)
  #let mgmtVal = localize(skillsData.at("mgmt", default: ""), lang)
  #let langVal = localize(skillsData.at("languages", default: ""), lang)
  #let hasSkills = backendVal != "" or archVal != "" or apisVal != "" or dbVal != "" or devopsVal != "" or frontendVal != "" or collabVal != "" or toolsVal != "" or mgmtVal != "" or langVal != ""
  #if hasSkills [
    #sectionHeader(strings.skills)
    #skillEntry(emoji.gear, strings.backend, backendVal)
    #skillEntry(emoji.crane, strings.architecture, archVal)
    #skillEntry(emoji.powerplug, strings.apis, apisVal)
    #skillEntry(emoji.cabinet.file, strings.databases, dbVal)  
    #skillEntry(emoji.rocket, strings.devops, devopsVal)
    #skillEntry(emoji.palette, strings.frontend, frontendVal)
    #skillEntry(emoji.hands.shake, strings.collaboration, collabVal)
    #skillEntry(emoji.wrench, strings.tools, toolsVal)
    #skillEntry(emoji.arrows.cycle, strings.management, mgmtVal)
    #skillEntry(emoji.globe.meridian, strings.languages, langVal)
  ]
]

// Courses and Certifications
#let certs = if "certificates" in override {
  override.certificates
} else {
  base.certificates
}
#if certs != none and certs.len() > 0 [
  #sectionHeader(strings.courses_certifications)
  #for cert in certs [
    #certificateEntry(cert)
  ]
]

// Volunteering
#let volData = if "volunteering" in override {
  override.volunteering
} else {
  base.volunteering
}
#if volData != none and volData.len() > 0 [
  #sectionHeader(strings.volunteering)
  #for vol in volData [
    #volunteeringEntry(
      vol.organization,
      vol.location,
      vol.position,
      vol.period,
      localize(vol.at("description", default: ""), lang),
      lang
    )
  ]
]


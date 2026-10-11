#import "utils.typ": *

#let resolve-profile(profiles, profile-name) = {
  let all = get(profiles, "profiles", none)
  get(all, profile-name, none)
}

#let default-section-order = ("education", "work", "projects", "skills")

#let resolve-selection(profiles, profile-name, kind, override: none) = {
  let manual = parse-csv(override)
  if manual.len() > 0 {
    manual
  } else {
    let profile = resolve-profile(profiles, profile-name)
    arr(get(profile, kind, ()))
  }
}

#let resolve-section-order(profiles, profile-name) = {
  let profile = resolve-profile(profiles, profile-name)
  let requested = arr(get(profile, "sectionOrder", ()))
  let ordered = ()

  for section in requested {
    let key = txt(section)
    if default-section-order.contains(key) and not ordered.contains(key) {
      ordered.push(key)
    }
  }

  for section in default-section-order {
    if not ordered.contains(section) {
      ordered.push(section)
    }
  }

  ordered
}

#let load-work-modules(keys) = {
  keys.map(k => yaml("../modules/work/" + k + ".yml"))
}

#let load-project-modules(keys) = {
  keys.map(k => yaml("../modules/projects/" + k + ".yml"))
}

#let build-cv(base, profiles, profile-name, work-override: none, projects-override: none) = {
  let work-keys = resolve-selection(
    profiles,
    profile-name,
    "work",
    override: work-override,
  )
  let project-keys = resolve-selection(
    profiles,
    profile-name,
    "projects",
    override: projects-override,
  )
  let section-order = resolve-section-order(profiles, profile-name)

  (
    personal: get(base, "personal", none),
    education: arr(get(base, "education", ())),
    skills: arr(get(base, "skills", ())),
    languages: arr(get(base, "languages", ())),
    interests: arr(get(base, "interests", ())),
    affiliations: arr(get(base, "affiliations", ())),
    certificates: arr(get(base, "certificates", ())),
    awards: arr(get(base, "awards", ())),
    work: load-work-modules(work-keys),
    projects: load-project-modules(project-keys),
    meta: (
      profile: profile-name,
      work_keys: work-keys,
      project_keys: project-keys,
      section_order: section-order,
    ),
  )
}

#let render-heading(info, uservars) = {
  let p = get(info, "personal", none)
  let name = txt(get(p, "name", ""))
  let show-number = get(uservars, "showNumber", true)

  let contacts = ()

  let email = txt(get(p, "email", ""))
  if has(email) {
    contacts.push(link("mailto:" + email)[#email])
  }

  let phone = txt(get(p, "phone", ""))
  if show-number and has(phone) {
    contacts.push(link("tel:" + phone)[#phone])
  }

  let homepage = txt(get(p, "url", ""))
  if has(homepage) {
    contacts.push(link(homepage)[#display-link(homepage)])
  }

  for profile in arr(get(p, "profiles", ())) {
    let u = txt(get(profile, "url", ""))
    if has(u) {
      contacts.push(link(u)[#display-link(u)])
    }
  }

  align(center)[
    = #name
    #if contacts.len() > 0 [
      #contacts.join([#sym.space.en #sym.diamond.filled #sym.space.en])
      #v(2pt)
    ]
  ]
}

#let render-education(info, isbreakable: true) = {
  let edus = arr(get(info, "education", ()))
  if edus.len() > 0 {
    block[
      == Education
      #set par(leading: 4pt)
      #for edu in edus [
        #block(width: 100%, breakable: isbreakable)[
          #let inst = txt(get(edu, "institution", ""))
          #let loc = txt(get(edu, "location", ""))
          #let url = get(edu, "url", none)
          #let gpa = txt(get(edu, "gpa", ""))
          #let courses = arr(get(edu, "keyCourses", get(edu, "courses", ())))
          #if url != none [
            *#link(url)[#inst]* #h(1fr) *#loc* \
          ] else [
            *#inst* #h(1fr) *#loc* \
          ]
          #text(style: "italic")[#txt(get(edu, "studyType", "")) in #txt(get(edu, "area", ""))] #h(1fr)
          #render-date-range(get(edu, "startDate", none), get(edu, "endDate", none)) \
          #let facts = ()
          #if has(gpa) [
            #facts.push([GPA: #gpa])
          ]
          #if courses.len() > 0 [
            #facts.push([Coursework: #courses.join(", ")])
          ]
          #if facts.len() > 0 [
            #text(size: 9pt)[#facts.join([ | ])]
          ]
        ]
      ]
    ]
  }
}

#let render-work(info, isbreakable: true) = {
  let works = arr(get(info, "work", ()))
  if works.len() > 0 {
    block[
      == Professional Experience
      #for w in works [
        #block(width: 100%, breakable: isbreakable)[
          #set par(leading: 4pt)
          #let org = txt(get(w, "organization", ""))
          #let loc = txt(get(w, "location", ""))
          #let url = get(w, "url", none)
          #if url != none [
            *#link(url)[#org]* #h(1fr) *#loc* \
          ] else [
            *#org* #h(1fr) *#loc* \
          ]
        ]

        #for p in arr(get(w, "positions", ())) [
          #block(width: 100%, breakable: isbreakable, above: 0.35em)[
            #set par(leading: 4pt)
            #text(style: "italic")[#txt(get(p, "position", ""))] #h(1fr)
            #render-date-range(get(p, "startDate", none), get(p, "endDate", none)) \
            #for hi in arr(get(p, "highlights", ())) [
              - #eval(hi, mode: "markup")
            ]
          ]
        ]
      ]
    ]
  }
}

#let render-projects(info, isbreakable: true) = {
  let projects = arr(get(info, "projects", ()))
  if projects.len() > 0 {
    block[
      == Projects
      #for p in projects [
        #block(width: 100%, breakable: isbreakable)[
          #set par(leading: 4pt)
          #let name = txt(get(p, "name", ""))
          #let url = get(p, "url", none)
          #if url != none and txt(url) != "none" [
            *#link(url)[#name]* \
          ] else [
            *#name* \
          ]
          #text(style: "italic")[#txt(get(p, "affiliation", ""))] #h(1fr)
          #render-date-range(get(p, "startDate", none), get(p, "endDate", none)) \
          #for hi in arr(get(p, "highlights", ())) [
            - #eval(hi, mode: "markup")
          ]
        ]
      ]
    ]
  }
}

#let render-skills(info, isbreakable: true) = {
  let groups = arr(get(info, "skills", ()))
  if groups.len() > 0 {
    block(breakable: isbreakable)[
      == Skills
      #let rows = ()
      #for group in groups [
        #let category = txt(get(group, "category", ""))
        #let values = arr(get(group, "skills", ()))
        #if values.len() > 0 [
          #if category == "" or lower(category) == "none" [
            #rows.push([#values.join(", ")])
          ] else [
            #rows.push([*#category*: #values.join(", ")])
          ]
        ]
      ]
      #for row in rows [
        #row \
      ]
    ]
  }
}

#let render-sections(info) = {
  let meta = get(info, "meta", none)
  let section-order = arr(get(meta, "section_order", default-section-order))

  for section in section-order {
    if section == "education" [
      #render-education(info)
    ] else if section == "work" [
      #render-work(info)
    ] else if section == "projects" [
      #render-projects(info)
    ] else if section == "skills" [
      #render-skills(info)
    ]
  }
}

#let render-endnote(info) = {
  let meta = get(info, "meta", none)
  let profile = txt(get(meta, "profile", ""))
  place(
    bottom + right,
    block[
      #set text(size: 5pt, font: "Times New Roman", fill: silver)
      \*This document was built on #datetime.today().display("[year]-[month]-[day]") with profile #profile.
    ],
  )
}

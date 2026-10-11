#let chip(body, txColor: black, bgColor: white) = {
  box(fill: bgColor, stroke: black, radius: 15%, inset: 5pt)[#text(fill: txColor)[#body]]
}

#let double_chip(data) = {
  (
    box(stroke: black, radius: (left: 15%), inset: 5pt)[#data.at(0)],
    box(stroke: black, radius: (right: 15%), inset: 5pt)[#data.at(1)]
  ).join()
}

#let split_chip(body1, body2, txColor: (black, black), bgColor: (white, white)) = {
  (
    box(
      stroke: (left: black, top: black, bottom: black),
      radius: (left: 15%),
      fill: bgColor.at(0),
      inset: (left: 5pt, top: 5pt, bottom: 5pt)
    )[#text(fill: txColor.at(0))[#body1]],
    box(
        stroke: (right: black, top: black, bottom: black),
        radius: (right: 15%),
        fill: bgColor.at(1),
        inset: (right: 5pt, top: 5pt, bottom: 5pt)
    )[#text(fill: txColor.at(0))[#body2]]
  ).join()
}

#let chips = (
  go: chip(bgColor: rgb("#6AD7E5"))[Go],
  python: split_chip(bgColor: (blue, yellow))[Pyt][hon],
  cpp: chip(txColor: white, bgColor: rgb("#0080CD"))[C++],
  c: chip(txColor: white, bgColor: rgb("#5B6ABE"))[C],
  django: chip(txColor: white, bgColor: rgb("#0F3D2D"))[Django],
  fastapi: chip(txColor: white, bgColor: rgb("#009485"))[FastAPI],
  jquery: chip(txColor: white, bgColor: rgb("#0769AD"))[jQuery],
  postgres: chip(bgColor: rgb("#699ECA"))[PostgreSQL],
  mongo: chip(txColor: white, bgColor: rgb("#023430"))[MongoDB],
  rabbitmq: chip(bgColor: rgb("#FF6600"))[RabbitMQ],
  redis: chip(txColor: white, bgColor: rgb("#D9271B"))[Redis],
  grpc: chip(txColor: white, bgColor: rgb("#244C5A"))[gRPC],
  docker: chip(bgColor: rgb("#0092E6"))[Docker],
  ci: chip()[CI],
  github: chip(txColor: white, bgColor: black)[GitHub],
)

#let CV(lang, personalInfo, languages, jobs, education, projects, certifications) = {
  set document(
    title: [#personalInfo.name - CV],
    author: personalInfo.name,
  )
  set page(paper: "a4", margin: 2cm)
  set text(font: "Carlito", size: 12pt, lang: lang)

  let secondary = rgb("#828282")

  let experienceTitle(body) = [
    #text(size: 1.25em)[*#body*]
  ]

  let chips(data) = [
    #data.join(h(3pt))
  ]

  let date(dateFrom, dateTo: none) = [
    #set text(secondary)
    #box(baseline: 0.15em, image("icons/calendar.svg", height: 1em))
    #text(dateFrom)
    #if dateTo != none {
      text("- "+dateTo)
    }
  ]

  let link(icon, link) = (
    align(center)[#box(image(icon, height: 1.5em))],
    text(baseline: 0.35em, link)
  )

  let links(data) = [
    #let d = data.map(l => link(l.icon, l.link)).flatten()
    #table(columns: 2, stroke: none, ..d)
  ]

  let langs(data) = [
    #underline(offset: 0.25em)[= #data.title]
    #v(5pt)
    #data.langs.map(d => double_chip(d)).join(linebreak())
  ]

  let job(data) = [
    #experienceTitle[#data.title]\
    #if data.keys().contains("company") [
      *#data.company*\
    ]
    #if data.keys().contains("description") {
      data.description
    }
    #if data.keys().contains("chips") {
      v(-5pt)
      chips(data.chips)
    }
    #linebreak()
    #date(data.dateFrom, dateTo: data.dateTo)
  ]

  let project(data) = [
    #experienceTitle[#data.title]\
    #data.link\
    #data.description
    #v(-5pt)
    #chips(data.chips)
  ]

  let certification(data) = [
    #experienceTitle[#data.title]\
    *#data.issuer*\
    #date(data.date)
  ]

  let experience(data, func) = [
    #grid(columns:(2.2fr, 13fr), {
      if data.keys().contains("logo") {
        box(inset: (top: -5pt))[#image(data.logo, height: 2.8em)]
      }
    }, {
      func(data)
    })
  ]

  let experiences(title, func, data) = [
    #underline(offset: 0.25em)[= #title]
    #v(5pt)
    #data.map(dt => experience(dt, func)).join(v(5pt))
  ]

  // Page 1
  grid(rows: (1fr, 9fr),
    {
      text(size: 2.5em)[*#personalInfo.degrees.join(" ") #personalInfo.name*]
      linebreak()
      if sys.inputs.at("jobTitle", default: "") != "" {
        text(secondary, size: 1.7em)[*#sys.inputs.jobTitle*]
      }
      line(length: 100%)
    },{
      grid(columns: (1.8fr, 3.5fr), {
          image(personalInfo.photo, width: 80%)
          links(personalInfo.links)
          langs(languages)
        },{
          experiences(jobs.title, job, jobs.jobs)
        }
      )
    }
  )

  // Page 2
  grid(columns: (1.8fr, 3.5fr), {
    },{
      experiences(education.title, job, education.education)
      experiences(projects.title, project, projects.projects)
      experiences(certifications.title, certification, certifications.certs)
    }
  )
}

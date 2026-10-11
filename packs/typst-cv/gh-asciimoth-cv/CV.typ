#import "@preview/flagada:0.2.0" : *
#import "@preview/cmarker:0.1.5"

#let cont = yaml("content.yml")

#let bullet = "-"

#if "bullet" in cont.style {
  bullet = cont.style.bullet
}

#let primcol(term) = {
  text(rgb(cont.palette.primary), box[#term])
}

#set document(
  title: cont.contacts.name + "'s CV",
  author: cont.contacts.name,
)
#set page(
  fill: rgb(cont.palette.page),
  margin: (
    x: 1cm*cont.style.x_margin,
    y: 1cm*cont.style.y_margin,
  ),
)

#set text(
  1pt*cont.style.text,
  font: cont.style.font,
)

#let icon(name, shift: 1pt*cont.style.icon_shift) = {
  box(
    baseline: shift,
    height: 1.1pt*cont.style.text,
    image("icons/" + name + ".svg", alt: "AAAAA")
  )
  h(1pt*cont.style.text/3)
}

#let bottomText(txt) = {
  set align(center)
  set text(
    1pt*cont.style.bottom_text,
  )
  txt
}


#let title(term, sub) = {
  pad(text(
    1pt*cont.style.title,
    rgb(cont.palette.grid),
    rect(
      fill: rgb(cont.palette.primary),
      width: auto,
      inset: 0% + 6pt,
      outset: 0%,
      box[= #term]+linebreak()+box[#sub],
    ),
    bottom-edge: "bounds"
  ), y: -0.5pt*cont.style.text)
}

#let head(term) = {
  text(rgb(cont.palette.page), rect(
    fill: rgb(cont.palette.primary),
    width: auto,
    inset: 0% + 4pt,
    box[== #term]
  ))
}

#let p(h, t) = {
  head(h)
  box[#t]
}

// TODO: Date formatting
#let period(per) = {
  let to = "present"
  if "to" in per {
    to = per.to
  }
  icon("calendar")
  box[#per.from --- #to]
}

#let fjob(job) = {
  let place = ""
  let product = ""
  let position = ""
  if "place" in job {
    place = job.place+" "
  }
  if "product" in job {
    product = "("+job.product+") "
  }
  if "position" in job {
    position = job.position
    if ("place" in job) or ("product" in job) {
      position = "| "+position
    }
  }
  box[=== #place#product#position]
}

#let textOrList(data) = {
  if type(data) == str {
    //box[#data]
    cmarker.render(data)
  } else {
    for elem in data {
      box[#bullet #elem]
      linebreak()
    }
  }
}

#let location(data) = {
  let loc = "Remote"
  if "location" in data {
    loc = data.location
  }
  icon("location")
  box[#loc]
}

#let progress(percent) = {
  let rad = 1em*cont.style.bar_rad
  let rightRad = 0
  let leftRad = 0
  if percent == 100 {
    rightRad = 1
  }
  if percent == 0 {
    leftRad = 1
  } else {
    box(rect(
      height: 1em*cont.style.bar_height,
      width: (1em*cont.style.bar_length/100)*percent,
      stroke: rgb(cont.palette.primary),
      fill: rgb(cont.palette.primary),
      radius: (left: rad, right: rad*rightRad)
    ))
  }
  if percent < 100 {
    box(rect(
      height: 1em*cont.style.bar_height,
      width: (1em*cont.style.bar_length/100)*(100-percent),
      stroke: rgb(cont.palette.primary),
      fill: rgb(cont.palette.grid),
      radius: (left: rad*leftRad, right: rad)
    ))
  }
}

#let bulletSeparate(elements) = {
  for elem in elements {
    box[#(bullet+" "+elem+" ")]
  }
}

#let fskill(name, percent) = {
  box[#name]
  h(1fr)
  progress(percent)
}

#let fskills(skills) = {
  for skill in skills {
    fskill(skill.name, skill.percent)
    linebreak()
  }
}

#let flangs(langs) = {
  for (lang, lvl) in langs {
    box[#flag(upper(lang)) #lvl #h(1pt*cont.style.text)]
  }
}

#let flinks(links) = {
  for lnk in links {
    if "ico" in lnk {
      icon(lnk.ico)
    }
    if "url" in lnk {
      link(lnk.url)[#lnk.text]
    }else{
      box[#lnk.text]
    }
    h(1pt*cont.style.text)
  }
}

#set rect(
  fill: rgb(cont.palette.grid),
  width: 100%,
  inset: 0% + 1pt*cont.style.grid_inset,
)

#title[#cont.contacts.name][#cont.contacts.title]
#location(cont.contacts)#h(1fr)#flinks(cont.contacts.links)

#show link: set text(fill: rgb(cont.palette.links))

#cont.about

#grid(
  columns: (7fr, 4.5fr),
  column-gutter: 1em,
  rect[
    #p[Commercial experience][
      #for job in cont.experience [
        #fjob(job) #linebreak()
        #period(job) #h(1fr) #location(job)
        #linebreak()
        #textOrList(job.descritpion)

      ]
    ]
    #if ("other_experience" in cont) [
      #p[Other experience][
        #for blk in cont.other_experience [
          === #blk.title
          #textOrList(blk.text)
        ]
      ]
    ]
  ],
  rect[
    #if ("objective" in cont) [
      #p[Objective][#textOrList(cont.objective)]
    ]
    #if ("expertise" in cont) [
      #p[Expertise][#fskills(cont.expertise)]
    ]
    #if ("skills" in cont) [
      #p[Skills][#bulletSeparate(cont.skills)]
    ]
    #if ("methodology" in cont) [
      #p[Methodology][#bulletSeparate(cont.methodology)]
    ]
    #if ("tools" in cont) [
      #p[Tools][#bulletSeparate(cont.tools)]
    ]
    #if ("langs" in cont) [
      #p[Languages][#flangs(cont.langs)]
    ]
    // TODO
    #if ("achievements" in cont) [
      #p[Achievements][#textOrList(cont.achievements)]
    ]
    #linebreak()#linebreak()
  ],
)
#align(bottom)[
  #if ("consent" in cont) [
    #bottomText(cont.consent)
  ]
]

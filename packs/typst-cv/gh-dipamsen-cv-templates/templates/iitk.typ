#import "@preview/fontawesome:0.5.0": fa-icon


#let section(title: "", body) = {
  heading(title, level: 2)
  body
}

#let project(body, ..args) = {
  let title = args.at("title")
  let url = args.at("url", default: none)
  let attr = args.at("attr", default: none)
  let dur = args.at("dur", default: none)
  let from = args.at("from", default: none)
  let to = args.at("to", default: none)
  if url == none {
    strong(title)
  } else {
    show: link.with(url)
    strong(title)
    [ ]
    box(fa-icon("github"))
  }
  if attr != none {
    [ | ]
    attr
  }
  if dur != none {
    h(1fr)
    emph(dur)
  } else if from != none and to != none {
    h(1fr)
    emph[#from #sym.dash.en #to]
  }
  body
}

#let resume(body, ..args) = {
  set text(font: "New Computer Modern", 11pt)
  
  set page(margin: 0.7cm)

  let name = args.at("name")
  let tagline = args.at("tagline")
  let dept = args.at("dept")
  let email = args.at("email", default: none)
  let phone = args.at("phone", default: none)
  let github = args.at("github", default: none)
  let linkedin = args.at("linkedin", default: none)

  set table(inset: 0.4em, stroke: 0.5pt)

  show heading.where(level: 2): it => {
    set block(above: 0.5em, below: 0.5em)
    block(it.body, fill: luma(210), width: 100%, inset: (x: 0.3em, y: 0.4em))
  }

  set list(marker: ([\u{25cf}], [\u{26AC}]))

  let name-el = {
    set text(1.67em, weight: "bold", bottom-edge: "descender")
    block(name)
  }
  let email-el = if email != none {link("mailto:" + email)[#fa-icon("envelope", solid: true) #email]}
  let phone-el = if phone != none [#fa-icon("phone", solid: true) #phone]
  let github-el = if github != none { link(github.at("url"))[#fa-icon("github") #github.at("username")] }
  let linkedin-el = if linkedin != none {link(linkedin.at("url"))[#fa-icon("linkedin") #linkedin.at("username")]}

  let contacts1 = (email-el, phone-el).filter(i => i != none).join([ | ])
  let contacts2 = (github-el, linkedin-el).filter(i => i != none).join([ | ])
  
  grid(
    columns: (1fr, auto), 
    row-gutter: 0.65em, 
    align: (left, right),
    grid.cell(colspan: 2, name-el), 
    tagline, 
    contacts1,
    dept,
    contacts2
  )
  {
    set block(spacing: 0.65em)
    line(length: 100%)
  }
  
  
  body
} 

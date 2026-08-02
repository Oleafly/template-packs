#let resume_config = state("resume_config", (
  theme: (line: red, accent: blue),
  block_spacing: (above: 0.7em, below: 1em),
  font: (family: "New Computer Modern", size: 11pt),
))

#let make_config(
  line: red,
  accent: blue,
  block_above: 0.7em,
  block_below: 1em,
  font: "New Computer Modern",
  font_size: 11pt,
) = (
  theme: (line: line, accent: accent),
  block_spacing: (above: block_above, below: block_below),
  font: (family: font, size: font_size),
)

#let icons = (
  phone: "phone.svg",
  email: "email.svg",
  site: "site.svg",
  linkedin: "linkedin.svg",
  github: "github.svg",
  location: "location.svg",
)

#let set_config(body: (theme: none, block_spacing: none, font: none)) = {
  resume_config.update(old => (
    theme: if body.theme != none {
      (
        line: if body.theme.at("line", default: none) != none { body.theme.line } else { old.theme.line },
        accent: if body.theme.at("accent", default: none) != none { body.theme.accent } else { old.theme.accent },
      )
    } else { old.theme },
    block_spacing: if body.block_spacing != none {
      (
        above: if body.block_spacing.at("above", default: none) != none { body.block_spacing.above } else { old.block_spacing.above },
        below: if body.block_spacing.at("below", default: none) != none { body.block_spacing.below } else { old.block_spacing.below },
      )
    } else { old.block_spacing },
    font: if body.font != none {
      (
        family: if body.font.at("family", default: none) != none { body.font.family } else { old.font.family },
        size: if body.font.at("size", default: none) != none { body.font.size } else { old.font.size },
      )
    } else { old.font },
  ))
}

#let apply_config(cfg) = set_config(body: cfg)

#let edit_date() = {
  let date = datetime.today().display("[month repr:long] [year]")
  place(top + right, dy: -10pt, block[
    #set text(style: "italic", size: 7pt, font: "DejaVu Sans Mono", fill: gray)
    \Last updated in #(lower(date))
  ])
}

#let resume(body) = {
  set list(indent: 1em)
  show list: set text(size: 0.92em)
  // show link: underline
  // show link: set underline(offset: 3pt)

  set page(paper: "us-letter", margin: (x: 0.5in, y: 0.5in), numbering: (page, pages) => {
    set text(fill: gray, style: "italic")
    str(page) + " / " + str(pages)
  })
  edit_date()

  context {
    let cfg = resume_config.get()
    set text(font: cfg.font.family, size: cfg.font.size)
    body
  }
}

#let create_link(link) = {
  "https://" + link
}

#let center_alignment(body) = {
  align(center, body)
}

#let contacts(body) = {
  center_alignment(body)
  // v(-3pt)
}

#let name_header(name, link: none, github: "", linkedin: "", site: "") = {
  context {
    let cfg = resume_config.get()
    let resolved_link = if link != none { link }
      else if github != "" { create_link("github.com/" + github) }
      else if linkedin != "" { create_link("linkedin.com/in/" + linkedin) }
      else if site != "" { create_link(site) }
      else { none }
    set text(size: 2.25em, fill: cfg.theme.accent)
    if resolved_link != none {
      std.link(resolved_link)[*#name*]
    } else {
      [*#name*]
    }
  }
}

#let contact_item(image, content, link: none, image_baseline: 0.15em, image_height: 0.8em) = box[#box(baseline: 0.20em, std.image("images/" + image), height: 1em)#h(0.2em)#if link != none {
    std.link(link)[#content]
  } else {
    content
  }#h(0.5em)]

#let header(name: "Jake Ryan", link: none, phone: "", email: "", linkedin: "", github: "", site: "", location: "") = {
  center_alignment[
    #v(7pt)
    #name_header(name, link: link, github: github, linkedin: linkedin, site: site)
    #v(-10pt)
  ]
}

#let resume_content(content) = {
  set block(above: block_spacing.above, below: block_spacing.below)
  content
}

#let resume_heading(txt) = {
  context {
    let cfg = resume_config.get()
    show heading: set text(size: 0.92em, weight: "regular", fill: cfg.theme.accent)
    //smallcaps()
    block[
      #v(4pt)
      = #txt
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + cfg.theme.line)
      #v(-1pt)
    ]
  }
}

#let section(name, content) = {
  resume_heading(name)
  resume_content(content)
}

#let item_block() = {
  context {
    let cfg = resume_config.get()
    set block(above: cfg.block_spacing.above, below: cfg.block_spacing.below)
  }
}

#let edu_item(
  name: "Sample University",
  degree: "B.S in Bullshit",
  location: "Foo, BA",
  date: "Aug. 1600 - May 1750",
  ..content,
) = {
  item_block()

  pad(left: 1em, right: 0.5em, box[
    #grid(columns: (3fr, 1fr), align(left)[
      *#name* \
      _#degree _
    ], align(right)[
      #location \
      _#date _
    ])

    #if content != none {
      list(..content)
    }
  ])
}

#let exp_item(
  name: "Sample Workplace",
  role: "Worker",
  date: "June 1837 - May 1845",
  location: "Foo, BA",
  description: none,
  stack: none,
  ..points,
) = {
  item_block()
  pad(left: 1em, right: 0.5em, box[
    #grid(columns: (3fr, 1fr), align(left)[
      *#role* \
      _#name _
    ], align(right)[
      #date \
      _#location _
    ])

    #let left_pad = 0.8em
    #if description != none {
      pad(left: left_pad)[#description]
    }
    #list(..points)

    #if stack != none {
      pad(left: left_pad)[
        Stack: _#stack _
      ]
    }
  ])
}

#let project_item(name: "Example Project", skills: "Programming Language 1, Database3", date: "May 1234 - June 4321", ..points) = {
  item_block()
  pad(left: 1em, right: 0.5em, box[
    *#name* | _#skills _ #h(1fr) #date
    #list(..points)
  ])
}

#let skill_item(category: "Skills", skills: "Balling, Yoga") = {
  item_block()
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[*#category*: #skills])
}

#let lang_item(lang: "English", level: "Native") = {
  item_block()
  pad(left: 1em, right: 0.5em, block[ *#lang*: #level ])
}

#let github_item(username) = {
  contact_item(icons.github, username, link: create_link("github.com/" + username))
}

#let linkedin_item(username) = {
  contact_item(icons.linkedin, username, link: create_link("linkedin.com/in/" + username))
}

#let email_item(email) = {
  contact_item(icons.email, email, link: "mailto:" + email)
}

#let phone_item(phone) = {
  contact_item(icons.phone, phone, link: "tel:" + phone)
}

#let location_item(place) = {
  contact_item(icons.location, place, link: "https://maps.google.com/?q=" + place)
}


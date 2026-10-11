#let portfolio = yaml("portfolio.yaml")
#let settings = yaml("settings.yaml")

#show link: set text(blue)

#show heading: h => [
  #set text(
    size: eval(settings.font.size.heading_large),
    font: settings.font.general
  )
  #h
]

#let sidebarSection = {[
  #par(justify: true)[

    #par[
      #set text(
        size: eval(settings.font.size.contacts),
        font: settings.font.minor_highlight,
      )
      
      Email: #link("mailto:" + portfolio.contacts.email) \
      Phone: #link("tel:" + portfolio.contacts.phone) \
      LinkedIn: #link(portfolio.contacts.linkedin)[mikhail-liamets] \
      GitHub: #link(portfolio.contacts.github)[caffeintazedgaze] \
      
      #portfolio.contacts.address
    ]
    #line(length: 100%)
  ]

  = Summary

  #par[
    #set text(
        eval(settings.font.size.education_description),
        font: settings.font.minor_highlight,
    )
    An experienced *software engineer* with a confident grasp of *infrastructure*, *system design*, and *DevOps*, now seeking opportunities to excel in the realms of solution architecture.

    Open to roles ranging from *software engineering* to *DevOps/SRE*.
  ]

  = Education

  #{
    for place in portfolio.education [
        #par[
          #set text(
            size: eval(settings.font.size.heading),
            font: settings.font.general
          )
            #place.from – #place.to \
            #link(place.university.link)[#place.university.name]
        ]
        #par[
          #set text(
            eval(settings.font.size.education_description),
            font: settings.font.minor_highlight,
          )
          #place.degree #place.major
        ]
    ]
  }

  = Skills

  #{
    for skill in portfolio.skills [
      #par[
        #set text(
          size: eval(settings.font.size.description),
        )
        #set text(
          // size: eval(settings.font.size.tags),
          font: settings.font.minor_highlight,
        )
        *#skill.name* 
        #linebreak()
        #skill.items.join(" • ")
      ]
    ]
  }
]}

#let mainSection = {[

  // #par[
  //   #set align(center)
  //   #figure(
  //     image("images/Kodak 20 Zanvoort Lumi.jpg", width: 6em),
  //     placement: top,
  //   )
  // ]

  #par[
    #set text(
      size: eval(settings.font.size.heading_huge),
      font: settings.font.general,
    )
    *#portfolio.contacts.name*
  ]

  #par[
    #set text(
      size: eval(settings.font.size.heading),
      font: settings.font.minor_highlight,
      top-edge: 0pt
    )  
    #portfolio.contacts.title
  ]

  = Experience

  #{
    for job in portfolio.jobs [
      #par(justify: false)[
        #set text(
          size: eval(settings.font.size.heading),
          font: settings.font.general
        )
          #job.from – #job.to \
          
          *#job.position*
          #link(job.company.link)[\@  #job.company.name]    
      ]
      #par(
        justify: false,
        leading: eval(settings.paragraph.leading)
      )[
        #set text(
          size: eval(settings.font.size.description),
          font: settings.font.general
        )
        #{
          for point in job.description [
            #h(0.5cm) • #point \
          ]
        }
      ]
      #par(
        justify: true,
        leading: eval(settings.paragraph.leading),
      )[
        #set text(
          size: eval(settings.font.size.tags),
          font: settings.font.minor_highlight
        )
      ]
    ]
  }
]}

#{
  grid(
    columns: (2fr, 5fr),
    column-gutter: 3em,
    sidebarSection,
    mainSection,
  )
}

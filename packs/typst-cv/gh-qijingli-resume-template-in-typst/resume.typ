#let content = yaml("content.yaml")
#let par-leading = 4pt
#let font-highlight = "Helvetica Neue" 
#let heading-font-size = 13pt
#let font-general = "Helvetica Neue"
#let font-size = (
  heading-huge : 19pt,
  heading-large : 16pt,
  heading : 12pt,
  desc : 8pt,
  contact : 8pt
)

#show link : set text(blue)

#show heading : h => [
  #set text(
    size : 16pt, 
    font : font-highlight 
  )
  #h
]

#let main = {
[
  #line(length : 100%)

  = Profile 
    #content.profile

  = Education
  #{
    for place in content.education [
        #par[
            #set text(
                size : font-size.heading,
                font : font-general 
            )

            #place.degree #place.major
            #grid(
                columns : (5fr, 2fr),
                column-gutter : 3em,
                link( place.university.link )[ #place.university.name ],
                [ #place.from - #place.to ]
            )
        ] 
    ]
  }

  = Skills
  #{
    for skill in content.skills [
      #par[
        #set text(
          size : font-size.desc,
        )
        #set text(
          font : font-highlight,
        )
        *#skill.name* 
        #linebreak()
        #skill.items.join(" • ")
      ]
    ]
  }

  = Work experiences
  #{
    for job in content.jobs [
      #par(justify : false)[
        #set text(
          size : font-size.heading,
          font : font-general 
        )
        #grid(
            columns : (5fr, 2fr, 3fr),
            column-gutter : 3em,
            [*#job.position* \ #link(job.company.link)[\@  #job.company.name]],
            [#job.job-type],
            [#job.from – #job.to ]
        )
      ]

      #par(
        justify : false,
        leading : par-leading 
      )[
        #set text(
          size : font-size.desc, 
          font : font-general 
        )
        #{
          for project in job.projects {
            par[
                #let descpt = project.description
                #if descpt.len() > 0 [
                    #descpt  \
                ]
                #let key-achievs = project.key-achievements
                #if key-achievs.len() > 0 {
                  [ \ *Highlights:* \ ]  
                  for point in key-achievs [
                    • #point \
                  ]
                }
            ]
          }
        }
      ]
    ]
  }

]}

#set page(numbering: "1/1")

/* Name, title and contact */
#{
  grid(
    columns : (5fr, 3fr),
    column-gutter : 3em,
    par()[
        #text(
              size : font-size.heading-huge,
              font : font-general,
             
        )[ *#content.name* ]

        #text(
          size : font-size.heading,
          font : font-highlight,
          top-edge : 0pt
        )[ #content.title ]
    ],

    par()[
      #set text(
        size : 8pt, 
        font : font-highlight, 
      )

      /* The contacts are key-value pairs */
      #for (k, v) in content.contacts { 
        /* Capitalize the first letter*/
        let item = upper(k.first()) + k.slice(1)
        if "email" in lower(k) [
            #item : #link("mailto:" + v) \
        ] else if "phone" in lower(k) or "tel" in lower(k) [
            #item : #link("tel:" + v) \
        ] else if "linkedin" in lower(k) [
            #item : #link(v)
        ] else [
            #item : #v \ 
        ]
    
      }
    ]
  )
}

/* Profile, Skills, Education, Work Experiece */ 
#main

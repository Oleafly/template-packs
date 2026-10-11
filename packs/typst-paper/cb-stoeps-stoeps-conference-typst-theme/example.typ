#import "stoeps-conference.typ": *
#show: show-theorion

#let date = datetime(
  year: 2026,
  month: 3,
  day: 28,
)
// Title and subtitle of presentation
#let title = [Session Title] 
#let subtitle = [Subtitle]
#let author = [Author]

// Logo
// Logo filename if needed
// #let logo = ""
// End //

#pdfpc.config(
  duration-minutes: 50,
  start-time: datetime(hour: 15, minute: 0, second: 0),
  last-minutes: 5,
  note-font-size: 14,
  disable-markdown: false,
  default-transition: (
    type: "box",
    duration-seconds: 1,
    angle: rtl,
    alignment: "vertical",
    direction: "outward",
  ),
)

#show: stoeps-conference-theme.with(
  aspect-ratio: "16-9",
  config-common(
    frozen-counters: (theorem-counter,),
    zero-margin-header: true,
  ),
  config-info(
    title: title,
    subtitle: subtitle,
    author: author,
    date: date.display(),
    institution: none,
    // logo: image(logo, width: 4cm),
  ),
  config-store(
    header-right: none,
    sidebar-text: "Sidebar Text",
  ),
  config-page(
    margin: (top: 3.0em),
  ),
  config-colors(
    primary: rgb(8, 106, 145),
    secondary: rgb(37, 173, 218),
    tertiary: rgb(115, 182, 191),
    neutral-lightest: rgb(255, 255, 255),
    neutral-darkest: rgb(0, 0, 0),
  )
)

/////////////// Presentation start ///////////////
// Title slide
#title-slide()


// Author 
== Givenname Surname
#slide[ 
  #grid(
  columns: (1fr, 3fr),
  gutter: 1em,
  [
#align(center)[#image("mojtaba-mosayebzadeh-V9mVXYKGyxc-unsplash.jpg",width: 3cm)]
#align(center, block[
#set text(12pt)
  #align(left, block[
  #fa-square-envelope()#h(5mm)#link("mailto:")[Your mail] \
  #fa-linkedin()#h(5mm)#link("https://linkedin.com/in/")[LinkedIn] \
  #fa-rss-square()#h(5mm)#link("https://example.com")[Blog] \
  #fa-mastodon()#h(5mm)#link("https://")[\@example\@example.com] \
  #v(-1mm)*m*#h(5mm)#link("https://matrix.to/#/@name:server")[Matrix Address] \
])])],
   [
- Explain about you
  ])
  #align(center + bottom)[*Some slogan*]
]

#pdfpc.speaker-note(
```md
- Your speaker notes
```
)

// agenda
/*
 * == Agenda <touying:hidden>
 *
 * #set outline(depth: 1)
 * #components.adaptive-columns(outline(title: none, indent: 1em))
 */

/*
 * Add a description why you want to talk about curl
 * curl is installed nearly everywhere
 */ 

== First Slide

- #lorem(20)

== Lösung

- #lorem(4)
- #lorem(4)
- #lorem(4)

= Section Slide

== Daten und Fakten
#slide[
  #grid(
    columns: (3fr, 2fr),
    gutter: 0.1em,
    [
    #lorem(20)
    ],[
) 
    ])
]
// Your slides
== History

#let events = (
  (date: "11. November 1996", desc: "Rafael Sagula veröffentlicht HttpGet version 0.1"),
  (date: "17. Dezember 1996", desc: "HttpGet 0.2, Daniel Stenberg"),
  (date: "Januar 1997", desc: "HttpGet 0.3, HTTP Urls in Kommandozeile"),
  
)
#timeline(events, theme: (
  colors: (
    accent: rgb("#2980b9"),  // Blue instead of red
    muted: rgb("#555555"),
    line: rgb("#aaaaaa"),
  ),
  sizes: (
    date: 14pt,
    body: 12pt,
    dot: 6pt,
    line-width: 3pt,
  ),
  spacing: (
    row: 0.5em,
  ),
))

#slide[
  #grid(
    columns: (3fr, 2fr, 3fr),
    gutter: 1em,
    [
      #align(left)[
        #v(2em)
        
        *Links:*
      #v(0.5em)
        - #link("https://github.com/curl/curl")[GitHub curl/curl]
      ]
    ],
    [
    #align(center)[
      #v(5em)
      = Fragen
    ]
  ],
    [
      #align(right)[
        #v(2em)
        // #image("images/stoeps.png", width: 3cm)
        
        #text(size: 12pt)[
        Add some links here
        ]
      ]
    ]
  )
]

#pdfpc.speaker-note(
```md
- Zeit für Fragen und Diskussion
- Links zu allen wichtigen Projekten
- Kontaktdaten für weitere Fragen
```
) 

#appendix[
  #show bibliography: set text(size: 0.6em)
  #show bibliography: set par(justify: false)
  #show heading: set heading(outlined: false)
  //#bibliography("includes/hayagriva.yml", style: "nature", title: "Quellen und Links")
  
== Quellen und Links
// #bibliography("includes/hayagriva.yml", style: "ieee", title: none)

== Community und Ressourcen

  - #lorem(6)
  - #lorem(6)
  - #lorem(6)

]

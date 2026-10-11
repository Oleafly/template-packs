#import "config.typ": primary_color, accent_color, at_text, format_date

#let experience_data = json("data/experience.json")

#for experience in experience_data [
  #text(fill: primary_color, weight: 600, size: 1.1em)[#experience.position #at_text #experience.company]
  #h(1fr)
  #text(fill: accent_color, weight: 600, size: 1em)[#format_date(experience.from) — #format_date(experience.to) #h(.2em) #text(size: 1.3em, baseline: 0.12em)[•] #h(.2em) #experience.location]
  #v(-0.4em)

  #text(weight: 600)[#experience.short_description]
  #v(-0.3em)

  #if experience.description.len() > 0 [
    #list(
      marker: text(size: 1.5em, baseline: -0.1em)[•],
      ..experience.description.map(desc => {
        if desc != "" {
          [#desc]
          v(0.3em)
        }
      }).filter(item => item != none)
    )
  ]

  #v(0.2em)
]

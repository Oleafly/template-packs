#import "config.typ": section_title, primary_color, accent_color, at_text, format_date

#v(-0.1em)
#section_title("Additional Experience")

#let experience_data = json("data/additional-experience.json")

#for experience in experience_data [
  #text(fill: primary_color, weight: 600, size: 1.1em)[#experience.position #at_text #experience.company] #h(1fr)
  #text(fill: accent_color, weight: 600, size: .9em)[#format_date(experience.from) — #format_date(experience.to) #h(.2em) #text(size: 1.3em, baseline: 0.12em)[•] #h(.2em) #experience.location]

  #v(0.2em)
]

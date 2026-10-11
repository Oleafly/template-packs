#import "config.typ": section_title, primary_color, accent_color, at_text, format_date

#v(-0.2em)
#section_title("Education")

#let education_data = json("data/education.json")

#for education in education_data [
  #text(fill: primary_color, weight: 600, size: 1.1em)[#education.school, #education.location]
  #h(1fr)
  #text(fill: accent_color, weight: 600, size: 1em)[#format_date(education.from) — #format_date(education.to)]
  #v(-0.5em)

  #text(size: 1em,weight: 500)[#education.degree]
  #v(0.5em)
]

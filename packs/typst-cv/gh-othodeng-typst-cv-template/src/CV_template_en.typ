#let conf(
  name: none,
  address: none,
  phone: none,
  email: none,
  blog: none,
  doc
) = {
  set page(margin: (x: 40pt, y: 40pt))
  set text(font: "New Computer Modern", size: 12pt)
  set block(spacing: 8pt)

  set document(
    title: "CV",
    author: name,
  )

  show link: underline

  set align(center)
  par(text(size: 18pt, weight: "bold", name))
  v(8pt)
  par(address)
  par(stack(
    dir: ltr,
    spacing: 4pt,
    text(phone),
    text("·"),
    link("mailto:" + email)
  ))
  v(4pt)

  set align(start)
  set line(stroke: 0.38pt + luma(20%))
  show heading.where(
    level: 1
  ): it => {
    set text(size: 14pt, weight: "bold")
    v(4pt)
    align(left, smallcaps(it))
    v(-10pt)
    stack(
      dir: ltr,
      spacing: 4pt,
      line(length: 100%),
      line(length: 4pt),
      line(length: 4pt),
      line(length: 4pt),
      line(length: 4pt),
      line(length: 4pt),
    )
    v(4pt)
  }
  show heading.where(//Heading style
    level: 2
  ): it => {
    box(text(size: 12pt, weight: "semibold", it, rgb("#1A237E")))
  }

  doc
}
#let cv_block(//CV Content style
  name: none,
  date: none,
  entity: none,
  description: none,

) = par({
  heading(level: 2, name)
  if entity != none {
    ", "
    text(fill: luma(20%),style: "italic", entity)
  }
  h(1fr)
  text(style: "italic", date)
  v(1pt)
  text(fill: luma(12%),description)
})

#let cv_link(
  url,
) = link("https://" + url, text(fill: rgb(20%, 20%, 40%), url))

//// Preview ////

#show: doc => conf(
  name: "Lainey Rin",
  address: "No.114, Apple Road, Banan(Postcode: 12345)",
  phone: "(+21) 123-4567-8900",
  email: "how@areyou.com",
  doc,
)
= Education

#cv_block(
  name: "Caliton University",
  date: "Sep. 2023 ~ Jul. 2027",
  entity: "Atlantic",
  description: [
    - B.S with Honors in Fish Touching
    - Ranking: 1/183 | GPA：4.00/4
  ],
)



= Project Experience/ Internship
#cv_block(
  name: "Research Assistant",
  entity: [Key Laboratory of Fishing],
  description: [
    - Assist with data collection and analysis for fish research project]
  )

#v(5pt)
#cv_block(
  name: "Member",
  entity: [
     Innovation Center on Fish Touching
  ],
  description:[
    - Contributed to development of fish catching model using machine learning
  ]
)



= Area of Interest
*Fish Touching* | *Cat Feeding* | *Dog jogging*

= Publications

#cv_block(
  name: "Rei,*Rin, et al.",
  entity: [Empirical Study of Paper Style Text Generation Technology Based on Large-scale Language Models [#cv_link("openai.com/114.514")]],
  description: [
    - Examined how Current students use Large-scale Language Module(ChatGPT) to cheat.

  ]
)

= Selected Awards and Honors
#cv_block(
  name: "Fish Catching Assessment Project",
  entity: "Supervised by Professor Miku",
  description: [
    - Analyzed 30 years of fish data to assess risk factors .
    - Developed an interactive data visualization dashboard using Python.
  ]
)

= Additional Information
#cv_block(
  name:"Extracurricular Activities",
  entity: [
    - Member, University Fish Association
    - Volunteer, Local Fish Service Office
    - User, #link("https://openai,com")[Open Ai]
  ]
)
#cv_block(
  name: "Laboratory Skills",
  description:[
    - Maintenance and operation of the clean laboratory
    - Pipetting, weighing, filtrating, titrating, etc.
  ]
)

#cv_block(
  name: "Computer and Language Skills",
  description: [
    - Programming: Python(Average)
    - Software: Meh
    - Language: Alienese(Native)
]
)

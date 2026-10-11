#let cover(
  title: "",
  by: (),
  to: "",
  date: "",
  logo: none,
  body
) = {
  set text(lang: "en")
  set page(
    paper:"a4",
    margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
  )
  set par(justify: true)

  align(center + horizon )[
    == #smallcaps("Some Notes")
    == #smallcaps("On")
    #v(1cm)   
    = #title
    #v(0.5cm)   
    == #smallcaps("By")

    == #for by in by {by.name}
    *#for by in by {by.rollno}*

    #v(0.5cm)   
    == #smallcaps("To")
    == #to
    #v(1cm)   
    #if logo != none {
      align(image(logo, width: 25%))
    } else {
      v(2cm)
    }
    #v(1cm)   
    = #smallcaps("Tribhuwan University")
    == #smallcaps("Institute of Engineering")
    #v(1cm)   
    = #smallcaps("Robotics Club")
    == #smallcaps("Purwanchal Campus")
    == #smallcaps("Dharan, Nepal")
    #v(1cm)   
    #date
  ]

  pagebreak()

  // Main body.
  set page(
    numbering: "1",
    number-align: center,
    margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
  )
  set heading(numbering: "1.1")
  set text(size: 12pt)
  counter(page).update(1)
  body
}

